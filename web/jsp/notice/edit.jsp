<%--
  Created by IntelliJ IDEA.
  User: asus
  Date: 2017/6/15
  Time: 23:08
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <meta charset="utf-8" />
  <title>修改公告</title>
  <script src="/test/static/common/header.js"></script>
  <script src="/test/static/common/utils.js"></script>
  <script src="/test/static/common/validateUser.js"></script>
  <link href="/test/lib/My97DatePicker/4.8/skin/WdatePicker.css" rel="stylesheet" type="text/css">
  <%--<script type="text/javascript" src="/test/xheditor/jquery/jquery-1.4.4.min.js"></script>--%>
  <%--<script type="text/javascript" src="/test/xheditor/xheditor-1.1.14-zh-cn.min.js"></script>--%>
</head>
<body>
<article class="page-container">
  <form class="form form-horizontal" id="edit">
    <div class="row cl">
      <label class="form-label col-xs-4 col-sm-3" style="text-align: left;"><span class="c-red">*</span>标题：</label>
      <div class="formControls col-xs-8 col-sm-9" style="text-align: left;">
        <input type="text" class="input-text" placeholder="" id="title" name="title">
      </div>
    </div>
    <div class="row cl">
      <label class="form-label col-xs-4 col-sm-3" style="text-align: left;"><span class="c-red">*</span>内容：</label>
      <div class="formControls col-xs-8 col-sm-9">
        <textarea id="content" class="xheditor {skin:'default'}" style="width: 800px; height: 400px;"></textarea>
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
<script type="text/javascript" src="/test/lib/My97DatePicker/4.8/WdatePicker.js"></script>
<script type="text/javascript">
  var id = getUrlParam('id');
  loadPage(id);
  function loadPage(id) {
    handleAjax('notice/find?id='+ id).done(function(data) {
           $('#title').val(data.title),
           $('#content').val(data.content)
    }).fail(function(xhr, error){
      alert('error')
    })
  }

  $(function(){
    $("#edit").validate({
      rules:{
        title:{
          required:true,
          rangelength:[5,20]
        },
        userName:{
          required:true,
          rangelength:[2,10]
        },
        content:{
          required:true
        }
      },
      onkeyup:false,
      focusCleanup:true,
      success:"valid",
      submitHandler:function(form){
        setTimeout(function(){
          edit();
        }, 200);
      }
    });
  });

  function edit(){
    var editor=$('#content').xheditor({tools:'full',skin:'default'});
    var sHtml=editor.getSource()
    alert(sHtml)
    // 添加公告
    var params = {
      title: $('#title').val(),
      content: sHtml
    }
    $.ajax({
      type: 'post',
      url: '/test/notice/update',
      dataType: 'json',
      contentType: 'application/json',
      data:JSON.stringify(params),
      success: function(result) {
        if(result==1){
          layer.msg('添加成功!', {icon:1,time:1000}, function(){
            refresh();
          });
        }else{
          layer.msg('添加失败!', {icon:1,time:1000}, function(){
            refresh();
          });
        }
      },
      error: function() {
        alert('error')
      }
    });
  }
</script>

</body>
</html>
