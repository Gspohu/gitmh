<?php
	header('content-type: text/css');
	ob_start('ob_gzhandler');
	header('Cache-Control: max-age=31536000, must-revalidate');

	include_once('../model/connexion_sql.php');

	include_once('../model/design.php');

	include_once('style.php');

	include_once('modification.php');

	include_once('nav.php');
?>

.project_list
{
	display: flex;
	justify-content: space-between;
	flex-wrap: wrap;
	margin-top: 20px;
	margin-left: 7%;
	margin-right: 7%;
	background-color: #F0F0F0;
	border-radius: 2px;
	border: solid 1px #E6E6E6;
}

.sort
{
	font-size: 25px;
	width: 99%;
	height: 30px;
	color: #868686;
	margin-left: 1%;
	margin-top: 5px;
}

.project
{
	width: 300px;
	height: 400px;
	border-radius: 2px;
	background-color: #F5F5F5;
	box-shadow: 0px 0px 2px 1px rgba(0,0,0,0.2);
	margin-top: 20px;
	margin-bottom: 50px;
	margin-left: 1%;
   margin-right: 1%;
	padding: 3px;
	overflow: hidden;
}

.title
{
	color: #232323;
}		

.owner
{
	color: #626968;
}

.description
{
   font-size: small;
   word-wrap: break-word;
   overflow: hidden;
	margin-top: 3px;
}

.project_logo 
{
	position: relative;
	height: 150px;
	width: 250px;
}
	
.project_logo img
{
	display: block;
	position: relative;
	width: auto;
	height: 150px;
	margin-bottom: 3px;
	margin-left: auto;
	margin-right: auto;
}
				

<?php
	include_once('footer.php');
?>
