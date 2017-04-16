<? php
// log in
if(!isset($_POST['submit'])){
	exit('Error in Email or Password!');
}
$emailid = htmlspecialchars($_POST['Email']);
$password = MD5($_POST['pass']);

//connect to DB
include('conn.php');

//check username or password
$check_query = mysql_query("SELECT email FROM Customer WHERE email = '$emailid' and password = '$pass' limit 1");
if($result = mysql_fetch_array($check_query)){
	//login successfully
	session_start();
	$_SESSION['Email'] = $emailid;
	$_SESSION['Email'] = $result['Email'];
	echo $emailid, 'Welcome! <a href = "my.php">User Account</a><br />';
	echo 'click here to <a href = "login.php?action=logout">Logout</a><br />';
	exit;
}
else{
	exit('Failed to log in! Clike here to <a href = "javascript:history.back(-1);">get back</a>');
}
//Logout
if($_GET['action']=="logout"){
	unset($_SESSION['Email']);
	echo 'Logout successfully! Clike here to <a href="login.html">Login</a>';
	exit;
}

?>
