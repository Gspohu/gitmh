<?php
$reponse = $bdd->query('SELECT * FROM Captcha');

$cpt=0;
while ($donnees = $reponse->fetch())
{
	$captcha[$cpt]=$donnees['Nom'];
	$cpt++;
}

$reponse->closeCursor();

?>
