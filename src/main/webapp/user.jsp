<%@ page import="vn.edu.iuh.fit.entities.GrantAccess" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    if (session.getAttribute("account") == null) {
        response.sendRedirect("index.jsp");
        return;
    }
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
    <jsp:include page="dashboardHeader.jsp"></jsp:include>
    <% } else { %>
    <jsp:include page="userHeader.jsp"></jsp:include>
    <% } %>
    <section class="container">
        <h1 class="mb-3">Profile Page</h1>

        <div class="row row-gap-3 align-items-center">
            <div class="col-4 fw-semibold">Account ID</div>
            <div class="col-8">
                <input value="${account.id}" class="form-control" type="text" disabled readonly>
            </div>
            <div class="col-4 fw-semibold">Full name</div>
            <div class="col-8">
                <input value="${account.fullName}" class="form-control" type="text" disabled
                       readonly>
            </div>
            <div class="col-4 fw-semibold">Email</div>
            <div class="col-8">
                <input value="${account.email}" class="form-control" type="text" disabled readonly>
            </div>
            <div class="col-4 fw-semibold">Phone</div>
            <div class="col-8">
                <input value="${account.phone}" class="form-control" type="text" disabled readonly>
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
                    <%= ga.getRole().getDescription() %>
                </td>
                <td>
                    <%= ga.getNote() %>
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