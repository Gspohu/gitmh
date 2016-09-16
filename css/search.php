<?php
   header('content-type: text/css');
   ob_start('ob_gzhandler');
   header('Cache-Control: max-age=31536000, must-revalidate');
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
	height: 138px;
   margin-top: 25px;
   color: black;
	border-radius: 2px;
   box-shadow: 0px 0px 3px 1px grey;	
	background-color: #F0F0F0;
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
	color: #626968;
   word-wrap: break-word;
	text-decoration: none;
}
