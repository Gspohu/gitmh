<?php

if(!isset($_SESSION['pseudo']))
{
	   header("Location: erreur403");
}


include_once('model/get_text.php');

include_once('model/view_member_info.php');

$data_sql_member = view_member_info($bdd, $_SESSION['pseudo']);
$data_member = $data_sql_member->fetch();

if($data_member['Droits'] !== "2")
{
	header("Location: erreur403");
}

include_once('view/nav/nav_bar_admin-interface.php');

$data_sql_all_member = view_all_member_info($bdd);

include_once('model/view_content_info.php');

$data_sql_languages = view_content_column_info($bdd);

include_once('model/view_design_info.php');

$data_sql_design = view_design_column_info($bdd);

include_once('model/view_member_info.php');

$data_sql_member = view_all_member_info($bdd);

include_once('view/body/admin-interface.php');

include_once('view/footer/footer_admin-interface.php');

?>
