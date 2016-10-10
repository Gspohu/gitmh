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

.repoperso_body
{
	display: flex;
	justify-content: space-between;
	width: 100%;
	flex: 1;
}

.aside_repoperso
{
	position: relative;
	width: 150px;
	background-color: <?php echo $color['background_2']; ?>;
	z-index: 2000;
	border-right: 1px solid grey;
	padding-bottom: 100px;
	margin-bottom: -100px;
}

.aside_repoperso_profil_img
{
	position relative;
	width: 118px;
	height: auto;
	max-height: 250px;
	padding: 5px;
	margin: 10px;
	border-radius: 2px;
   box-shadow: inset 0 0 3px #000, 0 0 2px rgba(255, 255, 255, .1);
   background-color: rgba(0, 0, 0, .25);
}

.aside_repoperso_choix_container
{
	display: flex;	
   box-shadow: inset 0 0 3px #000, 0 0 2px rgba(255, 255, 255, .1);
	margin-bottom: 20px;
}

.aside_repoperso_title
{
   position: relative;
   width: 100%;
   padding-top: 10px;
   padding-bottom: 10px;
   font-size: 20px;
	color: <?php echo $color['text_color']; ?>;
   text-align: center;
	background-color: <?php echo $color['background_2']; ?>;
}

.aside_repoperso_title a
{
	position: relative;
	width: 100%; 
	padding-top: 10px;
	padding-bottom: 10px;
	font-size: 20px;
	color: <?php echo $color['text_color']; ?>;
	text-align: center;
	background-color: <?php echo $color['background_2']; ?>;
	text-decoration: none;
}
								
.aside_repoperso_choix
{
	display: flex;
	flex-direction: column;
	justify-content: space-between;
	position: relative;
	height: 35px;
	width: 30px;
   background-color: rgba(0, 0, 0, .25);	
}

.aside_repoperso_choix_active
{
	position: relative;
	width: 82%;
	height: 20px;
	margin-top: 10px;
	margin-left: 18%;
	background-color: #93827;
	border-radius: 5px 0px 0px 5px;
	box-shadow: 0px 1px 5px 1px rgba(0, 0, 0, 0.7);
}

.aside_repoperso_choix a
{
	display: flex;
	justify-content: center;
	font-size: 25px;
	text-align: center;
	text-decoration: none;
}

.aside_repoperso_choix_temoin
{
	height: 3px;
	width: 29px;
	background-color: <?php echo $color['color_temoin']; ?>;
}

.aside_repoperso_choix_temoin_active
{

}

.aside_repoperso_todo
{
	display: flex;
	flex-direction: column;
	justify-content: space-around;
	width: 150px;
   box-shadow: inset 0 0 3px #000, 0 0 2px rgba(255, 255, 255, .1);
   background-color: rgba(0, 0, 0, .25);
}

.aside_repoperso_todo a
{
	color: <?php echo $color['text_color']; ?>;
   text-decoration: none;
	margin: 5px;
}

.aside_repoperso_todo a:nth-child(3)
{
	align-self: flex-end;
	text-decoration: none;
}

.aside_repoperso_space 
{
	position: relative;
	margin-top: 30px;
	margin-left: 10px;
	width: 122px;
	height: 24px;
	padding: 4px;
	background-color: rgba(0, 0, 0, .25);
	border-radius: 2px;
	box-shadow: inset 0 0 3px #000, 0 0 2px rgba(255, 255, 255, .1);
}

.aside_repoperso_space:before 
{
	content: '';
	position: absolute;
	height: 24px;
	background: #999;
	border-radius: 2px;
	box-shadow: inset 0 1px 0 rgba(255, 255, 255, .3), inset 0 -1px 3px rgba(0, 0, 0, .4), 0 1px 1px #000;
}

.aside_repoperso_space:after 
{ 
	content: '|||||||||||||';
	position: absolute;
	display: block;
	height: 24px;
	overflow: hidden;
	border-radius: 2px;
	transform: skewX(-30deg);
	font:bold 120px/80px sans-serif;
	letter-spacing: -6px;
	color: #000;
	opacity: 0.06;
}

.aside_repoperso_space[data-color="green"]:before
{
	background: linear-gradient(<?php echo $color['degrade_0_p0']; ?>, <?php echo $color['degrade_0_p1']; ?>);
}

.aside_repoperso_space[data-color="blue"]:before 
{ 
	background: linear-gradient(<?php echo $color['degrade_1_p0']; ?>, <?php echo $color['degrade_1_p1']; ?>);
}

.aside_repoperso_space[data-color="orange"]:before 
{ 
	background: linear-gradient(<?php echo $color['degrade_2_p0']; ?>, <?php echo $color['degrade_2_p0']; ?>);
}

.aside_repoperso_space[data-color="red"]:before
{
	background: linear-gradient(<?php echo $color['degrade_3_p0']; ?>, <?php echo $color['degrade_3_p0']; ?>);
}

.aside_repoperso_work_track
{
	position: relative;
	margin-top: 20px;
	margin-left: 10px;
	width: 130px;
	height: 150px;	
   background-color: rgba(0, 0, 0, .25);
   border-radius: 2px; 
   box-shadow: inset 0 0 3px #000, 0 0 2px rgba(255, 255, 255, .1);
}

.aside_repoperso_edit_profil
{
	display: flex;
	flex-direction: column;
   justify-content: center;
	margin-top: 30px;
	margin-left: 10px;
	width: 130px;
	height: 25px;
	text-align: center;
   position: relative;
	background-color: #69499C;
	color: <?php echo $color['text_color']; ?>; 
	cursor: pointer;
	border-radius: 2px;
	box-shadow: 0px 0px 2px 1px rgba(0, 0, 0, 0.7);
}

.aside_repoperso_edit_profil a
{ 
	color: <?php echo $color['text_color']; ?>;
   text-decoration: none;
}

.aside_repoperso_edit_profil a:hover
{
	color: white;
}

.repo_list_add_repo
{
   position: relative;
   left: calc(99% - 130px);
   height: 25px;
	color: <?php echo $color['text_color']; ?>;
	background-color: <?php echo $color['background_3']; ?>;
	border-radius: 2px;
   padding: 10px 20px 10px 20px;
   text-decoration: none;
   text-align: center;
}

.repo_list_add_repo:hover
{
   color: white;
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
	height: 138px;
	margin-top: 25px;
	color: black;
	border-radius: 2px;
	box-shadow: 0px 0px 3px 1px grey;	
	background-color: <?php echo $color['background_4']; ?>;
}

.description
{
	width: calc(100% - 12px);
	font-size: small;	
	word-wrap: break-word;
	overflow: hidden;
}

.project_logo img
{
	position: relative;
	width: auto;
	height: 132px;
	margin: 3px;
}

.project_name_description
{
	position: relative;
	display: flex;
	flex-direction: column;
	justify-content: space-between;
	margin-left: 20px;
	margin-bottom: 5px;
	width: 80%;
}

.title_repo 
{
	font-size: large;
	word-wrap: break-word;
	text-decoration: none;
	color: black;
}

.sub_title_repo 
{
	font-size: small;
	color: <?php echo $color['text_color_sub']; ?>;
	word-wrap: break-word;
	text-decoration: none;
}

<?php
	include_once('footer.php');
?>
