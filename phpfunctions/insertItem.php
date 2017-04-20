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


		if (isset($_POST['sell']))
		{
			if (isset($_POST['book']))
			{
				$query = ("INSERT INTO Item (Name, Info, Sell_Method, Categorie, Picture_Link) VALUES ('$name', '$info', '0', '0', '$pic')");
				mysqli_query($conn, $query);
				$id = mysqli_insert_id($conn);

				$query = ("INSERT INTO Sell_Item (ItemID, Price) VALUES ('$id', '$price')");
				mysqli_query($conn, $query);

				$query = ("INSERT INTO Books (ItemID, Author, Categories) VALUES ('$id', '$author', '$genre')");
				mysqli_query($conn, $query);

			} else if (isset($_POST['tech'])) {
				$query = ("INSERT INTO Item (Name, Info, Sell_Method, Categorie, Picture_Link) VALUES ('$name', '$info', '0', '1', '$pic')");
				mysqli_query($conn, $query);
				$id = mysqli_insert_id($conn);
				
				$query = ("INSERT INTO Sell_Item (ItemID, Price) VALUES ('$id', '$price')");
				mysqli_query($conn, $query);

				$query = ("INSERT INTO Technology (ItemID, Categories) VALUES ('$id', '$tcategorie')");
				mysqli_query($conn, $query);

			} else if (isset($_POST['clothes'])) {
				$query = ("INSERT INTO Item (Name, Info, Sell_Method, Categorie, Picture_Link) VALUES ('$name', '$info', '0', '2', '$pic')");
				mysqli_query($conn, $query);
				$id = mysqli_insert_id($conn);
				
				$query = ("INSERT INTO Sell_Item (ItemID, Price) VALUES ('$id', '$price')");
				mysqli_query($conn, $query);

				$query = ("INSERT INTO Apparel (ItemID, Gender, Categories, Size) VALUES ('$id', '$gender', '$acategorie', '$size')");
				mysqli_query($conn, $query);

			}
		} else if (isset($_POST['bid'])) {
			if (isset($_POST['book']))
			{
				$query = ("INSERT INTO Item (Name, Info, Sell_Method, Categorie, Picture_Link) VALUES ('$name', '$info', '1', '0', '$pic')");
				mysqli_query($conn, $query);
				$id = mysqli_insert_id($conn);

				$query = ("INSERT INTO Bid_Item (ItemID, Start_Price, Reserve_Price) VALUES ('$id', '$sprice', '$rprice')");
				mysqli_query($conn, $query);

				$query = ("INSERT INTO Books (ItemID, Author, Categories) VALUES ('$id', '$author', '$genre')");
				mysqli_query($conn, $query);

			} else if (isset($_POST['tech'])) {
				$query = ("INSERT INTO Item (Name, Info, Sell_Method, Categorie, Picture_Link) VALUES ('$name', '$info', '1', '1', '$pic')");
				mysqli_query($conn, $query);
				$id = mysqli_insert_id($conn);
				
				$query = ("INSERT INTO Bid_Item (ItemID, Start_Price, Reserve_Price) VALUES ('$id', '$sprice', '$rprice')");
				mysqli_query($conn, $query);

				$query = ("INSERT INTO Technology (ItemID, Categories) VALUES ('$id', '$tcategorie')");
				mysqli_query($conn, $query);

			} else if (isset($_POST['clothes'])) {
				$query = ("INSERT INTO Item (Name, Info, Sell_Method, Categorie, Picture_Link) VALUES ('$name', '$info', '1', '2', '$pic')");
				mysqli_query($conn, $query);
				$id = mysqli_insert_id($conn);
				
				$query = ("INSERT INTO Bid_Item (ItemID, Start_Price, Reserve_Price) VALUES ('$id', '$sprice', '$rprice')");
				mysqli_query($conn, $query);

				$query = ("INSERT INTO Apparel (ItemID, Gender, Categories, Size) VALUES ('$id', '$gender', '$acategorie', '$size')");
				mysqli_query($conn, $query);
			}
		}

		/*if(mysqli_query($conn, $query))
		{
			echo "<script>alert('INSERTED SUCCESSFULLY');</script>";
			//header("Location: ../himalaya.php");
		}
		else
		{
			echo "<script>alert('FAILED TO INSERT');</script>";
			//header("Location: ../register.html");
		}*/
	}

	//Close connection
	mysqli_close($conn);
?>