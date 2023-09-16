<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    if (session.getAttribute("account") != null) {
        response.sendRedirect((Boolean) session.getAttribute("isAdmin") ? "dashboard.jsp" : "user.jsp");
        return;
    }
%>
<html>
    <head>
        <title>Login</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
        <style>
            main {
                height: 100vh;
            }

            section {
                width: min(100%, 500px);
            }

            .invalid-feedback.error-message {
                display: block;
            }
        </style>
    </head>
    <body>
        <main class="d-flex justify-content-center align-items-center">
            <section class="m-3 p-3 shadow rounded">
                <h1 class="h1 text-center">Login</h1>
                <form class="" action="ControlServlet?action=login" method="post">
                    <div class="form-floating mb-3">
                        <input required name="username" type="text" class="form-control" id="username" value="<%= session.getAttribute("username") == null ? "" : session.getAttribute("username") %>">
                        <label for="username">Email or phone</label>
                    </div>
                    <div class="form-floating mb-3">
                        <input required name="password" type="password" class="form-control" id="password" value="<%= session.getAttribute("password") == null ? "" : session.getAttribute("password") %>">
                        <label for="password">Password</label>
                    </div>
                    <div class="invalid-feedback error-message mb-3">
                        <%= session.getAttribute("message") == null ? "" : session.getAttribute("message") %>
                    </div>
                    <button type="submit" class="btn btn-primary">Login</button>
                </form>
            </section>
        </main>

        <% session.invalidate(); %>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
    </body>
</html>
