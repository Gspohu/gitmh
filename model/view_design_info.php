<?php
function view_design_column_info($bdd)
{
        $req = $bdd->prepare('SHOW COLUMNS FROM Colors');
        $req->execute();

        return $req;
}

function view_design_info($bdd)
{
   $reponse_design = $bdd->query('SELECT * FROM Colors');
   while($donnes_design = $reponse_design->fetch())
		   {
			      $color[$donnes_design['Item']] = $donnes_design['Design_0'];
			}

	$reponse_design->closeCursor();
	return $color;
}
?>
