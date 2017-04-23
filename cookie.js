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

<?php
session_start();
$ids = $_GET["ids"];
if(empty($_SESSION["gwc"]))
{
 //1.购物车是空的，第一次点击添加购物车
 $arr = array(
 array($ids,1)
 );
 $_SESSION["gwc"]=$arr;
}
else
{
 //不是第一次点击
 //判断购物车中是否存在该商品
 $arr = $_SESSION["gwc"]; //先存一下
 $chuxian = false;
 foreach($arr as $v)
 {
 if($v[0]==$ids)
 {
  $chuxian = true;
 }
 }
 if($chuxian)
 {
 //3.如果购物车中有该商品
 for($i=0;$i<count($arr);$i++)
 {
  if($arr[$i][0]==$ids)
  {
  $arr[$i][1]+=1;
  }
 }
 $_SESSION["gwc"] = $arr;
 }
 else
 {
 //2.如果购物车中没有该商品
 $asg = array($ids,1);
 $arr[] = $asg;
 $_SESSION["gwc"] = $arr;
 }
}
>

<h2>购物车中有以下商品：</h2>
<table cellpadding="0" cellspacing="0" border="1" width="100%">
 <tr>
 <td>商品名称</td>
 <td>商品单价</td>
 <td>购买数量</td>
 <td></td>
 </tr>
 <?php
 session_start();
 //$uid=$_SESSION["uid"];
 $arr=array();
 if(!empty($_SESSION["gwc"]))
 {
 $arr=$_SESSION["gwc"];
 }
 include("DADB.class.php");
 $db=new DADB();
 foreach($arr as $v)
 {
 global $db;
 $sql="select * from fruit where ids='{$v[0]}'";
 $att=$db -> Query($sql,1);
 foreach($att as $n)
 {
  echo"<tr>
 <td>{$n[1]}</td>
 <td>{$n[2]}</td>
 <td>{$v[1]}</td>
 <td><a href='shanchu.php?ids={$v[0]}'>删除</a></td>
 </tr>";}
 }
 ?>
</table>
<div>
<a href="gouwuche.php" rel="external nofollow" rel="external nofollow" >查看购物车</a> 
<a href="main.php" rel="external nofollow" rel="external nofollow" >浏览商品</a> 
<a href="zhanghu.php" rel="external nofollow" rel="external nofollow" >查看账户</a> </div> 14 15 </body>