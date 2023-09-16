<%@ page import="vn.edu.iuh.fit.entities.Role" %>
<%@ page import="java.util.List" %>
<%
  if (session.getAttribute("account") == null) {
    response.sendRedirect("index.jsp");
    return;
  }
  if (!((Boolean)  session.getAttribute("isAdmin"))) {
    request.getRequestDispatcher("forbidden.jsp").forward(request, response);
    return;
  }

  Object rolesObject = session.getAttribute("roles");
  session.removeAttribute("roles");

  if (rolesObject == null) {
    response.sendRedirect("ControlServlet?action=role-manage");
    return;
  }

  List<Role> roles = (List<Role>) rolesObject;
%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Role Manage Page</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
</head>
<body>
<main>
  <jsp:include page="dashboardHeader.jsp"></jsp:include>
  <section class="container">
    <h1>Role manage</h1>
    <table class="table table-hover table-striped">
      <thead>
      <tr>
        <th>Role id</th>
        <th>Role name</th>
        <th>Description</th>
        <th>Status</th>
        <th>Actions</th>
      </tr>
      </thead>
      <tbody class="table-group-divider">
        <% for (Role role : roles) { %>
          <tr>
            <td><%= role.getId() %></td>
            <td><%= role.getName() %></td>
            <td><%= role.getDescription() == null ? "" : role.getDescription() %></td>
            <td><%= role.getStatus() %></td>
            <td>
              <div class="d-flex gap-1">
                <a class="btn" href="ControlServlet?action=account-by-role&id=<%= role.getId() %>">
                  <i class="fa-solid fa-circle-info"></i>
                </a>
                <a class="btn" href="ControlServlet?action=update-role&id=<%= role.getId() %>">
                  <i class="fa-solid fa-pen"></i>
                </a>
                <button data-id="<%= role.getId() %>" type="button" class="btn" data-bs-toggle="modal" data-bs-target="#exampleModal">
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
  <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <h1 class="modal-title fs-5" id="exampleModalLabel">Delete role</h1>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
          <form class="form" method="post">
            <button type="submit" class="btn btn-danger">Delete</button>
          </form>
        </div>
      </div>
    </div>
  </div>
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

  // Handle click delete btn
  const deleteBtns = document.querySelectorAll('button[data-id]');
  const modalBody = document.querySelector('.modal-body');
  const modalForm = document.querySelector('.modal .form')

  deleteBtns.forEach(deleteBtn => deleteBtn.addEventListener('click', () => {
    const id = deleteBtn.dataset.id;

    modalBody.innerHTML = `Are you sure you want to delete the role with id <strong>` + id +`</strong>?`;
    modalForm.setAttribute("action", "ControlServlet?action=delete-role&id=" + id);
  }))
</script>
</body>
</html>
