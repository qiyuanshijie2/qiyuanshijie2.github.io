<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@page import="java.io.*" %>
<% 
String level="1";
String user_id="";
if(session.getAttribute("user-level")!=null){
	level=session.getAttribute("user-level").toString();
	user_id=session.getAttribute("user-id").toString();
}
	try {
		Class.forName("com.mysql.cj.jdbc.Driver");
		String url=application.getInitParameter("cpj-url");
		String usr=application.getInitParameter("cpj-user");
		String passwd=application.getInitParameter("cpj-pass");
		Connection conn=DriverManager.getConnection(url, usr, passwd);
		String sql=""; 
		PreparedStatement ps=null;
		if(request.getParameter("picture")!=null){
			sql="select picture,id,owner from smallpicture where id=? and (level<=? or owner=?)";
			ps=conn.prepareStatement(sql);
			ps.setString(1, request.getParameter("picture"));
			response.setContentType("image/jpeg");
		}else if(request.getParameter("script")!=null){
			sql="select script,id,owner from smallscripts where id=? and (level<=? or owner=?)";
			ps=conn.prepareStatement(sql);
			ps.setString(1, request.getParameter("script"));
			response.setContentType(" text/plain");
		}else if(request.getParameter("css")!=null){
			sql="select css,id,owner from smallcsses where id=? and (level<=? or owner=?)";
			ps=conn.prepareStatement(sql);
			ps.setString(1, request.getParameter("css"));
			response.setContentType("text/plain");
		}
		if(ps!=null){
			
			ps.setString(2,level);
			ps.setString(3,user_id);
			ResultSet rst=ps.executeQuery();
			if(rst.next()){
				Blob blb=rst.getBlob(1);
				InputStream ism=blb.getBinaryStream();
				byte[] bytes=new byte[ism.available()];
				ism.read(bytes);
				ism.close();
				OutputStream osm=response.getOutputStream();
				osm.write(bytes);
				osm.close();
				out.clear();
				out = pageContext.pushBody();
			}else{
				response.setContentType("text/plain");
				out.println("您没有权限或者您查询的内容不存在");
			}
		}else{
			response.setContentType("text/plain");
			out.println("参数有误");
		}
		conn.close();
	}catch(Exception e) {
		e.printStackTrace();
		System.out.println("sth wrong!");
	}
%>