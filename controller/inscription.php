<?php
#Déclaration des varibales
$error_pass_length = "";
$error_bad_email = "";
$error_existing_pseudo = "";
$error_existing_email = "";
$error_pass_doesnt_match = "";
$error_bad_captcha = "";


include_once('model/get_text.php');

include_once('controller/modif_text.php');

include_once('view/nav/nav.php');

if( ! isset($_SESSION['captcha']))
{
	$_SESSION['captcha']= "";
}

if(isset($_POST['reg_pseudo']) && isset($_POST['reg_mail']) && isset($_POST['reg_password']) && isset($_POST['reg_repassword']) && isset($_POST['captcha']))
{
	$pseudo       = preg_replace("#[^[:alnum:]-]#","", $_POST['reg_pseudo']);
	$email        = htmlspecialchars($_POST['reg_mail']);
	$captcha_user = hash('sha256', $_POST['captcha']);
	

	if($_SESSION['captcha'] == $captcha_user)
	{
		unset($_SESSION['captcha']);

		#Vérification des mots de passes
		if(htmlspecialchars($_POST['reg_password']) == htmlspecialchars($_POST['reg_repassword']))
		{
			#Vérification de la taille des mots de passes
			$nb_carac_password = iconv_strlen(htmlspecialchars($_POST['reg_password']));
			
			if( $nb_carac_password < 8)
			{
				$error_pass_length = '<img src="images/pictogrammes/redcross.png" alt="error" width=15px /> Passphrase too short';
			}
			else
			{
				#Vérification de l'adresse mail
				include_once('model/verif_mail_pseudo.php');
				if(filter_var($email, FILTER_VALIDATE_EMAIL) == FALSE)
				{
					$error_bad_email = '<img src="images/pictogrammes/redcross.png" alt="error" width=15px /> Invalid email';
				}
				else if($result_pseudo)
				{
					$error_existing_pseudo = '<img src="images/pictogrammes/redcross.png" alt="error" width=15px /> Existing pseudo';
				}
				else if($result_email)
				{
					$error_existing_pseudo = '<img src="images/pictogrammes/redcross.png" alt="error" width=15px /> Existing email';
				}
				else
				{
                                        $password = hash('sha256', $_POST['reg_password']);
                                        include_once('model/inscription.php');
						
					#Création du repo
					$repo_name = $pseudo."_repo";
					mkdir("repository/$repo_name", 0777);
					mkdir("repository/$repo_name/.profil", 0777);	
					copy("images/avatar.png", "repository/$repo_name/.profil/avatar.png");
					$fichier = fopen('.htaccess', 'a');
					fputs($fichier, "RewriteRule ^$pseudo$  index_user.php [L]".PHP_EOL);
					fputs($fichier, "RewriteRule ^$pseudo/$1  repo.php?repo=$1 [L]".PHP_EOL);
					fclose($fichier);

					$_SESSION['pseudo'] = $pseudo;
					$_SESSION['pass'] = $password;
                                        header("Location: $pseudo"); 
				}
		
			}	
		}
		else
		{
				$error_pass_doesnt_match = '<img src="images/pictogrammes/redcross.png" alt="error" width=15px /> Passphrases does not match';
		}	
	}
	else
	{
			$error_bad_captcha = '<img src="images/pictogrammes/redcross.png" alt="error" width=15px /> Bad captcha';
			unset($_SESSION['captcha']);
	}	
}

#Génération du captcha
include_once('model/captcha.php');

$cpt=1;
$captcha_val = "";
while ($cpt < 5)
{
	$nb_captcha=rand(1, 52);
	$captcha_name="images/captcha/".$nb_captcha.".png";
	copy($captcha_name, "images/captcha/captcha".$cpt.".png");
	$captcha_val = $captcha_val.$captcha[$nb_captcha-1];
	$cpt++;
}

$_SESSION['captcha'] = hash('sha256', $captcha_val);

include_once('view/body/inscription.php');

include_once('view/footer/footer.php');
?>
