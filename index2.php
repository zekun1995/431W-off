<?php   
session_start();  

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

$id = $_GET["id"];

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
if(isset($_GET["action"]))  
{  
    if($_GET["action"] == "delete")  
    {  
         foreach($_SESSION["shopping_cart"] as $keys => $values)  
         {  
              if($values["item_id"] == $_GET["id"])  
              {  
                   unset($_SESSION["shopping_cart"][$keys]);  
                   echo '<script>alert("Item Removed")</script>';  
                   echo '<script>window.location="index2.php"</script>';  
              }  
         }  
    }  
}  
?>  
  
<html>
<head>  
<link href="style2.css" rel="stylesheet" type="text/css" />
<style type="text/css">
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
</style>
</head>

<body>
 <div class = "example">
    <ul id = "nav">
      <li><a href="../himalaya.php">Home</a></li>
      <li><a href="all.php">All</a></li>
    <li><a class = "fly" href="#">Books</a>
          <ul class = "dd">
              <li><a href=" ">Fiction</a></li>
                <li><a href=" ">Non-Fiction</a></li>
                <li><a href=" ">Science Fiction</a></li>
                <li><a href=" ">Romance</a></li>
                <li><a href=" ">Mystery</a></li>
        </ul>
    </li>
        <li><a class = "fly" href="#">Technology</a>
          <ul class = "dd">
              <li><a href=" ">Computer</a></li>
                <li><a href=" ">Coffee Machine</a></li>
                <li><a href=" ">Mobile Phone</a></li>
                <li><a href=" ">Portabe Heater</a></li>
                <li><a href=" ">Kindle</a></li>
        </ul>
    </li>
        </li>
        <li><a class = "fly" href="#">Clothes</a>
          <ul class = "dd">
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
  </div>

<div class="div2">
 <div class="container" style="width:500px;"> 
      <?php 
      $query = "SELECT * FROM item, Sell_Item WHERE Item.ItemID = '$id' AND Item.ItemID = Sell_Item.ItemID";  
      $result = mysqli_query($conn, $query);  
      if(mysqli_num_rows($result) > 0)  
      {  
           while($row = mysqli_fetch_array($result))  
           {  
      ?>  
      <div class="col-md-4">  
           <form method="post" action="index2.php?action=add&id=<?php echo $id ?>">  
                <div style="border:1px solid #333; background-color:#f1f1f1; border-radius:5px; padding:16px;" align="center">  
                     <img src="<?php echo $row["Picture_Link"]; ?>" class="img-responsive" height=200px/><br />  
                     <h4 class="text-info"><?php echo $row["Name"]; ?></h4>  
                     <h4 class="text-danger">$ <?php echo $row["Price"]; ?></h4>  
                     Quantity: <input type="text" name="quantity" class="form-control" value="1" />  
                     <input type="hidden" name="hidden_name" value="<?php echo $row["Name"]; ?>" />  
                     <input type="hidden" name="hidden_price" value="<?php echo $row["Price"]; ?>" />  
                     <input type="submit" name="add_to_cart" style="margin-top:5px;" class="btn btn-success" value="Add to Cart" />  
                </div>  
           </form>  
      </div>  
      <?php  
           }  
      }

      include('checkout.php');
 checkoutpage(); ?> 
 <br /> 

 <form
 <form method="post" action="checkoutlogin.html">
      <button type="submit" name="submit value="checkout">Check Out!</button>
  </form>
   </div>
      </body> 
 </html>