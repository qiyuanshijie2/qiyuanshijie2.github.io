/*
**@author 卖星星的教授
**@time 2018-07-09
**@用途 基本的js操作
**
**
**
**
*/

window.onload=function(){
	"use strict";
	var id_logo=document.getElementById("logo");
	var navigation=document.getElementById("navigation");
	var body_head=document.getElementById("body_head");
	var topnav=body_head.offsetTop+1;
	var leftnav=body_head.offsetLeft+0-navigation.offsetWidth;
	navigation.style.marginTop=topnav+"px";
	navigation.style.left=leftnav+"px";
	navigation.style.opacity=1.00;
	get_id_sort();
	get_id_body_head_left();
	//for test
	navigation.onclick=function(){
		for(var i=1;i<=5;i++){
		}
	};
	id_logo.onmouseover=function(){
	};
	//导航栏自动变化
	window.onscroll=function(){
		if(body_head.offsetTop-document.documentElement.scrollTop<document.documentElement.clientHeight*0.15){
			navigation.style.marginTop="10%";
			navigation.style.position="fixed";
		}else{
			topnav=body_head.offsetTop+1;
			navigation.style.marginTop=topnav+"px";
			navigation.style.position="absolute";
		}
	};
	window.onresize=function(){
		topnav=body_head.offsetTop+1;
		leftnav=body_head.offsetLeft+0-navigation.offsetWidth;
		navigation.style.marginTop=topnav+"px";
		navigation.style.left=leftnav+"px";
		navigation.style.opacity=1.00;
		if(body_head.offsetTop-document.documentElement.scrollTop<document.documentElement.clientHeight*0.15){
			navigation.style.marginTop="10%";
			navigation.style.position="fixed";
		}else{
			navigation.style.marginTop=topnav+"px";
			navigation.style.position="absolute";
		}
	};
};