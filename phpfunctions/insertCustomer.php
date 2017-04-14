<?php
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
	
	if (isset($_POST['submit']))
	{
		$email = $_POST['email'];
		$password = $_POST['pass'];
		$name = $_POST['name'];
		$phone = $_POST['mobile'];
		$income = $_POST['income'];
		$age = $_POST['age'];
		$gender = $_POST['gender'];
		
		$query = ("INSERT INTO customer (Email, Password, Name, Phone, Income, Age, Gender) VALUES ('$email', '$password', '$name', '$phone', '$income', '$age', '$gender')");

		if(mysqli_query($conn, $query))
		{
			echo "<script>alert('INSERTED SUCCESSFULLY');</script>";
			header("Location: ../himalaya.php");
		}
		else
		{
			echo "<script>alert('FAILED TO INSERT');</script>";
			header("Location: ../register.html");
		}
	}

	//Close connection
	mysqli_close($conn);
?>