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
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>payment page</title>
<style>
body,
input,
textarea,
select {
  font-family: 'Open Sans', sans-serif;
  font-size: 16px;
  color: #4c4c4c;
}

.header{
	background-color:#E8E8E8;
	width:300px;
	margin: 10px 20px;
}

.divpf{
	position:fixed;
	width:500px;
	margin: 10px 20px;
	background:#E8E8E8;
	right:1%;
	top:20%;
}
	
label{
display:inline-block;
width:200px;
margin-right:30px;
/*text-align:right;*/
}

form {
                width:500px;
                margin:left;
}
.search {
                padding:8px 15px;
                background:rgba(50, 50, 50, 0.2);
                border:0px solid #dbdbdb;
}
.button {
                position:relative;
                padding:6px 15px;
                left:-8px;
                border:2px solid #207cca;
                background-color:#BCBCBC;
                color:#fafafa;
}
.button:hover  {
                background-color:#fafafa;
                color:#207cca;
}
</style>
</head>

<body>
<form method="post" action="phpfunctions/addorder.php?id=<?php echo $id ?>">
<div class = "header">
<p style="padding:10px 10px 10px 10px"><font style = "font-size:18pt">1. Shipping Address</font></p>
</div>

<label><span class = "front_input">Name:</span><input id="name" type = "text" class = "_input"  required/></label><br />
    
    <label><span class = "front_input">Address:</span><input id = "address" type = "text" class="_input" required/></label><br/>

    <label><span class = "front_input">City:</span><input id = "city" type = "text" class = "_input" required/></label><br />
  
    <label><span class = "front_input">State:</span><input id = "state" type = "text" class = "_input" required/></label><br />
    
    <label><span class = "front_input">Zip code:</span><input id = "zip" type = "text" class = "_input" required/></label><br />
   
    <label><span class = "front_input">Phone:</span><input id = "phone" type = "text" class = "_input" required/></label><br />
    
    <div class = "header">
<p style="padding:10px 10px 10px 10px"><font style = "font-size:18pt">2. Shipping Options</font></p>
</div>
    
     <input type="radio" name="shipping" value="3-5" checked />3-5 Business Days
     <p style="padding-left:30px"><font color='#7C7C7C'>$10.89</font></p>
  
    <input type="radio" name="shipping" value="6-8" />6-8 Business Days
    <p style="padding-left:30px"><font color='#7C7C7C'>$5.89</font></p>
    
    <div class = "header">
<p style="padding:10px 10px 10px 10px"><font style = "font-size:18pt">3. Payment Method</font></p>
</div>

<label><span class = "front_input">Card number:</span><input id = "cardnum" type = "text" class = "_input" required/></label><br />
Expiration:<br>
    <select name="sel">
    <option value="1">01</option>
    <option value="2">02</option>
    <option value="3">03</option>
    <option value="4">04</option>
    <option value="5">05</option>
    <option value="6">06</option>
    <option value="7">07</option>
    <option value="8">08</option>
    <option value="9">09</option>
    <option value="10">10</option>
    <option value="11">11</option>
    <option value="12">12</option>
</select>

<select name="sel">
    <option value="1">2017</option>
    <option value="2">2018</option>
    <option value="3">2019</option>
    <option value="4">2020</option>
    <option value="5">2021</option>
    <option value="6">2022</option>
    <option value="7">2023</option>
    <option value="8">2024</option>
    <option value="9">2025</option>
    <option value="10">2026</option>
    <option value="11">2027</option>
    <option value="12">2028</option>
</select><br />
    <label><span class = "front_input">CVV/CVC:</span><input id = "cvv" type = "text" class = "_input" required/></label><br />
    <label><span class = "front_input">Name:</span><input id = "mobile" type = "text" class = "_input" required/></label><br />
    
    <br><button type="submit" name ="submit" class="button">Buy!!!</button>
    </form>

<div class="divpf">

    <div class="table-responsive">  
       <table class="table table-bordered">  
          
            <?php
            include('checkout.php');
            checkoutpage();
            ?>  
       </table>  
      </div> 

</div>
</body>
</html>
