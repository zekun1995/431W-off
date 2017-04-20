<?php
session_start();

//check if loged in
if(!isset($_SESSION['email'])){
	header("Location:login.html");
	exit();
}
include('conn.php');
$emailid = $_SESSION['Email'];
$user_query = mysql_query("SELECT * FROM Customer WHERE Email = '$emailid' limit 1");
$row = mysql_fetch_array($user_query);
echo 'User Info: <br />';
echo 'Email: ',$emailis, '<br />';
echo '<a href = "login.php?action=logout">Logout</a><br />';
?>