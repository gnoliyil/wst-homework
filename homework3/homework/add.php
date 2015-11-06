<?
	require "function.php"; 
	
	$db = mysql_connect("localhost", "usr_2015_44", "internetics"); 
	if (!$db)
		error("MySQL connect error!"); 
	
	$sel = mysql_select_db("db_2015_44"); 
	if (!$sel)
		error("MySQL database cannot be selected!"); 
	
	if (!isset($_POST['name'])    || 
		!isset($_POST['age'])     ||
		!isset($_POST['gender'])  ||
		!isset($_POST['addr']))
		error("POST action error!"); 
		
	$name = $_POST['name']; 
	$age = $_POST['age']; 
	$gender = $_POST['gender']; 
	$addr = $_POST['addr']; 
	
	$check_regex = '/^[^<>\\!*?\'"]+$/i';
	$check_addr = '/([\w-]+\.?)*@[\w-]+(\.[a-zA-Z]+)+/i'; 
	
	$q = mysql_query("INSERT INTO db_2015_44(`Guest_Name`, `Age`, `Gender`, `E_mail`) VALUES"); 
	
	header("Content-type: json; charset=utf-8");  
	echo json_encode($array_json); 
	
	mysql_close(); 
	unset($db, $sel, $q, $array_json, $array_item); 
?>