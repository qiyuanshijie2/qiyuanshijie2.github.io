/**
*@quthor 卖星星的教授
*@use-for upsthandaddsth
*@time 2018-08-27
**/

//选择分区
var tabnumber=0;
var level=0;
var tabs=new Array(30);
var type;
var sort="1";
var contextarea="";
var wantnum;
var alreadynum=0;
var article="";
var uptabs;
var title;
var page_tips;
var coverpicid="";
function addsort(){
		//add the part area
}
//添加标签
function checkwordsnumber(){
	article=document.getElementById("article").innerHTML;
	title=document.getElementById("title").innerHTML;
	page_tips=document.getElementById("page_tips").innerHTML;
	if(page_tips.length>80){
		alert("简介过长");
	}else if(title.length>80){
		alert("标题过长");
	}else{ 
		var pics=document.getElementsByClassName("addedpicture");
		var picsrclen=0;
		for(i=0;i<pics.length;i++){
			picsrclen=picsrclen+pics[i].src.length;
		}
		if(article.length-picsrclen>65500/3){
			alert("文章过长");
		}else{
			addsubmit();
		}
	}
}
function addtab(){
	var addtabvalue=document.getElementById("addtabs").value;
	var tabselect=document.getElementById("tabselect");

	for(var i=29;i>-1;i--){
			tabs[i]=0;
			uptabs="";
	}
	var added=document.getElementsByClassName("tableadds");
	for(var i=0;i<added.length;i++){
		tabs[i]=added[i].innerHTML;
	}
	for(var i=0;i<added.length;i++){
		uptabs=tabs[i]+";"+uptabs;
	}
	uptabs=uptabs+";"+addtabvalue;
	if(uptabs.length>60){
		alert("您添加的标签过多");
	}else{
		tabselect.innerHTML=tabselect.innerHTML+"<div id='tabadd"+tabnumber+"'  class='tabadds''><span class='tableadds'"+tabnumber+"'>"+addtabvalue+"</span><input type=\"image\" src=\"cancel.jpg\" onclick=\"removeele('tabadd"+tabnumber+"');return false\" style=\"width:20%;\"></div>";
		tabnumber=tabnumber+1;
	}
}
function uparticle(){
	var levelset=document.getElementsByName("levelsetting");
	for(var i=0;i<levelset.length;i++){
		if(levelset[i].checked==true){
			var value=levelset[i].value;
			level=value;
			break;
		}
	}
	var articletype=document.getElementsByName("articletype");
	for(var i=0;i<articletype.length;i++){
		if(articletype[i].checked==true){
			var value1=articletype[i].value;
			type=value1;
			break;
		}
	}
	contextarea=document.getElementById("areaset").value;
	alert(contextarea);
	uppicture();
}
//upload picture
function uppicture(){
	var pics=document.getElementsByClassName("addedpicture");
	wantnum=pics.length;
	waitxhrpictureover(pics);
}
function waitxhrpictureover(pics){
	if(wantnum===alreadynum){
		nextuparticle();
		wantnum=0;
	}else{
		var src=pics[alreadynum].src;
		var blob=dataURLtoBlob(src);
		uploadpicture(blob,level,pics[alreadynum],pics);
		alreadynum++;
	}
}
//update cover picture


function nextuparticle(){
	var xhr = new XMLHttpRequest();
	var url = "../articleeditor/addtosql.jsp";
	xhr.open("post", url, true);
	var form = new FormData(); // FormData 对象
	//注意添加cover picture的获取方法
    form.append("coverpicid",coverpicid);
    form.append("level", level);
    form.append("type", type);
    form.append("sort", sort);
    form.append("contextarea", contextarea);
    form.append("article",article);
	form.append("title",title);
	form.append("page_tips",page_tips);
	form.append("uptabs",uptabs);
	xhr.overrideMimeType("application/octet-stream"); 
	xhr.send(form);
}
//uploadcoverpicture
function Coverpictureupload(){
	picture_file=document.getElementById("coverpicturefile").files[0];
	if(picture_file.size>65535){
		becos_cover(picture_file);
		
	}else{
		showp_cover(picture_file);
		picture_article=picture_file;
	}
}
function becos_cover(file1){
	"use strict";
	n=n+1;

	var reader=new FileReader();
	reader.readAsDataURL(file1);
	reader.onload=function(){
		var imgsrc=this.result;
		var img=new Image();
		var minsize=99999990000;
		var codes="";
		var blob;
		var blob1;
		var quality;
		var ty=new Array(2);
		var casb64=new Array(2);
		var canvas = document.createElement('canvas');
        var ctx = canvas.getContext('2d');
		var anw = document.createAttribute("width");
        var anh = document.createAttribute("height");
		img.src=imgsrc;
		img.onload=function(){
			var w=img.width+0;
			var h=img.height+0;
			var size_img=file1.size+0;
			if(is_time_use===0){
				if (size_img/65500<9){
					times=1.5;
					quality=1;
				}else if(size_img/65500>16){
					times=Math.floor(Math.sqrt(size_img/65500)-Math.sqrt(Math.sqrt(size_img/65500)));
					quality=0.8;
				}else{
					times=Math.floor(Math.sqrt(size_img/65500)-1);
					quality=0.8;
				}
				is_time_use=1;
			}
			w=Math.floor(w/times);
			h=Math.floor(h/times);
			anw.nodeValue = w;
            anh.nodeValue = h;
            canvas.setAttributeNode(anw);
            canvas.setAttributeNode(anh);
            ctx.drawImage(this, 0, 0, w,h);
			ty[0]="image/jpeg";
			ty[1]="image/png";
			for(var i=0;i<2;i++){
				casb64[i]=canvas.toDataURL(ty[i], quality);
				blob = dataURLtoBlob(casb64[i]);
				if(blob.size<minsize){
					codes=casb64[i];
					blob1=blob;
					minsize=blob.size;
				}else{
				}
			}
			if(minsize<65536){
				showp_cover(blob1);

				picture_article=blob1;
				times=0;
				is_time_use=0;
			}else{
				times=times+0.25;
				quality=quality-0.05;
				becos_cover(picture_file);
			}
			
		};

	} ;
}function showp_cover(bb){
	"use strict";
		var reader=new FileReader();
		reader.readAsDataURL(bb);
		reader.onload=function(){
			document.getElementById("coverpicture").innerHTML="<image class=\"addedpicture\" id=\"coverpic\" src=\" "+this.result+"\" style=\"width:100%;height:100%\" \\>";
		};
}
//get cor picture`s id
function addcoverpicid(num){
	var pics=document.getElementsByClassName("addedpicture");
	for(i=0;i<pics.length;i++){
		if(pic[i].id=="coverpicture"){
			coverpicid=i;
			alert("coverid"+i)
			return 0;
		}
	}	
}