<?php
$req = $bdd->prepare('INSERT INTO Member(Pseudo, Email, Password, Timestamp) VALUES(:pseudo, :email, :password, :timestamp)');
$req->execute(array(
	'pseudo' => $pseudo,
	'email' => $email,
	'password' => $password,
	'timestamp' => date('l jS \of F Y h:i:s A'),
	));

$req->closeCursor();
?>
