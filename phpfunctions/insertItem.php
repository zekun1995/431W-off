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
	
	if (isset($_POST['add']))
	{
		$name = $_POST['name'];
		$info = $_POST['info'];
		$price = $_POST['price'];
		$qty = $_POST['qty'];
		$etime = $_POST['etime'];
		$sprice = $_POST['sprice'];
		$rprice = $_POST['rprice'];
		$author = $_POST['author'];
		$genre = $_POST['genre'];
		$tcategorie = $_POST['tcategorie'];
		$gender = $_POST['gender'];
		$acategorie = $_POST['acategorie'];
		$size = $_POST['size'];
		$pic = $_POST['picture'];

		$query = ("SELECT MAX(ItemID) FROM Item");
		$result = mysqli_query($conn, $query);
		if (mysqli_num_rows($result) > 0) {
			while($row = mysqli_fetch_assoc($result)) {
				$id = $row['MAX(ItemID)'];
			 }
		} else {
		     echo "0 results";
		}

		$id = $id + 1;

		if (isset($_POST['sell']))
		{
			if (isset($_POST['book']))
			{
				$query = ("INSERT INTO Item (ItemID, Name, Info, Sell_Method, Categorie, Picture_Link) VALUES ('$id', '$name', '$info', '0', '0', '$pic')");
				$check = mysqli_query($conn, $query);

				$query = ("INSERT INTO Sell_Item (ItemID, Qty, Price) VALUES ('$id', '$qty', '$price')");
				$check = mysqli_query($conn, $query);

				$query = ("INSERT INTO Books (ItemID, Author, Categories) VALUES ('$id', '$author', '$genre')");
				$check = mysqli_query($conn, $query);

			} else if (isset($_POST['tech'])) {
				$query = ("INSERT INTO Item (ItemID, Name, Info, Sell_Method, Categorie, Picture_Link) VALUES ('$id', '$name', '$info', '0', '1', '$pic')");
				$check = mysqli_query($conn, $query);
				
				$query = ("INSERT INTO Sell_Item (ItemID, Qty, Price) VALUES ('$id', '$qty', '$price')");
				$check = mysqli_query($conn, $query);

				$query = ("INSERT INTO Technology (ItemID, Categories) VALUES ('$id', '$tcategorie')");
				$check = mysqli_query($conn, $query);

			} else if (isset($_POST['clothes'])) {
				$query = ("INSERT INTO Item (ItemID, Name, Info, Sell_Method, Categorie, Picture_Link) VALUES ('$id', '$name', '$info', '0', '2', '$pic')");
				$check = mysqli_query($conn, $query);
				
				$query = ("INSERT INTO Sell_Item (ItemID, Qty, Price) VALUES ('$id', '$qty', '$price')");
				$check = mysqli_query($conn, $query);

				$query = ("INSERT INTO Apparel (ItemID, Gender, Categories, Size) VALUES ('$id', '$gender', '$acategorie', '$size')");
				$check = mysqli_query($conn, $query);

			}
		} else if (isset($_POST['bid'])) {
			if (isset($_POST['book']))
			{
				$query = ("INSERT INTO Item (ItemID, Name, Info, Sell_Method, Categorie, Picture_Link) VALUES ('$id', '$name', '$info', '1', '0', '$pic')");
				$check = mysqli_query($conn, $query);

				$query = ("INSERT INTO Bid_Item (ItemID, Start_Price, Reserve_Price) VALUES ('$id', '$sprice', '$rprice')");
				$check = mysqli_query($conn, $query);

				$query = ("INSERT INTO Books (ItemID, Author, Categories) VALUES ('$id', '$author', '$genre')");
				$check = mysqli_query($conn, $query);

			} else if (isset($_POST['tech'])) {
				$query = ("INSERT INTO Item (ItemID, Name, Info, Sell_Method, Categorie, Picture_Link) VALUES ('$id', '$name', '$info', '1', '1', '$pic')");
				$check = mysqli_query($conn, $query);
				
				$query = ("INSERT INTO Bid_Item (ItemID, Start_Price, Reserve_Price) VALUES ('$id', '$sprice', '$rprice')");
				$check = mysqli_query($conn, $query);

				$query = ("INSERT INTO Technology (ItemID, Categories) VALUES ('$id', '$tcategorie')");
				$check = mysqli_query($conn, $query);

			} else if (isset($_POST['clothes'])) {
				$query = ("INSERT INTO Item (ItemID, Name, Info, Sell_Method, Categorie, Picture_Link) VALUES ('$id', '$name', '$info', '1', '2', '$pic')");
				$check = mysqli_query($conn, $query);
				
				$query = ("INSERT INTO Bid_Item (ItemID, Start_Price, Reserve_Price) VALUES ('$id', '$sprice', '$rprice')");
				$check = mysqli_query($conn, $query);

				$query = ("INSERT INTO Apparel (ItemID, Gender, Categories, Size) VALUES ('$id', '$gender', '$acategorie', '$size')");
				$check = mysqli_query($conn, $query);
			}
		}

		if($check)
		{
			//Close connection
			mysqli_close($conn);
			echo "<script>alert('INSERTED SUCCESSFULLY');</script>";
			header("Location: ../himalaya.php");
		}
		else
		{
			//Close connection
			mysqli_close($conn);
			echo "<script>alert('FAILED TO INSERT');</script>";
			header("Location: ../add_item.html");
		}
	}
?>