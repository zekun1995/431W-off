<html>
<body>
<form action = "/search.php" method = "GET">
	<input type = "text" name = "query">
	<input type = "submit" value = "Search"/>
</form>

</body>
</html>

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

$query = $_GET['query'];

$min_length = 3;
if(strlen($query) >= $min_length){
	$query = htmlspecialchars($query);
	$query = mysqli_real_escape_string($query);
	$raw_results = mysqli_query("SELECT * FROM Item WHERE (`Name` LIKE '%".$query."%')OR(`Info` LIKE '%".$query."%')") or die(mysqli_error());

	if(mysqli_num_rows($raw_results)>0){
		while ($results = mysqli_fetch_array($raw_results)){
			echo "<p><h3>".$results['title']."</h3>".$results['text']."</p>";
		}
	}
	else{
		echo "No results";
	}
}
else{
	echo "Minimum length is ".$min_length;
}










?>
