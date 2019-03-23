<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%

int score=0;
String returnthings="";
String mod="";
String level="";
String id="";
String acpjrt="";
request.setCharacterEncoding("utf-8");
boolean isover=false;
String user_id="";
if(session.getAttribute("user-level")==null){
	response.sendRedirect("../login");
}else{
	System.out.println(session.getAttribute("user-level"));
	user_id=session.getAttribute("user-id").toString();
	user_id=user_id+"rating";
	if(application.getAttribute(user_id)!=null){
		int useratingtimes=Integer.valueOf(application.getAttribute(user_id).toString());
		if(useratingtimes<10){
			useratingtimes=useratingtimes+1;
			application.setAttribute(user_id, useratingtimes);
			isover=true;
		}else{
			java.util.Calendar c = java.util.Calendar.getInstance();
			long timenow=c.getTime().getTime();
			if(application.getAttribute(user_id+"time")!=null){
				long logtimeset=Long.valueOf(application.getAttribute(user_id+"time").toString());
				if(timenow-logtimeset<3600000){
					response.sendRedirect("./");
				}else{
				}
			}else{
				application.setAttribute(user_id+"time", timenow);
			}
		}
	}else{
		application.setAttribute(user_id, "1");
		isover=true;
	}
	if(isover){
		if(session.getAttribute("want-rate-level")==null){
			response.sendRedirect("./");
		}else{
			for(int i=0;i<10;i++){
				String quan="question"+i;
				request.getParameter(quan);
				if(request.getParameter(quan)==null||session.getAttribute(quan)==null){
					returnthings="您未答完全部题目或您未进行验证，请<a href=\"./uprate.jsp\">返回上一页</a>并刷新<br>";
					break;
				}
				if(request.getParameter(quan).equals(session.getAttribute(quan).toString())){
					score=score+1;
				}
				session.removeAttribute(quan);
			}
				if(score>6){
				try{
					String url="jdbc:mysql://localhost:3306/userpass?serverTimezone=UTC&useSSL=false&allowPublicKeyRetrieval=true";
					Class.forName("com.mysql.cj.jdbc.Driver");
					String usr=application.getInitParameter("userpass-user");
					String passwd=application.getInitParameter("userpass-pass");
					Connection conn=DriverManager.getConnection(url, usr, passwd);
					String sql="update userpasswd set level=? where id=?";
					PreparedStatement ps=conn.prepareStatement(sql);
					ps.setInt(1, Integer.valueOf(session.getAttribute("want-rate-level").toString()));
					ps.setInt(2, Integer.valueOf(session.getAttribute("user-id").toString()));
					ps.executeUpdate();
					ps.close();
					conn.close();
					returnthings="恭喜你通过了等级评定<br>";
					if(session.getAttribute("user-level").toString().equals("1")){
						Class.forName("com.mysql.cj.jdbc.Driver");
						url=application.getInitParameter("sql-users-url");
						usr=application.getInitParameter("sql-users-user");
						passwd=application.getInitParameter("sql-users-pass");
						conn=DriverManager.getConnection(url, usr, passwd);
						sql="insert into userbasic (id,username,into_time) values (?,?,?) ";
						String sql2="create table user?fans like fansbasic";
						String sql3="create table user?sub like subbasic";
						String sql4="create table user?collect like collectbasic";
						PreparedStatement ps1=conn.prepareStatement(sql);
						ps1.setInt(1, Integer.valueOf(session.getAttribute("user-id").toString()));
						ps1.setInt(2, Integer.valueOf(session.getAttribute("user-name").toString()));
						java.util.Calendar c = java.util.Calendar.getInstance();
						long timenow=c.getTime().getTime();
						ps1.setLong(3, timenow);
						ps1.executeUpdate();
						ps1.close();
						PreparedStatement ps2=conn.prepareStatement(sql2);
						PreparedStatement ps3=conn.prepareStatement(sql3);
						PreparedStatement ps4=conn.prepareStatement(sql4);
						ps2.setInt(1, Integer.valueOf(session.getAttribute("user-id").toString()));
						ps3.setInt(1, Integer.valueOf(session.getAttribute("user-id").toString()));
						ps4.setInt(1, Integer.valueOf(session.getAttribute("user-id").toString()));
						ps2.executeUpdate();
						ps3.executeUpdate();
						ps4.executeUpdate();
						ps2.close();
						ps3.close();
						ps4.close();
						conn.close();
					
					if(session.getAttribute("want-rate-level").toString().equals("4")){
						returnthings=returnthings+"检测到您通过了四级验证，您可以自行决定是否阅读<a href=\"../article/?article=1\">关于base64加密</a><br><a href=\"../article/?article=2\">关于资源传递事宜</a><a href=\"../article/?article=3\">关于政治/军事/色情/其他危险项目相关事宜</a>";
					}
					session.setAttribute("user-level" ,session.getAttribute("want-rate-level"));
					session.removeAttribute("want-rate-level");
					
						returnthings=returnthings+"欢迎加入Tuhol<br><a href=\"../\">前往主页</a>";
					}
				}catch(Exception e) {
					e.printStackTrace();
					out.println("出了些错误请返回<a href='./index.jsp'>等级选择页</a>重试");
				}
				}else{
					returnthings=returnthings+"不好意思，您未通过验证";
				}
		}
	}else{
		returnthings="您超过了尝试次数";
	}
}
%>
<%=returnthings %>
</body>
</html>