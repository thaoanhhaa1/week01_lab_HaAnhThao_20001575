<%@ page import="vn.edu.iuh.fit.entities.Account" %>
<%@ page import="vn.edu.iuh.fit.entities.Status" %>
<% if (session.getAttribute("account") == null) {
    response.sendRedirect("index.jsp");
    return;
}
    if (!((Boolean) session.getAttribute("isAdmin"))) {
        request.getRequestDispatcher("forbidden.jsp").forward(request, response);
        return;
    }
    Object o = session.getAttribute("account-update");
    if (o == null) {
        String id = request.getParameter("id");

        if (id == null)
            request.getRequestDispatcher("notFound.jsp").forward(request, response);
        else
            response.sendRedirect("ControlServlet?action=update-account&id=" + id);
        return;
    }
    session.removeAttribute("account-update");
    Account account = (Account) o;
%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>

<head>
    <title>Update Account Page</title>
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
        <h1>Update account</h1>
        <form action="ControlServlet?action=update-account" method="post">
            <div class="mb-3">
                <label for="id" class="form-label">Account ID</label>
                <input value="<%= account.getId() %>" type="text" class="form-control disabled" name="id"
                       id="id" required readonly>
                <div class="invalid-feedback">
                    Please provide a valid zip.
                </div>
            </div>
            <div class="mb-3">
                <label for="full-name" class="form-label">Full name</label>
                <input value="<%= account.getFullName() %>" type="text" class="form-control"
                       name="full-name" id="full-name" required>
                <div class="invalid-feedback">
                    Please provide a valid zip.
                </div>
            </div>
            <div class="mb-3">
                <label for="password" class="form-label">Password</label>
                <input value="<%= account.getPassword() %>" type="password" class="form-control"
                       name="password" id="password" required>
                <div class="invalid-feedback">
                    Please provide a valid zip.
                </div>
            </div>
            <div class="mb-3">
                <label for="email" class="form-label">Email</label>
                <input value="<%= account.getEmail() == null ? "" : account.getEmail() %>" type="email" class="form-control"
                       name="email" id="email">
                <div class="invalid-feedback">
                    Please provide a valid zip.
                </div>
            </div>
            <div class="mb-3">
                <label for="phone" class="form-label">Phone</label>
                <input value="<%= account.getPhone() == null ? "" : account.getPhone() %>" type="tel" class="form-control"
                       name="phone" id="phone">
                <div class="invalid-feedback">
                    Please provide a valid zip.
                </div>
            </div>
            <div class="form-check mb-3">
                <input <%= account.getStatus().equals(Status.active) ? "checked" : "" %> name="status"
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