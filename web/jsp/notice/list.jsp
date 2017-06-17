<%--
  Created by IntelliJ IDEA.
  User: lxr
  Date: 2017/6/14
  Time: 23:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <meta charset="utf-8" />
  <script src="/test/static/common/header.js"></script>
  <script src="/test/static/common/utils.js"></script>
</head>
<body >
<nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 基础数据维护 <span class="c-gray en">&gt;</span><span id='head'>公告管理</span><a class="btn btn-success radius r" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
<div class="page-container" style='margin-top: -20px;'>
  <div class="cl pd-5 bg-1 bk-gray mt-20"> <span class="l"><a href="javascript:;" onclick="add()" class="btn btn-primary radius"><i class="Hui-iconfont">&#xe600;</i> <span id='addButton'>添加公告</span></a></span></div>
  <div class="mt-20">
    <table class="table table-border table-bordered table-hover table-bg table-sort">
      <thead>
      <tr class="text-c">
        <th width="100">标题</th>
        <th width="40">添加人</th>
        <th width="100">操作</th>
      </tr>
      </thead>
    </table>
  </div>
</div>
<!--请在下方写此页面业务相关的脚本-->
<script type="text/javascript" src="/test/lib/datatables/1.10.0/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="/test/lib/laypage/1.2/laypage.js"></script>
<script type="text/javascript">
  $(function(){
    $('.table-sort').dataTable({
      "aaSorting": [[1, "desc" ]],//默认第几个排序
      "bStateSave": true//状态保存
    });
    loadList();
  });
  /*公告-列表*/
  function loadList() {
    handleAjax('notice/list?currentPage=1&pageSize=100').done(function(result){
      var data=result.list;
      if (data == null) {
        $('tbody').html('暂无数据');
        return;
      }
      var str = ''
      for (var i=0; i<data.length; i++) {
        str +=
                '<tr class="text-c">' +
                '<th>' + data[i].title + '</th>' +
                '<td>' + data[i].userName + '</td>' +
                '<td class="td-manage">' +
                '<a title="编辑" href="javascript:;" onclick="edit(' + data[i].id + ')" class="ml-5" style="text-decoration:none"><i class="Hui-iconfont">&#xe6df;</i></a>' +
                '<a title="删除" href="javascript:;" onclick="del(' + data[i].id + ')" class="ml-5" style="text-decoration:none"><i class="Hui-iconfont">&#xe6e2;</i></a>' +
                '<a title="查看" href="javascript:;" onclick="view('+data[i].id +')" class="ml-5" style="text-decoration:none"><i class="Hui-iconfont">&#xe709;</i></a>'+
                '</td>' +
                '</tr>';
      };
      $('tbody').html(str);
    }).fail(function(xhr, error){
      alert('error');
    });
  }
  /*公告-添加*/
  function add(){
    layer_show('添加公告', 'add.jsp', '900', '600');
  }
  /*公告-编辑*/
  function edit(id){
    layer_show('编辑公告', 'edit.jsp?id=' + id, '900', '600');
  }
  function view(id) {
    layer_show('查看', 'view.jsp?id=' + id, '900', '600');
  }
  /*公告-删除*/
  function del(id){
    layer.confirm('确认要删除该公告吗？',function(index){
      handleAjax('notice/delete?id='+ id).done(function(result){
        if (result!=null) {
          layer.msg('已删除!', {icon:1,time:1000}, function(){
            window.location.reload();
          });
        } else {
          layer.msg(result.msg, {icon:1,time:1000});
        }
      }).fail(function(xhr, error){
        alert('error');
      });
    });
  }
</script>
</body>
</html>
