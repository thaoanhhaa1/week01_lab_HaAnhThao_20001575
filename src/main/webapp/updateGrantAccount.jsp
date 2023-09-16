<%@ page import="vn.edu.iuh.fit.entities.Account" %>
<%@ page import="vn.edu.iuh.fit.entities.GrantAccess" %><%
    if (session.getAttribute("account") == null) {
        response.sendRedirect("index.jsp");
        return;
    }
    if (!((Boolean) session.getAttribute("isAdmin"))) {
        request.getRequestDispatcher("forbidden.jsp").forward(request, response);
        return;
    }

    String id = request.getParameter("id");
    String roleId = request.getParameter("role-id");

    if (id == null || roleId == null) {
        request.getRequestDispatcher("notFound.jsp").forward(request, response);
        return;
    }

    Object accountObject = session.getAttribute("accountGrantAccess");
    Object grantAccessObject = session.getAttribute("grantAccess");

    if (accountObject == null || grantAccessObject == null) {
        response.sendRedirect(String.format("ControlServlet?action=update-grant-access&id=%s&role-id=%s", id, roleId));
        return;
    }

    session.removeAttribute("accountGrantAccess");
    session.removeAttribute("grantAccess");

    Account account = (Account) accountObject;
    GrantAccess grantAccess = (GrantAccess) grantAccessObject;
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
            <h1>Update Grant Access</h1>

            <form action="ControlServlet?action=update-grant-account" method="post">
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
                    <label for="role-id" class="form-label">Role ID</label>
                    <input value="<%= grantAccess.getRole().getId() %>" type="text" class="form-control disabled"
                           name="role-id" id="role-id" readonly>
                </div>
                <div class="mb-3">
                    <label for="role-name" class="form-label">Role name</label>
                    <input value="<%= grantAccess.getRole().getName() %>" type="text" class="form-control disabled"
                           name="role-name" id="role-name" readonly>
                </div>
                <div class="form-check mb-3">
                    <input <%= grantAccess.isGrant() ? "checked" : "" %> name="grant"
                           class="form-check-input" type="checkbox" id="grant" value="active">
                    <label class="form-check-label" for="grant">
                        Active grant
                    </label>
                </div>
                <div class="mb-3">
                    <label for="note" class="form-label">Note</label>
                    <textarea class="form-control" name="note" id="note"><%= grantAccess.getNote() == null ? "" : grantAccess.getNote() %></textarea>
                    <div class="invalid-feedback">
                        Please provide a valid zip.
                    </div>
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
