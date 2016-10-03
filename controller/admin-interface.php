<?php

if(!isset($_SESSION['pseudo']))
{
	   header("Location: erreur403");
}

//$data_sql_member = view_member_info($bdd);

include_once('model/get_text.php');

include_once('view/nav/nav_bar_admin-interface.php');

include_once('view/body/admin-interface.php');

include_once('view/footer/footer_admin-interface.php');

?>
