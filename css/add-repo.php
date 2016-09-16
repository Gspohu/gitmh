<?php
   header('content-type: text/css');
   ob_start('ob_gzhandler');
   header('Cache-Control: max-age=31536000, must-revalidate');
?>

.form_add
{
        position: relative;
	width: 40%;
	min-width: 200px;
	color: #DFDCD5;
	background-color: #23282D;
        margin-top: 40px;
        margin-left: 30%;
	border-radius: 2px;
        padding: 0px 15px 10px 10px;
        border: solid #282622 1px;
        text-decoration: none;
	box-shadow: 0px 1px 5px 1px rgba(0, 0, 0, 0.7);
}

.title_add
{
	position: relative;
	font-size: 30px;
	font-weight: 600;
	margin-top: 10px;
	margin-bottom: -10px;
}

.field_add
{
	position: relative;
	width: 100%;
	height: 20px;
	border-radius: 0px 2px 2px 2px;
	margin-top: -10px;
	border: solid black 0px;	
	box-shadow: 0px 1px 5px 1px rgba(0, 0, 0, 0.7);
}

.field_add_textarea
{
        position: relative;
        width: 100%;
        height: 100px;
        border-radius: 0px 2px 2px 2px;
        margin-top: 0px;
        border: solid black 0px;
        box-shadow: 0px 1px 5px 1px rgba(0, 0, 0, 0.7);
	resize: none;
}

.title_form_add
{
	position: relative;
	bottom: -16px;
	width: 30%;
	min-width: 100px;
	background-color: #69499C;
	box-shadow: 0px 1px 5px 1px rgba(0, 0, 0, 0.7);
	border-radius: 2px 2px 0px 0px;
	padding: 5px 5px 5px 5px;
}

.title_form_add_select
{
        position: relative;
        bottom: -16px;
        width: 60%;
        min-width: 100px; 
        background-color: #69499C;
        box-shadow: 0px 1px 5px 1px rgba(0, 0, 0, 0.7);
        border-radius: 2px 2px 0px 0px;
        padding: 5px 5px 5px 5px;
}


.inline_block
{
	display: flex;
	justify-content: space-between;
}

.add_publpriv_select
{
	display: flex;
	flex-direction: column;
	justify-content: flex-end;
	width: 50%;
}

.add_logo
{
	width: 20%;
	min-width: 90px;
}

.submit_add
{
	position: relative;
	width: calc(100% + 25px);
	left: -10px;
	bottom: -10px;
	height: 30px;
	background-color: #69499C;	
	content: '||||||';
	border-radius: 2px;
	color: #DDD9D1; 
	font-size: 16px;
	border: 1px solid rgb(0,0,0);
}

.submit_add:hover
{
	color: white;
}

.select_add
{
	position: relative;
	width: calc(30% + 10px);
	height: 20px;
	min-width: 100px;
	margin-top: -10px;
	border-radius: 0px 0px 2px 2px;
	border: none;
	box-shadow: 0px 1px 5px 1px rgba(0, 0, 0, 0.7);
	background-color: white;
}

.select_add_first
{
        position: relative;
        width: calc(60% + 10px);
        height: 20px;
        min-width: 100px;
        border-radius: 0px 0px 2px 2px;
        border: none;
        box-shadow: 0px 1px 5px 1px rgba(0, 0, 0, 0.7);
        background-color: white;
}

.div_logo_repo_add
{
	position: relative;
	margin-top: 15px;
        background-color: #69499C;
        box-shadow: 0px 1px 5px 1px rgba(0, 0, 0, 0.7);
        border-radius: 2px 2px 0px 0px;
        padding: 5px 3px 5px 5px;
	min-width: 80px;
}

.div_logo_repo_add img
{
	width: 100%;
	min-width: 80px;
}

div.inputfile 
{
	position: relative;
	width: 100%;
	margin-top: 5px;
}

div.mask 
{
	position: absolute;
	width: calc(100% + 2px);
	min-width: 90px;
	margin-left: -1px;
	margin-top: -35px;
	left: 0px;
	z-index: 1;
}

input.file 
{
	position: relative;
	width: 100%;
	height: 30px;
	top: -5px;
	text-align: right;
	opacity: 0;
	z-index: 2;
}

.button_file
{
	width: 100%;
	height: 30px;
	background-color: #69499C;	
        border-radius: 0px 0px 2px 2px;
	color: #DDD9D1;
	border-right: 1px solid rgba(0,0,0,0.7);
	border-left: 1px solid rgba(0,0,0,0.7);
	border-bottom: 1px solid rgba(0,0,0,0.7);
	border-top: none;
	font-size: 16px;
	padding : 1px 0px 1px 0px;
	box-shadow: 0px 2px 3px 0px rgba(0,0,0,0.7);
}
