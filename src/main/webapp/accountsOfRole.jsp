<%@ page import="vn.edu.iuh.fit.entities.Account" %>
<%@ page import="java.util.List" %>
<%@ page import="vn.edu.iuh.fit.entities.Role" %>
<%@ page import="vn.edu.iuh.fit.entities.Status" %>
<%
    if (session.getAttribute("account") == null) {
        response.sendRedirect("index.jsp");
        return;
    }
    if (!((Boolean) session.getAttribute("isAdmin"))) {
        request.getRequestDispatcher("forbidden.jsp").forward(request, response);
        return;
    }

    String roleId = request.getParameter("id");
    if (roleId == null) {
        request.getRequestDispatcher("notFound.jsp").forward(request, response);
        return;
    }

    Object roleObject = session.getAttribute("role");
    Object accountsObject = session.getAttribute("accounts");

    session.removeAttribute("role");
    session.removeAttribute("accounts");

    if (roleObject == null || accountsObject == null) {
        response.sendRedirect("ControlServlet?action=account-by-role&id=" + roleId);
        return;
    }
    Role role = (Role) roleObject;
    List<Account> accounts = (List<Account>) accountsObject;
%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>

<head>
    <title>Account Detail page</title>
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"
          integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA=="
          crossorigin="anonymous" referrerpolicy="no-referrer"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css"
          rel="stylesheet"
          integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9"
          crossorigin="anonymous">
</head>

<body>
<main>
    <jsp:include page="dashboardHeader.jsp"></jsp:include>
    <section class="container">
        <h1>Account Detail</h1>

        <div class="row row-gap-3 align-items-center">
            <div class="col-4 fw-semibold">Role ID</div>
            <div class="col-8">
                <input value="<%= role.getId() %>" class="form-control" type="text" disabled readonly>
            </div>
            <div class="col-4 fw-semibold">Role name</div>
            <div class="col-8">
                <input value="<%= role.getName() %>" class="form-control" type="text"
                       disabled readonly>
            </div>
            <div class="col-4 fw-semibold">Description</div>
            <div class="col-8">
                <input value="<%= role.getDescription() == null ? "" : role.getDescription() %>" class="form-control" type="text"
                       disabled readonly>
            </div>
            <div class="col-4 fw-semibold">Status</div>
            <div class="col-8">
                <input value="<%= role.getStatus().equals(Status.active) ? "Active" : "Deactive" %>" class="form-control" type="text"
                       disabled readonly>
            </div>
        </div>

        <table class="table table-hover table-striped mt-3">
            <thead>
            <tr>
                <th>Account ID</th>
                <th>Full name</th>
                <th>Email</th>
                <th>Phone</th>
                <th>Status</th>
            </tr>
            </thead>
            <tbody class="table-group-divider">
                <% for (Account account : accounts) { %>
                <tr>
                    <td>
                        <%= account.getId() %>
                    </td>
                    <td>
                        <%= account.getFullName() %>
                    </td>
                    <td>
                        <%= account.getEmail() == null ? "" : account.getEmail() %>
                    </td>
                    <td>
                        <%= account.getPhone() == null ? "" : account.getPhone() %>
                    </td>
                    <td>
                        <%= account.getStatus().equals(Status.active) ? "Active" : "Deactive" %>
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </section>
</main>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm"
        crossorigin="anonymous"></script>
</body>
</html>