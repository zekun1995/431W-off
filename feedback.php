<html>
<head>
<title>Feedback</title>
<link href="../Sites/MHID_Project_2015 copy/style1.css" rel="stylesheet" type="text/css">
<style>
@import url("../Sites/MHID_Project_2015 copy/style1.css");
 
body {
    background:#eee;
    margin:0;
    padding:0;
}
.example {
    background:#fff url(../images/tech.jpg);
    /*width:770px;
    height:570px;
    border:1px #000 solid;*/
    margin:20px auto;
    padding:15px;
    border-radius:3px;
    -moz-border-radius:3px;
    -webkit-border-radius:3px;
}

/* main menu styles */
#nav,#nav ul {
    background-image:url(../images/tr75.png);
    list-style:none;
    margin:0;
    padding:0;
}
#nav {
    height:41px;
    padding-left:5px;
    padding-top:5px;
    position:relative;
    z-index:2;
}
#nav ul {
    left:-9999px;
    position:absolute;
    top:37px;
    width:auto;
}
#nav ul ul {
    left:-9999px;
    position:absolute;
    top:0;
    width:auto;
}
#nav li {
    float:left;
    margin-right:5px;
    position:relative;
}
#nav li a {
	
    background:#c1c1bf;
    color:#000;
    display:block;
    float:left;
    font-size:16px;
    padding:8px 10px;
    text-decoration:none;
}
#nav > li > a {
    -moz-border-radius:6px;
    -webkit-border-radius:6px;
    -o-border-radius:6px;
    border-radius:6px;

    overflow:hidden;
}
#nav li a.fly {
	margin:0 auto; 
    background:#c1c1bf url(../images/arrow.gif) no-repeat right center;
    padding-right:15px;
}
#nav ul li {
    margin:0;
}
#nav ul li a {
    width:120px;
}
#nav ul li a.fly {
    padding-right:10px;
}

/*hover styles*/
#nav li:hover > a {
	
    background-color:#858180;
    color:#fff;
}

/*focus styles*/
    #nav li a:focus {
    outline-width:0;
}

/*popups*/
#nav li a:active + ul.dd,#nav li a:focus + ul.dd,#nav li ul.dd:hover {
    left:0;
}
#nav ul.dd li a:active + ul,#nav ul.dd li a:focus + ul,#nav ul.dd li ul:hover {
    left:140px;
}

.div1 {
	background-color:#F8F8F8;
	/*width:2;*/
	margin: 10px 20px;
	padding: 20px;
	float: left;
	
}
.div2 {
	background-color:#F8F8F8;
	/*width:2;*/
	margin: 10px 20px;
	padding: 15px;
	float: left;
	
}
      .rating {
          overflow: hidden;
          display: inline-block;
      }
      .rating-input {
          position: absolute;
          left: 0;
          top: -50px;
      }
      .rating-star {        
          display: block;
          float: right;        
          width: 16px;
          height: 16px;
          background: url('http://kubyshkin.ru/samples/star-rating/star.png') 0 -16px;
      }
      .rating-star:hover,
      .rating-star:hover ~ .rating-star {
          background-position: 0 0;
      }



  

</style>
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
session_start();
$_SESSION['itemid'] = $_GET['itemid'];
$itemid = $_GET['itemid'];
?>
<div class = "example">
	<ul id = "nav">
    	<li><a href="himalaya.php">Home</a></li>
		<li><a class = "fly" href="#">Books</a>
        	<ul class = "dd">
                <li><a href="book.php">All</a></li>
            	<li><a href=" ">Fiction</a></li>
                <li><a href=" ">Non-Fiction</a></li>
                <li><a href=" ">Science Fiction</a></li>
                <li><a href=" ">Romance</a></li>
                <li><a href=" ">Mystery</a></li>
  			</ul>
		</li>
        <li><a class = "fly" href="#">Technology</a>
        	<ul class = "dd">
                <li><a href="tech.php">All</a></li>
            	<li><a href=" ">Computer</a></li>
                <li><a href=" ">Coffee Machine</a></li>
                <li><a href=" ">Mobile Phone</a></li>
                <li><a href=" ">Television</a></li>
                <li><a href=" ">Kindle</a></li>
  			</ul>
        </li>
        <li><a class = "fly" href="#">Clothes</a>
        	<ul class = "dd">
                <li><a href="apparel.php">All</a></li>
            	<li><a class = "fly" href="#">Men</a>
                	<ul>
                    	<li><a class = "fly" href="#">Top</a>
                		<ul>
            				<li><a href=" ">Junior</a></li>
                			<li><a href=" ">Adult</a></li>
                			<li><a href=" ">Senior</a></li>
                        </ul>
                        </li>
                        <li><a class = "fly" href="#">Bottom</a>
                		<ul>
            				<li><a href=" ">Junior</a></li>
                			<li><a href=" ">Adult</a></li>
                			<li><a href=" ">Senior</a></li>
                        </ul>
                        </li>
                        <li><a class = "fly" href="#">Shoes</a>
                		<ul>
            				<li><a href=" ">Junior</a></li>
                			<li><a href=" ">Adult</a></li>
                			<li><a href=" ">Kids</a></li>
                        </ul>
                    	</li>
                    </ul>
                </li>
                <li><a class = "fly" href="#">Women</a>
                	<ul>
                    	<li><a class = "fly" href="#">Top</a>
                		<ul>
            				<li><a href=" ">Junior</a></li>
                			<li><a href=" ">Adult</a></li>
                			<li><a href=" ">Senior</a></li>
                        </ul>
                        </li>
                        <li><a class = "fly" href="#">Bottom</a>
                		<ul>
            				<li><a href=" ">Junior</a></li>
                			<li><a href=" ">Adult</a></li>
                			<li><a href=" ">Senior</a></li>
                        </ul>
                        </li>
                        <li><a class = "fly" href="#">Shoes</a>
                		<ul>
            				<li><a href=" ">Junior</a></li>
                			<li><a href=" ">Adult</a></li>
                			<li><a href=" ">Kids</a></li>
                        </ul>
                    	</li>
                    </ul>
                </li>
  			</ul>
		</li>
        <li><a href="login.html">Login</a></li>
        <li><a href="register.html">Register</a></li>
	</ul>

