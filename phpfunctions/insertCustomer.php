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
		$email = $_POST['Email'];
		$password = $_POST['Password'];
		$name = $_POST['Name'];
		$income = $_POST['Income'];
		$age = $_POST['Age'];

		$query = ("INSERT INTO customer (Email, Password, Name, Income, Age) VALUES ('$email', '$password', '$name', '$income', '$age')");

		if(mysqli_query($conn, $query))
		{
			echo "<script>alert('INSERTED SUCCESSFULLY');</script>";
		}
		else
		{
			echo "<script>alert('FAILED TO INSERT');</script>";
		}
	}

	//Close connection
	mysqli_close($conn);
?>