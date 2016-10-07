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


.inscription
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

.title_inscription
{
	position: relative;
	font-size: 30px;
	font-weight: 600;
	margin-top: 0px;
	margin-bottom: -10px;
}

.inscription_field
{
	position: relative;
	width: 100%;
	height: 20px;
	border-radius: 0px 2px 2px 2px;
	margin-top: -10px;
	border: solid black 0px;	
	box-shadow: 0px 1px 5px 1px rgba(0, 0, 0, 0.7);
}

.title_form_inscription
{
	position: relative;
	bottom: -16px;
	width: 50%;
	min-width: 120px;
	background-color: <?php echo $color['background_5']; ?>;
	box-shadow: 0px 1px 5px 1px rgba(0, 0, 0, 0.7);
	border-radius: 2px 2px 0px 0px;
	padding: 5px 5px 5px 5px;
}

.submit_inscription
{
	position: relative;
	width: calc(100% + 25px);
	left: -10px;
	bottom: -10px;
	height: 30px;
	background-color: <?php echo $color['background_5']; ?>;	
	content: '||||||';
	border-radius: 2px;
	border: solid black 1px;
	color: <?php echo $color['text_color']; ?>; 
	font-size: 16px;
}

.submit_inscription:hover
{
	color: white;
}

.captcha
{
	position: relative;
	display: flex;
	flex-direction: row;
	justify-content: space-around;
	width: 100px;
	height: 22px;
	border-radius: 0px 2px 2px 0px;
	margin-left: calc(100% - 100px);
	margin-top: -38px;
	border: solid black 0px;
	box-shadow: 0px 1px 5px 1px rgba(0, 0, 0, 0.7);	
	background-color: <?php echo $color['background_5']; ?>;
	background-size: cover;
}

.captcha1
{
	position: relative;
	background-image: url(../images/captcha/captcha1.png);
	height: 22px;
	width: 22px;
	background-size: cover;
}

.captcha2
{
	position: relative;
	background-image: url(../images/captcha/captcha2.png);
	height: 22px;
	width: 22px;
	background-size: cover;
}

.captcha3
{
	position: relative;
	background-image: url(../images/captcha/captcha3.png);
	height: 22px;
	width: 22px;
	background-size: cover;
}

.captcha4
{
	background-image: url(../images/captcha/captcha4.png);
	position: relative;
	height: 22px;
	width: 22px;
	border-radius: 0px 2px 2px 0px;
	background-size: cover;
}

.captcha_field
{
	position: relative;
	width: calc(100% - 100px);
	height: 20px;
	border-radius: 0px 0px 0px 2px;
	margin-top: 0px;
	border: solid black 0px;
	box-shadow: 0px 1px 5px 1px rgba(0, 0, 0, 0.7);
}

<?php
	include_once('footer.php');
?>
