<%@ page import="vn.edu.iuh.fit.entities.Status" %>
<%@ page import="vn.edu.iuh.fit.entities.Role" %>
<% if (session.getAttribute("account") == null) {
    response.sendRedirect("index.jsp");
    return;
}
    if (!((Boolean)
            session.getAttribute("isAdmin"))) {
        request.getRequestDispatcher("forbidden.jsp").forward(request,
                response);
        return;
    }
    Object o = session.getAttribute("role");
    String id = request.getParameter("id");
    session.removeAttribute("role");
    if (id == null) {
        request.getRequestDispatcher("notFound.jsp").forward(request, response);
        return;
    }
    if (o == null) {
        response.sendRedirect("ControlServlet?action=update-role&id=" + id);
        return;
    }
    Role role = (Role) o;
%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>

<head>
    <title>Update Role Page</title>
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
        <h1>Update role</h1>
        <form action="ControlServlet?action=update-role" method="post">
            <div class="mb-3">
                <label for="id" class="form-label">Role ID</label>
                <input value="<%= role.getId() %>" type="text" class="form-control disabled" name="id"
                       id="id" required readonly>
            </div>
            <div class="mb-3">
                <label for="role-name" class="form-label">Role name</label>
                <input value="<%= role.getName() %>" type="text" class="form-control"
                       name="role-name" id="role-name" required>
                <div class="invalid-feedback">
                    Please provide a valid zip.
                </div>
            </div>
            <div class="mb-3">
                <label for="description" class="form-label">Description</label>
                <input value="<%= role.getDescription() == null ? "" : role.getDescription() %>" type="text" class="form-control"
                       name="description" id="description">
                <div class="invalid-feedback">
                    Please provide a valid zip.
                </div>
            </div>
            <div class="form-check mb-3">
                <input <%= role.getStatus().equals(Status.active) ? "checked" : "" %> name="status"
                   class="form-check-input" type="checkbox" id="status" value="active">
                <label class="form-check-label" for="status">
                    Active
                </label>
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
    <%--    Show toast--%>
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