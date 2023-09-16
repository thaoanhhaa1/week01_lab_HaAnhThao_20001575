<header class="bg-body-tertiary">
    <div class="container">
        <nav class="navbar navbar-expand-lg bg-body-tertiary">
            <div class="container-fluid">
                <a class="navbar-brand" href="user.jsp">WWW</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                        data-bs-target="#navbarSupportedContent"
                        aria-controls="navbarSupportedContent" aria-expanded="false"
                        aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                        <li class="nav-item">
                            <a class="nav-link active" aria-current="page"
                               href="user.jsp">Home</a>
                        </li>
                    </ul>
                    <div class="d-flex align-items-center gap-3">
                        <h5 class="mb-0">Hello ${account.fullName}</h5>
                        <form class="mb-0" method="post" action="ControlServlet?action=logout">
                            <button type="submit" class="btn btn-outline-secondary">Log
                                out
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </nav>
    </div>
</header>