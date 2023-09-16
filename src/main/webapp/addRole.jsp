<%@ page import="vn.edu.iuh.fit.entities.Status" %>
<%@ page import="vn.edu.iuh.fit.entities.Role" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    if (session.getAttribute("account") == null) {
        response.sendRedirect("index.jsp");
        return;
    }
    if (!((Boolean) session.getAttribute("isAdmin"))) {
        request.getRequestDispatcher("forbidden.jsp").forward(request, response);
        return;
    }

    Role newRole = (Role) session.getAttribute("newRole");
    session.removeAttribute("newRole");
    if (newRole == null)
        newRole = new Role("", "", "", Status.active);
%>
<html>
<head>
    <title>Add Role Page</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
</head>
<body>
<main>
    <jsp:include page="dashboardHeader.jsp"></jsp:include>
    <section class="container">
        <h1>Add role</h1>
        <form action="ControlServlet?action=add-role" method="post">
            <div class="mb-3">
                <label for="id" class="form-label">Role ID</label>
                <input value="<%= newRole.getId() %>" type="text" class="form-control" name="id" id="id" required>
                <div class="invalid-feedback">
                    Please provide a valid zip.
                </div>
            </div>
            <div class="mb-3">
                <label for="role-name" class="form-label">Role name</label>
                <input value="<%= newRole.getName()%>" type="text" class="form-control" name="role-name" id="role-name" required>
                <div class="invalid-feedback">
                    Please provide a valid zip.
                </div>
            </div>
            <div class="mb-3">
                <label for="description" class="form-label">Description</label>
                <input value="<%= newRole.getDescription()%>" type="text" class="form-control" name="description" id="description">
                <div class="invalid-feedback">
                    Please provide a valid zip.
                </div>
            </div>
            <div class="form-check mb-3">
                <input <%= newRole.getStatus().equals(Status.active) ? "checked" : "" %> name="status" class="form-check-input" type="checkbox" id="status" value="active">
                <label class="form-check-label" for="status">
                    Active
                </label>
            </div>
            <button type="submit" class="btn btn-primary">Submit</button>
        </form>
    </section>
</main>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
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
