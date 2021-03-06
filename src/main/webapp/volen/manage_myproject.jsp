<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" pageEncoding="UTF-8" %>
<%@ page isELIgnored="false" %>

<!DOCTYPE HTML>
<html>

<head>

    <style type="text/css">
        table {
            width: 100%;
            text-align: center;
            margin-top: 1%
        }

        table tr {
            font-size: 18px;
            font-family: "微软雅黑";
            height: 40px;
        }

        table tr:nth-child(2n-1) {
            background-color: white;
        }

        table tr:nth-child(2n) {
            background-color: #E7E7E7;
        }
    </style>

</head>

<body style="font-family: '微软雅黑 Light';background: #f9f9f9 !important;">
<div style="margin-top:8px;height: 60px;font-size: 40px;border-bottom: 1px solid #ddd;">
    <span style="margin-left: 10%"><img src="images/m2.png">我发布的项目</span>
</div>
<table>
    <tr>

        <th>项目编号</th>
        <th>项目名</th>
        <th style="width: 300px">项目描述</th>
        <%--<th>项目开始时间</th>--%>
        <%--<th>项目结束时间</th>--%>
        <th>目标金额</th>
        <th>当前金额</th>
        <th>当前人数</th>
        <%--<th>投资前景</th>--%>
        <th>项目类型</th>
        <th>币种</th>
        <th>限制最大金额</th>
        <th>项目状态</th>
        <%--<th>项目团队介绍</th>--%>
        <%--<th>开发计划</th>--%>
        <%--<th>备注</th>--%>
        <th>详情</th>
        <th>修改</th>


    </tr>
    <c:forEach items="${mynewprojects}" var="pro">
        <tr>

            <td>${pro.pid}</td>
            <td>${pro.pname}</td>
            <td>${pro.pdesc}</td>
                <%--<td>${pro.psd}</td>--%>
                <%--<td>${pro.ped}</td>--%>
            <td>${pro.ptarget}</td>
            <td>${pro.pnm}</td>
            <td>${pro.pnp}</td>
                <%--<td>${pro.pMilestone}</td>--%>
            <td>${pro.projectTypeByPCategoryId.projecttypename}</td>
            <td>${pro.pmf}</td>
            <td>
                <c:if test="${pro.plimit==0}">
                    否
                </c:if>
                <c:if test="${pro.plimit==1}">
                    是
                </c:if>
            </td>
            <td>
                <c:if test="${pro.pstate == 0}">未开始</c:if>
                <c:if test="${pro.pstate == 1}">进行中</c:if>
                <c:if test="${pro.pstate == 2}">已完成</c:if>
                <c:if test="${pro.pstate == 3}">未成功</c:if>
            </td>
                <%--<td>${pro.pTeam}</td>--%>
                <%--<td>${pro.pPlan}</td>--%>
                <%--<td>${pro.pRemark}</td>--%>
            <td>
                <a href="ProjectDetails.mvc?pid=${pro.pid}">详情</a>
            </td>
            <td>
                <a href="PreUpdateProject.mvc?pid=${pro.pid}">更新</a>
            </td>
        </tr>
    </c:forEach>
</table>

</body>

</html>