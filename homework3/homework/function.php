<?
    function error($msg){
		header("Content-type: json; charset=utf-8"); 
		echo "{ \"code\": -1, \"msg\": \"$msg\" }"; 
		exit(-1); 
	}
?>