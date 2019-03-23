<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@page import="org.tuhol.webside.users.tposs.*" %>
<!DOCTYPE html>
<html>
<head>
<%@include file="..\headstyle.jsp" %>
<style>
p{
		 border-top:1px dashed #ddd;
}
</style>
<meta charset="UTF-8">
<title>起源视界等级评定</title>
</head>
<body style="background-color: #E8E8E8">
<%@include file="..\head.jsp" %>
<div>
	<div style="height:45px;width:100%;"></div>
</div>

<div style="margin-left:7%;margin-right:7%;width: 80%;float: left;background-color:#444644;height=100%" id="sssss">
<div style="background-color:#FFFFFF;width: 80%;height=100%">
<form action="./ratingcheck.jsp" method="post" >
<div ><h1 style="text-align:center">Tuhol等级评定</h1></div>
<%
String user_id="";
String ratingq="";
if(session.getAttribute("want-rate-level")==null){
	response.sendRedirect("./");
}else{
	if(session.getAttribute("user-level")==null){
		response.sendRedirect("../login");
	}else{
		request.setCharacterEncoding("utf-8");
		user_id=session.getAttribute("user-id").toString();
		user_id=user_id+"rating";
		java.util.Calendar c = java.util.Calendar.getInstance();
		long timenow=c.getTime().getTime();
		if(application.getAttribute(user_id+"time")!=null){
			long logtimeset=Long.valueOf(application.getAttribute(user_id+"time").toString());
			if(timenow-logtimeset<3600000){
				long times=3600000-timenow+logtimeset;
				long min=times/60000;
				long sec=(times-min*60000)/1000;
				String timets="您所在的用户地址所尝试登录次数过多，距离下次可用登录还有"+min+"分"+sec+"秒";
				request.setAttribute("returnthing",timets);
				}else{
					application.removeAttribute(user_id+"time");
					application.removeAttribute(user_id);
					request.setAttribute("returnthing","您现在可以正常答题");
				}
			}else{
				if(application.getAttribute(user_id)!=null){
					int timesss2=10-Integer.valueOf(application.getAttribute(user_id).toString())+1;
					request.setAttribute("returnthing","您现在还有"+timesss2+"次机会");
				}else{
					request.setAttribute("returnthing","您现在可以正常答题");
				}
			}
	}
		String level=session.getAttribute("want-rate-level").toString();
		try{
			Class.forName("com.mysql.cj.jdbc.Driver");
			String url=application.getInitParameter("rating-url");
			String usr=application.getInitParameter("rating-user");
			String passwd=application.getInitParameter("rating-pass");
			Connection conn=DriverManager.getConnection(url, usr, passwd);
			String sql="select max(id) from level"+level;
			PreparedStatement ps=conn.prepareStatement(sql);
			ResultSet rs=ps.executeQuery();
			boolean canrate=false;
			int maxid=0;
			if(rs.next()){
				maxid=rs.getInt(1);
				if(maxid>10){canrate=true;}
			}
			rs.close();
			ps.close();
			if(canrate){
				rand rad=new rand();
				int[] arr0=rad.Randoms(10,maxid,1);
				sql="select question,choice1,choice2,choice3,choice4 from level"+level+" where id=?";
				ps=conn.prepareStatement(sql);
				String[] questions=new String[10];
				int[] tureans=new int[10];
				for(int i=0;i<arr0.length;i++) {
					String[] queans=new String[4];
					ps.setInt(1, arr0[i]);
					ResultSet rst=ps.executeQuery();
					rst.next();
					String question=rst.getString("question");
					String[] choices=new String[4];
					for(int j=0;j<=3;j++){
						int k=j+1;
						choices[j]=rst.getString("choice"+k);
					}
					int[] arr2=rad.Randoms(4,4,1);
					for (int i4=0;i4<arr2.length;i4++){
						arr2[i4]=arr2[i4]-1;
					}
					for(int i1=0;i1<=3;i1++){
						if(arr2[i1]==0){
							String quan="question"+i;
							session.setAttribute(quan, i1);
						}
						queans[i1]=" \n<label><input type=\"radio\" name=\"question"+i+"\" value=\""+i1+"\" id=\"question"+i+"_"+i1+"\" class=\"awnser\">"+choices[arr2[i1]]+"</label><br>";
					}	
					questions[i]="\n<p><div id=\"question"+i+"\" class=\"question\">"+(i+1)+"."+question+"</div></p>";
					for(int i2=0;i2<=3;i2++){
						questions[i]=questions[i]+queans[i2];
					}
				}
				ratingq=ratingq+"您在一个小时内一共只有10次机会";
				for(int i3=0;i3<10;i3++){
					ratingq=ratingq+questions[i3];
				}
			}else{
				out.println("对不起，由于题目不够，该方面的认证还未开启");
			}
			}catch(Exception e) {
				e.printStackTrace();
				out.println("出了些错误请返回<a href='./index.jsp'>等级选择页</a>重试");
			}
}
%>
<%if(request.getAttribute("returnthing")!=null){
out.print(request.getAttribute("returnthing").toString()); 
}%>
<%=ratingq %>
<input type="image" alt="0" src="submit.jpg" height="50px" onclick=""  style="margin-left: 20%">
<input type="image" alt="0" src="reflash.jpg" height="50px" onclick="window.location.reload();return false;"style="margin-right: 20%;float: right">
</form>
</div>
</div>
</body>
</html>