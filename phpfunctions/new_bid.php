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

	$item = $_GET["item"];
	
	if (isset($_POST['sub']))
	{
		$bid = $_POST['bid'];
		$query = ("INSERT INTO Bid (Price) VALUES ($bid)");
		mysqli_query($conn, $query);
		$id = mysqli_insert_id($conn);
		$query = ("INSERT INTO Bid_Contains (BidID, ItemID) VALUES ($id, $item)");
		mysqli_query($conn, $query);
		header ("Location: ../bidpage.php?itemid=$item");

	} else {
		echo 'WRONG WRONG';
	}

	//Close connection
	mysqli_close($conn);
?>