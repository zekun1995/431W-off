<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>payment page</title>
<style>
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
</style>
</head>

<body>

<div class = "header">
<p style="padding:10px 10px 10px 10px"><font style = "font-size:18pt">1. Shipping Address</font></p>
</div>

<span class = "front_input">Name:</span><input id="email" type = "text" class = "_input"  /><br />
    
    <span class = "front_input">Address:</span><input id = "pass" type = "password" class="_input" /><br/>

    <span class = "front_input">City:</span><input id = "rpass" type = "password" class = "_input" /><br />
  
    <span class = "front_input">State:</span><input id = "mobile" type = "text" class = "_input" /><br />
    
    <span class = "front_input">Zip code:</span><input id = "age" type = "text" class = "_input" /><br />
   
    <span class = "front_input">Phone:</span><input id = "gender" type = "text" class = "_input" /><br />
    
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

<span class = "front_input">Card number:</span><input id = "mobile" type = "text" class = "_input" /><br />
Expiration:
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
    <span class = "front_input">CVV/CVC:</span><input id = "age" type = "text" class = "_input" /><br />
    <span class = "front_input">Name:</span><input id = "mobile" type = "text" class = "_input" /><br />

<div class="divpf">

    <div class="table-responsive">  
       <table class="table table-bordered">  
          
            <?php   
            error_reporting(0);
            include('index2.php');
            ?>  
       </table>  
      </div> 

</div>
</body>
</html>
