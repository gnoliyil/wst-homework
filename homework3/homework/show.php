<?
	require "function.php"; 
	
	$db = mysql_connect("localhost", "usr_2015_44", "internetics"); 
	if (!$db)
		error("MySQL connect error!"); 
	
	$sel = mysql_select_db("db_2015_44"); 
	if (!$sel)
		error("MySQL database cannot be selected!"); 
	
	$q = mysql_query("SELECT * FROM db_2015_44 WHERE"); 
	
	$array_json = array(); 
	
	while ($row = mysql_fetch_array($query)){
		$array_item = array(); 
		$array_item['id'] = $row['Guest_ID']; 
		$array_item['name'] = $row['Guest_Name']; 
		$array_item['age'] = $row['Age']; 
		$array_item['gender'] = $row['Gender']; 
		$array_item['addr'] = $row['E_mail']; 
		
		array_push($array_json, $array_item); 
	}
	
	header("Content-type: json; charset=utf-8");  
	echo json_encode($array_json); 
	
	mysql_close(); 
	unset($db, $sel, $q, $array_json, $array_item); 
?>