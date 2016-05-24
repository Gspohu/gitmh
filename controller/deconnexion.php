<?php
	session_start();
	session_destroy();
	setcookie('gsScrollPos', NULL, -1);
	header('Location: '.$_SERVER['HTTP_REFERER']);
?>

