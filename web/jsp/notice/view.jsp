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
  <script type="text/javascript" src="/test/xheditor/jquery/jquery-1.4.4.min.js"></script>
  <script type="text/javascript" src="/test/xheditor/xheditor-1.1.14-zh-cn.min.js"></script>
</head>
<body>
<article class="page-container">
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
    <label class="form-label col-xs-4 col-sm-3" style="text-align: left;"><span class="c-red">*</span>添加人：</label>
    <div class="formControls col-xs-8 col-sm-9" style="text-align: left;">
      <input type="text" class="input-text" placeholder="" id="userName" name="userName">
    </div>
  </div>
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
      $('#userName').val(data.userName),
      $('#content').val(data.content)
    }).fail(function(xhr, error){
      alert('error')
    })
  }
</script>
</body>
</html>
