<html>
<head>
<title>Himalaya</title>
<link href="../Sites/MHID_Project_2015 copy/style1.css" rel="stylesheet" type="text/css">
<style>
@import url("../Sites/MHID_Project_2015 copy/style1.css");
 
.button {
                position:relative;
                padding:6px 15px;
                left:-8px;
                border:2px solid #207cca;
                /*background-color:#BCBCBC;*/
                color:#fafafa;
}
body {
    background:#eee;
    margin:0;
    padding:0;
}

body,
input,
textarea,
select {
  font-family: 'Open Sans', sans-serif;
  font-size: 16px;
  color: #4c4c4c;
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
    width:600;
    margin: 10px 20px;
    padding: 15px;
    float: left;
    
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
        <li><a href="all.php">All</a></li>
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
include("search.php");
?>

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
    $sql2 = "SELECT Author, Categories, Start_Time, End_Time, Start_Price, Status, MAX(Price) FROM Books, Bid_Item, Bid, Bid_Contains WHERE $itemid = Books.ItemID AND $itemid = Bid_Item.ItemID AND $itemid = Bid_Contains.ItemID AND Bid_Contains.BidID = Bid.BidID";
    $result2 = mysqli_query($conn, $sql2);
    if (mysqli_num_rows($result2) > 0) {
        while($row2 = mysqli_fetch_assoc($result2)) {
            $author = $row2["Author"];
            $categories = $row2["Categories"];
            $stime = $row2["Start_Time"];
            $etime = $row2["End_Time"];
            $sprice = $row2["Start_Price"];
            $status = $row2["Status"];
            if ($row2["MAX(Price)"] == null) {
                $cprice = $sprice;
            } else {
                $cprice = $row2["MAX(Price)"];
            }
        }
?>
<div class="div1">
<a href="#"><img src="<?php echo $link ?>" width="300" height="350"/></a>
</div>
<div class="div2">
<p><b><font size="+3"><?php echo $name ?></font></b></p>
<p>Author: <?php echo $author ?></p>
<p>Genre: <?php echo $categories ?></p>
<p>Info: <br><?php echo $info; ?></p>
<p>Start Time: <?php $stime ?></p>
<p>End Time: <?php $etime ?></p>
<p>Starting Price: $<?php echo number_format($sprice,2) ?></p>
<p>Current Price: <font color="red" size="+1">$<?php echo number_format($cprice,2) ?></font></p>
<?php
    } else {
    echo "0 results";
    }
}

//output tech
if ($categorie == 1) {
    $sql2 = "SELECT Categories, Start_Time, End_Time, Start_Price, Status , MAX(Price) FROM Technology, Bid_Item, Bid, Bid_Contains WHERE $itemid = Technology.ItemID AND $itemid = Bid_Item.ItemID AND $itemid = Bid_Contains.ItemID AND Bid_Contains.BidID = Bid.BidID";
    $result2 = mysqli_query($conn, $sql2);
    if (mysqli_num_rows($result2) > 0) {
        while($row2 = mysqli_fetch_assoc($result2)) {
            $categories = $row2["Categories"];
            $stime = $row2["Start_Time"];
            $etime = $row2["End_Time"];
            $sprice = $row2["Start_Price"];
            $status = $row2["Status"];
            if ($row2["MAX(Price)"] == null) {
                $cprice = $sprice;
            } else {
                $cprice = $row2["MAX(Price)"];
            }
        }
?>
<div class="div1">
<a href="#"><img src="<?php echo $link ?>" width="450" height="350"/></a>
</div>
<div class="div2">
<p><b><font size="+3"><?php echo $name ?></font></b></p>
<p>Categorie: <?php echo $categories ?></p>
<p>Status: <?php $status ?></p>
<p>Info: <br><?php echo $info; ?></p>
<p>Start Time: <?php $stime ?></p>
<p>End Time: <?php $etime ?></p>
<p>Starting Price: $<?php echo number_format($sprice,2) ?></p>
<p>Current Price: <font color="red" size="+1">$<?php echo number_format($cprice,2) ?></font></p>
<?php
    } else {
        echo "0 results";
    }
}

//output clothes
if ($categorie == 2) {
    $sql2 = "SELECT Gender, Categories, Size, Start_Time, End_Time, Start_Price, Status, MAX(Price) FROM Apparel, Bid_Item, Bid, Bid_Contains WHERE $itemid = Apparel.ItemID AND $itemid = Bid_Item.ItemID AND $itemid = Bid_Contains.ItemID AND Bid_Contains.BidID = Bid.BidID";
    $result2 = mysqli_query($conn, $sql2);
    if (mysqli_num_rows($result2) > 0) {
        while($row2 = mysqli_fetch_assoc($result2)) {
            $gender = $row2["Gender"];
            $categories = $row2["Categories"];
            $size = $row2["Size"];
            $stime = $row2["Start_Time"];
            $etime = $row2["End_Time"];
            $sprice = $row2["Start_Price"];
            $status = $row2["Status"];
            if ($row2["MAX(Price)"] == null) {
                $cprice = $sprice;
            } else {
                $cprice = $row2["MAX(Price)"];
            }
        }
?>
<div class="div1">
<a href="#"><img src="<?php echo $link ?>" width="300" height="350"/></a>
</div>
<div class="div2">
<p><b><font size="+3"><?php echo $name ?></font></b></p>
<p>Categorie: <?php echo $categories ?></p>
<p>Gender: <?php echo $gender?></p>
<p>Size: <?php echo $size?></p>
<p>Info: <br><?php echo $info; ?></p>
<p>Start Time: <?php $stime ?></p>
<p>End Time: <?php $etime ?></p>
<p>Starting Price: $<?php echo number_format($sprice,2) ?></p>
<p>Current Price: <font color="red" size="+1">$<?php echo number_format($cprice,2) ?></font></p>
<?php
    } else {
        echo "0 results";
    }
}
mysqli_close($conn);
?>
<form action="phpfunctions/new_bid.php?item=<?php echo $itemid ?>" method="post">
Your Bid: <input type="text" name="bid" value="<?php echo number_format($cprice+2,2) ?>"><button class="button" type="submit" name="sub" value="Bid">Bid
</form>
</div>
</body>
</html>