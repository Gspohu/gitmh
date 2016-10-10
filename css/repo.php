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


.repo_body
{
	display: flex;
	justify-content: space-between;
	width: 100%;
	flex: 1;
}

.aside_repo
{
   position: relative;
   width: 150px;
   background-color: #353E46;
   z-index: 2000;
   border-right: 1px solid grey;
   padding-bottom: 100px;
   margin-bottom: -100px;
}

.aside_repo_choix
{
	display: flex;
	position: relative;
	height: 30px;
	margin-top: 10px;
}

.aside_repo_choix_logo
{
	position: relative;
	width: 55px;
	height: 25px;
	text-align: center;
	font-size: 23px;
	letter-spacing: -3px;
	text-decoration: none;
   color: #DDD9D1;
}

.aside_repo_choix_text
{
	height: 25px;
	margin-left: 10px;
	font-size: 14px;
	color: #DDD9D1;
	align-self: flex-end;
}

.repo_list_title
{
	position: relative;
	color: black;
	font-size: xx-large;
	margin-bottom: 10px;
}

.repo_body_2
{
	display: flex;
	flex-direction: column;
	justify-content: space-around;
	width: calc(90% - 150px);
	margin: 0;
}

.repo_button
{
	display: flex;
	position: relative;
	margin-right: 11%;
	margin-top: 20px;
	margin-bottom: 20px;
	height: 25px;
	align-self: flex-end;
}

.repo_button_rating
{
   background-color: #FF6200;
   margin-right: 10px;
   border-top: solid 1px grey;
   border-left: solid 1px grey;
   border-right: solid 1px grey;
   border-radius: 2px 2px 0px 0px;
}

.repo_button_fork
{
   background-color: #5A1082;
   border-top: solid 1px grey;
   border-left: solid 1px grey;
   border-right: solid 1px grey;
   border-radius: 2px 2px 0px 0px;
}

.repo_button_text
{
	display: flex;
   font-size: 17px;
   text-decoration: none;
   color: #141414;
	background-color: #EBEBEB;
	padding-right: 2px;
}

.repo_button_nombre
{
	background-color: rgba(0,0,0,0.2);
	color: #282828;
	font-size: 15px;
	padding-right: 2px;
	padding-left: 2px;
	border-right: solid 1px grey;
	margin-right: 2px;
}

.repo_button_design
{
	height: 3px;
}

.repo_list_contain
{
	position: relative;
	display: flex;
	flex-direction: column;
	justify-content: space-around;
	color: #DDD9D1;
	margin-top: 40px;
	margin-right: 11%;
	text-decoration: none;
	border-radius: 2px;
	border: 1px solid #BEBEBE;
	overflow: hidden;
	min-height: 300px;
}

.title_repo_list_contain
{
	position: relative;
	display: flex;
	justify-content: space-between;
	background-color: rgba(0, 0, 0, 0.3);
	border-bottom: 1px solid rgba(38, 142, 156, 0.5);
	overflow: hidden;
}

.title_repo_list_contain_a
{
	display: flex;
	justify-content: flex-start;
}

.title_repo_list_contain_a a
{
	text-decoration: none;
	color: #DDD9D1;
	margin-top: 15px;
	font-size: 20px;
	font-weight: normal;
	margin-bottom: -10px;
}

.tabgroup_repo_list_contain
{
	display: flex;
	position: relative;
	width: 100%;
	margin-top: 65px;
}

.tab_repo_list_contain
{
	position: relative;
	width: 25%;
	height: 0px;
	line-height: 10px;	
	border-right: 30px solid transparent;
	border-bottom: 30px solid rgba(0, 0, 0, 0.7);
	text-align: center;
	text-decoration: none;
	color: #E6E3DC;
}

.tab_repo_list_contain:hover
{
	border-bottom: 30px solid #009400;
}

