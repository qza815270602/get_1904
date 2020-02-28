<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/2/4
  Time: 18:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<title>Title</title>
<script type="text/javascript" src="<%=request.getContextPath()%>\res\js\jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>\res\layer-v3.1.1\layer\layer.js"></script>
<script type="text/javascript">

    function update() {
        var index = layer.load(0, {shade:0.5});
        $.post(
            "<%=request.getContextPath()%>/user",
            $("#fm").serialize(),
            function(data){
                layer.close(index);
                layer.msg(data.msg, function(){
                    if (data.code != 200) {
                        return;
                    }
                    window.location.href = "<%=request.getContextPath()%>/user/toShow";
                });

            })
    }

</script>
</head>
<body>

<form id = "fm">
    <input type="hidden" name="_method" value="put"/>
    <input type="hidden" name = "id" value="${user.id}"/>
    用户名:<input type = "text" name = "userName" value="${user.userName}"/><br/>
    手机:<input type = "text" name = "phone" value="${user.phone}"/><br/>
    密码:<input type = "text" name = "password" value="${user.password}"/><br/>
    性别:<input type = "radio" name = "sex" value="1" <c:if test = "${user.sex == 1}">checked</c:if>/>男
    <input type = "radio" name = "sex" value="2" <c:if test = "${user.sex == 2}">checked</c:if>/>女<br/>
    年龄:<input type = "text" name = "age" value="${user.age}"/><br/>
    <input type="button" value="修改" onclick="update()"/>
</form>

</body>
</html>
