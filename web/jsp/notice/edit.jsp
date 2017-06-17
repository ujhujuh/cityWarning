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
  <script type="text/javascript" src="/test/static/common/header.js"></script>
  <script type="text/javascript" src="/test/static/common/utils.js"></script>
  <script type="text/javascript" src="/test/static/common/validateUser.js"></script>
  <%--<script type="text/javascript" src="/test/xheditor/jquery/jquery-1.4.4.min.js"></script>--%>
  <%--<script type="text/javascript" src="/test/xheditor/xheditor-1.1.14-zh-cn.min.js"></script>--%>
  <script type="text/javascript" charset="utf-8" src="/test/static/ueditor/ueditor.config.js"></script>
  <script type="text/javascript" charset="utf-8" src="/test/static/ueditor/ueditor.all.min.js"> </script>
  <style type="text/css">
    div{
      width:100%;
    }
  </style>
</head>
</head>
<body>
<article class="page-container">
  <form class="form form-horizontal" id="form-study-link-add">
    <div class="row cl">
      <label class="form-label col-xs-3 col-sm-3" style="text-align: right;width: 150px;"><span class="c-red">*</span>标题：</label>
      <div class="formControls col-xs-8 col-sm-9">
        <input type="text" class="input-text" value="" placeholder="" id="title" name="title">
      </div>
    </div>
    <div>
      <div id="editor" type="text/plain" style="width:850px;height:300px; margin-top: 20px;"></div>
        </div>
        <div class="row cl">
            <div class="col-xs-8 col-sm-9 col-xs-offset-3 col-sm-offset-3">
            <input class="btn btn-primary radius" onclick="edit()" type="submit" value="&nbsp;&nbsp;修改&nbsp;&nbsp;">
            </div>
            </div>
            </form>
            </article>
            </body>
            <script type="text/javascript" src="/test/lib/jquery.validation/1.14.0/jquery.validate.js"></script>
      <script type="text/javascript" src="/test/lib/jquery.validation/1.14.0/validate-methods.js"></script>
      <script type="text/javascript" src="/test/lib/jquery.validation/1.14.0/messages_zh.js"></script>
      <script type="text/javascript">
          var ue = UE.getEditor('editor');
          function isFocus(e){
              alert(UE.getEditor('editor').isFocus());
              UE.dom.domUtils.preventDefault(e)
          }
          function setblur(e){
              UE.getEditor('editor').blur();
              UE.dom.domUtils.preventDefault(e)
          }
          function insertHtml() {
              var value = prompt('插入html代码', '');
              UE.getEditor('editor').execCommand('insertHtml', value)
          }
          function createEditor() {
              enableBtn();
              UE.getEditor('editor');
          }

          $(function () {
              var id = getUrlParam('id');
              $.ajax({
                  type: 'post',
                  url: '/test/notice/find?id='+id,
                  contentType: 'application/json',
                  success: function(result) {
                      $("#title").val(result.title);
                      // editor准备好之后才可以使用
                      ue.addListener("ready", function () {
                          ue.setContent(result.content);
                      });


                  }
              })
          })

          function edit() {
              var id = getUrlParam('id');
              var params = {
                  id:id,
                  userId:user.id,
                  userName:user.realName,
                  title: $('#title').val(),
                  content: UE.getEditor('editor').getContent()
              };
              $.ajax({
                  type: 'post',
                  url: '/test/notice/update',
                  dataType: 'json',
                  contentType: 'application/json',
                  data:JSON.stringify(params),
                  success: function(result) {
                      if(result==1){
                          layer.msg('修改成功!', {icon:1,time:1000}, function(){
                              refresh();
                          });
                      }
                  },
                  error: function() {
                      refresh();
                  }
              })
          }
      </script>
</html>
