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
	$query = mysqli_real_escape_string($conn, $query);
	$raw_results = mysqli_query($conn ,"SELECT * FROM Item WHERE (Name LIKE '%".$query."%')OR(Info LIKE '%".$query."%')") or die(mysqli_error());

	if(mysqli_num_rows($raw_results)>0){
		while ($results = mysqli_fetch_array($raw_results)){
			?>
			<div class="div2">
			<a href="phpfunctions/page_select.php?itemid=<?php echo $results['ItemID'] ?>"><?php echo $results['Name']; ?></a><br>
			<a href="phpfunctions/page_select.php?itemid=<?php echo $results['ItemID'] ?>"><img src="<?php echo $results['Picture_Link']; ?>" width="150" height="150"/></a>
			</div>
			<?php
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