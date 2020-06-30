
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>Title</title>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.11.2.js"></script>
    <script type="text/javascript" src="../vue/vue.min.js"></script>
</head>
<body>

<button id="btn">添加</button>
<table border="1" width="800px">
    <theader>
        <tr>
            <th>ID</th>
            <th>姓名</th>
            <th>性别</th>
            <th>入职时间</th>
            <th>薪资</th>
            <th>操作</th>
        </tr>
    </theader>
    <tbody id="emp">
    </tbody>
</table>
<p />

当前 :<span id="current" style="color: red;"></span>/<span id="pages"></span>页 总计 :<span id="total"></span> 条

<a href="javascript:void(0)" id="first" num="" onclick="go(this)">首页</a> &nbsp;
<a href="javascript:void(0)" id="pre" num=""  onclick="go(this)">上一页</a> &nbsp;
<a href="javascript:void(0)" id="next" num="" onclick="go(this)">下一页</a> &nbsp;
<a href="javascript:void(0)" id="last" num="" onclick="go(this)">尾页</a> &nbsp;

<div id="add" style="display: none;">
    <form action="${pageContext.request.contextPath}/emp/add" id="frm" method="post">

        <input type="hidden" name="empid" id="empid" />
        ename :<input type="text" id="ename" name="ename">   <p />
        sex :<input type="radio" name="sex" value="男" checked>男
        <input type="radio" name="sex" value="女">女
        <p />
        jobDate :<input type="text" name="jobDate" id="jobDate">   <p />
        salary :<input type="text" name="salary" id="salary">   <p />
        <input type="button" id="save" value="save" />
    </form>
</div>



<script>
    $(function () {
        var url = "${pageContext.request.contextPath}/empAjax/list" ;
        init(url,null);
    })

    function init(url,params) {
        $.post(url,params,function (data) {
            console.log(data);
            $("#current").html(data.pageNum);
            $("#pages").html(data.pages);
            $("#total").html(data.total);

            $("#first").attr("num",1);
            if(data.prePage == 0) {
                $("#pre").attr("num",1);
            }else{
                $("#pre").attr("num",data.prePage);
            }
            if (data.pageNum == data.pages) {
                $("#next").attr("num",data.pages);
            }else {
                $("#next").attr("num",data.nextPage);
            }
            $("#last").attr("num",data.pages);

            var s = "" ;
            for (var i = 0; i < data.list.length; i++) {
                s += "<tr>" ;
                s += "<td>"+data.list[i].empid+"</td>";
                s += "<td>"+data.list[i].ename+"</td>";
                s += "<td>"+data.list[i].sex+"</td>";
                var d = new Date(data.list[i].jobDate);
                var y = "" ;
                y += d.getFullYear()+"-"+(d.getMonth()+1)+"-"+d.getDate();
                s += "<td>"+y+"</td>";
                s += "<td>"+data.list[i].salary+"</td>";
                s += "<td>";
                s += "<button onclick='modify("+data.list[i].empid+")'>修改</button>" ;
                s += "<button onclick='del("+data.list[i].empid+")'>删除</button>" ;
                s += "</td>"
                s += "</tr>"
            }
            $("#emp").append(s);
        },"json");
    }
    $("#submit").click(function(){
        var formData = new FormData($("#frm")[0]);
        $.ajax({
            url : 'empAjax/upload',
            data:formData,
            type:'post',
            dataType:'json',
            success:function(data){}
        });
    });

    function del(id) {
        var url = "${pageContext.request.contextPath}/empAjax/del/"+id

        if (confirm("确认删除吗？")){
            $.get(url,function (data) {
                if (data == 1){
                    alert("删除成功!");
                    location.reload();
                }else {
                    alert("删除失败!!!");
                }
            });
        }
    }




    function go(obj) {
        $("#emp").html("");
        //alert($(obj).attr("num"));
        var url = "${pageContext.request.contextPath}/empAjax/list" ;
        var params = "now="+$(obj).attr("num");
        init(url,params);
    }


    $("#btn").click(function () {
        $("#add").css("display","block");
    });

    $("#save").click(function () {
        var params = $("#frm").serialize();
        //判断id 有没有值
        var id = $("#empid").val();
        if (id == null || id == ''){
            var url = "${pageContext.request.contextPath}/empAjax/add";
            add(url ,params);
        }else {
            var url = "${pageContext.request.contextPath}/empAjax/modify";
            update(url,params);
        }

    });

    function update(url,params) {
        $.post(url,params,function (data) {

            $("#add").css("display","none");
            if (data == 1){
                alert("修改成功!");
                location.reload();
            }else {
                alert("修改失败!!!");
            }
        });
    }


    function add(url,params) {
        $.post(url,params,function (data) {
            console.log(data);
            var line = "" ;
            line += "<tr>" ;
            line += "<td>"+data.empid+"</td>";
            line += "<td>"+data.ename+"</td>";
            line += "<td>"+data.sex+"</td>";
            var d = new Date(data.jobDate);
            var y = "" ;
            y += d.getFullYear()+"-"+(d.getMonth()+1)+"-"+d.getDate();
            line += "<td>"+y+"</td>";
            line += "<td>"+data.salary+"</td>";
            line += "<td><button onclick='modify('"+data.empid+"')'>修改</button> </td>";
            line += "</tr>"

            $("#emp").append(line);

            $("#add").css("display","none");

        });
    }


    function modify(id) {
        $("#add").css("display","block");
        var url = "${pageContext.request.contextPath}/empAjax/findEmp/"+id
        $.get(url,function (data) {

            console.log(data);

            $("#empid").val(data.empid);
            $("#ename").val(data.ename);
            $("#salary").val(data.salary);
            var d = new Date(data.jobDate);
            var y = "" ;
            y += d.getFullYear()+"-"+(d.getMonth()+1)+"-"+d.getDate();
            $("#jobDate").val(y);

            var radios = $("input[name=sex]");
            radios.each(function () {
                if ($(this).val() == data.sex) {
                    this.checked = true ;
                }
            })
        },"json");
    }
</script>
</body>
</html>
