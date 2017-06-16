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
</head>
<body>
<article class="page-container">
    <div class="row cl">
      <div style="text-align: center">
        <strong><span id="title"></span></strong>
      </div>
      <div id="content">

      </div>
    </div>
</article>
<!--请在下方写此页面业务相关的脚本-->
<script type="text/javascript" src="/test/lib/jquery.validation/1.14.0/jquery.validate.js"></script>
<script type="text/javascript" src="/test/lib/jquery.validation/1.14.0/validate-methods.js"></script>
<script type="text/javascript" src="/test/lib/jquery.validation/1.14.0/messages_zh.js"></script>
<script type="text/javascript" src="/test/lib/My97DatePicker/4.8/WdatePicker.js"></script>
<script type="text/javascript">
  $(function () {
      var id = getUrlParam('id');
      loadPage(id);
  })

  function loadPage(id) {
    handleAjax('notice/find?id='+ id).done(function(data) {
        $("#title").text(data.title);
        $("#content").html(data.content);
    }).fail(function(xhr, error){
      alert('error')
    })
  }
</script>
</body>
</html>