<?php
$sql = "SELECT Name, Info, Categorie, Picture_Link FROM Item WHERE $itemid = Item.ItemID";
$result = mysqli_query($conn, $sql);

if (mysqli_num_rows($result) > 0) {
     // output data of each row
     while($row = mysqli_fetch_assoc($result)) {
        $name = $row["Name"];
        $info = $row["Info"];
        $link = $row["Picture_Link"];
        $categorie = $row["Categorie"];
    }
} else {
    echo "0 results";
}

//output books
if ($categorie == 0) {
    $sql2 = "SELECT Author, Categories, Price FROM Books, Sell_Item WHERE $itemid = Books.ItemID AND $itemid = Sell_Item.ItemID";
    $result2 = mysqli_query($conn, $sql2);
    if (mysqli_num_rows($result2) > 0) {
        while($row2 = mysqli_fetch_assoc($result2)) {
            $author = $row2["Author"];
            $price = $row2["Price"];
            $categories = $row2["Categories"];
        }
?>
<div class="div2">
<p><b><font size="+3"><?php echo $name ?></font></b></p>
<p>Author: <?php echo $author ?></p>
<p>Genre: <?php echo $categories ?></p>
<a href="#"><img src="<?php echo $link ?>" width="150" height="150"/></a>
<p>Info: <br><?php echo $info; ?></p>
<p>Price: <?php echo $price ?> USD</p>
<?php
    } else {
    echo "0 results";
    }
}

//output tech
if ($categorie == 1) {
    $sql2 = "SELECT Categories, Price FROM Technology, Sell_Item WHERE $itemid = Technology.ItemID AND $itemid = Sell_Item.ItemID";
    $result2 = mysqli_query($conn, $sql2);
    if (mysqli_num_rows($result2) > 0) {
        while($row2 = mysqli_fetch_assoc($result2)) {
            $categories = $row2["Categories"];
            $price = $row2["Price"];
        }
?>
<div class="div2">
<p><?php echo $name ?></p>
<p>Categorie: <?php echo $categories ?></p>
<a href="#"><img src="<?php echo $link ?>" width="150" height="150"/></a>
<p>Info: <br><?php echo $info; ?></p>
<p>Price: <?php echo $price ?> USD</p>
<?php
    } else {
        echo "0 results";
    }
}

//output clothes
if ($categorie == 2) {
    $sql2 = "SELECT Gender, Categories, Size, Price FROM Apparel, Sell_Item WHERE $itemid = Apparel.ItemID AND $itemid = Sell_Item.ItemID";
    $result2 = mysqli_query($conn, $sql2);
    if (mysqli_num_rows($result2) > 0) {
        while($row2 = mysqli_fetch_assoc($result2)) {
            $gender = $row2["Gender"];
            $categories = $row2["Categories"];
            $size = $row2["Size"];
            $price = $row2["Price"];
        }
?>
<div class="div2">
<p><?php echo $name ?></p>
<p>Categorie: <?php echo $categories ?></p>
<a href="#"><img src="<?php echo $link ?>" width="150" height="150"/></a>
<p>Gender: <?php echo $gender?></p>
<p>Size: <?php echo $size?></p>
<p>Info: <br><?php echo $info; ?></p>
<p>Price: <?php echo $price ?> USD</p>
<?php
    } else {
        echo "0 results";
    }
}
mysqli_close($conn);
?>


<p>Star Rating:</p>
<span class="rating">
    <input type="radio" class="rating-input"
        id="rating-input-1-5" name="rating-input-1">
    <label for="rating-input-1-5" class="rating-star"></label>
    <input type="radio" class="rating-input"
        id="rating-input-1-4" name="rating-input-1">
    <label for="rating-input-1-4" class="rating-star"></label>
    <input type="radio" class="rating-input"
        id="rating-input-1-3" name="rating-input-1">
    <label for="rating-input-1-3" class="rating-star"></label>
    <input type="radio" class="rating-input"
        id="rating-input-1-2" name="rating-input-1">
    <label for="rating-input-1-2" class="rating-star"></label>
    <input type="radio" class="rating-input"
        id="rating-input-1-1" name="rating-input-1">
    <label for="rating-input-1-1" class="rating-star"></label>
</span>
<p>Comments:</p>
<textarea name="comments" rows="15" cols="50">
</textarea>

<form>
  <input type="button" value="Submit" onclick="msg()">
</form>

<script>
function msg() {
	var ask = window.confirm("Are you sure to upload this feedback!");
    if (ask) {
        window.alert("Your feedback has been submitted successfully!");

        document.location.href = "himalaya.php";
    }
}
</script>

</div>

</div>
</body>
</html>