<?php

#Déclaration variable
$extension_upload = "png";

include_once('model/update_purchase.php');

include_once('model/view_purchase.php');

include_once('model/view_repo_info.php');

if(!isset($_SESSION['pseudo']))
{
	header("Location: erreur403");	
}

if(isset($_POST['repo_name']) && isset($_POST['publpriv']) && isset($_POST['repo_type']) && isset($_POST['repo_license']) && htmlspecialchars($_POST['submit']) == 'Submit')
{
	$repo_name		= htmlspecialchars($_POST['repo_name']);
	$publpriv		= htmlspecialchars($_POST['publpriv']);
	$repo_type		= htmlspecialchars($_POST['repo_type']);
	$repo_description	= htmlspecialchars($_POST['repo_description']);
	$repo_license		= htmlspecialchars($_POST['repo_license']);
	$repo_tags		= htmlspecialchars($_POST['repo_tags']);

        if(isset($_POST['encryption']))
        {
                $encryption     = htmlspecialchars($_POST['encryption']);
        }
	else
	{
                $encryption     = "none";
	}


	if($publpriv == 'private')
	{
		$view_what	           = 'Private_project';
		$view_who	           = $_SESSION['pseudo'];
		$nb_private_project        = view_purchase($bdd, $view_what, $view_who);
		$view_what                 = 'Private_project_unlimited';		
		$private_project_unlimited = view_purchase($bdd, $view_what, $view_who);
	
		if($private_project_unlimited == "Unlimited")
		{
			#Encryption

			$view_what  = $repo_name;
			$view_value = $_SESSION['pseudo'];
			$result     = view_repo_info_name($bdd, $view_what, $view_value);

			if(!$result)
			{
				mkdir("repository/".$_SESSION['pseudo']."_repo/".$repo_name."/.cairn", 0777);
				$create_repo = 'OK';
			}
			else
			{
				echo '<img src="images/pictogrammes/redcross.png" alt="error" width=15px />Project already existing';
			}
		}
		else if($nb_private_project > 0)
		{
			#Encryption			

			$update_value = $nb_private_project - 1;
			$update_what  = 'Private_project';
			$update_who   = $_SESSION['pseudo'];
			update_purchase($bdd, $update_value, $update_what, $update_who);
                 
		        $view_what  = $repo_name;
                        $view_value = $_SESSION['pseudo'];
                        $result     = view_repo_info_name($bdd, $view_what, $view_value);

                        if(!$result)
                        {
                                mkdir("repository/".$_SESSION['pseudo']."_repo/".$repo_name."/.cairn", 0777);
                                $create_repo = 'OK';
                        }
                        else
                        {
                                echo '<img src="images/pictogrammes/redcross.png" alt="error" width=15px />Project already existing';
                        }
		}
		else
		{
			 header("Location: purchase?what=repo");
		}
	}
	else if($publpriv == 'public')
	{
                        $view_what  = $repo_name;
                        $view_value = $_SESSION['pseudo'];
                        $result     = view_repo_info_name($bdd, $view_what, $view_value);

                        if(!$result)
                        {
				mkdir("repository/".$_SESSION['pseudo']."_repo/".$repo_name."/", 0777);
                                mkdir("repository/".$_SESSION['pseudo']."_repo/".$repo_name."/.cairn/", 0777);
                                $create_repo = 'OK';
                        }
                        else
                        {
                                echo '<img src="images/pictogrammes/redcross.png" alt="error" width=15px />Project already existing';
                        }	
	}

	if($create_repo == 'OK')
	{
		#Traitement de l'upload du logo du projet
		if (isset($_FILES['repo_logo']) AND $_FILES['repo_logo']['error'] == 0 AND $_FILES['repo_logo']['size'] <= 4000000)
		{
               		 	$infosfichier = pathinfo($_FILES['repo_logo']['name']);
		                $extension_upload = strtolower($infosfichier['extension']);
        		        $extensions_autorisees = array('jpg', 'jpeg', 'gif', 'png', 'svg');
	                	if (in_array($extension_upload, $extensions_autorisees))
		                {
        		                move_uploaded_file($_FILES['repo_logo']['tmp_name'], "repository/".$_SESSION['pseudo']."_repo/".$repo_name."/.cairn/repo_logo.".$extension_upload);
					chmod("repository/".$_SESSION['pseudo']."_repo/".$repo_name."/.cairn/repo_logo.".$extension_upload, 0644);
				}
		}
		else
		{
			copy("images/logo/logo_base_proj.png", "repository/".$_SESSION['pseudo']."_repo/".$repo_name."/.cairn/repo_logo.png");
		}
			$ext = ".". $extension_upload;
			include_once('model/add_repo.php');

			$path = "repository/".$_SESSION['pseudo']."_repo/".$repo_name."/"; # Faille /!\

			copy("example/".$repo_license.".txt", $path.$repo_license.".txt");
			exec("git init ".escapeshellarg($path));
			exec("cd escapeshellarg($path); mv hooks/post-update.sample hooks/post-update");
			exec("cd escapeshellarg($path); chmod a+x hooks/post-update");
			exec("cd escapeshellarg($path); git add .");
			exec("cd escapeshellarg($path); git commit -m 'Initial commit'");
			$gitignore = fopen($path.".gitignore", 'a+');
			fputs($gitignore, '.gitignore'.PHP_EOL);
 			fputs($gitignore, '.cairn'.PHP_EOL);
			fclose($gitignore);
			$redirec = $_SESSION['pseudo']."🜉/".$repo_name."📂/";
			header("Location: $redirec");			
			
			#Système de chiffrement
	}
}


include_once('model/get_text.php');

include_once('controller/modif_text.php');

include_once('view/nav/nav.php');

include_once('view/body/add-repo.php');

include_once('view/footer/footer.php');
?>
