<?php
	$reponse_get_text = $bdd->query('SELECT * FROM Content_EN');

	$cpt=0;

	while($donnes_get_text = $reponse_get_text->fetch())
	{
		$get_text[$donnes_get_text['Name']] = $donnes_get_text['Content'];
	}

	$reponse_get_text->closeCursor();

?>
