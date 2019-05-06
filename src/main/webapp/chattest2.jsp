<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" pageEncoding="UTF-8" %>
<%@ page isELIgnored="false" %>


<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">



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
                    setMessageInnerHTML(event.data);
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
ser" id="sendUser"/>v
<input type="button" id="login" value="登录" onclick="login()"/>
<input type="button" onclick="closeWebSocket()" value="退出"/>
在线人数:<font id="count"></font>　　　连接状态:<font id="status"></font>

<br/>
接收人:<input type="text" name="toUser" id="toUser"/><br/>
<input type="button" value="发送" onclick="send()"/>
　<input type="button" value="关闭" onclick="closeWebSocket()"/>
<div class="chatContainer">
    <div class="chatBtn">
        <i class="iconfont icon-xiaoxi1"></i>
    </div>
    <div class="chat-message-num">10</div>
    <div class="chatBox" ref="chatBox">
        <div class="chatBox-head">
            <div class="chatBox-head-two">
                <div class="chat-close" onclick="closeWebSocket()">关闭</div>
            </div>
        </div>
        <div class="chatBox-info">
            <div class="chatBox-kuang" ref="chatBoxkuang">
                <div class="chatBox-content">
                    <div class="chatBox-content-demo" id="chatBox-content-demo">

                        <div class="clearfloat">
                            <div class="author-name">
                                <small class="chat-date">2017-12-02 14:26:58</small>
                            </div>
                            <div class="left">
                                <div class="chat-avatars"><img src="img/icon01.png" alt="头像"/></div>
                                <div class="chat-message">
                                    给你看张图
                                </div>
                            </div>
                        </div>

                        <div class="clearfloat">
                            <div class="author-name">
                                <small class="chat-date">2017-12-02 14:26:58</small>
                            </div>
                            <div class="left">
                                <div class="chat-avatars"><img src="img/icon01.png" alt="头像"/></div>
                                <div class="chat-message">
                                    <img src="img/1.png" alt="">
                                </div>
                            </div>
                        </div>

                        <div class="clearfloat">
                            <div class="author-name">
                                <small class="chat-date">2017-12-02 14:26:58</small>
                            </div>
                            <div class="right">
                                <div class="chat-message">嗯，适合做壁纸</div>
                                <div class="chat-avatars"><img src="img/icon02.png" alt="头像"/></div>
                            </div>
                        </div>

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
    $(".chatBtn").click(function () {
        $(".chatBox").toggle(10);
    })
    $(".chat-close").click(function () {
        $(".chatBox").toggle(10);
    })


</script>

</body>
</html>
