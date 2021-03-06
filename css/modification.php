<?php
   header('content-type: text/css');
	header('Cache-Control: max-age=31536000, must-revalidate');
?>


.modif_text img
{
	position: relative;
	bottom: 8px;
	width: 10px;
}

#Modif
{
	display: none;
}

#Modif:target
{
	display: block;
	position: absolute;
        left: 25%;
        top: 30%;
	width: 50%;
	height: 35%;
	z-index: 3002;
	box-shadow: 0px 1px 5px 1px rgba(0, 0, 0, 0.7);
	border: 1px #4F9C45 solid;
	overflow: hidden;
	border-radius: 0px 0px 5px 5px;
}

#Modif::after
{
	content: "";
	display: block;
	position: absolute;
        left: 0;
        top: 0;
        width: 100%;
        height: 100%;
        z-index: 3001;
        background-color: #4F9C45;
        background-image: linear-gradient(rgba(190,190,190,.3) 1px, transparent 1px),
        linear-gradient(90deg, rgba(190,190,190,.3) 1px, transparent 1px),
        linear-gradient(rgba(190,190,190,.3) 1px, transparent 1px),
        linear-gradient(90deg, rgba(190,190,190,.3) 1px, transparent 1px);
        background-size: 100px 100px, 100px 100px, 20px 20px, 20px 20px;	
}

#Modif::before 
{
	content: "";
	display: block;
	position: fixed;
	left: 0;
	top: 0;
	width: 100%;
	height: 100%;
	background-color: #000000;
	opacity: 0.3;
}

.form_modif
{
	position: relative;
	display: flex;
	justify-content: space-between;
	width: 100%;
	height: 100%;
	z-index: 3002;
}

.title_modif_container
{
	position: relative;
	display: flex;
	justify-content: space-between;
	width: 100%;
        background-color: #4F9C45;
        border-bottom: 1px white solid;
	z-index: 3002;
}

.title_modif
{
	position: relative;
	height: 10%;
	color: white;
}

.exit_modif
{
	position: relative;
	margin-top: 2px;
	margin-right: 5px;
	width: 13px;
	height: 13px;
}

.textarea_modif
{
	position: relative;
	width: 70%;
	height: 94%;
	resize: none;
	border: none;
	border-radius: 0px 0px 0px 5px;
	margin: 0;
}

.menu_modif
{
	position: relative;
	display: flex;
	flex-direction: column;
	justify-content: space-between;	
	width: 20%;
}

.modif_gen_logo
{
	position: relative;
	width: 30px;
	height: 30px;
	margin-top: 10px;
	margin-left: 20px;
}

.select_modif
{
	position: relative;
	height: 20px;
	width: 80px;
	margin-right: 4px;
	color: white;
        background-color: #4F9C45;
        border-radius: 3px;
        border: 1px white solid
}

.submit_modif
{
	position: relative;
	width: 80px;
	height: 28px;
	margin-bottom: 23px;
	margin-right: 4px;
	background-color: #4F9C45;
	border-radius: 3px;
	border: 1px white solid;
	color: white;
	align-self: flex-end;
}
