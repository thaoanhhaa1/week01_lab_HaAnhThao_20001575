<%@ page import="vn.edu.iuh.fit.entities.GrantAccess" %>
<%@ page import="java.util.List" %>
<%@ page import="vn.edu.iuh.fit.entities.Account" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Object accountObject = session.getAttribute("account");

    if (accountObject == null) {
        response.sendRedirect("index.jsp");
        return;
    }

    Account account = (Account) accountObject;
%>
<html>

<head>
    <title>Profile Page</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css"
          rel="stylesheet"
          integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9"
          crossorigin="anonymous">
</head>

<body>
<main>
    <% if ((Boolean) session.getAttribute("isAdmin")) { %>
    <jsp:include page="dashboardHeader.jsp" />
    <% } else { %>
    <jsp:include page="userHeader.jsp" />
    <% } %>
    <section class="container">
        <h1 class="mb-3">Profile Page</h1>

        <div class="row row-gap-3 align-items-center">
            <div class="col-4 fw-semibold">Account ID</div>
            <div class="col-8">
                <input value="<%=account.getId() %>" class="form-control" type="text" disabled readonly>
            </div>
            <div class="col-4 fw-semibold">Full name</div>
            <div class="col-8">
                <input value="<%=account.getFullName() %>" class="form-control" type="text" disabled
                       readonly>
            </div>
            <div class="col-4 fw-semibold">Email</div>
            <div class="col-8">
                <input value="<%=account.getEmail() == null ? "" : account.getEmail() %>" class="form-control" type="text" disabled readonly>
            </div>
            <div class="col-4 fw-semibold">Phone</div>
            <div class="col-8">
                <input value="<%=account.getPhone() == null ? "" : account.getPhone() %>" class="form-control" type="text" disabled readonly>
            </div>
        </div>

        <table class="mt-3 table table-hover table-striped">
            <thead>
            <tr>
                <th>Role id</th>
                <th>Role name</th>
                <th>Description</th>
                <th>Note</th>
            </tr>
            </thead>
            <tbody class="table-group-divider">
            <% for (GrantAccess ga : (List<GrantAccess>) session.getAttribute("grantAccesses")) {
            %>
            <tr>
                <td>
                    <%= ga.getRole().getId() %>
                </td>
                <td>
                    <%= ga.getRole().getName() %>
                </td>
                <td>
                    <%= ga.getRole().getDescription() == null ? "" : ga.getRole().getDescription() %>
                </td>
                <td>
                    <%= ga.getNote() == null ? "" : ga.getNote() %>
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