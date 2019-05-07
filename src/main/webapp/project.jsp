<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" pageEncoding="UTF-8" %>
<%@ page isELIgnored="false" %>

<html>
<head>
    <title>ecommerce</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <script src="js/jquery.js" type="text/javascript"></script>
    <script src="js/index.js" type="text/javascript"></script>
    <script src="js/product.js" type="text/javascript"></script>
    <script src="js/jquery.js" type="text/javascript"></script>
    <script src="js/jquery-ui.min.js" type="text/javascript"></script>
    <link rel="stylesheet" type="text/css" href="css/jquery-ui.min.css"/>
    <link rel="stylesheet" type="text/css" href="css/header.css"/>
    <link rel="stylesheet" type="text/css" href="css/project.css"/>

    <link rel="stylesheet" type="text/css" href="font_Icon/iconfont.css">
    <link rel="stylesheet" type="text/css" href="css/chat.css">

    <script type="text/javascript">
        var websocket = null;


        function login() {

            if ('WebSocket' in window) {
                var sendUser = document.getElementById("sendUser").value;
                document.getElementById("sendUser").disabled = true;
                websocket = new WebSocket("ws://localhost:8080/Ecommerce/" + sendUser);
            } else {
                alert('Not support websocket')
            }

            //连接发生错误的回调方法
            websocket.onerror = function () {
                document.getElementById('status').innerHTML = "error";
            };

            //连接成功建立的回调方法
            websocket.onopen = function (event) {
                document.getElementById('status').innerHTML = "连接服务器成功";
            }

            //接收到消息的回调方法
            websocket.onmessage = function (event) {
                //判断分割是统计人数还是显示消息
                if (event.data.indexOf("count") > -1) {
                    var msg = event.data;
                    var data = msg.split(":");
                    document.getElementById('count').innerHTML = data[1];
                } else {
                    var message = JSON.parse(event.data);
                    var content = message.message;
                    setMessageInnerHTML(content);
                }
            }

            //连接关闭的回调方法
            websocket.onclose = function () {
                document.getElementById('status').innerHTML = "连接被成功关闭";
            }

            //监听窗口关闭事件，当窗口关闭时，主动去关闭websocket连接，防止连接还没断开就关闭窗口，server端会抛异常。
            window.onbeforeunload = function () {
                websocket.close();
            }
        }

        //将消息显示在网页上
        function setMessageInnerHTML(innerHTML) {
            $(".chatBox-content-demo").append("<div class=\"clearfloat\">\n" +
                "                            <div class=\"author-name\">\n" +
                "                            </div>\n" +
                "                            <div class=\"left\">\n" +
                "                                <div class=\"chat-avatars\"><img src=\"img/icon01.png\" alt=\"头像\"/></div>\n" +
                "                                <div class=\"chat-message\">\n" +
                innerHTML +
                "                                </div>\n" +
                "                            </div>\n" +
                "                        </div>");
            $(document).ready(function () {
                $("#chatBox-content-demo").scrollTop($("#chatBox-content-demo")[0].scrollHeight);
            });
        }

        //关闭连接
        function closeWebSocket() {
            websocket.close();
        }

        //发送消息
        function send(textContent) {
            var sendUser = document.getElementById("sendUser").value;
            var toUser = document.getElementById("toUser").value;
            var message = textContent;

            var jsonMsg = {"sendUser": sendUser, "toUser": toUser, "message": message}
            websocket.send(JSON.stringify(jsonMsg));
        }
    </script>

</head>

<body>

<!--引入头部-->
<div id="head_div">
    <jsp:include page="h.jsp"/>
