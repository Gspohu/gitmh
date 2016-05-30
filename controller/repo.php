<?php

#include
include_once('model/view_repo_info.php');

#Assignation des variables
$owner = htmlspecialchars($_GET['owner']);
$repo  = htmlspecialchars($_GET['repo']);
$tab   = htmlspecialchars($_GET['tab']);

$data_sql   =  view_repo_info_ext($bdd, $repo, $owner);

while($data = $data_sql->fetch())
{
	$ext = $data['logo'];
}
$data_sql->closeCursor();

include_once('model/get_text.php');

include_once('controller/modif_text.php');

include_once('view/nav/nav.php');

include_once('view/body/repo.php');

include_once('view/footer/footer.php');
?>
