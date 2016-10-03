<?php

#include function
include_once('model/update_member_option.php');
include_once('model/view_member_option.php');
include_once('model/view_repo_info.php');

#Initialisation des variables
$data_sql = view_member_search_option($bdd, $_SESSION['pseudo']);

while($data = $data_sql->fetch())
{
	$_SESSION['sort']                 = $data['Option_search_sort'];
	$_SESSION['in']                   = $data['Option_search_in'];
        $_SESSION['reduce_search_option'] = $data['Option_search_reduce'];
}
$data_sql->closeCursor();


if(isset($_SESSION['pseudo']))
{
	if(isset($_GET['sort']) && isset($_GET['in']))
	{
		$sort = htmlspecialchars($_GET['sort']);
		$in = htmlspecialchars($_GET['in']);
		update_search_option($bdd, $sort, $in, $reduce, $_SESSION['pseudo']);
        	$_SESSION['sort'] = htmlspecialchars($_GET['sort']);
	        $_SESSION['in'] = htmlspecialchars($_GET['in']);
	}
	else
	{
		$data_sql = view_member_search_option($bdd, $_SESSION['pseudo']);

                while($data = $data_sql->fetch())
                {
		        $_SESSION['sort'] = $data['Option_search_sort'];
		        $_SESSION['in'] = $data['Option_search_in'];
			$_SESSION['reduce_search_option'] = $data['Option_search_reduce'];
                }
                $data_sql->closeCursor();
	}
}
else if(isset($_GET['sort']) && isset($_GET['in']))
{
	$_SESSION['sort'] = htmlspecialchars($_GET['sort']);
	$_SESSION['in'] = htmlspecialchars($_GET['in']);
}
else if(!isset($_SESSION['sort']) && !isset($_SESSION['in']))
{
        $_SESSION['sort'] = '🕒';
        $_SESSION['in'] = '📁';
}

if(isset($_GET['searchbar']))
{
	$view_value = htmlspecialchars($_GET['searchbar']);
	#Faire le tri
	$view_sort  = 'test';
	$data_sql   = view_repo_info_sort($bdd, $view_value, $view_sort);
}

include_once('model/get_text.php');

include_once('controller/modif_text.php');

include_once('view/nav/nav.php');

include_once('view/body/search.php');

include_once('view/footer/footer.php');
?>
