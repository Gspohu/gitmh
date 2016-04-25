<?php
$req = $bdd->prepare('INSERT INTO Member(Pseudo, Email, Password) VALUES(:pseudo, :email, :password)');
$req->execute(array(
	'pseudo' => $pseudo,
	'email' => $email,
	'password' => $password,
	));
?>
