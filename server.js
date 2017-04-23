// JavaScript Document
/*
	to check if the product is in the database, by itemId
	
*/

function checkObjByPid(id){
	var jsonStr = cokkkieObj.get("datas");
	var jsonObj = JSON.parse(jsonStr);
	var isExist = false;
	for(var i = 0, len = jsonObj.length; i < len; i++){
		if(jsonObj[i].pid == id){
			isExist = true;break;
		}
	}return isExist; // return false;
}
/*
update local database
return the updated data
*/
function updateData(arr){
	var jsonStr = JSON.stringify(arr);
	cookieObj.set({
		name: "datas",
		value: jsonStr
	});
	jsonStr = cookieObj.get("datas");
	return JSON.parse(jsonStr);
}
/*get the products amount
return integer
*/
function gettotalCount(){
	var totalCount = 0;
	var jsonStr = cookieObj.get("datas");
	var listObj = JSON.parse(jsonStr);
	for(var i = 0, len = listObj.length; i < len; i++){
		totalCount = listObj[i].pCount + totalCount;
	}
	return totalCount;
}
/*
update the local database by itemId
*/
function updateIbjById(id, num){
	var jsonStr = cookieObj.get("datas");
	var listObj = JSON.parse(jsonStr);
	for(var i = 0, len = listObj.length; i < len; i++){
		if(listObj[i].pid == id){
			listObj[i].pCount = listObj[i].pCount + num;
			break;
		}
	}
	return updateData(listObj);
}
/*
get data from local database
return product
*/
function getAllData(){
	var jsonStr = cookieObj.get("datas");
	var listObj = JSON.parse(jsonStr);
	return listObj;
}

function deleteObjByPid(id){
	var lisObj = getAllData();
	for(var i = 0, len = lisObj.length; i < len; i++){
		if(lisObj[i].pid == id){
			lisObj.splice(i, 1);
			break;
		}
	}
	updateData(lisObj);
	return lisObj;
}