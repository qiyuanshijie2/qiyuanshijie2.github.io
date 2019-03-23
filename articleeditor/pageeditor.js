/**
*@quthor 卖星星的教授
*@use-for upsthandaddsth
*@time 2018-08-27
**/
var mouseselection;
var mouseelet;
//测试代码
//测试代码
//插入链接框
function addoutlinks(){
	"use strict";
	if(mouseelet!==undefined){
		mouseselection=window.getSelection().anchorOffset;
		var body=document.getElementById("dcbody");
		body.innerHTML="<div id=\"addlink\">本插入框可以插入视频分享的html5代码，&lt;iframe&gt;或者&lt;embed&gt;中width和height属性可以调节宽高<br>注意：链接将会添加在文章末尾<br><textarea  contenteditable=\"true\" style=\"height: 120px;width:99%;background-color: rgba(255,255,255,1)\" id=\"linktext\"></textarea><input type=\"image\" src=\"yes.jpg\"  style=\"float:left;width:10%;margin-left:10%\" onclick=\"addinto();return false\"><input type=\"image\" src=\"cancel.jpg\" onclick=\"removeele('addlink');return false\" style=\"float:right;width:10%;margin-right:10%\"></div>"+body.innerHTML;
	}else{
		alert("请先选择插入点");
	}
}
//删除插入框
function removeele(eleid){
	"use strict";
	var eleider=document.getElementById(eleid);
	eleider.parentNode.removeChild(eleider);
	addclicked();
	document.getElementById("editor_butoons").style.left="-3%";
}
//获取对象
function mouseeletadd(getele){
	"use strict";
	mouseelet=getele;
}
//插入代码
function addinto(){
	"use strict";
	var replacedtext=document.getElementById("linktext").value;
	var addthings=mouseelet.innerHTML+replacedtext;
	document.getElementById(mouseelet.id).innerHTML=addthings;
	removeele('addlink');
	addclicked();
}
//插入链接
function addtextslinks(){
	"use strict";
	if(mouseelet!==undefined){
		mouseselection=window.getSelection().anchorOffset;
		var body=document.getElementById("dcbody");
		body.innerHTML="<div id=\"addlink\">注意：链接将会添加在文章末尾<br><textarea  contenteditable=\"true\" style=\"height: 60%;width:99%;margin-top:1%;background-color: rgba(255,255,255,1)\" id=\"linktext\"></textarea><br>插入链接文字<br><input type=\"text\" name=\"linktexts\" id=\"textlinks\" style=\"width: 99%\"><input type=\"image\" src=\"yes.jpg\"  style=\"float:left;width:10%;margin-left:10%\" onclick=\"addlinks();return false\"><input type=\"image\" src=\"cancel.jpg\" onclick=\"removeele('addlink');return false\" style=\"float:right;width:10%;margin-right:10%\"></div>"+body.innerHTML;
	}else{
		alert("请先选择插入位置");
	}
}
//添加链接
function addlinks(){
	"use strict";
	var texts=document.getElementById("textlinks").value;
	var links=document.getElementById("linktext").value;
	var addedthing="<a href=\""+links+"\">"+texts+"</a>";
	var addthings=mouseelet.innerHTML+addedthing;
	document.getElementById(mouseelet.id).innerHTML=addthings;
	removeele('addlink');
	addclicked();
}
//添加图片
function readyaddimage(){
		"use strict";
		if(mouseelet!==undefined){
		mouseselection=window.getSelection().anchorOffset;
		var body=document.getElementById("dcbody");
		body.innerHTML="<div id=\"addlink\">选择插入图片<br><input type=\"file\" id=\"files\" onChange=getfile();return false;><br>图片预览<br>请保证你的文章中只有十张图片，否则服务端无法接收过多图片<br><div id=\"showpicture\" style=\"width:100%;float:right\"></div><br><div id=\"bottondiv\" style=\"width:100%;float:right\" ><input type=\"image\" src=\"yes.jpg\"  style=\"float:left;width:10%;margin-left:10%\" onclick=\"showp_article();return false\"><input type=\"image\" src=\"cancel.jpg\" onclick=\"removeele('addlink');return false\" style=\"float:right;width:10%;margin-right:10%\"></div></div>"+body.innerHTML;
	}else{
		alert("请先选择插入点");
	}
}
//添加提交框
function addsubmit(){
	var body=document.getElementById("dcbody");
		body.innerHTML="<div id=\"addsubmit\"><h3 style=\"text-align: center\">准备提交文章</h3> 该文章是：   <input type='radio' name='articletype' value='self' id='articletype_0'> 原创</label><label><input type='radio' name='articletype' value='translate' id='articletype_1'>转译</label> <label><input type='radio' name='articletype' value='turn' id='articletype_2'> 转载</label><br>选择等级设定：	    <input type=\"radio\" name=\"levelsetting\" value=\"1\" id=\"levelsetting_0\">1</label><label><input type=\"radio\" name=\"levelsetting\" value=\"2\" id=\"levelsetting_1\">2</label><label> <input type=\"radio\" name=\"levelsetting\" value=\"3\" id=\"levelsetting_2\"> 3</label><label><input type=\"radio\" name=\"levelsetting\" value=\"4\" id=\"levelsetting_3\">4</label> <label><input type=\"radio\" name=\"levelsetting\" value=\"5\" id=\"levelsetting_4\"> 5</label><label><input type=\"radio\" name=\"levelsetting\" value=\"100\" id=\"levelsetting_5\">专业等级1</label><label><input type=\"radio\" name=\"levelsetting\" value=\"101\" id=\"levelsetting_5\">专业等级101</label><label><input type=\"radio\" name=\"levelsetting\" value=\"200\" id=\"levelsetting_5\">专业等级2</label>&nbsp;&nbsp;&nbsp;<a>tuhol.org等级条例</a><br> 添加分区：<input type=\"button\" class=\"uparticlesub\" value=\"分区选择\"><div id=\"sortselct\"></div><br>添加标签： <input type=\"text\" id=\"addtabs\" style=\"width:5%\">&nbsp;<input type=\"image\" alt=\"0\" value=\"添加标签\" onClick=\"addtab();return false;\"><div id=\"tabselect\"></div> <BR><BR><BR><BR><BR>限制的地区:&nbsp;<input type=\"text\" id=\"areaset\" style=\"width:20%\"><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;请添加两个字母的简写国家并加上\";\"例如：cn;us;uk;jp;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;限制的地区仅仅对于专业等级以下的用户有效果<br>设置封面图片：<input type=\"file\" id=\"coverpicturefile\" onChange=Coverpictureupload();return false;>(封面图片会按比例缩放)<div id=\"coverpicture\" ></div><input type=\"image\" src=\"yes.jpg\"  style=\"float:left;width:10%;margin-left:10%\" onclick=\"uparticle();return false;\"><input type=\"image\" src=\"cancel.jpg\" onclick=\"removeele('addsubmit');return false\" style=\"float:right;width:10%;margin-right:10%\"></div></div>"+body.innerHTML;
}

//upratepiture
function upratepicture(){
	var pictures=document.getElementsByTagName("image");
}
//注册事件
function addclicked(){
	"use strict";
	var article=document.getElementById("article");
	var author_support=document.getElementById("author_support");
	var title=document.getElementById("title");
	var page_tips=document.getElementById("page_tips");
	article.onclick=function(){
		mouseeletadd(article);
	};
	author_support.onclick=function(){
		mouseeletadd(author_support);
	};
	title.onclick=function(){
		mouseeletadd(title);
	};
	page_tips.onclick=function(){
		mouseeletadd(page_tips);
	};
		document.getElementById("editor_butoons").onmouseover=function(){
		document.getElementById("editor_butoons").style.left="0%";
	}
	document.getElementById("editor_butoons").onmouseout=function(){
		document.getElementById("editor_butoons").style.left="-3%";
	}
}
