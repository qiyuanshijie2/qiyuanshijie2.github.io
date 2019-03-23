<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html>
<head>
	<meta charset="utf-8">
	<%@include file="..\headstyle.jsp" %>
	<link href="link.css" rel="stylesheet" type="text/css">
	<script src="picture.js"></script>
	<script src="uparticle.js"></script>
	<script src="pageeditor.js"></script>
<title>无标题文档</title>
</head>

<body id="dcbody">
	<div id="editor_butoons">
		<input type="image" alt="0" src="addimage.jpg" style="width:100%" onclick="readyaddimage();return false;">
		<input type="image" alt="0" src="addoutlink.jpg" style="width: 100%" onclick="addoutlinks();return false;">
		<input type="image" alt="0" src="addlinks.jpg" style="width: 100%" onclick="addtextslinks();return false;">
		<input type="image" alt="0" class="editor" style="width: 100%" value="提交" onClick="checkwordsnumber();return false;">
		<input type="button" class="editor">
	</div>
<%@include file="..\head.jsp" %>
	<div>
		<div style="height:45px;width:100%">
		</div>
	</div>
		<div id="bodyer">
		<div contenteditable="true" id="bodyer_page">
		    <h1 id="title" 	style="text-align: center">我是文章标题（可修改）（少于80字）</h1>
			  <div id="others" contenteditable="false">
			    <div id="others_likes" class="others">喜欢:</div>
			    <div id="others_dislike" class="others">不喜欢</div>
			    <div id="others_collect" class="others">收藏:</div>
			    <div id="others_readed" class="others">阅读:</div>
			    <div id="others_sort" class="others">分区:</div>
			    <div id="others_time" class="others">时间</div>
			    <div id="others_tipoff" class="others">举报</div>
			  </div>
			  <div id="article">
			    我是您的文章内容表达的部分（可修改）（如果您学过html可以在浏览器(F12)控制台输入代码，本站会add所有article.innerHtml("script"来防止xss和csrf会被替换成10进制的html编码)，如果您只想拷贝文字请使用"仅粘贴文本"，如果您的粘贴包含格式，请选择"粘贴"（视浏览器不同而定））
			  </div>
			  <div contenteditable="false" id="author_support" style="text-align: center">我是作者支持区，这里将会显示你的自定义广告内容<a href>点击此处自定义你的广告内容</a></div>
		  </div>
		<div id="bodyer_sider">
			<div id="page_owner">我是文章作者</div>
			<div id="page_tips" contenteditable="true">我是文章简介(可修改)（少于80字）</div>
			<div id="page_related" ></div>
		</div>
		<div id="other_area">
			<div id="comment_area">我是评论区</div>
			<div id="financial_support">

				<div id="webside_support">我是本站广告</div>
			</div>
		</div>
	</div>

<script>  

window.onload=function(){
	addclicked();
}
</script>
</body>
</html>
