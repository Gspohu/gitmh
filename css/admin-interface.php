<?php
	header('content-type: text/css');
	ob_start('ob_gzhandler');
	header('Cache-Control: max-age=31536000, must-revalidate');

	include_once('../model/connexion_sql.php');

	include_once('../model/design.php');

	include_once('style.php');

	include_once('modification.php');
?>

.nav
{
   position: relative;
   height: 50px;
   width: 100%;
   box-shadow: 0px 1px 5px 1px rgba(0, 0, 0, 0.7);
   z-index: 2000;
	background: radial-gradient( circle at center, <?php echo $color['nav_admininterface_gradiant_0']; ?>, <?php echo $color['nav_admininterface_gradiant_1']; ?>);
}


.nav_motif
{
	position: relative;
   display: flex;
   justify-content: space-around;
   align-items: center;
   height: 50px;
   width: 100%;
	background-image: 
							linear-gradient(transparent 15px, rgba(220,220,200,.3) 16px, transparent 16px),
							linear-gradient(90deg, transparent 15px, rgba(220,220,200,.3) 16px, transparent 16px);
	background-size: 100% 16px, 16px 100%;
}


<?php
	include_once('footer_admin');
?>
