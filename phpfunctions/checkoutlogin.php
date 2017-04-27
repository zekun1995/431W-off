<?php
// connect with DB
$servername = "localhost:3306";
$username = "root";
$password = "lollipop";
$dbname = "tester";
// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);
// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// log in
if(isset($_POST['login'])){
	exit('Error in Email or Password!');
}
$emailid = $_POST['email'];
$password = $_POST['pass'];

//check username or password
$sql = "SELECT CustomerID FROM Customer WHERE Email = '$emailid' and Password = '$password'";
$result = mysqli_query($conn, $sql);
if(mysqli_num_rows($result) > 0){
	while($row = mysqli_fetch_assoc($result)) {
		//login successfully
		$id = $row["CustomerID"];
		if ($id == 1) {
			header( "refresh:3;url=../admin.php?id=$id");
			echo $emailid;
			?>
			<br>Welcome! <a href = "../admin.php?id=<?php echo $id ?>">User Account</a><br/>
			<?php
			echo 'Click here to <a href = "../login.html?action=logout">Logout</a><br/>';
			echo 'The webpage will redirect you to checkout in 3 seconds.';
			exit;

		} else {
			header( "refresh:3;url=../ordersummary.php?id=$id");
			echo $emailid;
			?>
			<br>Welcome! <a href = "../ordersummary.php?id=<?php echo $id ?>">Check Out Page</a><br/>
			<?php
			echo 'Click here to <a href = "../login.html?action=logout">Logout</a><br/>';
			echo 'The webpage will redirect you to checkout in 3 seconds.';
			exit;
		}
		
	}
}else{
	exit('Failed to log in! Click here to <a href = "javascript:history.back(-1);">get back</a>');
}

//Logout
if($_GET['action']=="logout"){
	unset($_SESSION['Email']);
	echo 'Logout successfully! Click here to <a href="login.html">Login</a>';
	exit;
}

mysqli_close($conn);

?>
