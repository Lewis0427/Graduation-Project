<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" pageEncoding="UTF-8" %>
<%@ page isELIgnored="false" %>

<head>
    <title>Facelet Title</title>

    <script type="text/javascript" src="js/jquery.js"></script>
    <script type="text/javascript" src="js/carousel.js"></script>
    <link type="text/css" rel="stylesheet" href="css/carousel.css"/>
    <script type="text/javascript">
        function topro(pid) {
            top.location.href = "ShowProject.mvc?pid=" + pid;
        }
    </script>
</head>
<body>


<div id="myCarousel" class="carousel slide">
    <!-- 轮播（Carousel）指标 -->
    <ol class="carousel-indicators">
        <%--<c:if test="${hotimglist==null}">--%>
            <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
        <%--</c:if>--%>
        <%--<c:forEach items="${hotimglist}" var="ad" varStatus="vs" begin="0" end="0">--%>
        <%--<li data-target="#myCarousel" data-slide-to="0" class="active"></li>--%>
        <%--</c:forEach>--%>
        <c:forEach items="${hotimglist}" var="ad" varStatus="vs" begin="0">
            <li data-target="#myCarousel" data-slide-to="${vs.index+1}"></li>
        </c:forEach>
    </ol>
    <!-- 轮播（Carousel）项目 -->
    <div class="carousel-inner">

        <div class="item active">
            <img class="cimg" src="images/LRFbg.jpg">
        </div>
        <c:forEach items="${hotimglist}" var="ad" varStatus="vs">
            <div class="item">
                <img class="cimg" src="${ad.imgpath}" alt="${vs.count}" onclick="topro(${ad.pid})">
            </div>
        </c:forEach>
    </div>
    <!-- 轮播（Carousel）导航 -->
    <a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev">
        <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
        <span class="sr-only">Previous</span>
    </a>
    <a class="right carousel-control" href="#myCarousel" role="button" data-slide="next">
        <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
        <span class="sr-only">Next</span>
    </a>
</div>
<script>

    $("#myCarousel").carousel('cycle');
    $("#myCarousel").carousel({
        interval: 500
    });
</script>
</body>
