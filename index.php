<?php
	session_start();
	include_once('model/connexion_sql.php');
?>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8" />
		<title>CairnGit</title>
		<link href="css/index" rel="stylesheet" />
	</head>

	<div class="conteneur" >
		<?php
			include_once('controller/index.php');
		?>
	</div>

<html>
