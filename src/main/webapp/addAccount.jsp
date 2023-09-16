<%@ page import="vn.edu.iuh.fit.entities.Account" %>
<%@ page import="vn.edu.iuh.fit.entities.Status" %>
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

    Account newAccount = (Account) session.getAttribute("newAccount");

    session.removeAttribute("newAccount");

    if (newAccount == null)
        newAccount = new Account("", "", "", "", "", Status.active);
%>
<html>
<head>
    <title>Add account</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
</head>
<body>
    <main>
        <jsp:include page="dashboardHeader.jsp"></jsp:include>
        <section class="container">
            <h1>Add account</h1>
            <form action="ControlServlet?action=add-account" method="post">
                <div class="mb-3">
                    <label for="id" class="form-label">Account ID</label>
                    <input value="<%= newAccount.getId() %>" type="text" class="form-control" name="id" id="id" required>
                    <div class="invalid-feedback">
                        Please provide a valid zip.
                    </div>
                </div>
                <div class="mb-3">
                    <label for="full-name" class="form-label">Full name</label>
                    <input value="${newAccount.fullName}" type="text" class="form-control" name="full-name" id="full-name" required>
                    <div class="invalid-feedback">
                        Please provide a valid zip.
                    </div>
                </div>
                <div class="mb-3">
                    <label for="password" class="form-label">Password</label>
                    <input type="password" class="form-control" name="password" id="password" required>
                    <div class="invalid-feedback">
                        Please provide a valid zip.
                    </div>
                </div>
                <div class="mb-3">
                    <label for="email" class="form-label">Email</label>
                    <input type="email" class="form-control" name="email" id="email">
                    <div class="invalid-feedback">
                        Please provide a valid zip.
                    </div>
                </div>
                <div class="mb-3">
                    <label for="phone" class="form-label">Phone</label>
                    <input type="tel" class="form-control" name="phone" id="phone">
                    <div class="invalid-feedback">
                        Please provide a valid zip.
                    </div>
                </div>
                <div class="form-check mb-3">
                    <input checked="<%= newAccount.getStatus().equals(Status.active) %>" name="status" class="form-check-input" type="checkbox" id="status" value="active">
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
