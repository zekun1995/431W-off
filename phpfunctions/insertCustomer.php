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
		$income = $_POST['income'];
		$age = $_POST['age'];
		$gender = $_POST['gender'];
		$address = $_POST['address'];
		$phone = $_POST['mobile'];
		$revenue = $_POST['revenue'];

		if (isset($_POST['Buyer']))
		{
			$query = ("INSERT INTO customer (Email, Password, Name, Income, Age, Gender) VALUES ('$email', '$password', '$name', '$income', '$age', '$gender')");
		}
		else if (isset($_POST['Seller']))
		{
			if (isset($_POST['indi']))
			{
				$query = ("INSERT INTO seller (Email, Password, Name, Address, Phone, Revenue, Type) VALUES ('$email', '$password', '$name', '$address', '$phone', '$revenue', '0')");
			}
			else if (isset($_POST['supplier']))
			{
				$query = ("INSERT INTO seller (Email, Password, Name, Address, Phone, Revenue, Type) VALUES ('$email', '$password', '$name', '$address', '$phone', '$revenue', '1')");
			}
			
		}

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