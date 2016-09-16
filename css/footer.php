<?php
   header('content-type: text/css');
   ob_start('ob_gzhandler');
   header('Cache-Control: max-age=31536000, must-revalidate');
?>


footer
{
	position: relative;
	display: block;
	background-color: #23282D;
	box-shadow: 5px 0px 5px 1px rgba(0, 0, 0, 0.7);	
	margin-top: 100px;
	padding-top: 10px;
	padding-bottom: 10px;
}

.footer_logo
{
	position: relative;
	display: block;
	width: 150px;
	margin-left: 20px;
}

.copyright
{
	position: relative;
	display: block;
	width: 220px;
	height: 20px;
	color: #DDD9D1;
	margin-left: 0px;
	margin-bottom: 10px;
	background-image: url(../images/texture_inscription.png);
	border-radius: 0px 2px 2px 0px;
	box-shadow: 0px 1px 5px 1px rgba(0, 0, 0, 0.7);
}

.copyright_text a
{
	margin-left: 10px;	
        color: #DDD9D1;
        text-decoration: none;
}

.copyright_text a:hover
{
	color: white;
}

.links_footer
{
	position: relative;
	display: flex;
        justify-content: space-between;	
}

.text_footer
{
	line-height: 20pt;
	color: #DDD9D1;
	margin-right: 10%;
	margin-bottom: 20px;
	text-align: center;
}

.text_footer a
{
	color: #DDD9D1;
	text-decoration: none;
}

.text_footer a:hover
{
	color: white;
}