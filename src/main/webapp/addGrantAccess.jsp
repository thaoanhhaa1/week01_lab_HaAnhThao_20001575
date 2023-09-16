<%@ page import="vn.edu.iuh.fit.entities.Account" %>
<%@ page import="vn.edu.iuh.fit.entities.Role" %>
<%@ page import="java.util.List" %><%
    if (session.getAttribute("account") == null) {
        response.sendRedirect("index.jsp");
        return;
    }
    if (!((Boolean) session.getAttribute("isAdmin"))) {
        request.getRequestDispatcher("forbidden.jsp").forward(request, response);
        return;
    }

    String id = request.getParameter("id");

    if (id == null) {
        request.getRequestDispatcher("notFound.jsp").forward(request, response);
        return;
    }

    Object accountObject = session.getAttribute("accountRole");
    Object rolesObject = session.getAttribute("roles");

    session.removeAttribute("accountRole");
    session.removeAttribute("roles");

    if (accountObject == null || rolesObject == null) {
        response.sendRedirect("ControlServlet?action=add-grant-access&id=" + id);
        return;
    }

    String note = (String) session.getAttribute("note");
    String roleID = (String) session.getAttribute("role-id");
    session.removeAttribute("role-id");
    session.removeAttribute("note");

    if (note == null)
        note = "";
    if (roleID == null)
        roleID = "";

    Account account = (Account) accountObject;
    List<Role> roles = (List<Role>) rolesObject;
%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Update Grant Account Page</title>
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"
          integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA=="
          crossorigin="anonymous" referrerpolicy="no-referrer"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css"
          rel="stylesheet"
          integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9"
          crossorigin="anonymous">
    <link rel="stylesheet" href="./style.css">
</head>

<body>
<main>
    <jsp:include page="dashboardHeader.jsp"></jsp:include>
    <section class="container">
        <h1>Add Grant Access</h1>

        <form action="ControlServlet?action=add-grant-account" method="post">
            <div class="mb-3">
                <label for="id" class="form-label">Account ID</label>
                <input value="<%= account.getId() %>" type="text" class="form-control disabled" name="id"
                       id="id" readonly>
            </div>
            <div class="mb-3">
                <label for="full-name" class="form-label">Full name</label>
                <input value="<%= account.getFullName() %>" type="text" class="form-control disabled" readonly
                       id="full-name">
            </div>
            <div class="mb-3">
                <label for="role" class="form-label">Role</label>
                <select id="role" name="role-id" class="form-select mb-3" aria-label="Default select example" required>
                    <option value="" <%= roleID.equals("") ? "selected" : ""  %>>Choose role</option>
                    <% for (Role role : roles) { %>
                        <option <%= role.getId().equals(roleID) ? "selected" : "" %> value="<%= role.getId() %>"><%= role.getName() %></option>
                    <% } %>
                </select>
            </div>
            <div class="mb-3">
                <label for="note" class="form-label">Note</label>
                <textarea class="form-control" name="note" id="note"><%= note %></textarea>
            </div>
            <button type="submit" class="btn btn-primary">Submit</button>
        </form>
    </section>
</main>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm"
        crossorigin="anonymous"></script>
<script src="./toast.js"></script>
<script>
    <%-- Show toast --%>
    const toastMessage = "<%= session.getAttribute("toast-message")%>";
    const toastType = "<%= session.getAttribute("toast-type")%>";

    <%
        session.removeAttribute("toast-message");
        session.removeAttribute("toast-type");
    %>

    if (toastMessage !== 'null')
        addToast(toastType, toastMessage);
</script>
</body>
</html>
