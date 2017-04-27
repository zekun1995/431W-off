<?php
session_start();

if(isset($_POST["add_to_cart"]))  
{  
    if(isset($_SESSION["shopping_cart"]))  
    {  
         $item_array_id = array_column($_SESSION["shopping_cart"], "item_id");  
         if(!in_array($_GET["id"], $item_array_id))  
         {  
              $count = count($_SESSION["shopping_cart"]);  
              $item_array = array(  
                   'item_id'               =>     $_GET["id"],  
                   'item_name'               =>     $_POST["hidden_name"],  
                   'item_price'          =>     $_POST["hidden_price"],  
                   'item_quantity'          =>     $_POST["quantity"]  
              );  
              $_SESSION["shopping_cart"][$count] = $item_array;  
         }  
         else  
         {  
              echo '<script>alert("Item Already Added")</script>';  
              echo '<script>window.location="index2.php?id=$id"</script>';  
         }  
    }  
    else  
    {  
         $item_array = array(  
              'item_id'               =>     $_GET["id"],  
              'item_name'               =>     $_POST["hidden_name"],  
              'item_price'          =>     $_POST["hidden_price"],  
              'item_quantity'          =>     $_POST["quantity"]  
         );  
         $_SESSION["shopping_cart"][0] = $item_array;  
    }  
}  

$cusid = $_GET["id"];

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
		foreach($_SESSION["shopping_cart"] as $keys => $values) {
			$qty = $values["item_quantity"];
      $itemid = $values["item_id"];
			$query = ("INSERT INTO Orders(Qty) VALUES ('$qty')");
			mysqli_query($conn, $query);
			$id = mysqli_insert_id($conn);

      $query = ("INSERT INTO Cus_Place_Ord(OrderID, CustomerID) VALUES ('$id', '$cusid')");
      mysqli_query($conn, $query);

      $query = ("INSERT INTO Order_contains(OrderID, ItemID) VALUES ('$id', $itemid)");
      mysqli_query($conn, $query);

      $query = ("UPDATE Sell_Item SET Qty = Qty - $qty WHERE Sell_Item.ItemID = $itemid");
      mysqli_query($conn, $query);

      unset($_SESSION["shopping_cart"][$keys]); 

      echo "<p>You have placed your order!!!</p>";
      echo "Your order ID: ", $id;

      header("Location: ../userProfile.php?id=$cusid");
		}
	} else {
    echo "FATAL ERRORRR!";
  }

	//Close connection
	mysqli_close($conn);
?>