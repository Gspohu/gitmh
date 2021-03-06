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


.repo_list_body
{
	display: flex;
	justify-content: space-between;
	width: 100%;
	flex: 1;
}

.aside_searchbar
{
	position: relative;
	width: 150px;
	background-color: #353E46;
	z-index: 2000;
	border-right: 1px solid grey;
	padding-bottom: 100px;
	margin-bottom: -100px;
}

.aside_searchbar_title
{
	position: relative;
	width: 100%;
	padding-top: 10px;
	padding-bottom: 10px;
	font-size: 20px;
	color: #969696;
	text-align: center;
	border-top: 1px solid grey;
	background-color: #353E46;
}

.aside_searchbar_tab
{
	display: flex;
	justify-content: space-between;
	height: 80px;
	width: 150px;
	border-top: 1px solid grey;
	background-color: #353E46;
}

.aside_searchbar_tab_active
{
	display: flex;
	justify-content: space-between;
	height: 80px;
	width: 150px;
	border-top: 1px solid grey;
	background-color: #44505A;
}

.aside_searchbar_tab_last
{
	display: flex;
	justify-content: space-between;
	height: 80px;
	width: 150px;
	border-top: 1px solid grey;
	border-bottom: 1px solid grey;
	background-color: #353E46;
}

.aside_searchbar_tab:hover
{
	background-color: #44505A;
}

.aside_temoin
{
	position: relative;
	margin: 0;
	height: 80px;
	width: 7px;
	border-right: 1px solid grey;
	background-color: #454F5A;
}

.aside_temoin_active
{
	height: 80px;
	width: 7px;
	border-right: 1px solid grey;
	background-color: #541664;
}

.aside_logo
{
	display: flex;
	flex-direction: column;
	height: 80px;
	width: 150px;
	font-size: 55px;
	color: #969696;
	text-align: center;
}

.aside_text
{
	font-size: 13px;
	color: #6B6B6B;
	text-align: center;
}

.select_type
{
	width: 100%;
	border: none;
	color: #969696;
	font-size: 12px;
	padding-left: 15px;
	text-align: center;
	background-color: #44505A;
}

.repo_list
{
	position: relative;
	width: calc(85% - 200px);
	margin-top: 30px;
	margin-right: 7.5%;
}

.repo_list_result
{
	position: relative;
	display: flex;
	justify-content: flex-start;
	width: 100%;
	height: 132px;
	margin-top: 25px;
	color: black;
	border-radius: 2px;
	box-shadow: 0px 0px 3px 1px grey;	
	background-color: #F0F0F0;
	padding: 3px;
}

.inline_search
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


.description
{
	width: calc(100% - 12px);
	font-size: small;	
	overflow-wrap: break-word;
	overflow: hidden;
}

.project_logo img
{
	position: relative;
	width: auto;
	height: 132px;
}

.project_name_description
{
	position: relative;
	display: flex;
	flex-direction: column;
	justify-content: space-between;
	margin-left: 20px;
	margin-bottom: 5px;
	width: 100%;
}

.title_repo 
{
	font-size: large;
	overflow-wrap:break-word;
	text-decoration: none;
	color: black;
}

.sub_title_repo 
{
	font-size: small;
	color: #626968;
	word-wrap: break-word;
	text-decoration: none;
}

<?php
include_once('footer.php');
?>
