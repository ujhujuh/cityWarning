<%--
  Created by IntelliJ IDEA.
  User: lxr
  Date: 2017/6/14
  Time: 23:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>修改密码</title>
    <script src="/test/static/common/header.js"></script>
    <script src="/test/static/common/validateUser.js"></script>
</head>
<body>
<nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 个人管理 <span class="c-gray en">&gt;</span><span id='head'></span>修改密码<a class="btn btn-success radius r" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
<article class="page-container">
    <form class="form form-horizontal" id="form-change-password">
        <div class="row cl">
            <label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>用户名：</label>
            <div class="formControls col-xs-8 col-sm-9" id="username"></div>
        </div>
        <div class="row cl">
            <label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>新密码：</label>
            <div class="formControls col-xs-8 col-sm-9">
                <input id="newpassword" name="newpassword" type="password" class="input-text" autocomplete="off" placeholder="不修改请留空">
            </div>
        </div>
        <div class="row cl">
            <label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>确认密码：</label>
            <div class="formControls col-xs-8 col-sm-9">
                <input id="newpassword2" name="newpassword2" type="password" class="input-text" autocomplete="off" placeholder="不修改请留空">
            </div>
        </div>
        <div class="row cl">
            <div class="col-xs-8 col-sm-9 col-xs-offset-4 col-sm-offset-3">
                <input class="btn btn-primary radius" type="submit" value="&nbsp;&nbsp;保存&nbsp;&nbsp;">
            </div>
        </div>
    </form>
</article>
</body>
<script type="text/javascript" src="/test/lib/jquery.validation/1.14.0/jquery.validate.js"></script>
<script type="text/javascript" src="/test/lib/jquery.validation/1.14.0/validate-methods.js"></script>
<script type="text/javascript" src="/test/lib/jquery.validation/1.14.0/messages_zh.js"></script>

<script type="text/javascript">
    $(function(){
        setTimeout(function(){
            $('#username').html(user.userName);
        }, 200);
        $("#form-change-password").validate({
            rules:{
                newpassword:{
                    required:true,
                    minlength:6,
                    maxlength:16
                },
                newpassword2:{
                    required:true,
                    minlength:6,
                    maxlength:16,
                    equalTo: "#newpassword"
                },
            },
            onkeyup:false,
            focusCleanup:true,
            success:"valid",
            submitHandler:function(form){
                changePassword();
            }
        });
    });

    function changePassword() {
        var params = {
            id: user.id,
            password: $('#newpassword').val()
        };
        $.ajax({
            type: 'post',
            url: '/test/user/update',
            dataType: 'json',
            contentType: 'application/json',
            data: JSON.stringify(params),
            success: function (status) {
                if (status == 1) {
                    layer.msg('修改成功!', {icon: 1, time: 1000}, function () {
                        location.reload();
                    });
                } else {
                    layer.msg('修改失败!', {icon: 1, time: 1000}, function () {
                        location.reload();
                    });
                }
            },
            error: function () {
                alert('error')
            }
        })
    }
</script>
</html>
