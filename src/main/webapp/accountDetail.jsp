<%@ page import="vn.edu.iuh.fit.entities.Account" %>
<%@ page import="java.util.List" %>
<%@ page import="vn.edu.iuh.fit.entities.GrantAccess" %>
<%
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

    Object accountObject = session.getAttribute("account-detail");
    Object grantAccessesObject = session.getAttribute("grant-accesses-detail");
    session.removeAttribute("account-detail");
    session.removeAttribute("grant-accesses-detail");
    if (accountObject == null || grantAccessesObject == null) {
        response.sendRedirect("ControlServlet?action=account-detail&id=" + id);
        return;
    }
    Account account = (Account) accountObject;
    List<GrantAccess> grantAccesses = (List<GrantAccess>) grantAccessesObject;
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
            <div class="col-4 fw-semibold">Account ID</div>
            <div class="col-8">
                <input value="<%= account.getId() %>" class="form-control" type="text" disabled readonly>
            </div>
            <div class="col-4 fw-semibold">Full name</div>
            <div class="col-8">
                <input value="<%= account.getFullName() %>" class="form-control" type="text"
                       disabled readonly>
            </div>
            <div class="col-4 fw-semibold">Email</div>
            <div class="col-8">
                <input value="<%= account.getEmail() == null ? "" : account.getEmail() %>" class="form-control" type="text"
                       disabled readonly>
            </div>
            <div class="col-4 fw-semibold">Phone</div>
            <div class="col-8">
                <input value="<%= account.getPhone() == null ? "" : account.getPhone() %>" class="form-control" type="text"
                       disabled readonly>
            </div>
        </div>
        <div class="d-flex align-items-center justify-content-between mt-3 mb-2 gap-3">
            <h2 class="mb-0">Roles</h2>
            <a class="btn btn-outline-primary" href="ControlServlet?action=add-grant-access&id=<%= account.getId() %>">
                <i class="fa-solid fa-plus"></i>
            </a>
        </div>
        <table class="table table-hover table-striped">
            <thead>
            <tr>
                <th>Role id</th>
                <th>Role name</th>
                <th>Role description</th>
                <th>Grant</th>
                <th>Note</th>
                <th></th>
            </tr>
            </thead>
            <tbody class="table-group-divider">
            <% for (GrantAccess ga : grantAccesses) { %>
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
                    <%= ga.isGrant() ? "Enable" : "Disable" %>
                </td>
                <td>
                    <%= ga.getNote() == null ? "" : ga.getNote() %>
                </td>
                <td>
                    <div class="d-flex gap-1">
                        <a class="btn"
                           href="ControlServlet?action=update-grant-access&id=<%= account.getId() %>&role-id=<%= ga.getRole().getId() %>">
                            <i class="fa-solid fa-pen"></i>
                        </a>
                        <button data-id="<%= account.getId() %>"
                                data-role-id="<%= ga.getRole().getId() %>" type="button"
                                class="btn" data-bs-toggle="modal"
                                data-bs-target="#exampleModal">
                            <i class="fa-solid fa-trash"></i>
                        </button>
                    </div>
                </td>
            </tr>
            <% } %>
            </tbody>
        </table>
    </section>

    <%-- Modal --%>
    <div class="modal fade" id="exampleModal" tabindex="-1"
         aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title fs-5" id="exampleModalLabel">Disable role</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"
                            aria-label="Close"></button>
                </div>
                <div class="modal-body">
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary"
                            data-bs-dismiss="modal">Close
                    </button>
                    <form class="form" method="post">
                        <button type="submit" class="btn btn-danger">Disable</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
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

    // Handle click delete btn
    const deleteBtns = document.querySelectorAll('button[data-id]');
    const modalBody = document.querySelector('.modal-body');
    const modalForm = document.querySelector('.modal .form');

    deleteBtns.forEach(deleteBtn => deleteBtn.addEventListener('click', () => {
        const id = deleteBtn.dataset.id;
        const roleId = deleteBtn.dataset.roleId;

        modalBody.innerHTML = `Are you sure you want to disable role <strong>` + roleId + `</strong> of account <strong>` + id + `</strong>?`;
        modalForm.setAttribute("action", "ControlServlet?action=disable-grant-account&id=" + id + "&role-id=" + roleId);
    }))
</script>
</body>

</html>