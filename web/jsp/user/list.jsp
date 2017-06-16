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
    <title>用户管理</title>
    <script src="/test/static/common/header.js"></script>
    <script src="/test/static/common/utils.js"></script>
    <script src="/test/static/common/validateUser.js"></script>
</head>
<body>
<nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 用户管理 <span class="c-gray en">&gt;</span><span>用户列表</span><a class="btn btn-success radius r" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
<div class="page-container" style='margin-top: -20px;'>
    <div class="cl pd-5 bg-1 bk-gray mt-20"> <span class="l"><a href="javascript:;" onclick="user_add()" class="btn btn-primary radius"><i class="Hui-iconfont">&#xe600;</i><span>添加用户</span></a></span> </div>
    <div class="mt-20">
        <table class="table table-border table-bordered table-hover table-bg table-sort">
            <thead>
            <tr class="text-c">
                <th width="100">用户名</th>
                <th width="70">真实姓名</th>
                <th width="40">性别</th>
                <th width="90">手机</th>
                <th width="150">邮箱</th>
                <th width="130">创建时间</th>
                <th width="100">操作</th>
            </tr>
            </thead>
            <tbody>
            <tr class="text-c">
                <td>ujhujuh</td>
                <td>tom</td>
                <td>男</td>
                <td>18123123123</td>
                <td>admin@mail.com</td>
                <td>2014-6-11</td>
                <td class="td-manage">
                    <a title="编辑" href="javascript:;" onclick="user_edit()" class="ml-5" style="text-decoration:none"><i class="Hui-iconfont">&#xe6df;</i></a>
                    <a style="text-decoration:none" class="ml-5" onClick="change_password()" href="javascript:;" title="重置密码"><i class="Hui-iconfont">&#xe63f;</i></a>
                    <a title="删除" href="javascript:;" onclick="user_del(this)" class="ml-5" style="text-decoration:none"><i class="Hui-iconfont">&#xe6e2;</i></a>
                </td>
            </tr>
            </tbody>
        </table>
    </div>
</div>
<!--请在下方写此页面业务相关的脚本-->
<script type="text/javascript" src="/frame/lib/datatables/1.10.0/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="/frame/lib/laypage/1.2/laypage.js"></script>
<script type="text/javascript">

    var type = null;
    $(function(){
        loadList();

        $('.table-sort').dataTable({
            "aaSorting": [[ 5, "desc" ]],//默认第几个排序
            "bStateSave": true,//状态保存
            "aoColumnDefs": [
                //{"bVisible": false, "aTargets": [ 3 ]} //控制列的隐藏显示
                {"orderable":false,"aTargets":[6]}// 制定列不参与排序
            ]
        });
    });

    /*用户-列表*/
    function loadList() {
        handleAjax('user/list?currentPage=1&pageSize=100').done(function(result){
            data =  result.list;
            if (data == null) {
                $('tbody').html('暂无数据');
                return;
            }
            var str = '';
            for (var i=0; i<data.length; i++) {
                str +=
                    '<tr class="text-c">' +
                    '<th>' + data[i].userName + '</th>' +
                    '<td>' + data[i].realName + '</td>' +
                    '<td>' + (data[i].gender == 1 ? '男' : '女') + '</td>' +
                    '<td>' + data[i].telphone + '</td>' +
                    '<td>' + data[i].address + '</td>' +
                    '<td>' + getDate(data[i].createTime) + '</td>' +
                    '<td class="td-manage">' +
                    '<a title="编辑" href="javascript:;" onclick="user_edit(' + data[i].id + ')" class="ml-5" style="text-decoration:none"><i class="Hui-iconfont">&#xe6df;</i></a>' +
                    '<a style="text-decoration:none" class="ml-5" onClick="change_password(' + data[i].id + ')" href="javascript:;" title="重置密码"><i class="Hui-iconfont">&#xe63f;</i></a>' +
                    '<a title="删除" href="javascript:;" onclick="user_del(' + data[i].id + ')" class="ml-5" style="text-decoration:none"><i class="Hui-iconfont">&#xe6e2;</i></a>' +
                    '</td>' +
                    '</tr>';
            };
            $('tbody').html(str);
        }).fail(function(xhr, error){
            alert('error');
        });

    }
    /*用户-添加*/
    function user_add(){
        layer_show('添加用户', 'add.jsp', '600', '400');
    }
    /*用户-编辑*/
    function user_edit(id){
        layer_show('编辑用户','modify.jsp?id=' + id, '600', '400');
    }

    /*密码-重置*/
    function change_password(id){
        layer.confirm('确认要重置密码吗？',function(index){
            var params = {
                id: id,
                password: '123456'
            };
            $.ajax({
                type: 'post',
                url: '/test/user/update',
                dataType: 'json',
                contentType: 'application/json',
                data: JSON.stringify(params),
                success: function (status) {
                    if (status == 1) {
                        layer.msg('重置密码成功，该用户密码为：123456!', {icon:1,time:1000}, function(){
                            location.reload();
                        });
                    }
                },
                error: function () {
                    alert('error')
                }
            });
        });
    }

    /*用户-删除*/
    function user_del(id){
        layer.confirm('确认要删除改该用户吗？',function(index){
            handleAjax('user/delete?id='+ id).done(function(status){
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
