<html>
<head>
<title>Orders</title>
</head>
<body>
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

$ordid = $_GET["orderid"];
$id = $_GET["itemid"];
$qty = $_GET["qty"];

$query = ("DELETE FROM Cus_Place_Ord WHERE OrderID = $ordid");
$result = mysqli_query($conn, $query);

$query = ("DELETE FROM Order_contains WHERE OrderID = $ordid");
$result = mysqli_query($conn, $query);

$query = ("UPDATE Sell_Item SET Qty = Qty + $qty WHERE Sell_Item.ItemID = $id");
$result = mysqli_query($conn, $query);

if ($result) {
    header("Location: ../himalaya.php");
}

mysqli_close($conn);
?>
</body>
</html>