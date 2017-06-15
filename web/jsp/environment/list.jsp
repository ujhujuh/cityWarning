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
    <title>环境</title>
    <script src="/test/static/common/header.js"></script>
    <script src="/test/static/common/export.js"></script>
    <script src="/test/static/common/utils.js"></script>
    <script src="/test/static/common/validateUser.js"></script>
    <link rel="stylesheet" type="text/css" href="/test/static/h-ui.admin/skin/default/skin.css" id="skin" />
</head>
<body>
<nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 环境管理 <span class="c-gray en">&gt;</span><span>城市环境列表</span><a class="btn btn-success radius r" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
<div class="page-container" style='margin-top: -20px;'>
    <div class="cl pd-5 bg-1 bk-gray mt-20"> <span class="l"><a href="javascript:;" onclick="add()" class="btn btn-primary radius"><i class="Hui-iconfont">&#xe600;</i><span>添加</span></a></span><span class="l">&nbsp;&nbsp;&nbsp;<a href="javascript:;" onclick="method5('table')" class="btn btn-primary radius"><i class="Hui-iconfont"></i><span>导出</span></a></span>  </div>
    <div class="mt-20">
        <table id="table" class="table table-border table-bordered table-hover table-bg table-sort">
            <thead>
            <tr class="text-c">
                <th width="100">ID</th>
                <th width="70">城市</th>
                <th width="100">时间</th>
                <th width="90">aqi</th>
                <th width="150">co</th>
                <th width="130">pm2.5</th>
                <th width="100">pm10</th>
                <th width="100">操作</th>
            </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
    </div>
</div>
<!--请在下方写此页面业务相关的脚本-->
<script type="text/javascript" src="/test/lib/datatables/1.10.0/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="/test/lib/laypage/1.2/laypage.js"></script>
<script type="text/javascript">
    var type = null;
    $(function(){
        loadList();

        $('.table-sort').dataTable({
            "aaSorting": [[ 2, "desc" ]],//默认第几个排序
            "bStateSave": true,//状态保存
            "aoColumnDefs": [
                //{"bVisible": false, "aTargets": [ 3 ]} //控制列的隐藏显示
                {"orderable":false,"aTargets":[7]}// 制定列不参与排序
            ]
        });
    });

    /*用户-列表*/
    function loadList() {
        handleAjax('cityWarning/list?currentPage=1&pageSize=100').done(function(result){
            data = result.list;
            if (data == null) {
                $('tbody').html('暂无数据');
                return;
            }
            var str = '';
            for (var i=0; i<data.length; i++) {
                str +=
                    '<tr class="text-c">' +
                    '<th>' + data[i].id + '</th>' +
                    '<th>' + data[i].city + '</th>' +
                    '<td>' + getDate(data[i].createTime) + '</td>' +
                    '<td>' + data[i].aqi + '</td>' +
                    '<td>' + data[i].co + '</td>' +
                    '<td>' + data[i].pm2 + '</td>' +
                    '<td>' + data[i].pm10 + '</td>' +
                    '<td class="td-manage">' +
                    '<a title="编辑" href="javascript:;" onclick="edit(' + data[i].id + ')" class="ml-5" style="text-decoration:none"><i class="Hui-iconfont">&#xe6df;</i></a>' +
                    '<a title="删除" href="javascript:;" onclick="del(' + data[i].id + ')" class="ml-5" style="text-decoration:none"><i class="Hui-iconfont">&#xe6e2;</i></a>' +
                    '</td>' +
                    '</tr>';
            };
            $('tbody').html(str);
        }).fail(function(xhr, error){
            alert('error');
        });

    }
    /*添加*/
    function add(){
        layer_show('添加', 'add.jsp', '600', '400');
    }
    /*编辑*/
    function user_edit(id){
        layer_show('编辑','modify.html?id=' + id, '600', '400');
    }


    /*删除*/
    function del(id){
        layer.confirm('确认要删除改该数据吗？',function(index){
            handleAjax('cityWarning/delete?id='+ id).done(function(status){
                if (status === 1) {
                    layer.msg('已删除!', {icon:1,time:1000}, function(){
                        window.location.reload();
                    });
                }
            }).fail(function(xhr,error){
                alert('error');
            });
        });
    }
</script>
</body>
</html>
