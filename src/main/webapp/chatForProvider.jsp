<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" pageEncoding="UTF-8" %>
<%@ page isELIgnored="false" %>

<!DOCTYPE HTML>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>webScocket一对一聊天</title>
    <link rel="stylesheet" type="text/css" href="font_Icon/iconfont.css">
    <link rel="stylesheet" type="text/css" href="css/chat.css">
    <script type="text/javascript">
        var websocket = null;
        var alluser = new Array();
        var alljson = new Array();
        var nowtouser = null;
        var nowpage = 1;

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
                    var user = message.user;
                    alljson.push(message);
                    var flag = 0;
                    for (var i = 0; i < alluser.length; i++) {
                        if (alluser[i] == user)
                            flag = 1;
                    }
                    if (flag == 0) {
                        console.log("new user");
                        alluser.push(user);
                        showuser(user);
                    }

                    console.log(message);
                    showmsg(nowtouser);
                }
            };

            //连接关闭的回调方法
            websocket.onclose = function () {
                document.getElementById('status').innerHTML = "连接被成功关闭";
            };

            //监听窗口关闭事件，当窗口关闭时，主动去关闭websocket连接，防止连接还没断开就关闭窗口，server端会抛异常。
            window.onbeforeunload = function () {
                websocket.close();
            }
        }

        //关闭连接
        function closeWebSocket() {
            websocket.close();
        }

        //发送消息
        function send(textContent) {
            console.log("send msg")
            var sendUser = document.getElementById("sendUser").value;
            var toUser = nowtouser;

            var jsonMsg = {"sendUser": sendUser, "toUser": toUser, "message": textContent}
            console.log(jsonMsg)
            websocket.send(JSON.stringify(jsonMsg));

            document.getElementById('showMsg').innerHTML += textContent;
            var newj = {"user": toUser, "message": textContent, "type": 0}
            alljson.push(newj);
        }

        function showuser(user) {
            nowtouser = user;
            console.log("show user ")
            var hm = "<div onclick='showmsgpage(" + user + ")' class=\"chat-list-people\">\n" +
                "                    <div><img src=\"img/icon01.png\" alt=\"头像\"/></div>\n" +
                "                    <div class=\"chat-name\">\n" +
                "                        <p>" + user + "</p>\n" +
                "                    </div>\n" +
                "                    <div class=\"message-num\">10</div>\n" +
                "                </div>";

            document.getElementById('chatBox-list').innerHTML += hm;
        }

        function showmsgpage(user) {
            $(".chatBox-head-one").toggle();
            $(".chatBox-head-two").toggle();
            $(".chatBox-list").fadeToggle();
            $(".chatBox-kuang").fadeToggle();
            showmsg(user);
        }

        function showmsg(user) {
            nowpage = 2;
            document.getElementById('chatBox-content-demo').innerHTML = "";
            console.log("show msg")
            for (var i = 0; i < alljson.length; i++) {
                if (alljson[i].user == user)
                    if (alljson[i].type == 1) {
                        var inner = "<div class=\"clearfloat\">\n" +
                            "                            <div class=\"author-name\">\n" +
                            "                            </div>\n" +
                            "                            <div class=\"left\">\n" +
                            "                                <div class=\"chat-avatars\"><img src=\"img/icon01.png\" alt=\"头像\"/></div>\n" +
                            "                                <div class=\"chat-message\">\n" +
                            alljson[i].message +
                            "                                </div>\n" +
                            "                            </div>\n" +
                            "                        </div>";
                    } else {
                        var inner = "<div class=\"clearfloat\">" +
                            "<div class=\"author-name\"></div> " +
                            "<div class=\"right\"> <div class=\"chat-message\"> " + alljson[i].message + " </div> " +
                            "<div class=\"chat-avatars\"><img src=\"img/icon01.png\" alt=\"头像\" /></div> </div> </div>;"
                    }
                document.getElementById('chatBox-content-demo').innerHTML += inner;

                console.log("enter msg")


                //传名字
                $(".ChatInfoName").text(user);

                //聊天框默认最底部
                $(document).ready(function () {
                    $("#chatBox-content-demo").scrollTop($("#chatBox-content-demo")[0].scrollHeight);
                });
            }
        }
    </script>
</head>
<body>
账　号:<input type="text" name="sendUser" id="sendUser"/>
<input type="button" id="login" value="登录" onclick="login()"/>
<input type="button" onclick="closeWebSocket()" value="退出"/>
在线人数:<font id="count"></font>　　　连接状态:<font id="status"></font>
<div class="chatContainer">
    <div class="chatBtn">
        <i class="iconfont icon-xiaoxi1"></i>
    </div>
    <div class="chat-message-num">10</div>
    <div class="chatBox" ref="chatBox">
        <div class="chatBox-head">
            <div class="chatBox-head-one">
                Conversations
                <div class="chat-close" style="margin: 10px 10px 0 0;font-size: 14px">关闭</div>
            </div>
            <div class="chatBox-head-two">
                <div class="chat-return">返回</div>
                <div class="chat-people">

                    <div class="ChatInfoName">这是用户的名字，看看名字到底能有多长</div>
                </div>
                <div class="chat-close">关闭</div>
            </div>
        </div>
        <div class="chatBox-info">
            <div class="chatBox-list" id="chatBox-list" ref="chatBoxlist">

            </div>
            <div class="chatBox-kuang" ref="chatBoxkuang">
                <div class="chatBox-content">
                    <div class="chatBox-content-demo" id="chatBox-content-demo">


                    </div>
                </div>
                <div class="chatBox-send">
                    <div class="div-textarea" id="entermsgdiv" contenteditable="true"></div>
                    <div>

                        <button id="chat-fasong" class="btn-default-styles"><i class="iconfont icon-fasong"></i>
                        </button>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>


<script src="http://www.jq22.com/jquery/jquery-1.10.2.js"></script>
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


    //打开/关闭聊天框
    $(".chatBtn").click(function () {
        $(".chatBox").toggle(10);
    })
    $(".chat-close").click(function () {
        $(".chatBox").toggle(10);
    })

    //返回列表
    $(".chat-return").click(function () {
        $(".chatBox-head-one").toggle(1);
        $(".chatBox-head-two").toggle(1);
        $(".chatBox-list").fadeToggle(1);
        $(".chatBox-kuang").fadeToggle(1);
        nowpage = 1;
    });

    //      发送信息
    $("#chat-fasong").click(function () {
        var textContent = $(".div-textarea").html().replace(/[\n\r]/g, '<br>')
        if (textContent != "") {
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
            send(textContent);
        }
    });


</script>
</body>
</html>