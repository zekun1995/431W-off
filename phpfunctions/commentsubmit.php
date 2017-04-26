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

        $comment = $_POST['comments'];
        $itemid = $_GET['itemid'];

        $query = ("INSERT INTO Gives_Feedback(ItemID, Feedback_Info) VALUES ('$itemid', '$comment')");
        mysqli_query($conn, $query);

        header("Location: ../himalaya.php");

?>