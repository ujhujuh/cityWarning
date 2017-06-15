<%--
  Created by IntelliJ IDEA.
  User: lxr
  Date: 2017/6/14
  Time: 23:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE HTML>
<html>
<head>
    <meta charset="utf-8">
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
    <meta http-equiv="Cache-Control" content="no-siteapp" />
    <!--[if lt IE 9]>
    <script type="text/javascript" src="/test/lib/html5shiv.js"></script>
    <script type="text/javascript" src="/test/lib/respond.min.js"></script>
    <![endif]-->
    <link rel="stylesheet" type="text/css" href="/test/static/h-ui/css/H-ui.min.css" />
    <link rel="stylesheet" type="text/css" href="/test/static/h-ui.admin/css/H-ui.admin.css" />
    <link rel="stylesheet" type="text/css" href="/test/lib/Hui-iconfont/1.0.8/iconfont.css" />
    <link rel="stylesheet" type="text/css" href="/test/static/h-ui.admin/skin/default/skin.css" id="skin" />
    <link rel="stylesheet" type="text/css" href="/test/static/h-ui.admin/css/style.css" />
    <!--[if IE 6]>
    <script type="text/javascript" src="/test/lib/DD_belatedPNG_0.0.8a-min.js" ></script>
    <script>DD_belatedPNG.fix('*');</script>
    <![endif]-->
    <title>折线图</title>
</head>
<body>
<nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 统计管理 <span class="c-gray en">&gt;</span> 折线图 <a class="btn btn-success radius r" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
<div>
    <span>请选择城市查询最近的空气质量：</span>
    <div style="margin-left: 50px;">
        <select class="select" name="model" id="model" style="width: 100px;">
            <option value="昆明">昆明</option>
            <option value="上海">上海</option>
        </select>
        &nbsp;&nbsp;<a href="javascript:;" onclick="findCity()" style="height: 30px;" class="btn btn-primary radius"><i class="Hui-iconfont"></i><span>查询</span></a>
    </div>
</div>

<div class="page-container">
    <div id="container" style="min-width:700px;height:400px"></div>
</div>
<!--_footer 作为公共模版分离出去-->
<script type="text/javascript" src="/test/lib/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="/test/lib/layer/2.4/layer.js"></script>
<script type="text/javascript" src="/test/static/h-ui/js/H-ui.min.js"></script>
<script type="text/javascript" src="/test/static/h-ui.admin/js/H-ui.admin.js"></script> <!--/_footer 作为公共模版分离出去-->

<!--请在下方写此页面业务相关的脚本-->
<script type="text/javascript" src="/test/lib/hcharts/Highcharts/5.0.6/js/highcharts.js"></script>
<script type="text/javascript" src="/test/lib/hcharts/Highcharts/5.0.6/js/modules/exporting.js"></script>
<script type="text/javascript">
    $(function () {
        getCity();
        findCity();
    });

    function getCity() {
        $.ajax({
            type: 'post',
            url: '/test/cityWarning/listCity',
            contentType: 'application/json',
            success: function(result) {
                var str = '';
                for(var i=0;i<result.length;i++){
                    str+='<option value="'+result[i].city+'">'+result[i].city+'</option>'
                }
                $("#model").html(str);
            },
            error: function() {
                alert('error')
            }
        });
    }

    function findCity() {
        var params = {
            city: $('#model').val()
        };
        $.ajax({
            type: 'post',
            url: '/test/cityWarning/findCity',
            dataType: 'json',
            contentType: 'application/json',
            data:JSON.stringify(params),
            success: function(result) {
                var title = $('#model').val()+'市近期空气质量变化';
                chart(result.time,title,result.aqi,result.co,result.pm2,result.pm10);
            },
            error: function() {
                alert('error')
            }
        });
    }

    function chart(horizontal,title,aqi,co,pm2,pm10) {
        Highcharts.chart('container', {
            title: {
                text: title,
                x: -20 //center
            },
            subtitle: {
                text: '折线图',
                x: -20
            },
            xAxis: {
                categories: horizontal
            },
            yAxis: {
                title: {
                    text: '数值 (/1h)'
                },
                plotLines: [{
                    value: 0,
                    width: 1,
                    color: '#808080'
                }]
            },
            tooltip: {
                valueSuffix: '/1h'
            },
            legend: {
                layout: 'vertical',
                align: 'right',
                verticalAlign: 'middle',
                borderWidth: 0
            },
            series: [{
                name: 'aqi',
                data: aqi
            }, {
                name: 'co',
                data: co
            }, {
                name: 'pm2.5',
                data: pm2
            }, {
                name: 'pm10',
                data: pm10
            }]
        });
    }
</script>
</body>
</html>