.file_repo_list_contain
{
	position: relative;
	background-color: #FAFAFA;
	width: 100%;
	flex: 1;
	margin-top: -1px; 
	border-radius: 0px 0px 2px 2px;
	border-top: 1px solid black;
	color: #323232;
}

.repo_list_result
{
	border-bottom: 1px solid #E6E6E6;
	padding: 5px;
}

.repo_list_result:hover
{
	background-color: rgba(59, 148, 178, 0.05);
}

.title_repo_list_link_group
{
	display: flex;
	justify-content: space-around;
	width: 60%;
	margin-top: 20px;
}

.repo_button_bar_newfolder
{
   height: 4px;
   background-color: #EE6B00;
   margin-top: 3px;
}

.repo_button_bar_git
{
   height: 4px;
   background-color: #E10D1F;
	margin-top: 3px;
}

.button_git
{
	width: 120px;
	height: 20px;
	border-radius: 2px 2px 0px 0px;
	border: 1px solid grey;
	background-color: #EBEBEB;	
	color: #1E1E1E;
	text-align: center;
	font-size: small;
   align-self: flex-end;
}

.button_upload
{
	height: 22px;
	border-radius: 2px 2px 0px 0px;
	border: 1px solid grey;
	background-color: #EBEBEB;
	color: #1E1E1E;
	text-align: center;
	font-size: small;
   align-self: flex-end;
}

.button_file
{
	width: 23px;
	height: 20px;
	border-radius: 2px;
	border: 1px solid #2C007A;
	background-color: #664798;
	color: #1E1E1E;
	text-align: center;
	font-size: 15px;
}

div.inputfile
{
	position: relative;
	width: 60px;
	height: 20px;
}

div.mask
{
	position: absolute;
	width: 60px;
	height: 18px;
	left: 0px;
	z-index: 1;
}

input.file
{
	position: relative;
	width: 100%;
	height: 20px;
	top: 20px;
	text-align: right;
	opacity: 0;
	z-index: 2;
	overflow: hidden;
}

.select_files
{
	position: relative;
	display: flex;
	flex-direction: column;
	justify-content: flex-start;
	top: -37px;
}

.inline_button
{
	display: flex;
	justify-content: flex-start;
	height: 30px;
}

.button_new_folder
{
	width: 120px;
	height: 20px;
	border-radius: 2px;
	border: 1px solid grey;
	background-color: #EBEBEB;
	color: #1E1E1E;
	text-align: center;
	font-size: small;
	align-self: flex-end;
}

#GitLink
{
	display: none;
}

#GitLink:target
{
	position: absolute;
	display: flex;
	flex-direction: column;
	justify-content: space-between;
	height: 50px;
	width: 500px;
	background: white;
	border-radius: 0px 0px 0px 2px;
	border-left: 1px solid #BEBEBE;
	border-bottom: 1px solid #BEBEBE;
	padding: 5px;
	color: black; 
	right: 0;
	top: 51px;
	line-height: 17px;
}

#GitLink:target h3
{
	font-weight: bold;
	margin: 0;
	cursor: pointer;
}

.lien_git
{
	border-radius: 2px;
	border: 1px solid #C9C9C9;
	padding: 3px;
	resize: none;
	height: 15px;
	word-wrap: none;
}

.lien_git::selection
{
	background: #C90000;
}


.lien_git::-moz-selection
{
	background: #C90000;
}

.project_logo
{
	position: relative;
	width: auto;
	height: 50px;
	margin-right: 15px;
}

.aside_icon
{
	width: 25px;
	height: auto;
	margin-left: 10px;
	margin-right: 5px;
}

.repo_icon
{
	width: 30px;
	height: auto;
	margin-left: 10px;
	margin-right: 5px;
}

.aff_media
{
	position: relative;
	display:block;
	width: auto;
	max-width: 50%;
	height: auto;
	margin-left: auto;
	margin-right: auto;
	margin-top: 100px;
	margin-bottom: 100px;
}

<?php
	include_once('footer.php');
?>