</div>
<!--总体div-->
<div id="all">
    <!--插入页眉-->
    <%--<script type="text/javascript" src="js/head_div.js"></script>--%>
    <!--模块1-->
    <div id="m1">
        <div id="left">
            <c:forEach items="${imglist}" var="il" begin="0" end="0">
                <img id="product" src="${il.imgpath}">
            </c:forEach>
            <%--<img id="product" src="${imglist[0].imgpath}"/>--%>
        </div>
        <div id="right">
            <div id="rightTop">
                <p id="title">${showproject.pname}</p>
                <p>已筹到</p>
                <p id="got">
                    ${showproject.pnm}
                    <c:if test="${typestr!='USD'}">
                        ${typestr}
                        (${cpnm} $)
                    </c:if>
                </p>
                <div>
                    <div>
                            <div class="layui-progress layui-progress-big">
                                <div class="layui-progress-bar" lay-percent="${percentage}%"></div>
                            </div>

                    </div>
                    <div>
                        <p id="now">当前进度${percentage}%&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${showproject.pnp}名支持者</p>
                    </div>
                </div>
                <p>此项目必须在
                    <span class="time">&nbsp;
                        <input id="pedt" name="pedC" value="${showproject.ped}" disabled>
                    </span>
                    &nbsp;
                    前得到<br>
                    &nbsp;
                    <span class="time">
                        ${showproject.ptarget}
                            <c:if test="${typestr!='USD'}">
                                ${typestr}
                                (${cpt} $)
                            </c:if>

                    </span>
                    &nbsp;的支持才可成功！
                <p><input class="ped" name="ped" value="${showproject.ped}" disabled></p>
                </p>

            </div>

            <form action="AddOrder.mvc" method="post" id="orderform">
                <table>
                    <tr>
                        <td>

                            支持额：
                        </td>
                        <td>
                            <input class="input" type="number" name="ordernum" required/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            是否需要回报:
                            <input name="oexpect" type="radio" checked="checked" value="1" onclick="showdiv()">是
                            <input name="oexpect" type="radio" value="0" onclick="notshowdiv()">否
                        </td>
                        <td>

                        </td>
                    </tr>
                </table>
                <table>
                    <tr name="cdiv">
                        <td>
                            期许的回报:
                        </td>
                        <td>
                            <input name="oexpectType" type="radio" checked="checked" value="1">投资产品享受折扣
                        </td>
                    </tr>
                    <tr name="cdiv">
                        <td>

                        </td>
                        <td>
                            <input name="oexpectType" type="radio" value="2">购买产品享有更高折扣或附加服务
                        </td>
                    </tr>
                    <tr name="cdiv">
                        <td>

                        </td>
                        <td>
                            <input name="oexpectType" type="radio" value="3">免费获得投资产品
                        </td>
                    </tr>
                    <tr name="cdiv">
                        <td>

                        </td>
                        <td>
                            <input name="oexpectType" type="radio" value="4">其他
                            <br>
                            <input class="input" type="text" name="oexpectOther">
                        </td>
                    </tr>

                    <%--<c:if test="${empty addr}">--%>
                    <%--<script type="text/javascript">--%>
                    <%--window.location.href = "manage.jsp?mangetype=manageaddr";--%>
                    <%--</script>--%>
                    <%--</c:if>--%>


                    <tr name="cdiv">
                        <td>
                            地址:
                        </td>
                        <td>
                            <c:forEach items="${addr}" var="uad" varStatus="vs" begin="0" end="0">
                                <input name="oaid" type="radio" value="${uad.aid}" checked>
                                ${uad.address}
                            </c:forEach>
                            <c:forEach items="${addr}" var="uad" varStatus="vs" begin="1">
                                <input name="oaid" type="radio" value="${uad.aid}">
                                ${uad.address}
                            </c:forEach>
                        </td>
                    </tr>


                    <%--结束地址--%>
                </table>
                <input id="sbtn" class="but" type="submit" value="确认支持"/>
            </form>

        </div>
    </div>

    <!--模块2-->
    <div id="left2">
        <div id="menu_main" style="margin-top: 30px;">
            <ul id="menu" >
                <li><p onclick="showintroducation()">产品介绍</p></li>
                <li><p>&nbsp;&nbsp;|&nbsp;&nbsp;</p></li>
                <li><p onclick="showcomments()">留言</p></li>
            </ul>
        </div>
        <br/>
        <div id="introducation">
            <c:forEach items="${imglist}" var="il">
                <img src="${il.imgpath}">
            </c:forEach>
            <%--显示产品介绍--%>
        </div>
        <div id="commentsDiv">

            <c:if test="${comlist!=null}">
                <c:forEach items="${comlist}" var="fb">
                    <div>
                        <hr/>
                        <div>
                            <div>
                                <table>

                                    <tr>
                                        <td>
                                            用户名： ${fb.usersByUPhone.uname}
                                        </td>
                                        <td id="commentsinfo">
                                            评论时间： ${fb.pctime}
                                        </td>
                                    </tr>

                                </table>

                            </div>
                            <br/>
                            <div>
                                <p id="comment">${fb.pcomment}</p>
                            </div>
                        </div>

                        <br/>

                        <hr/>
                    </div>

                </c:forEach>


            </c:if>

            <div id="inputComment">
                <form action="AddComment.mvc?pid=%{showproject.pid}" method="post">
                    <br/>
                    <p>请输入您的评论：</p>
                    <br/>
                    <input type="text" id="newcom" name="newcom" required>

                    <%--<div class="layui-form-item layui-form-text">--%>
                    <%--<div class="layui-input-block">--%>
                    <%--<textarea placeholder="请输入内容" class="layui-textarea" id="newcom" name="newcom" required></textarea>--%>
                    <%--</div>--%>
                    <%--</div>--%>

                    <br/>
                    <input id="subbtn" value="提交" type="submit" style="margin-left: 40%"/>
                </form>
            </div>
            </form>
        </div>
    </div>

    <div id="right2">
        <div id="desc">

            账　号:<input type="text" name="sendUser" id="sendUser" value="${user.uphone}" hidden/>

            <input type="button" onclick="closeWebSocket()" value="退出" hidden/>
            在线人数:<font id="count"></font>　　　连接状态:<font id="status"></font>

            <br/>
            接收人:<input type="text" name="toUser" id="toUser" value="${showproject.uphone}" hidden/><br/>
            <btn id="qbtn" class="chat-close"><input type="button" id="login" value="咨询客服" onclick="login()"/></btn>
            <br>
            <br>
            项目介绍:${showproject.pdesc}
            <br/>
            投资前景:${showproject.pmilestone}
            <br/>
            项目团队介绍:${showproject.pteam}
            <br/>
            项目开发计划:${showproject.pplan}
        </div>

        <div id="hot">
            <img class="imgtitle" src="images/热门推荐.png"/>
            <div name="projectdiv">
                <ul name="menu">
                    <c:forEach items="${hot}" var="pro" begin="0" end="3">
                        <c:if test="${pid != pro.pid}">
                            <li>
                                <div>
                                    <p class="picture">
                                        <a href="ShowProject.mvc?pid=${pro.pid}">
                                            <img class="pimg" src="images/${pro.pid}/0.jpg"/>
                                        </a>
                                    </p>

                                    <p class="pname">
                                        <a href="ShowProject.mvc?pid=${pro.pid}">
                                                ${pro.pname}
                                        </a>
                                    </p>
                                    <p class="ptype" style="width: 40px">
                                        <a class="ptypea"
                                           href="Projectlist.mvc?type=${pro.projectTypeByPCategoryId.projecttypeid+2}">
                                                ${pro.projectTypeByPCategoryId.projecttypename}
                                        </a>
                                    </p>
                                </div>

                                <div>
                                    <table>
                                        <tr>
                                            <td>
                                                <p class="ptype">
                                                        ${pro.pnp}人

                                                </p>
                                            </td>

                                            <td>
                                                <p class="ptype">
                                                        ${pro.pnm}

                                                </p>
                                            </td>

                                            <td>

                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="100px">支持</td>
                                            <td width="140px">已筹</td>

                                        </tr>
                                        <tr>
                                            <td>剩余时间</td>
                                            <td>
                                                <p>
                                                    <input style="display: none" name="pedC" value="${pro.ped}">
                                                    <input class="ped" name="ped" value="${pro.ped}" disabled>
                                                </p>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </li>
                        </c:if>

                    </c:forEach>
                </ul>
            </div>
        </div>
        </br>
        </br>
    </div>
