<?php

#include
include_once('model/view_repo_info.php');

#Assignation des variables
$owner = htmlspecialchars($_GET['owner']);
$repo  = htmlspecialchars($_GET['repo']);
$tab   = htmlspecialchars($_GET['tab']);

$data_sql   = view_repo_info_ext($bdd, $repo, $owner);

while($data = $data_sql->fetch())
{
	$ext = $data['logo'];
}
$data_sql->closeCursor();


#Récupération des dosiers upload
$count = 0;
if ($_SERVER['REQUEST_METHOD'] == 'POST')
{
	foreach ($_FILES['folder']['name'] as $i => $name) 
	{
        	if (strlen($_FILES['folder']['name'][$i]) > 1) 
		{
            		if (move_uploaded_file($_FILES['folder']['tmp_name'][$i], "repository/".$_SESSION['pseudo']."_repo/".$repo."/".$name)) 
			{
               			$count++;
            		}
        	}
	}
#Récupération des fichiers upload
	$count = 0;
        foreach ($_FILES['files']['name'] as $i => $name)
        {
                if (strlen($_FILES['files']['name'][$i]) > 1)
                {
                        if (move_uploaded_file($_FILES['files']['tmp_name'][$i], "repository/".$_SESSION['pseudo']."_repo/".$repo."/".$name))     
                        {
                                $count++;
                        }
                }
        }
}

include_once('model/get_text.php');

include_once('controller/modif_text.php');

include_once('view/nav/nav.php');

include_once('view/body/repo.php');

include_once('view/footer/footer.php');
?>
