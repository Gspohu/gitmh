<?php
	$reponse_design = $bdd->query('SELECT * FROM Colors');

	while($donnes_design = $reponse_design->fetch())
	{
		$color[$donnes_design['Item']] = $donnes_design['Design_0'];
	}

	$reponse_design->closeCursor();
?>
