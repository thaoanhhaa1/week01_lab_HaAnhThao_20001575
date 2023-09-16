<%@ page import="vn.edu.iuh.fit.entities.Account" %>
<header class="bg-body-tertiary">
  <div class="container">
    <nav class="navbar navbar-expand-lg bg-body-tertiary">
      <div class="container-fluid">
        <a class="navbar-brand" href="dashboard.jsp">WWW</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
          <ul class="navbar-nav me-auto mb-2 mb-lg-0">
            <li class="nav-item">
              <a class="nav-link active" aria-current="page" href="dashboard.jsp">Home</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="addAccount.jsp">Add account</a>
            </li>
            <li class="nav-item dropdown">
              <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                Role
              </a>
              <ul class="dropdown-menu">
                <li><a class="dropdown-item" href="ControlServlet?action=role-manage">Manage</a></li>
                <li><a class="dropdown-item" href="addRole.jsp">Add</a></li>
              </ul>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="user.jsp">Profile</a>
            </li>
          </ul>
          <div class="d-flex align-items-center gap-3">
            <h5 class="mb-0">Hello <%= ((Account) session.getAttribute("account")).getFullName() %></h5>
            <form class="mb-0" method="post" action="ControlServlet?action=logout">
              <button type="submit" class="btn btn-outline-secondary">Log out</button>
            </form>
          </div>
        </div>
      </div>
    </nav>
  </div>
</header>