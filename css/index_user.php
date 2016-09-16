<?php
   header('content-type: text/css');
   ob_start('ob_gzhandler');
   header('Cache-Control: max-age=31536000, must-revalidate');
?>

<?php
	   $background_color='#353E46';
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
	background-color: <?php echo $background_color; ?>;
	z-index: 2000;
	border-right: 1px solid grey;
	padding-bottom: 100px;
	margin-bottom: -100px;
}

.aside_repoperso_title
{
	position: relative;
	width: 60%;
	height: 20px; 
	margin-top: 10px;
	background-image: url(../images/texture_inscription.png);
	border-radius: 0px 5px 5px 0px;
	box-shadow: 0px 1px 5px 1px rgba(0, 0, 0, 0.7);
}

.aside_repoperso_title_text
{
	margin-left: 10px;
	color: #DDD9D1;
}

.aside_repoperso_choix
{
	position: relative;
	width: 82%;
	height: 20px;
	margin-top: 10px;
	margin-left: 18%;
}


.aside_repoperso_choix_active
{
	position: relative;
	width: 82%;
	height: 20px;
	margin-top: 10px;
	margin-left: 18%;
	background-image: url(../images/texture_connexion.png);
	border-radius: 5px 0px 0px 5px;
	box-shadow: 0px 1px 5px 1px rgba(0, 0, 0, 0.7);
}

.aside_repoperso_choix_text
{
	margin-right: 10px;
	margin-left: 5px;
	color: #DDD9D1;
}

.repo_list
{
	position: relative;
	width: calc(85% - 200px);
	margin-top: 30px;
	margin-right: 7.5%;
}

.repo_list_title
{
	position: relative;
	color: black;
	font-size: xx-large;
	margin-bottom: 10px;
}

.repo_list_add_repo
{
	position: relative;
	left: calc(99% - 130px);
	height: 25px;
	color: #F5F1E9;
	background-color: #3FA031;
	border: 1px solid #388C2A;
	border-radius: 2px;
	padding: 10px 20px 10px 20px;
	text-decoration: none;	
	text-align: center;
}

.repo_list_add_repo:hover
{
	color: white;
}	

.project_logo
{
	position: relative;
	width: auto;
	height: 100px;
}

.project_name_description
{
	position: relative;
	display: flex;
	flex-direction: column;
	justify-content: space-between;
	margin-left: 20px;
	width: 80%;
}

.repo_list_result
{
	position: relative;
	display:flex;
	justify-content: flex-start;
	width: 100%;
	border-bottom: 1px #DCDCDC solid;
	margin-top: 25px;
	color: black;
	padding-bottom: 10px;
}

.repo_list_result a
{
	text-decoration: none;
	color: black;
}

.description
{
	width: 100%;
	font-size: small;	
	word-wrap: break-word;
}

.aside_repoperso_space 
{
	position: relative;
	margin-top: 20px;
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
	background: linear-gradient(#00C000, #009900);
}

.aside_repoperso_space[data-color="blue"]:before 
{ 
	background: linear-gradient(#5fb6e1, #207ba9);
}

.aside_repoperso_space[data-color="orange"]:before 
{ 
	background: #f28518;
}

.aside_repoperso_space[data-color="red"]:before
{
	background: #B90000;
}

.aside_repoperso_work_track
{
	position: relative;
	margin-top: 20px;
	margin-left: 10px;
	width: 130px;
	height: 150px;	
	background: black;
	border-radius: 5px;
}
