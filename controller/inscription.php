<?php
include_once('model/get_text.php');

include_once('view/nav/nav.php');

#Génération du captcha
$nb_captcha=rand(1, 60);
$captcha_name="images/captcha/captcha".$nb_captcha.".png";
copy($captcha_name, 'images/captcha/captcha.png');

include_once('view/body/inscription.php');

if(isset($_POST['reg_pseudo']) && isset($_POST['reg_mail']) && isset($_POST['reg_password']))
{
	$pseudo=htmlspecialchars($_POST['reg_pseudo']);
	$email=htmlspecialchars($_POST['reg_mail']);
	$password=hash('sha256', $_POST['reg_password']);
	include_once('model/inscription.php');
	echo 'Votre compte à été enregistré';
}

include_once('view/footer/footer.php');
?>
