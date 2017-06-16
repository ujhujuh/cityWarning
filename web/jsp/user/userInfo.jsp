<%--
  Created by IntelliJ IDEA.
  User: lxr
  Date: 2017/6/16
  Time: 3:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>用户信息</title>
    <script src="/test/static/common/header.js"></script>
    <script src="/test/static/common/utils.js"></script>
    <script src="/test/static/common/validateUser.js"></script>
</head>
<body>
<div class="cl pd-20" style=" background-color:#5bacb6">
    <img class="avatar size-XL l" src="/test/static/h-ui/images/ucnter/avatar-default.jpg">
    <dl style="margin-left:80px; color:#333">
        <dt>
            <span class="f-18" id='realname'></span>
            <span class="pl-10 f-12" id='role'></span>
        </dt>
        <dd class="pt-10 f-12" style="margin-left:0">用户名：<span id='username'></span></dd>
    </dl>
</div>
<div class="pd-20">
    <table class="table">
        <tbody>
        <tr>
            <th class="text-r" width="80">性别：</th>
            <td id='gender'></td>
        </tr>
        <tr>
            <th class="text-r">年龄：</th>
            <td id='age'></td>
        </tr>
        <tr>
            <th class="text-r">电话：</th>
            <td id='tel'></td>
        </tr>
        <tr>
            <th class="text-r">邮箱：</th>
            <td id='mail'></td>
        </tr>
        <tr>
            <th class="text-r">注册时间：</th>
            <td id='createTime'></td>
        </tr>
        </tbody>
    </table>
</div>
</body>
</html>

<script>
    $(function(){
        setTimeout(function(){
            $('#realname').html(user.realName);
            $('#role').html(user.role);
            $('#username').html(user.userName);
            $('#gender').html(user.gender == 1 ? '男' : '女');
            $('#age').html(user.age);
            $('#tel').html(user.telphone);
            $('#mail').html(user.address);
            $('#createTime').html(user.createTime);
        }, 200);
    })
</script>

