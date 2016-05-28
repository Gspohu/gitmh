<?php

include_once('model/view_repo_info.php');

function FileSizeConvert($bytes)
{
    $bytes = floatval($bytes);
        $arBytes = array(
            0 => array(
                "UNIT" => "TB",
                "VALUE" => pow(1024, 4)
            ),
            1 => array(
                "UNIT" => "GB",
                "VALUE" => pow(1024, 3)
            ),
            2 => array(
                "UNIT" => "MB",
                "VALUE" => pow(1024, 2)
            ),
            3 => array(
                "UNIT" => "KB",
                "VALUE" => 1024
            ),
            4 => array(
                "UNIT" => "B",
                "VALUE" => 1
            ),
        );
	
	$result = 0;

    foreach($arBytes as $arItem)
    {
        if($bytes >= $arItem["VALUE"])
        {
            $result = $bytes / $arItem["VALUE"];
            $result = str_replace(".", "," , strval(round($result, 2)))." ".$arItem["UNIT"];
            break;
        }
    }
    return $result;
}

#if (htmlspecialchars($_POST['reducebutton']) == 'noreduce')
#{
#	$_SESSION['reduce_search_option'] = 'KO';
#}

#if (htmlspecialchars($_POST['reducebutton']) == 'reduce' || $_SESSION['reduce_search_option'] == 'OK' && $_SESSION['oneredirection'] == 'NO') 
#{
#	$_SESSION['reduce_search_option'] = 'OK';
#	$_SESSION['oneredirection']= 'YES';	
#	header('Location: '.$_SERVER['REQUEST_URI'].'#reduce');
#}
#else if ($_SESSION['oneredirection'] == 'YES')
#{
#	$_SESSION['oneredirection']= 'NO';
#}




#Vérification de la connexion

$owner             = htmlspecialchars($_GET['owner']);
$repo_name         = "repository/".$owner."_repo";
$repo_list         = scandir($repo_name);
$repo_proto_weight = 0;

#Lister les fichiers de manière récursive et additionner le poids
$cpt = 2;
while(isset($repo_list[$cpt]))
{
        $repo_proto_weight = filesize($repo_list[$cpt]) + $repo_proto_weight;
	$cpt++;
}

$repo_weight = FileSizeConvert($repo_proto_weight);
$weight_percent = "14";
if ($weight_percent < 15)
{
	$weight_color = 'green';
}
else if ($weight_percent < 65)
{
	$weight_color = 'blue';
}
else if ($weight_percent < 85)
{
	$weight_color = 'orange';
}
else if ($weight_percent < 100)
{
	$weight_color = 'red';
}


$view_value = $owner;
$data_sql = view_repo_info_table($bdd, $view_value);

include_once('model/get_text.php');

include_once('controller/modif_text.php');

include_once('view/nav/nav.php');

include_once('view/body/index_user.php');

include_once('view/footer/footer.php');
?>
