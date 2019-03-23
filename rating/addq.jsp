<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@page import="java.util.*" %>
<%
request.setCharacterEncoding("utf-8");
if(session.getAttribute("question-add-level")==null){
	response.sendRedirect("./add.jsp");
}else{
	try{
		Class.forName("com.mysql.cj.jdbc.Driver");
		String url=application.getInitParameter("rating-url");
		String usr=application.getInitParameter("rating-user");
		String passwd=application.getInitParameter("rating-pass");
		Connection conn=DriverManager.getConnection(url, usr, passwd);
		String level=session.getAttribute("question-add-level").toString();
		String sql="insert into level"+level+" (question,choice1,choice2,choice3,choice4) values (?,?,?,?,?)";
		PreparedStatement ps=conn.prepareStatement(sql);
		ps.setString(1, request.getParameter("quest"));
		ps.setString(2, request.getParameter("trueans"));
		ps.setString(3, request.getParameter("wrong1"));
		ps.setString(4, request.getParameter("wrong2"));
		ps.setString(5, request.getParameter("wrong3"));
		ps.executeUpdate();
		ps.close();
		conn.close();
		out.println("题目添加成功，返回<a href='./sadd.jsp'>题目添加页</a>继续添加题目");
	}catch(Exception e) {
		e.printStackTrace();
		out.println("出了些错误请返回<a href='./sadd.jsp'>题目添加页</a>重试");
	}
}
%>