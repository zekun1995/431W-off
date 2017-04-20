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

session_start();
$_SESSION['itemid'] = $_GET['itemid'];
$itemid = $_GET['itemid'];

$sql = "SELECT Sell_Method FROM Item WHERE $itemid = Item.ItemID";
$result = mysqli_query($conn, $sql);

if (mysqli_num_rows($result) > 0) {
	while($row = mysqli_fetch_assoc($result)) {
	     if ($row["Sell_Method"] == 0) {
	        header("Location: ../sellpage.php?itemid=$itemid");
	        exit;

	     } else if ($row["Sell_Method"] == 1) {
	        header("Location: ../bidpage.php?itemid=$itemid");
	        exit;
	     }
	 }
} else {
     echo "0 results";
}

mysqli_close($conn);
?>