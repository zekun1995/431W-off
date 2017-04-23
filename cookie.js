// JavaScript Document
var cookisObj = {
	/*add or update cookie
	set function: {o}
	name: string cookie
	value:string cookie
	expires:date
	path:string
	domain: string
	secure:boolean true https, false or undeinfed
	*/
	set: function(o){
		var cookieStr = encodeURIComponent(o.name) + "=" + encodeURIComponent(o.value);
		if(o.expires){
			cookieStr += ";expires=" + o.expires;
		}
		if(o.path){
			cookieStr += ";path=" + o.path;
		}
		if(o.domain){
			cookieStr +=";domain=" + o.domain;
		}
		if(o.secure){
			cookieStr += ";secure";
		}
		decument.cookie = cookieStr;
	},
	/*
	delete
	n string cookie's name
	*/
	del: function(n){
		var date = new Date();
		date.setHours(-1);
		this.set({
			name:n,
			expires: date
		});
	},
	/*get*/
	get: function(n){
		n = encodeURIComponent(n);
		var cookieTotal = document.cookie;
		var cookies = cookieTotal.split("; ");
		for(var i = 0, len = cookies.length; i < len; i++){
			var arr = cookies[i].split("=");
			if(n==arr[0]){
				return decodeURIComponent(arr[1]);
			}
		}
	}
				
	
}