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
                    var content = message.neirong;
                    var user = message.user;

                    console.log(message);


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
            document.getElementById('showMsg').innerHTML += innerHTML;
        }

        //关闭连接
        function closeWebSocket() {
            websocket.close();
        }

        //发送消息
        function send() {
            var sendUser = document.getElementById("sendUser").value;
            var toUser = document.getElementById("toUser").value;
            var message = document.getElementById("message").value;

            var jsonMsg = {"sendUser": sendUser, "toUser": toUser, "message": message}
            websocket.send(JSON.stringify(jsonMsg));

            document.getElementById('showMsg').innerHTML += message;
        }
    </script>
</head>
<body>
账　号:<input type="text" name="sendUser" id="sendUser"/>
<input type="button" id="login" value="登录" onclick="login()"/>
<input type="button" onclick="closeWebSocket()" value="退出"/>
在线人数:<font id="count"></font>　　　连接状态:<font id="status"></font>

<br/>
接收人:<input type="text" name="toUser" id="toUser"/><br/>
消息框:<br/>
<textarea rows="5" cols="5" id="showMsg" name="showMsg" disabled="disabled"
          style="width: 302px; height: 111px; "></textarea><br/>
<textarea rows="5" cols="5" id="message" name="sendMsg" style="width: 302px; height: 111px; "></textarea><br/>
<input type="button" value="发送" onclick="send()"/>　<input type="button" value="关闭" onclick="closeWebSocket()"/>

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
                    <div class="ChatInfoHead">
                        <img src="" alt="头像"/>
                    </div>
                    <div class="ChatInfoName">这是用户的名字，看看名字到底能有多长</div>
                </div>
                <div class="chat-close">关闭</div>
            </div>
        </div>
        <div class="chatBox-info">
            <div class="chatBox-list" ref="chatBoxlist">
                <div class="chat-list-people">
                    <div><img src="img/icon01.png" alt="头像"/></div>
                    <div class="chat-name">
                        <p>自酌一杯酒</p>
                    </div>
                    <div class="message-num">10</div>
                </div>
                <div class="chat-list-people">
                    <div><img src="img/icon02.png" alt="头像"/></div>
                    <div class="chat-name">
                        <p>白兰地</p>
                    </div>
                    <div class="message-num">8</div>
                </div>
                <div class="chat-list-people">
                    <div><img src="img/icon03.png" alt="头像"/></div>
                    <div class="chat-name">
                        <p>威士忌</p>
                    </div>
                    <div class="message-num">2</div>
                </div>
                <div class="chat-list-people">
                    <div><img src="img/icon01.png" alt="头像"/></div>
                    <div class="chat-name">
                        <p>荷兰金酒</p>
                    </div>
                    <div class="message-num">20</div>
                </div>
                <div class="chat-list-people">
                    <div><img src="img/icon03.png" alt="头像"/></div>
                    <div class="chat-name">
                        <p>朗姆酒</p>
                    </div>
                    <div class="message-num">10</div>
                </div>
                <div class="chat-list-people">
                    <div><img src="img/icon02.png" alt="头像"/></div>
                    <div class="chat-name">
                        <p>特其拉酒</p>
                    </div>
                    <div class="message-num">18</div>
                </div>
                <div class="chat-list-people">
                    <div><img src="img/icon02.png" alt="头像"/></div>
                    <div class="chat-name">
                        <p>鸡尾酒</p>
                    </div>
                    <div class="message-num">9</div>
                </div>
                <div class="chat-list-people">
                    <div><img src="img/icon01.png" alt="头像"/></div>
                    <div class="chat-name">
                        <p>虎骨酒</p>
                    </div>
                    <div class="message-num">12</div>
                </div>
                <div class="chat-list-people">
                    <div><img src="img/icon01.png" alt="头像"/></div>
                    <div class="chat-name">
                        <p>琴酒</p>
                    </div>
                    <div class="message-num">99+</div>
                </div>
                <div class="chat-list-people">
                    <div><img src="img/icon02.png" alt="头像"/></div>
                    <div class="chat-name">
                        <p>葡萄酒</p>
                    </div>
                    <div class="message-num"></div>
                </div>
                <div class="chat-list-people">
                    <div><img src="img/icon01.png" alt="头像"/></div>
                    <div class="chat-name">
                        <p>蓝莓酒</p>
                    </div>
                    <div class="message-num"></div>
                </div>
                <div class="chat-list-people">
                    <div><img src="img/icon03.png" alt="头像"/></div>
                    <div class="chat-name">
                        <p>樱花酒</p>
                    </div>
                    <div class="message-num"></div>
                </div>
            </div>
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
                        <button id="chat-biaoqing" class="btn-default-styles">
                            <i class="iconfont icon-biaoqing"></i>
                        </button>
                        <label id="chat-tuxiang" title="发送图片" for="inputImage" class="btn-default-styles">
                            <input type="file" onchange="selectImg(this)" accept="image/jpg,image/jpeg,image/png"
                                   name="file" id="inputImage" class="hidden">
                            <i class="iconfont icon-tuxiang"></i>
                        </label>
                        <button id="chat-fasong" class="btn-default-styles"><i class="iconfont icon-fasong"></i>
                        </button>
                    </div>
                    <div class="biaoqing-photo">
                        <ul>
                            <li><span class="emoji-picker-image" style="background-position: -9px -18px;"></span></li>
                            <li><span class="emoji-picker-image" style="background-position: -40px -18px;"></span></li>
                            <li><span class="emoji-picker-image" style="background-position: -71px -18px;"></span></li>
                            <li><span class="emoji-picker-image" style="background-position: -102px -18px;"></span></li>
                            <li><span class="emoji-picker-image" style="background-position: -133px -18px;"></span></li>
                            <li><span class="emoji-picker-image" style="background-position: -164px -18px;"></span></li>
                            <li><span class="emoji-picker-image" style="background-position: -9px -52px;"></span></li>
                            <li><span class="emoji-picker-image" style="background-position: -40px -52px;"></span></li>
                            <li><span class="emoji-picker-image" style="background-position: -71px -52px;"></span></li>
                            <li><span class="emoji-picker-image" style="background-position: -102px -52px;"></span></li>
                            <li><span class="emoji-picker-image" style="background-position: -133px -52px;"></span></li>
                            <li><span class="emoji-picker-image" style="background-position: -164px -52px;"></span></li>
                            <li><span class="emoji-picker-image" style="background-position: -9px -86px;"></span></li>
                            <li><span class="emoji-picker-image" style="background-position: -40px -86px;"></span></li>
                            <li><span class="emoji-picker-image" style="background-position: -71px -86px;"></span></li>
                            <li><span class="emoji-picker-image" style="background-position: -102px -86px;"></span></li>
                            <li><span class="emoji-picker-image" style="background-position: -133px -86px;"></span></li>
                            <li><span class="emoji-picker-image" style="background-position: -164px -86px;"></span></li>
                            <li><span class="emoji-picker-image" style="background-position: -9px -120px;"></span></li>
                            <li><span class="emoji-picker-image" style="background-position: -40px -120px;"></span></li>
                            <li><span class="emoji-picker-image" style="background-position: -71px -120px;"></span></li>
                            <li><span class="emoji-picker-image" style="background-position: -102px -120px;"></span>
                            </li>
                            <li><span class="emoji-picker-image" style="background-position: -133px -120px;"></span>
                            </li>
                            <li><span class="emoji-picker-image" style="background-position: -164px -120px;"></span>
                            </li>
                            <li><span class="emoji-picker-image" style="background-position: -9px -154px;"></span></li>
                            <li><span class="emoji-picker-image" style="background-position: -40px -154px;"></span></li>
                            <li><span class="emoji-picker-image" style="background-position: -71px -154px;"></span></li>
                            <li><span class="emoji-picker-image" style="background-position: -102px -154px;"></span>
                            </li>
                            <li><span class="emoji-picker-image" style="background-position: -133px -154px;"></span>
                            </li>
                            <li><span class="emoji-picker-image" style="background-position: -164px -154px;"></span>
                            </li>
                        </ul>
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

    (window.onresize = function () {
        screenFuc();
    })();
    //未读信息数量为空时
    var totalNum = $(".chat-message-num").html();
    if (totalNum == "") {
        $(".chat-message-num").css("padding", 0);
    }
    $(".message-num").each(function () {
        var wdNum = $(this).html();
        if (wdNum == "") {
            $(this).css("padding", 0);
        }
    });


    //打开/关闭聊天框
    $(".chatBtn").click(function () {
        $(".chatBox").toggle(10);
    })
    $(".chat-close").click(function () {
        $(".chatBox").toggle(10);
    })
    //进聊天页面
    $(".chat-list-people").each(function () {
        $(this).click(function () {
            var n = $(this).index();
            $(".chatBox-head-one").toggle();
            $(".chatBox-head-two").toggle();
            $(".chatBox-list").fadeToggle();
            $(".chatBox-kuang").fadeToggle();

            //传名字
            $(".ChatInfoName").text($(this).children(".chat-name").children("p").eq(0).html());

            //传头像
            $(".ChatInfoHead>img").attr("src", $(this).children().eq(0).children("img").attr("src"));

            //聊天框默认最底部
            $(document).ready(function () {
                $("#chatBox-content-demo").scrollTop($("#chatBox-content-demo")[0].scrollHeight);
            });
        })
    });

    //返回列表
    $(".chat-return").click(function () {
        $(".chatBox-head-one").toggle(1);
        $(".chatBox-head-two").toggle(1);
        $(".chatBox-list").fadeToggle(1);
        $(".chatBox-kuang").fadeToggle(1);
    });

    //      发送信息
    $("#chat-fasong").click(function () {
        var textContent = $(".div-textarea").html().replace(/[\n\r]/g, '<br>')
        if (textContent != "") {
            $(".chatBox-content-demo").append("<div class=\"clearfloat\">" +
                "<div class=\"author-name\"><small class=\"chat-date\">2017-12-02 14:26:58</small> </div> " +
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

    //      发送表情
    $("#chat-biaoqing").click(function () {
        $(".biaoqing-photo").toggle();
    });
    $(document).click(function () {
        $(".biaoqing-photo").css("display", "none");
    });
    $("#chat-biaoqing").click(function (event) {
        event.stopPropagation();//阻止事件
    });

    $(".emoji-picker-image").each(function () {
        $(this).click(function () {
            var bq = $(this).parent().html();
            console.log(bq)
            $(".chatBox-content-demo").append("<div class=\"clearfloat\">" +
                "<div class=\"author-name\"><small class=\"chat-date\">2017-12-02 14:26:58</small> </div> " +
                "<div class=\"right\"> <div class=\"chat-message\"> " + bq + " </div> " +
                "<div class=\"chat-avatars\"><img src=\"img/icon01.png\" alt=\"头像\" /></div> </div> </div>");
            //发送后关闭表情框
            $(".biaoqing-photo").toggle();
            //聊天框默认最底部
            $(document).ready(function () {
                $("#chatBox-content-demo").scrollTop($("#chatBox-content-demo")[0].scrollHeight);
            });
        })
    });

    //      发送图片
    function selectImg(pic) {
        if (!pic.files || !pic.files[0]) {
            return;
        }
        var reader = new FileReader();
        reader.onload = function (evt) {
            var images = evt.target.result;
            $(".chatBox-content-demo").append("<div class=\"clearfloat\">" +
                "<div class=\"author-name\"><small class=\"chat-date\">2017-12-02 14:26:58</small> </div> " +
                "<div class=\"right\"> <div class=\"chat-message\"><img src=" + images + "></div> " +
                "<div class=\"chat-avatars\"><img src=\"img/icon01.png\" alt=\"头像\" /></div> </div> </div>");
            //聊天框默认最底部
            $(document).ready(function () {
                $("#chatBox-content-demo").scrollTop($("#chatBox-content-demo")[0].scrollHeight);
            });
        };
        reader.readAsDataURL(pic.files[0]);

    }


</script>
</body>
</html>