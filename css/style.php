<?php
	header('content-type: text/css');
	header('Cache-Control: max-age=31536000, must-revalidate');
?>


html
{
	height: 100%;
	margin:0;
	padding:0;
	background-color: rgb(235, 235, 235);
	background-size: cover;
	font-family: 'Ubuntu';
}

a
{
	text-decoration: none;
}

body
{
	margin: 0;
	height: 100%;
}

.body
{
	flex: 1;
}

.conteneur
{
	display: flex;
	flex-direction: column;
	justify-content: space-between;
	min-height: 100%;
}

.full_page_img
{
	position: relative;
	width: 100%;
	background-image: url(../images/background/Vieux_papier.png);
	background-size: contain;
	flex: 1;
	margin-bottom: -100px;
}

.error
{
	width: 70%;
	margin-right: 15%;
	margin-left: 15%;
}

.error403401
{
	width: 85%;
	margin-right: 15%;
	flex: 1;
}

.title_classic
{
	position: relative;
	display: flex;
	justify-content: center;
	font-size: 38px;
	color: #434343;
	text-align: center;
	margin: 60px;
}

.emph_border
{
	height: 1px;
	width: 140px;
	margin-top: 25px;
	margin-left: 15px;
	margin-right: 15px;
	background-color: #BEBEBE;
}

.under_title
{
	width: 60%;
	margin-left: 20%;
	margin-bottom: 50px;
	text-align: center;
	font-size: large;
	color: #414141;
}

.hidden
{
	display: none;
}

.inline
{
	display: flex;
	justify-content: flex-start;
	margin-top: 5px;
}

.inline-between
{
	display: flex;
	justify-content: space-between;
}

.text_white
{
	color: #DDD9D1;
}

.text_green
{
   color: #009E00;
}

.text_red
{
   color: #9E0002;
}

.text_blue
{
	color: #085D9E;
}

.text_purple
{
	color: #69499C;
}

::-moz-selection
{
	color: white;
	background: #2E8C8C;
}

::selection
{
	color: white;
	background: #2E8C8C;
}

a:active
{
	text-shadow: 0px 1px 0px #000000;
	outline: none;
}

a:focus
{
	text-shadow: 0px 1px 0px #000000;
	outline: none;
}

@font-face 
{
font-family: 'Ubuntu';
font-style: normal;
font-weight: 400;
src: local('Ubuntu'), url(https://fonts.gstatic.com/s/ubuntu/v9/sDGTilo5QRsfWu6Yc11AXg.woff2) format('woff2');
unicode-range: U+0000-00FF, U+0131, U+0152-0153, U+02C6, U+02DA, U+02DC, U+2000-206F, U+2074, U+20AC, U+2212, U+2215, U+E0FF, U+EFFD, U+F000;
}

