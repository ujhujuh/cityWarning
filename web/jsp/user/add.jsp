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
    <title>添加用户</title>
    <script src="/test/static/common/header.js"></script>
    <script src="/test/static/common/utils.js"></script>
    <script src="/test/static/common/validateUser.js"></script>
</head>
<body>
<article class="page-container">
    <form action="" method="post" class="form form-horizontal" id="form-user-add">
        <div class="row cl">
            <label class="form-label col-xs-3 col-sm-3" style="text-align: right;"><span class="c-red">*</span>用户名：</label>
            <div class="formControls col-xs-8 col-sm-9">
                <input type="text" class="input-text" value="" placeholder="" id="username" name="username">
            </div>
        </div>
        <div class="row cl">
            <label class="form-label col-xs-3 col-sm-3" style="text-align: right;"><span class="c-red">*</span>真实姓名：</label>
            <div class="formControls col-xs-8 col-sm-9">
                <input type="text" class="input-text" value="" placeholder="" id="realname" name="realname">
            </div>
        </div>
        <div class="row cl">
            <label class="form-label col-xs-3 col-sm-3" style="text-align: right;"><span class="c-red">*</span>性别：</label>
            <div class="formControls col-xs-8 col-sm-9 skin-minimal">
                <div class="radio-box">
                    <input type="radio" name="sex" value="1" checked>
                    <label for="sex-1">男</label>
                </div>
                <div class="radio-box">
                    <input type="radio" name="sex" value="2">
                    <label for="sex-2">女</label>
                </div>
            </div>
        </div>
        <div class="row cl">
            <label class="form-label col-xs-3 col-sm-3" style="text-align: right;"><span class="c-red">*</span>手机：</label>
            <div class="formControls col-xs-8 col-sm-9">
                <input type="text" class="input-text" value="" placeholder="" id="tel" name="tel">
            </div>
        </div>
        <div class="row cl">
            <label class="form-label col-xs-3 col-sm-3" style="text-align: right;"><span class="c-red">*</span>邮箱：</label>
            <div class="formControls col-xs-8 col-sm-9">
                <input type="text" class="input-text" placeholder="@" name="email" id="email">
            </div>
        </div>
        <div class="row cl">
            <div class="col-xs-8 col-sm-9 col-xs-offset-3 col-sm-offset-3">
                <input class="btn btn-primary radius" type="submit" value="&nbsp;&nbsp;提交&nbsp;&nbsp;">
            </div>
        </div>
    </form>
</article>

<!--请在下方写此页面业务相关的脚本-->
<script type="text/javascript" src="/test/lib/jquery.validation/1.14.0/jquery.validate.js"></script>
<script type="text/javascript" src="/test/lib/jquery.validation/1.14.0/validate-methods.js"></script>
<script type="text/javascript" src="/test/lib/jquery.validation/1.14.0/messages_zh.js"></script>
<script type="text/javascript">

    $(function(){
        $('.skin-minimal input').iCheck({
            checkboxClass: 'icheckbox-blue',
            radioClass: 'iradio-blue',
            increaseArea: '20%'
        });

        $("#form-user-add").validate({
            rules:{
                username:{
                    required:true,
                    minlength:4,
                    maxlength:10
                },
                realname:{
                    required:true,
                    minlength:2,
                    maxlength:10
                },
                sex:{
                    required:true,
                },
                tel:{
                    required:true,
                    isMobile:true,
                },
                email:{
                    required:true,
                    email:true,
                },
            },
            onkeyup:false,
            focusCleanup:true,
            success:"valid",
            submitHandler:function(form){
                add();
            }
        });
    });

    function add(){
        // 1.判断该username是否可用，若不存在则可用
        var user= {
            username: $('#username').val(),
        }
        handleAjax('user/isRegister', user).done(function(status){
            if (status == 1) {
                // 添加用户
                var params = {
                    userName: $('#username').val(),
                    realName: $('#realname').val(),
                    gender: $('input:radio[name="sex"]:checked').val(),
                    telphone: $('#tel').val(),
                    address: $('#email').val(),
                    type: 1,
                    password: '123456',
                    createTime: new Date(),
                }
                $.ajax({
                    type: 'post',
                    url: '/test/user/insert',
                    dataType: 'json',
                    contentType: 'application/json',
                    data: JSON.stringify(params),
                    success: function (result) {
                        if (result == 1) {
                            layer.msg('添加成功!', {icon: 1, time: 1000}, function () {
                                refresh();
                            });
                        } else {
                            layer.msg('添加失败!', {icon: 1, time: 1000}, function () {
                                refresh();
                            });
                        }
                    },
                    error: function () {
                        alert('error')
                    }
                });
            } else {
                layer.msg('对不起，该用户已被注册!', {icon:1,time:1000});
            }
        });
    }
</script>
</body>
</html>
