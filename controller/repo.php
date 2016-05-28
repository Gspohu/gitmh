<?php

#Assignation des variables
$owner = htmlspecialchars($_GET['owner']);
$repo  = htmlspecialchars($_GET['repo']);
$tab   = htmlspecialchars($_GET['tab']);

include_once('model/get_text.php');

include_once('controller/modif_text.php');

include_once('view/nav/nav.php');

include_once('view/body/repo.php');

include_once('view/footer/footer.php');
?>
