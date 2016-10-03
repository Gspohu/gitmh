<?php
	session_start();
	include_once('model/connexion_sql.php');
?>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8" />
		<title>CairnGit</title>
		<link href="/css/add-repo" rel="stylesheet" />
		<script src="/js/add-repo.js"></script>
	</head>
	<div class="conteneur" >
		<?php
			include_once('controller/add-repo.php');
		?>
	</div>
<html>
