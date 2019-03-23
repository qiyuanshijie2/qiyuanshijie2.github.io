<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
if(session.getAttribute("user-level")==null){
	response.sendRedirect("../login");
}else if(Integer.valueOf(session.getAttribute("user-level").toString())<9){
	response.sendRedirect("./");
}else if(request.getParameter("ratelevel")==null ){
	request.setAttribute("returnthing", "请选择您要添加题目的难度(请填入2到6之间的数字)<form action=\"./add.jsp\" method=\"get\"><input name=\"ratelevel\" type=\"text\" maxlength=\"2\"><input type=\"submit\" value=\"提交\"></form>");
}else if(request.getParameter("ratelevel").length()>3 || !request.getParameter("ratelevel").matches("[0-9]+")){
	request.setAttribute("returnthing", "您所选择的题目等级不正确，请重新选择(请填入2到6之间的数字)<form action=\"./add.jsp\" method=\"get\"><input name=\"ratelevel\" type=\"text\" maxlength=\"2\"><input type=\"submit\" value=\"提交\"></form>");
}else if(Integer.valueOf(request.getParameter("ratelevel"))>6 || Integer.valueOf(request.getParameter("ratelevel"))<2){
	request.setAttribute("returnthing", "您所选择的题目等级不正确，请重新选择(请填入2到6之间的数字)<form action=\"./add.jsp\" method=\"get\"><input name=\"ratelevel\" type=\"text\" maxlength=\"2\"><input type=\"submit\" value=\"提交\"></form>");
}else{
	session.setAttribute("question-add-level", request.getParameter("ratelevel"));
	response.sendRedirect("sadd.jsp");
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>添加问题</title>
</head>
<body>
<%=request.getAttribute("returnthing") %>
</body>
</html>