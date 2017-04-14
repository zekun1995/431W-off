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

	$sql = "SELECT Name, Picture_Link FROM Item";
	$result = mysqli_query($conn, $sql);

	if (mysqli_num_rows($result) > 0) {
	     // output data of each row
	     while($row = mysqli_fetch_assoc($result)) {
	        $link = $row["Picture_Link"];
	        $name = $row["Name"];
	?>
	<div class="div2">
	<p><?php echo $name; ?></p>
	<img src="<?php echo $link; ?>" width="150" height="150"/>
	</div>
	<?php
	     }
	} else {
	     echo "0 results";
	}
	mysqli_close($conn);
?>