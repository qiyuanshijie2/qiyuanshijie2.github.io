<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@page import="java.util.*" %>
<%
request.setCharacterEncoding("utf-8");
if(session.getAttribute("user-level")!=null){
	String user_level=session.getAttribute("user-level").toString();
	int user_level_plus=Integer.valueOf(user_level)+1;
	if(request.getParameter("ratelevel")==null ){
		request.setAttribute("returnthing", "您所选择的题目等级不正确，请重新选择(请填入"+user_level_plus+"到7之间的数字)<form action=\"./\" method=\"get\"><input name=\"ratelevel\" type=\"text\" maxlength=\"2\"><input type=\"submit\" value=\"提交\"></form>");
	}else if(request.getParameter("ratelevel").length()>3 || !request.getParameter("ratelevel").matches("[0-9]+")){
		request.setAttribute("returnthing", "您所选择的题目等级不正确，请重新选择(请填入"+user_level_plus+"到7之间的数字)<form action=\"./\" method=\"get\"><input name=\"ratelevel\" type=\"text\" maxlength=\"2\"><input type=\"submit\" value=\"提交\"></form>");
	}else if(user_level_plus>Integer.valueOf(request.getParameter("ratelevel"))){
		request.setAttribute("returnthing", "您已经通过了该等级的考核，请重新选择(请填入"+user_level_plus+"到7之间的数字)<form action=\"./\" method=\"get\"><input name=\"ratelevel\" type=\"text\" maxlength=\"2\"><input type=\"submit\" value=\"提交\"></form>");
	}else if(user_level_plus>=2){
		if(user_level_plus<=7){
					session.setAttribute("want-rate-level", request.getParameter("ratelevel"));
					response.sendRedirect("uprate.jsp");
		}else{
			request.setAttribute("returnthing", "您已经完成全部考核，更高级别的认证请前往支持");
		}
	}else{
		request.setAttribute("returnthing", "您的账号已被封禁");
	}
}else{
	response.sendRedirect("../login");
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>等级考核系统</title>
</head>
<body>
<%=request.getAttribute("returnthing") %>
</body>
</html>