<?php
	session_start();
	include_once('model/connexion_sql.php');
?>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8" />
		<title>CairnGit</title>
		<link href="/css/repo" rel="stylesheet" />
		<link rel="stylesheet" href="/css/highlight/arduino-light">
		<script src="/js/highlight.pack.js"></script>
		<script>hljs.initHighlightingOnLoad();</script>
		<script src="/js/repo.js"></script>
	</head>

	<div class="conteneur" >
		<?php
			include_once('controller/repo.php');
		?>
	</div>
<html>
