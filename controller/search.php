<?php

if (htmlspecialchars($_POST['reducebutton']) == 'noreduce')
{
	$_SESSION['reduce_search_option'] = 'KO';
}

if (htmlspecialchars($_POST['reducebutton']) == 'reduce' || $_SESSION['reduce_search_option'] == 'OK' && $_SESSION['oneredirection'] == 'NO') 
{
	$_SESSION['reduce_search_option'] = 'OK';
	$_SESSION['oneredirection']= 'YES';	
	header('Location: '.$_SERVER['REQUEST_URI'].'#reduce');
}
else if ($_SESSION['oneredirection'] == 'YES')
{
	$_SESSION['oneredirection']= 'NO';
}

include_once('model/get_text.php');

include_once('view/nav/nav.php');

include_once('view/body/search.php');

include_once('view/footer/footer.php');
?>
