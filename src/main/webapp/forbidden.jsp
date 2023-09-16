<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    if (session.getAttribute("account") == null) {
        response.sendRedirect("index.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en" >

<head>
    <meta charset="UTF-8">
    <title>403 Page</title>
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
<div class="page-wrap d-flex flex-row align-items-center mt-5">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-12 d-flex justify-content-center">
                <svg xmlns:inkscape="http://www.inkscape.org/namespaces/inkscape" class="me-2"
                     xmlns:svg="http://www.w3.org/2000/svg" width="80" viewBox="0 0 197.25294 196.33728" version="1.1">
                    <g transform="translate(-5.7036999,-49.34148)">
                        <path id="path5905"
                              d="m 104.33018,49.341481 c -54.469919,0 -98.6264796,44.156567 -98.6264796,98.626469 0.00948,7.10487 0.7858642,14.18797 2.3168302,21.12595 15.3072454,-8.85719 26.5978174,-18.82243 41.2280594,-39.02733 16.842495,-23.26005 38.593973,-34.06599 57.6438,-34.156172 16.28899,-0.07714 30.60247,7.681272 38.18294,22.186732 6.21285,11.8888 42.10234,26.16107 29.14053,28.39606 -39.94507,8.99353 -32.93834,14.37665 -32.85342,61.3329 -3.98154,16.71084 -11.96025,26.81588 -23.9651,37.85267 48.96604,-6.54533 85.53615,-48.30893 85.55931,-97.71081 0,-54.469902 -44.15658,-98.626469 -98.62647,-98.626469 z m -2.46727,63.578389 c -0.16287,0.017 -0.3161,0.047 -0.47761,0.0659 -0.0484,0.0598 -0.0969,0.11688 -0.14504,0.17679 0.0535,0.024 0.0832,0.0378 0.13451,0.0607 0.0541,-0.005 0.1072,-0.017 0.16099,-0.0238 0.0764,-0.0668 0.26417,-0.22387 0.32721,-0.2797 z m -0.48817,0.30346 c -0.0113,7.9e-4 -0.0216,0.002 -0.0343,0.002 -0.0281,0.001 -0.076,-0.0238 -0.11345,-0.0476 -0.24039,0.29922 -0.48199,0.6008 -0.72304,0.90247 0.31628,-0.27187 0.72866,-0.61821 0.96053,-0.82065 -0.0306,-0.0135 -0.056,-0.0219 -0.0897,-0.0369 z m -0.14775,-0.0449 c 0.006,-0.006 0.0113,-0.0113 0.0135,-0.0159 -0.0216,-0.009 -0.0335,-0.0138 -0.0554,-0.0238 -0.0287,-0.0135 10e-4,0.0135 0.0421,0.0396 z"
                              sodipodi:nodetypes="sccsssccccssccccsssccccssccccc" />
                    </g>
                </svg>
            </div>
            <div class="col-md-12 text-center">
                <span class="display-1 d-block">403 - Forbidden Page</span>
                <div class="mb-2 lead">You tried to access a page you did not have prior authorization for</div>
                <a href="<%=  (Boolean) session.getAttribute("isAdmin") ? "dashboard.jsp" : "user.jsp" %>" class="btn btn-link">Home</a>
                <button onclick="history.back()" class="btn btn-link">Back</button>
            </div>
        </div>
    </div>
</div>

</body>

</html>
