var n=0;
var times=0;
var is_time_use=0;
var picture_file;
var picture_article;
function getfile(){
	"use strict";
	picture_file=document.getElementById("files").files[0];
	if(picture_file.size>65535){
		becos(picture_file);
		
	}else{
		showp(picture_file);
		picture_article=picture_file;
	}
}

function becos(file1){
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
				showp(blob1);
				picture_article=blob1;
				times=0;
				is_time_use=0;
			}else{
				times=times+0.25;
				quality=quality-0.05;
				becos(picture_file);
			}
			
		};

	} ;
}
function dataURLtoBlob(dataurl) {
	"use strict";
    var arr = dataurl.split(','), mime = arr[0].match(/:(.*?);/)[1],
        bstr = atob(arr[1]), n = bstr.length, u8arr = new Uint8Array(n);
    while(n--){
        u8arr[n] = bstr.charCodeAt(n);
    }
    return new Blob([u8arr], {type:mime});
}
function showp(bb){
	"use strict";
		var reader=new FileReader();
		reader.readAsDataURL(bb);
		reader.onload=function(){
			document.getElementById("showpicture").innerHTML="<image src=\" "+this.result+"\" width=\"30%\" style=\"float:left;\"\\>";
		};
}

function showp_article(){
	"use strict";
		var reader=new FileReader();
		reader.readAsDataURL(picture_article);
		reader.onload=function(){
			document.getElementById("article").innerHTML=document.getElementById("article").innerHTML+"<image class=\"addedpicture\" src=\" "+this.result+"\"  \\>";
		};
	picture_article=0;
	
}
function uploadpicture(filep,levelp,pic1,pics){
	"use strict";
	var xhr = new XMLHttpRequest();
	var url = "../addsth/addtosql.jsp";
	xhr.open("post", url, true);
	var form = new FormData(); // FormData 对象
    form.append("file", filep);
	form.append("mod","picture");
	form.append("level",levelp);
	xhr.overrideMimeType("application/octet-stream"); 
	xhr.send(form);
	xhr.onreadystatechange=function(){
		if(xhr.readyState===4){
			if(xhr.status===200){
				var infor=xhr.responseText;
				if(infor.replace(/[^0-9]/ig,"")===null){
					alert(infor);
				}
				infor=infor.replace(/[^0-9]/ig,"");

				pic1.src="../getcpj/?picture="+infor;
				waitxhrpictureover(pics);
			}
		}
	}

	
}
