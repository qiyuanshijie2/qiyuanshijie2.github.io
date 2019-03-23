<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.io.*" %>
<%@page import="java.util.*" %>
<%@page import="org.apache.commons.fileupload.*" %>
<%@page import="org.apache.commons.fileupload.disk.*" %>
<%@page import="org.apache.commons.fileupload.servlet.*" %>
<%@page import="org.tuhol.webside.users.tposs.*" %>
<%
String mod="";
String level="";
String id="";
String acpjrt="";
request.setCharacterEncoding("utf-8");
boolean isover=false;
request.setCharacterEncoding("utf-8");
String user_id="";
if(session.getAttribute("user-level")==null){
	response.sendRedirect("../login");
}else if(session.getAttribute("user-level").toString().equals("1")){
	response.sendRedirect("../rating/?ratelevel=2");
}else{
	user_id=session.getAttribute("user-id").toString();
	user_id=user_id+"cpj";
	if(application.getAttribute(user_id)!=null){
		int useraddtimes=Integer.valueOf(application.getAttribute(user_id).toString());
		if(useraddtimes<10){
			useraddtimes=useraddtimes+1;
			application.setAttribute(user_id, useraddtimes);
			isover=true;
		}else{
			Calendar c = Calendar.getInstance();
			long timenow=c.getTime().getTime();
			if(application.getAttribute(user_id+"time")!=null){
				long logtimeset=Long.valueOf(application.getAttribute(user_id+"time").toString());
				if(timenow-logtimeset<3600000){
					out.print("您上传过多图片");
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
			boolean isMultipart = ServletFileUpload.isMultipartContent(request);
			DiskFileItemFactory factory = new DiskFileItemFactory();
			ServletContext servletContext = this.getServletConfig().getServletContext();
			File repository = (File) servletContext.getAttribute("javax.servlet.context.tempdir");
			factory.setRepository(repository);
			ServletFileUpload upload = new ServletFileUpload(factory);
			try{
				InputStream ism1=null;
				List<FileItem> list=upload.parseRequest(request); 
				Iterator<FileItem> itr=list.iterator();
				while(itr.hasNext()){
					FileItem item=itr.next();
					if(item.isFormField()){  
	                    String name = item.getFieldName();  //得到名称
	                    if(name.equals("mod")){mod=item.getString("UTF-8");}
	                    if(name.equals("level")){level=item.getString( "UTF-8");}
	                    if(name.equals("id")){id=item.getString( "UTF-8");}
	                   }
		        	else if(!item.isFormField()){
						String filename = item.getName();
						filename = filename.substring(filename.lastIndexOf("\\")+1);
						ism1 = item.getInputStream();
		        	}
				}
				if(level.matches("[0-9]+") && level.length()<3){
					Addcpj acpj=new Addcpj();
					if(mod.equals("")||level.equals("")){
						acpjrt="nothing";
					}else if(id.equals("")){
						acpjrt=acpj.writetosql(ism1, mod, Integer.valueOf(level), session.getAttribute("user-id").toString());
					}else if(!id.equals(""))
						acpjrt=acpj.updatesql(ism1, mod, Integer.valueOf(id), Integer.valueOf(level),session.getAttribute("user-id").toString());
					out.println(acpjrt);
				}else{
					out.println("请输入小于16整数");
				}
				ism1.close();
				list.clear();
			}catch(Exception e){
				e.printStackTrace();
				System.out.println("sth wrong");
			}
	}else{
		out.println("请勿同时传大量内容");
	}
}
%>
