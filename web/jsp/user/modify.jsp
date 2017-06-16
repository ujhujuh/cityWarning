<%--
  Created by IntelliJ IDEA.
  User: lxr
  Date: 2017/6/14
  Time: 23:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>修改用户</title>
    <script src="/test/static/common/header.js"></script>
    <script src="/test/static/common/utils.js"></script>
    <script src="/test/static/common/validateUser.js"></script>
</head>
<body>
<nav style='display: none;' class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 个人管理 <span class="c-gray en">&gt;</span><span id='head'></span>修改个人信息<a class="btn btn-success radius r" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
<article class="page-container">
    <form action="" method="post" class="form form-horizontal" id="form-member-add">
        <div class="row cl">
            <label class="form-label col-xs-3 col-sm-3" style="text-align: right;"><span class="c-red">*</span>用户名：</label>
            <div class="formControls col-xs-8 col-sm-9">
                <span id="username"></span>
            </div>
        </div>
        <div class="row cl">
            <label class="form-label col-xs-3 col-sm-3" style="text-align: right;"><span class="c-red">*</span>角色：</label>
            <div class="formControls col-xs-8 col-sm-9">
                <span id="role"></span>
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
                <input class="btn btn-primary radius" type="submit" value="&nbsp;&nbsp;修改&nbsp;&nbsp;">
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
//        var id = getUrlParam('id');
        var type = getUrlParam('type');
        // 显示用户信息，不是编辑
        if (type == 'mine') {
            setTimeout(function(){
                $('nav').show();
                id = user.id;
                loadPage(id);
            }, 200);
        } else {
            id = user.id;
            loadPage(id);
        }

        $('.skin-minimal input').iCheck({
            checkboxClass: 'icheckbox-blue',
            radioClass: 'iradio-blue',
            increaseArea: '20%'
        });

        $("#form-member-add").validate({
            rules:{
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
                id = user.id;
                userModify(id, type);
            }
        });
    });

    function loadPage(id) {
        handleAjax('user/find?id=' + id).done(function(data) {
            $('#username').html(data.userName);
            $('#role').html(data.type == 1 ? '普通人员' : '管理员');
            $('#realname').val(data.realName);
            $("input:radio[name='sex'][value=" + data.gender + "]").prop("checked", "checked");
            $('#tel').val(data.telphone);
            $('#email').val(data.address);
        }).fail(function(xhr, error){
            alert('error')
        })
    }

    function userModify(id, type){
        var params = {
            id: id,
            realName: $('#realname').val(),
            gender: $('input:radio[name="sex"]:checked').val(),
            telphone: $('#tel').val(),
            address: $('#email').val(),
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
                        if (type !== 'mine') {
                            refresh();
                        }
                    });
                }
            },
            error: function () {
                alert('error')
            }
        })
    }
</script>
</body>
</html>
