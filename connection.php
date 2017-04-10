<html>
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

$Email = @$_POST["email"];
$Password = @$_POST["pass"];
$Name = @$_POST["email"];



$sql = "INSERT INTO Customer (Email, Password, Name)
VALUES (Email, PassWord, Name)";

if ($conn->query($sql) === TRUE) {
    echo "New record created successfully";
} else {
    echo "Error: " . $sql . "<br>" . $conn->error;
}

/*$sql = "SELECT CustomerID, Name, Email, Password FROM Customer";
$result = mysqli_query($conn, $sql);

if (mysqli_num_rows($result) > 0) {
     // output data of each row
     while($row = mysqli_fetch_assoc($result)) {
         echo "id: " . $row["CustomerID"]. " - Name: " . $row["Name"]. " Email:" . $row["Email"]. " Password: " . $row["Password"]. "<br>";
     }
} else {
     echo "0 results";
}*/

?>

</body>
</html>