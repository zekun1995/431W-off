// JavaScript Document
var ccount = document.getElementById("ccount");// show the number of items in cart
var btns = document.querySelectorAll(".list dl dd buttom"); 

var listStr = cookieObj.get("datas");// datas is the cookie's name, that takes the info in the shopping cart

//check is there a shopping cart, by check if has datas or not
if(!listStr){// if there is not datas, create one
	cookieObj.set({
		name:"datas",
		value:"[]"
	});
	listStr=cookieObj.get("datas");
}
var listObj = JSON.parse(listStr);

// loop to count
var totalCount = 0;
for(var i = 0, len = listObj.length; i < len; i++){
	totalCount = listObj[i].pCount + totalCount;
}
ccount.innerHTML = totalCount;

// loop to add button for each item in the cart
for(var i = 0, len = btns.length; i < len; i++){
	btns[i].onclick = function(){
		var dl = this.parentNode.parentNode;
		var pid = dl.getAttribute("pid");
		var arrs = dl.children;
		if(checkObjByPid(pid)){
			listObj = updateObjById(pid, 1);
		}
		else
		{
			var imgSrc = arrs[0].firstElementChild.src;
			var pName = arrs[1].innerHTML;
			var pDesc = arrs[2].innerHTML;
			var price = arrs[3].firstElementChild.innerHTML;
			var obj = {pid: pid, pImg: imgSrc, pName: pName, pDesc: pDesc, price: price, pCount: 1};
			listObj.push(obj);
			listObj = updateData(listObj);
		}
			
		ccount.innerHTML = getTotalCount();	
	}
}