<?php
	header('content-type: text/css');
	ob_start('ob_gzhandler');
	header('Cache-Control: max-age=31536000, must-revalidate');

	include_once('../model/connexion_sql.php');

	include_once('../model/design.php');

	include_once('style.php');

	include_once('modification.php');
  
	include_once('nav_bar_no_log.php');

   include_once('slideshow.php');

   include_once('tab.php');

   include_once('footer.php');
?>
