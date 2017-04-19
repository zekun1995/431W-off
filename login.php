<?php
// connect with DB
$servername = "localhost:3306";
$username = "root";
$password = "lollipop";
$dbname = "tester";
// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);
// Check connection

// log in
if(isset($_POST['login'])){
	exit('Error in Email or Password!');
}
$emailid = $_POST['email'];
$password = $_POST['pass'];

//check username or password
$sql = "SELECT Email FROM Customer WHERE Email = '$emailid' and Password = '$password'";
$check_query = mysqli_query($conn, $sql);
if(mysqli_num_rows($check_query) > 0){
	//login successfully
	echo $emailid, 'Welcome! <a href = "my.php">User Account</a><br/>';
	echo 'click here to <a href = "login.html?action=logout">Logout</a><br />';
	exit;
}else{
	exit('Failed to log in! Click here to <a href = "javascript:history.back(-1);">get back</a>');
}
//Logout
if($_GET['action']=="logout"){
	unset($_SESSION['Email']);
	echo 'Logout successfully! Clike here to <a href="login.html">Login</a>';
	exit;
}

?>
