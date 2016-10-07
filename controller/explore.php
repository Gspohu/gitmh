<?php
include_once('model/get_text.php');

include_once('controller/modif_text.php');
?>

<div class="conteneur" >

<?php
include_once('view/nav/nav.php');

include_once('model/view_repo_info.php');

$data_sql_repo = view_repo_info_explore($bdd);

include_once('view/body/explore.php');

include_once('view/footer/footer.php');
?>
