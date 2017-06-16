<%--
  Created by IntelliJ IDEA.
  User: lxr
  Date: 2017/6/15
  Time: 23:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <script src="/test/static/common/header.js"></script>
    <script src="/test/static/common/utils.js"></script>
    <script src="/test/static/common/validateUser.js"></script>
    <link href="/test/lib/My97DatePicker/4.8/skin/WdatePicker.css" rel="stylesheet" type="text/css">

</head>
<body>
<article class="page-container">
    <form class="form form-horizontal" id="form-study-link-add">
        <div class="row cl">
            <label class="form-label col-xs-3 col-sm-3" style="text-align: right;"><span class="c-red">*</span>城市：</label>
            <div class="formControls col-xs-8 col-sm-9">
                <input type="text" class="input-text" value="" placeholder="" id="city" name="city">
            </div>
        </div>
        <div class="row cl">
            <label class="form-label col-xs-3 col-sm-3" style="text-align: right;"><span class="c-red">*</span>aqi：</label>
            <div class="formControls col-xs-8 col-sm-9">
                <input type="text" class="input-text" value="" placeholder="" id="aqi" name="aqi">
            </div>
        </div>
        <div class="row cl">
            <label class="form-label col-xs-3 col-sm-3" style="text-align: right;"><span class="c-red">*</span>co：</label>
            <div class="formControls col-xs-8 col-sm-9">
                <input type="text" class="input-text" value="" placeholder="" id="co" name="co">
            </div>
        </div>
        <div class="row cl">
            <label class="form-label col-xs-3 col-sm-3" style="text-align: right;"><span class="c-red">*</span>pm2.5：</label>
            <div class="formControls col-xs-8 col-sm-9">
                <input type="text" class="input-text" value="" placeholder="" id="pm2" name="pm2">
            </div>
        </div>
        <div class="row cl">
            <label class="form-label col-xs-3 col-sm-3" style="text-align: right;"><span class="c-red">*</span>pm210：</label>
            <div class="formControls col-xs-8 col-sm-9">
                <input type="text" class="input-text" value="" placeholder="" id="pm10" name="pm10">
            </div>
        </div>
        <div class="row cl">
            <label class="form-label col-xs-3 col-sm-3" style="text-align: right;"><span class="c-red">*</span>时间：</label>
            <div class="formControls col-xs-8 col-sm-9">
                <input type="text" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" id="createTime" class="input-text Wdate" style="width:180px;">
            </div>
        </div>
        <div class="row cl">
            <div class="col-xs-8 col-sm-9 col-xs-offset-3 col-sm-offset-3">
                <input class="btn btn-primary radius" type="submit" value="&nbsp;&nbsp;添加&nbsp;&nbsp;">
            </div>
        </div>
    </form>
</article>
</body>
<script type="text/javascript" src="/test/lib/jquery.validation/1.14.0/jquery.validate.js"></script>
<script type="text/javascript" src="/test/lib/jquery.validation/1.14.0/validate-methods.js"></script>
<script type="text/javascript" src="/test/lib/jquery.validation/1.14.0/messages_zh.js"></script>
<script type="text/javascript" src="/test/lib/My97DatePicker/4.8/WdatePicker.js"></script>
<script type="text/javascript">
    $(function(){
        $('.skin-minimal input').iCheck({
            checkboxClass: 'icheckbox-blue',
            radioClass: 'iradio-blue',
            increaseArea: '20%'
        });

        $("#form-study-link-add").validate({
            rules:{
                city:{
                    required:true
                },
                aqi:{
                    required:true,
                    digits:true,
                    max:200,
                    min:1
                },
                co:{
                    required:true,
                    number:true,
                    max:200,
                    min:1                },
                pm2:{
                    digits:true,
                    number:true,
                    max:200,
                    min:1
                },
                pm10:{
                    digits:true,
                    number:true,
                    max:200,
                    min:1
                },
                createTime:{
                    required:true
                }
            },
            onkeyup:false,
            focusCleanup:true,
            success:"valid",
            submitHandler:function(form){
                setTimeout(function(){
                    add();
                }, 200);
            }
        });
    });

    function add(userId) {
        // 添加资源
        var params = {
            city: $('#city').val(),
            aqi: $('#aqi').val(),
            co: $('#co').val(),
            pm2: $('#pm2').val(),
            pm10: $('#pm10').val(),
            createTime: new Date($('#createTime').val())
        };
        console.info(params)
        $.ajax({
            type: 'post',
            url: '/test/cityWarning/insert',
            dataType: 'json',
            contentType: 'application/json',
            data:JSON.stringify(params),
            success: function(result) {
                if(result==1){
                    layer.msg('添加成功!', {icon:1,time:1000}, function(){
                        refresh();
                    });
                }
            },
            error: function() {
                alert('error')
            }
        })
    }
</script>
</html>
