<?php

#Récupération des identifiants et mots de passes
$secureAccess = fopen('/var/www/CairnGit/.htpasswd', 'r+');

$identification = fgets($secureAccess);
$password = fgets($secureAccess);
 
fclose($secureAccess);


#Connexion à la base sql
try
{
	$bdd = new PDO('mysql:host=localhost;dbname=cairngit;charset=utf8mb4', $identification, $password, array(PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION));
}
catch (Exception $e)
{
        die('Erreur : ' . $e->getMessage());
}
?>
