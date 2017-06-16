
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Title</title>
  <script src="/test/static/common/header.js"></script>
  <script src="/test/static/common/utils.js"></script>
  <script src="/test/static/common/validateUser.js"></script>
  <link href="/test/lib/My97DatePicker/4.8/skin/WdatePicker.css" rel="stylesheet" type="text/css">
  <script type="text/javascript" src="/test/xheditor/jquery/jquery-1.4.4.min.js"></script>
  <script type="text/javascript" src="/test/xheditor/xheditor-1.1.14-zh-cn.min.js"></script>
</head>
<body>
<article class="page-container">
  <form class="form form-horizontal" id="form-add">
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
        <input class="btn btn-primary radius" type="submit"  value="&nbsp;&nbsp;提交&nbsp;&nbsp;">
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
    $("#form-add").validate({
      rules:{
        title:{
          required:true,
          rangelength:[5,15]
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
          add();
        }, 200);
      }
    });
  });

  function add() {
    var editor=$('#content').xheditor({tools:'full',skin:'default'});
    var sHtml=editor.getSource();
    // 添加公告
    var params = {
      title: $('#title').val(),
      content: sHtml
    }
  console.info(params)
  $.ajax({
    type: 'post',
    url: '/test/notice/insert',
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
</html>
