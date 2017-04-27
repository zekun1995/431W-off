<?php
session_start();
$ids = $_GET["item"];
if(empty($_SESSION["gwc"]))
{
 $arr = array(
 array($ids,1)
 );
 $_SESSION["gwc"]=$arr;
}
else
{
 $arr = $_SESSION["gwc"];
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
 $asg = array($ids,1);
 $arr[] = $asg;
 $_SESSION["gwc"] = $arr;
 }
}
?>

<table cellpadding="0" cellspacing="0" border="1" width="100%">
 <tr>
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
 
 foreach($arr as $v)
 {
 global $db;
 $sql="select * from items where ids='{$v[0]}'";
 $att=$db -> Query($sql,1);
 foreach($att as $n)
 {
  echo"<tr>
 <td>{$n[1]}</td>
 <td>{$n[2]}</td>
 <td>{$v[1]}</td>
 </tr>";}
 }
 ?>
</table>
<div>
</body>