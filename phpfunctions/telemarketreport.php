<html>
<head>
<title>Telemarketers Report</title>
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

table {
    display: table;
    border-collapse: separate;
    border-spacing: 30px;
    border-color: black;
    align: center;
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

$sql = "SELECT * FROM Customer WHERE CustomerID <> 1";
$result = mysqli_query($conn, $sql);
if(mysqli_num_rows($result) > 0){
    ?>
    <table>
            <tr align="center">
                <th>Name</th>
                <th>Address</th>
                <th>Email</th>
                <th>Phone</th>
                <th>Age</th>
                <th>Gender</th>
                <th>Annual Income</th>
            </tr>
    <?php
    while($row = mysqli_fetch_assoc($result)) {
        //login successfully
        $name = $row["Name"];
        //$address = $row[""];
        $email = $row["Email"];
        //$phone = $row[""];
        $age = $row["Age"];
        $gender = $row["Gender"];
        $income = $row["Income"];
        ?>
            <tr align="center">
                <td><?php echo $name ?></td>
                <td></td>
                <td><?php echo $email ?></td>
                <td></td>
                <td><?php echo $age ?></td>
                <td><?php echo $gender ?></td>
                <td><?php echo $income ?></td>
            </tr>
        <?php
    }
    
}else{
    echo('0 results');
}

mysqli_close($conn);
?>
</table>
</body>
<br><a href=../admin.php?id=1>Back</a>
</html>