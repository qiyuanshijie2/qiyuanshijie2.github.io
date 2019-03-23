<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>题目添加系统</title>
</head>
<body>
	<div style="margin-left:10%; margin-right:0px;">
	<h1 style=" text-align: cente">等级题目提交系统</h1><br>
	您当前正在提交第
	<%
if(session.getAttribute("question-add-level")==null){
	response.sendRedirect("./add.jsp");
}else{
	out.print(session.getAttribute("question-add-level").toString());
}
%>&nbsp;等级的题目，请确认题目难度<br>
	<form action="addq.jsp" method="post"><br>
		请在下方填入题目内容<br>
		<textarea style="width:80%;height:60px;margin-left: auto; margin-right:auto" name="quest"></textarea><br><br>
		请在此填入正确答案:<input type="text" name="trueans"><br>
		请在此填入迷惑性答案：（三条,若只有两个答案则在二三两处写“空”）<br>
		1.<input type="text" name="wrong1"><br>2.<input type="text" name="wrong2"><br>3.<input type="text" name="wrong3"><br>
		请在多次确认答案及题目符合难度且正确后单击此按钮：<input type="submit" value="提交"><br>
		若想删除全部内容请点击此处：<input type="reset">
	</form>
	</div>
</body>
</html>