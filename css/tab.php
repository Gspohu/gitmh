<?php
   header('content-type: text/css');
   ob_start('ob_gzhandler');
   header('Cache-Control: max-age=31536000, must-revalidate');
?>


.tab_container
{
	display: block;
}

.tab
{
	width: 100%;
	display: flex;
	justify-content: space-around;
	position: relative;
	margin-top: 50px;
	margin-bottom: 100px;
	color: #DDD9D1;	
}

.tab1
{
	position: relative;
	width: 250px;
	height: 350px;
        border-radius: 2px;
        border: solid grey 1px;
        box-shadow: 0px 1px 5px 1px rgba(0, 0, 0, 0.7);
	background:
			linear-gradient(45deg, #206464 45px, transparent 45px)64px 64px,
			linear-gradient(45deg, #206464 45px, transparent 45px,transparent 91px, #699687 91px, #699687 135px, transparent 135px),
			linear-gradient(-45deg, #206464 23px, transparent 23px, transparent 68px,#206464 68px,#206464 113px,transparent 113px,transparent 158px,#206464 158px);
	background-color:#699687;
	background-size: 128px 128px;
	overflow: hidden;
}

.tab2
{
        position: relative;
        width: 250px;
        height: 350px;
        background-image: url(../images/texture_nav.png);
        border-radius: 2px;
        border: solid grey 1px;
        box-shadow: 0px 1px 5px 1px rgba(0, 0, 0, 0.7);
        overflow: hidden;
}

.tab3
{
        position: relative;
        width: 250px;
        height: 350px;
	background-color:#269;
	background-image: linear-gradient(white 2px, transparent 2px),
	linear-gradient(90deg, white 2px, transparent 2px),
	linear-gradient(rgba(190,190,190,.3) 1px, transparent 1px),
	linear-gradient(90deg, rgba(190,190,190,.3) 1px, transparent 1px);
	background-size: 100px 100px, 100px 100px, 20px 20px, 20px 20px;
	background-position:-2px -2px, -2px -2px, -1px -1px, -1px -1px;
	border-radius: 2px;
        border: solid grey 1px;
        box-shadow: 0px 1px 5px 1px rgba(0, 0, 0, 0.7);
        overflow: hidden;
}

.tab_img
{
	width: 50%;
	margin-left: 25%;
	margin-top: 10px;
}

.text_tab
{
	position: relative;
	width: 90%;
	margin-left: 5%;
	margin-top: 15px;
	text-shadow: 1px 1px 2px #000000;
	line-height: 25px;
}

.title_tab
{
	position: relative;
	margin-top: 10px;
	width: 50%;
	height: 20px;
	background-image: url(../images/texture_inscription.png);
	border-radius: 0px 2px 2px 0px;
	box-shadow: 0px 1px 5px 1px rgba(0, 0, 0, 0.7);		
}

.title_text
{
	margin-left: 10px;
}

.tab_whoisfor
{	
	position: relative;
	display: flex;
	justify-content: space-around;
	margin-top: 40px;
	margin-bottom: 200px;
}

.tab_whoisfor_1
{
	position: relative;
	width: 17%;
	height: 200px;
}

.tab_whoisfor_2
{
	position: relative;
	width: 17%;
	height: 200px;
}

.tab_whoisfor_3
{
	position: relative;
	width: 17%;
	height: 200px;
}

.tab_whoisfor_4
{
	position: relative;
        width: 17%;
	height: 200px;
}

.tab_whoisfor_image img
{
	position: relative;
	width: 50%;
	margin-right: 25%;
	margin-left: 25%;
	margin-bottom: 7px;
}

.tab_whoisfor_text
{
	border-top: 1px solid #BEBEBE;
	padding-top: 5px;
	position: relative;
	color: #242424;
	text-align: center;
}
