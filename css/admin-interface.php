<?php
	header('content-type: text/css');
	ob_start('ob_gzhandler');
	header('Cache-Control: max-age=31536000, must-revalidate');

	include_once('../model/connexion_sql.php');

	include_once('../model/view_design_info.php');

	$color= view_design_info($bdd);

	include_once('style.php');

	include_once('modification.php');
?>

.nav
{
   position: relative;
	height: 47px;
   width: 100%;
   box-shadow: 0px 1px 5px 1px rgba(0, 0, 0, 0.7);
   z-index: 2000;
	background: radial-gradient( circle at center, <?php echo $color['nav_admininterface_gradiant_0']; ?>, <?php echo $color['nav_admininterface_gradiant_1']; ?>);
	margin-bottom: 20px;
}


.nav_motif
{
	position: relative;
   display: flex;
   justify-content: space-around;
   align-items: center;
   height: 47px;
   width: 100%;
	color: <?php echo $color['text_color']; ?>;
	background-image: 
							linear-gradient(transparent 15px, rgba(220,220,200,.3) 16px, transparent 16px),
							linear-gradient(90deg, transparent 15px, rgba(220,220,200,.3) 16px, transparent 16px);
	background-size: 100% 16px, 16px 100%;
}

.nav_motif a
{
   text-decoration: none;
	color: <?php echo $color['text_color']; ?>;
}

.admin-interface_body
{
	display: flex;
	flex-direction: column;
   justify-content: space-between;
   width: 100%;
   flex: 1;
}

.admin-interface_block
{
	display: flex;
	flex-direction: column;
	width: 80%;
	margin-left: 10%;
}

.admin-interface_title
{
   position: relative;
   width: 20%;
   min-width: 120px;
	background-color: <?php echo $color['background_1']; ?>;
	color: <?php echo $color['text_color']; ?>;
   border-radius: 2px 2px 0px 0px;
   padding: 5px 5px 5px 5px;
}

.admin-interface_text
{
	position: relative;
	width: 100%;
	min-height: 50px;
	border: solid 1px grey;
	border-radius: 0px 2px 2px 2px;
	padding: 5px 5px 5px 5px;
}

<?php
	include_once('footer_admin');
?>
