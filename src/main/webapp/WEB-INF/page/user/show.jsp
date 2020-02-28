<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/2/4
  Time: 16:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
<title>Title</title>
<script type="text/javascript" src="<%=request.getContextPath()%>\res\js\jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>\res\js\jsencrypt.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>\res\layer-v3.1.1\layer\layer.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/res/layui-v2.5.5/layui/layui.js" charset="utf-8"></script>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/res/layui-v2.5.5/layui/css/layui.css"  media="all">
<script type="text/javascript">

    var totalNum = 0;

    $(function() {
        search();
    })


    function search() {
        var index = layer.load(0, {shade:0.5});
        $.post("<%=request.getContextPath() %>/user/list",
            $("#fm").serialize(),
            function(data){
                layer.close(index);
                if (data.code != 200) {
                    layer.msg(data.msg);
                    return;
                }
                totalNum = data.data.totalNum;

                var html = "";
                for (var i = 0; i < data.data.userList.length; i++) {
                    html += "<tr>";
                    html += "<td><input type='checkbox' name = 'ids' value = '"+data.data.userList[i].id+"'/></td>";
                    html += "<td>"+data.data.userList[i].userName+"</td>";
                    html += "<td>"+data.data.userList[i].phone+"</td>";
                    html += "<td>"+data.data.userList[i].password+"</td>";
                    html += data.data.userList[i].sex == 1 ? "<td>男</td>" : "<td>女</td>";
                    html += "<td>"+data.data.userList[i].age+"</td>";
                    html += "</tr>";
                }
                $("#tbd").html(html);
                var pageNo = $("#pageNo").val();
                var pageHtml = "<input type='button' value='上一页' onclick='page("+(parseInt(pageNo) - 1)+")'>";
                pageHtml += "<input type='button' value='下一页' onclick='page("+(parseInt(pageNo) + 1)+")')'>";
                $("#pageInfo").html(pageHtml);


            });
    }

    function page(page) {

        if (page < 1) {
            layer.msg('首页啦!', {icon:0});
            return;
        }
        if (page > totalNum) {
            layer.msg('已经到尾页啦!!', {icon:0});
            return;
        }
        $("#pageNo").val(page);
        search();

    }

    function find(){
        $("#pageNo").val(1);
        search();
    }
    function toUpdate() {
        var chkValue = $('input[name="ids"]:checked');
        if (chkValue.length == 0) {
            layer.msg('请选择');
        } else if (chkValue.length > 1) {
            layer.msg('只能选择一个');
        } else {
            var id = chkValue.val();
            window.location.href= "<%=request.getContextPath()%>/user/toUpdate/"+id;
        }
    }


    function toAdd() {
        window.location.href= "<%=request.getContextPath()%>/user/toAdd";
    }



    function del() {
        var chkValue = $('input[name="ids"]:checked');
        if (chkValue.length == 0) {
            layer.msg('请选择');
        } else if (chkValue.length > 1) {
            layer.msg('只能选择一个');
        } else {
            var id = chkValue.val();
            var index = layer.load(0, {shade:0.5});
            $.post("<%=request.getContextPath()%>/user",
                {"id" : id, "isDel" : 2, "_method" : "delete"},
                function(data){
                    layer.close(index);
                    layer.msg(data.msg, function(){
                        if (data.code != 200) {
                            return;
                        }
                        location.href = "<%=request.getContextPath()%>/user/toShow";
                    });

                })
        }
    }




</script>
</head>
<body>


<form id = "fm">
    <div align="center">
    <input type="hidden" name="_method" value="get"/>
    <input type="hidden" value="1" id="pageNo" name="pageNo">
        性别:<input type = "radio" name = "sex" value="1"/>男<input type = "radio" name = "sex" value="2"/>女<br/>
    用户名:<input type = "text" name = "userName"/><br/>
    年龄：<input type="text" name = "age"/>~<input type="text" name = "age1"/>
    <input type = "hidden" name = "isDel" value = "1"/><br/>
    <input type = "button" value = "搜索" onclick = "find()"/><br/>

<%--    <input type="button" value="新增" onclick="toAdd()"/>--%>
<%--    <input type="button" value="删除" onclick="del()"/>--%>
        <input type="button" value="修改" onclick="toUpdate()"/>

    <table  class="layui-table">
        <colgroup>
            <col width="100">
            <col width="100">
            <col width="100">
            <col>
        </colgroup>
        <thead>
        <tr>
            <th style="background: aquamarine;">用户id</th>
            <th style="background: aquamarine;">用户名</th>
            <th style="background: aquamarine;">手机号</th>
            <th style="background: aquamarine;">密码</th>
            <th style="background: aquamarine;">性别</th>
            <th style="background: aquamarine;">年龄</th>
        </tr>
        </thead>
        <tbody id = "tbd">
        </tbody>
    </table>

    </div>
</form>
<div id="pageInfo">

</div>



</body>
</html>
