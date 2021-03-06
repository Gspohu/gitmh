<?php
	header('content-type: text/css');
	ob_start('ob_gzhandler');
	header('Cache-Control: max-age=31536000, must-revalidate');

	include_once('../model/connexion_sql.php');

	include_once('../model/design.php');

	include_once('style.php');

	include_once('modification.php');

	include_once('nav.php');
?>


.connexion
{
	position: relative;
	width: 30%;
	min-width: 200px;
	color: <?php echo $color['text_color']; ?>;
	background-color: <?php echo $color['background_element']; ?>;
	margin-top: 40px;
	margin-left: 35%;
	border-radius: 2px;
	padding: 0px 15px 10px 10px;
	border: solid <?php echo $color['background_element']; ?> 1px;
	text-decoration: none;
	box-shadow: 0px 1px 5px 1px rgba(0, 0, 0, 0.7);
}

.title_connexion
{
	position: relative;
	font-size: 30px;
	font-weight: 600;
	margin-top: 0px;
	margin-bottom: -10px;
}

.connexion_field
{
	position: relative;
	width: 100%;
	height: 20px;
	border-radius: 0px 2px 2px 2px;
	margin-top: -10px;
	border: solid black 0px;	
	box-shadow: 0px 1px 5px 1px rgba(0, 0, 0, 0.7);
}

.title_form_connexion
{
	position: relative;
	bottom: -16px;
	width: 50%;
	min-width: 120px;
	background-color: <?php echo $color['background_1']; ?>;
	box-shadow: 0px 1px 5px 1px rgba(0, 0, 0, 0.7);
	border-radius: 2px 2px 0px 0px;
	padding: 5px 5px 5px 5px;
}

.submit_connexion
{
	position: relative;
	width: calc(100% + 25px);
	left: -10px;
	bottom: -10px;
	height: 30px;
	background-color: <?php echo $color['background_1']; ?>;	
	content: '||||||';
	border-radius: 2px;
	border: solid black 1px;
	color: <?php echo $color['text_color']; ?>; 
	font-size: 16px;
	cursor: pointer;
}


.submit_connexion:hover
{
	color: white;
}

.text_connexion 
{
	color: <?php echo $color['text_color']; ?>;
	text-decoration: none;
}

.text_connexion:hover
{
	color: white;
}

<?php
	include_once('footer.php');
?>