</div>

<%--聊天部分--%>
<div class="chatContainer">
    <div class="chatBox" ref="chatBox">
        <div class="chatBox-head">
            <div class="chatBox-head-two">

                &nbsp;&nbsp; &nbsp;在线咨询
                <div class="chat-close" onclick="closeWebSocket()">关闭</div>
            </div>
        </div>
        <div class="chatBox-info">
            <div class="chatBox-kuang" ref="chatBoxkuang">
                <div class="chatBox-content">
                    <div class="chatBox-content-demo" id="chatBox-content-demo">


                    </div>
                </div>
                <div class="chatBox-send">
                    <div class="div-textarea" contenteditable="true"></div>
                    <div>
                        <button id="chat-fasong" class="btn-default-styles"><i class="iconfont icon-fasong"></i>
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!--撑出页脚-->
<div id="blank" style="height:2030px"></div>

<%--聊天功能--%>
<script src="js/jquery.js"></script>
<script>

    screenFuc();

    function screenFuc() {
        var topHeight = $(".chatBox-head").innerHeight();//聊天头部高度
        //屏幕小于768px时候,布局change
        var winWidth = $(window).innerWidth();
        if (winWidth <= 768) {
            var totalHeight = $(window).height(); //页面整体高度
            $(".chatBox-info").css("height", totalHeight - topHeight);
            var infoHeight = $(".chatBox-info").innerHeight();//聊天头部以下高度
            //中间内容高度
            $(".chatBox-content").css("height", infoHeight - 46);
            $(".chatBox-content-demo").css("height", infoHeight - 46);

            $(".chatBox-list").css("height", totalHeight - topHeight);
            $(".chatBox-kuang").css("height", totalHeight - topHeight);
            $(".div-textarea").css("width", winWidth - 106);
        } else {
            $(".chatBox-info").css("height", 495);
            $(".chatBox-content").css("height", 448);
            $(".chatBox-content-demo").css("height", 448);
            $(".chatBox-list").css("height", 495);
            $(".chatBox-kuang").css("height", 495);
            $(".div-textarea").css("width", 260);
        }
    }

    (window.onresize = function () {
        screenFuc();
    })();


    $(".chatBox-head-one").toggle();
    $(".chatBox-head-two").toggle();
    $(".chatBox-list").fadeToggle();
    $(".chatBox-kuang").fadeToggle();

    //传名字
    $(".ChatInfoName").text("test");

    //传头像
    $(".ChatInfoHead>img").attr("src", "srcurl");

    //聊天框默认最底部
    $(document).ready(function () {
        $("#chatBox-content-demo").scrollTop($("#chatBox-content-demo")[0].scrollHeight);
    });

    //      发送信息
    $("#chat-fasong").click(function () {
        var textContent = $(".div-textarea").html().replace(/[\n\r]/g, '<br>')
        if (textContent != "") {
            send(textContent);
            $(".chatBox-content-demo").append("<div class=\"clearfloat\">" +
                "<div class=\"author-name\"></div> " +
                "<div class=\"right\"> <div class=\"chat-message\"> " + textContent + " </div> " +
                "<div class=\"chat-avatars\"><img src=\"img/icon01.png\" alt=\"头像\" /></div> </div> </div>");
            //发送后清空输入框
            $(".div-textarea").html("");
            //聊天框默认最底部
            $(document).ready(function () {
                $("#chatBox-content-demo").scrollTop($("#chatBox-content-demo")[0].scrollHeight);
            });
        }
    });


    //打开、关闭聊天框
    $("#qbtn").click(function () {
        $(".chatBox").toggle(10);
    })
    $(".chat-close").click(function () {
        $(".chatBox").toggle(10);
    })


</script>

<script type="text/javascript">
    //倒计时
    window.onload = cheangetime();

    //是否需要回报
    function showdiv() {
        var controls = document.getElementsByName("cdiv");
        for (var i = 0; i < controls.length; i++) {
            var c = controls[i];
            c.style.display = "table-row-group";
        }
    }

    function notshowdiv() {
        var controls = document.getElementsByName("cdiv");
        for (var i = 0; i < controls.length; i++) {
            var c = controls[i];
            c.style.display = "none";
        }
    }

    //判断项目是否已经超时
    var pcontrols = document.getElementById("pedt").value;
    nped = pcontrols.substr(0, pcontrols.length - 4);
    var npedfor = new Date(nped.replace(/-/g, "/"));
    var dateBegin = new Date(npedfor);
    var dateEnd = new Date();
    var dateDiff = dateBegin.getTime() - dateEnd.getTime();//时间差的毫秒数
    if (dateDiff <= 0) {
        document.getElementById("orderform").style.display = "none";
    }

</script>

</body>
<footer>
    <div id="footer">
        <br><br>
        Copyright ©2018 Made By
        <br>
        @境界的彼方 -许志伟 孟文杰 张鑫禹.
        <br>-All rights reserved.
        <br><br>
    </div>
</footer>