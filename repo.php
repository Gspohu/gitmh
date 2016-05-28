<?php
	session_start();
	include_once('model/connexion_sql.php');
?>

<!DOCTYPE html>
<html>
        <head>
                <meta charset="utf-8" />
                <title>CairnGit</title>
		<base href="<?php echo "http://".$_SERVER['SERVER_NAME']."/cairngit/" ?>"/>
                <link href="css/style.css" rel="stylesheet" />
		<link href="css/modification.css" rel="stylesheet" />
		<link href="css/nav_bar_no_log.css" rel="stylesheet" />
		<link href="css/repo.css" rel="stylesheet" />
		<link href="css/footer.css" rel="stylesheet" />
        </head>

	<div class="conteneur" >
<?php
	include_once('controller/repo.php');
?>
	</div>
<html>
