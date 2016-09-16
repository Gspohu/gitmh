<?php
	session_start();
	include_once('model/connexion_sql.php');
?>

<!DOCTYPE html>
<html>
        <head>
                <meta charset="utf-8" />
                <title>CairnGit</title>
                <link href="css/style" rel="stylesheet" />
		<link href="css/modification" rel="stylesheet" />
		<link href="css/nav_bar_no_log" rel="stylesheet" />
		<link href="css/search" rel="stylesheet" />
		<link href="css/footer" rel="stylesheet" />
        </head>

	<div class="conteneur" >
<?php
	include_once('controller/search.php');
?>
	</div>
<html>
