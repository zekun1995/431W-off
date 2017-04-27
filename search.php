<html>
<style>
form {
                width:500px;
                margin:left;
}
body,
input,
textarea,
select {
  font-family: 'Open Sans', sans-serif;
  font-size: 16px;
  color: #4c4c4c;
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
<body>
<form action = "searchphpfunction.php" method = "GET">
 	<input type = "text" class = "search" name = "query">
	<input type = "submit" class="button" value = "Search">
</form>

</body>
</html>


