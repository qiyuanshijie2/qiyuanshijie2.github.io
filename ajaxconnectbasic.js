/*
 *@autho 卖星星的教授
 *@tiome 2018-07-09
 *@use-for do ajax
 *
*/
var sort_number=5;
var style_sorts_p=100/sort_number;
var id_sorts_innerhtml="";
var id_body_main_innerhtml="";
var id_navigation_innerhtml="";
function get_id_sort(){
	//do some ajax and get some information
	"use strict";
	for(var i=1;i<=sort_number;i++){
		id_sorts_innerhtml=id_sorts_innerhtml+"<div style=\"width:"+style_sorts_p+"%\;float:left\;background-color: rgba(100,212,255,0.9)\;height:100%\">我是分区"+i+"</div>";
		id_body_main_innerhtml=id_body_main_innerhtml+"<div style=\"width:100%\;float:left\;background-color: rgba(100,212,"+255/5*i+",0.9)\;height:300px\" id=\"body_main_sort"+i+"\">我是分区"+i+"</div>";
		var x=i-1;
		id_navigation_innerhtml=id_navigation_innerhtml+"<a href=\"#body_main_sort"+x+"\"><div style=\"width:100%\;float:left\;background-color: rgba(100,212,"+255/5*i+",0.9)\;height:"+style_sorts_p+"%\" id=\"body_main_sort"+i+"\">我是分区"+i+"的锚点</div></a>";
	}
	document.getElementById("sorts").innerHTML=id_sorts_innerhtml;
	document.getElementById("body_main").innerHTML=id_body_main_innerhtml;
	document.getElementById("navigation").innerHTML=id_navigation_innerhtml;
	document.getElementById("body_main").style.height=300*5+"px";
	document.getElementById("sider").style.height=300*5+"px";
	var bodyer_height=document.getElementById("sider").scrollHeight+document.getElementById("body_head").scrollHeight;
	document.getElementById("bodyer").style.height=bodyer_height+"px";
}
function get_id_body_head_left(){
	"use strict";
	document.getElementById("body_head_left").innerHTML="<a href=\"article/index.html\"><div style=\"width: 100%\;height: 100%\;background-color: red\">我是一篇测试文章</div></a>";
}