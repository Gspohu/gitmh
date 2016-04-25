<?php

#Récupération des identifiants et mots de passes
$secureAccess = fopen('secure_access', 'r+');

$noneT1 = fgets($secureAccess);
$identification = fgets($secureAccess);
$noneT2 = fgets($secureAccess);
$password = fgets($secureAccess);
 
fclose($secureAccess);


#Nettoyage des valeurs récupéré
$identification = preg_replace("/(\r\n|\n|\r)/", "", $identification);
$password = preg_replace("/(\r\n|\n|\r)/", "", $password);


#Connexion à la base sql
try
{
	$bdd = new PDO('mysql:host=localhost;dbname=cairngit;charset=utf8', $identification, $password, array(PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION));
}
catch (Exception $e)
{
        die('Erreur : ' . $e->getMessage());
}
?>
