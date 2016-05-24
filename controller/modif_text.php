<?php
function modif_text($Name)
{
	if($_SESSION['Droits'] == "Admin")
	{
		echo 'oncontextmenu="document.location.href=\'#Modif\'; title_modif(\''.$Name.'\'); return false;"';
	}
}
?>

<?php
	if($_SESSION['Droits'] == "Admin")
        {
		if (isset($_POST['name']) && isset($_POST['content']))
		{
			$name = htmlspecialchars($_POST['name']);
			$content = htmlspecialchars($_POST['content']);
			include_once('model/modif_text.php');
			$redirect = $_SERVER['REQUEST_URI'];
			header("Location: $redirect");			
		}

		include_once('view/body/div_modif.php');
	}	
?>
