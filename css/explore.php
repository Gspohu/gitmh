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
	border: solid 1px #F0F0F0;
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

.project_logo 
{
	position: relative;
	height: 150px;
	width: 294px;
   border-radius: 2px;
   box-shadow: inset 0 0 3px rgba(0, 0, 0, .2);
	margin-bottom: 6px;
	background-color: #F0F0F0;
	background-image: 
	radial-gradient(circle at 100% 150%, #F0F0F0 24%, #F5F5F5 25%, #F5F5F5 28%, #F0F0F0 29%, #F0F0F0 36%, #F5F5F5 36%, #F5F5F5 40%, transparent 40%, transparent),
	radial-gradient(circle at 0    150%, #F0F0F0 24%, #F5F5F5 25%, #F5F5F5 28%, #F0F0F0 29%, #F0F0F0 36%, #F5F5F5 36%, #F5F5F5 40%, transparent 40%, transparent),
	radial-gradient(circle at 50%  100%, #F5F5F5 10%, #F0F0F0 11%, #F0F0F0 23%, #F5F5F5 24%, #F5F5F5 30%, #F0F0F0 31%, #F0F0F0 43%, #F5F5F5 44%, #F5F5F5 50%, #F0F0F0 51%, #F0F0F0 63%, #F5F5F5 64%, #F5F5F5 71%, transparent 71%, transparent),
	radial-gradient(circle at 100% 50%, #F5F5F5 5%, #F0F0F0 6%, #F0F0F0 15%, #F5F5F5 16%, #F5F5F5 20%, #F0F0F0 21%, #F0F0F0 30%, #F5F5F5 31%, #F5F5F5 35%, #F0F0F0 36%, #F0F0F0 45%, #F5F5F5 46%, #F5F5F5 49%, transparent 50%, transparent),
	radial-gradient(circle at 0    50%, #F5F5F5 5%, #F0F0F0 6%, #F0F0F0 15%, #F5F5F5 16%, #F5F5F5 20%, #F0F0F0 21%, #F0F0F0 30%, #F5F5F5 31%, #F5F5F5 35%, #F0F0F0 36%, #F0F0F0 45%, #F5F5F5 46%, #F5F5F5 49%, transparent 50%, transparent);
	background-size: 50px 25px;
	padding: 3px;
}

.project_logo a img
{
	display: block;
	position: relative;
	width: auto;
	height: 144px;
	margin-left: auto;
	margin-right: auto;
	margin-top: 3px;
}

.title
{
	color: #232323;
}  

.inline_explore
{
	display: flex;
	justify-content: space-between;
}

.button_fork_rate
{
	border: solid 1px grey;
   border-radius: 2px 2px 2px 2px;
	margin-right: 20px;
   height: 20px;
}

.button_text
{
	display: flex;
	font-size: 17px;
	text-decoration: none;
	color: #141414;
	padding-right: 2px;
}

.button_nombre
{
	background-color: rgba(0,0,0,0.05);
	color: #282828;
	font-size: 15px;
   border-right: solid 1px grey;
	padding-right: 2px;
	padding-left: 2px;
	margin-right: 2px;
	height: 20px;
}

.owner
{
	color: #626968;
	align-self: flex-end;
}

.description
{
	font-size: small;
	word-wrap: break-word;
	overflow: hidden;
	margin-top: 10px;
}
						

<?php
	include_once('footer.php');
?>
