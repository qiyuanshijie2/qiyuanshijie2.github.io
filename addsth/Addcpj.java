package org.tuhol.webside.users.tposs;
import java.io.*;
import java.sql.*;

public class Addcpj {
	public  Addcpj(){}
	public String writetosql(InputStream ism,String mod,int level,String username) {
		String returnthing="";
		try {
			String sql="";
			String sql2="";
			if(mod.equals("picture")) {
				if(ism.available()<65536) {
					sql="insert into smallpicture (picture,owner,level) values (?,?,?)";
					sql2="select id from smallpicture where owner=?";
	//			}else if(ism.available()<16777215){
	//				sql="insert into pictures (picture,owner,level) values (?,?,?)";
	//				sql2="select id from pictures where owner=?";
				}else {
					sql="too long";
				}
			}else if(mod.equals("css")) {
				if(ism.available()<65536) {
					sql="insert into smallcsses (css,owner,level) values (?,?,?)"; 
					sql2="select id from smallcsses where owner=?";
	//			}else if(ism.available()<16777215){
	//				sql="insert into csses (csses,owner,level) values (?,?,?)";
	//				sql2="select id from csses where owner=?";
				}else {
					sql="too long";
				}
			}else if(mod.equals("script")) {
				if(ism.available()<65536) {
					sql="insert into smallscripts (script,owner,level) values (?,?,?)"; 
					sql2="select id from smallscripts where owner=?";
	//			}else if(ism.available()<16777215){
	//				sql="insert into scripts (script,owner,level) values (?,?,?)";
	//				sql2="select id from scripts where owner=?";
				}else {
					sql="too long";
				}
			}else {
				sql="no such type";
			}
			if(sql.equals("too long")) {
				returnthing=sql;
			}else if(sql.equals("no such type")) {
				returnthing=sql;
			}else {
				String url=null;
				url="jdbc:mysql://localhost:3306/cpj?serverTimezone=UTC&useSSL=false";
				Class.forName("com.mysql.cj.jdbc.Driver");
				Connection conn=DriverManager.getConnection(url, *, *);
				PreparedStatement ps=conn.prepareStatement(sql);
				ps.setBlob(1, ism);
				ps.setInt(2,Integer.valueOf(username));
				ps.setInt(3, level);
				ps.executeUpdate();
				ps.close();
				ism.close();
				ps=conn.prepareStatement(sql2);
				ps.setInt(1, Integer.valueOf(username));
				ResultSet rs=ps.executeQuery();
				long cpjnum=0;
				while(rs.next()) {
					cpjnum=rs.getLong(1);
				};
				conn.close();
				returnthing=cpjnum+"";
			}
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println("sth wrong!");
			returnthing="数据库错误";
		}
		return returnthing;
	}
	public String updatesql(InputStream ism,String mod,int id,int level,String username) {
		String returnthing="";
		try {
			String sql="";
			if(mod.equals("picture")) {
				if(ism.available()<65536) {
					sql="update smallpicture set picture=?,level=? where id=? and owner=?";
	//			}else if(ism.available()<16777215){
	//				sql="insert into pictures (picture,owner,level) values (?,?,?)";
	//				sql2="select id from pictures where owner=?";
				}else {
					sql="too long";
				}
			}else if(mod.equals("css")) {
				if(ism.available()<65536) {
					sql="update smallcsses set css=?,level=? where id=? and owner=?"; 
	//			}else if(ism.available()<16777215){
	//				sql="insert into csses (csses,owner,level) values (?,?,?)";
	//				sql2="select id from csses where owner=?";
				}else {
					sql="too long";
				}
			}else if(mod.equals("script")) {
				if(ism.available()<65536) {
					sql="update smallscripts set script=?,level=? where id=? and owner=?"; 
	//			}else if(ism.available()<16777215){
	//				sql="insert into scripts (script,owner,level) values (?,?,?)";
	//				sql2="select id from scripts where owner=?";
				}else {
					sql="too long";
				}
			}else {
				sql="no such type";
			}
			if(sql.equals("too long")) {
				returnthing=sql;
			}else if(sql.equals("no such type")) {
				returnthing=sql;
			}else {
				String url=null;
				url="jdbc:mysql://localhost:3306/cpj?serverTimezone=UTC&useSSL=false";
				Class.forName("com.mysql.cj.jdbc.Driver");
				Connection conn=DriverManager.getConnection(url, "root", "MNjkl!!..528467193");
				PreparedStatement ps=conn.prepareStatement(sql);
				ps.setBlob(1, ism);
				ps.setInt(2, level);
				ps.setInt(3, id);
				ps.setInt(4, Integer.valueOf(username));
				ps.executeUpdate();
				ps.close();
				ism.close();
				String cpjnum=id+"";
				conn.close();
				returnthing=cpjnum;
			}
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println("sth wrong!");
			returnthing="数据库错误";
		}
		return returnthing;
	}
}


