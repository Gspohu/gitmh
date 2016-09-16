<?php
   header('content-type: text/css');
   ob_start('ob_gzhandler');
   header('Cache-Control: max-age=31536000, must-revalidate');
?>


.open-hardware
{
	position: relative;
	display: flex;
	flex-direction: column;
	justify-content: space-around;
	width: 80%;
	margin-left: 10%;
	margin-top: 10px;
}

.open-hardware_part
{
	position: relative;
	display: flex;
	justify-content: space-between;
	border-bottom: 1px solid #BEBEBE;	
	margin-top: 15px;
}

.open-hardware_image_1
{
	position: relative;
	background-image: url(../images/OH_img_1.png);
	background-size: contain;
   background-repeat: no-repeat;
	width: 65%;
	height: auto;
	margin-right: 10px;
	z-index: 1;
}

.open-hardware_image_1:hover
{
	background: grey;
}

.open-hardware_image_2
{
        position: relative;
        background-image: url(../images/OH_img_2.svg);
        background-size: contain;
	background-repeat: no-repeat;
        width: 65%;
        height: auto;
        z-index: 1;
	margin-left: 10px;
}

.open-hardware_image_2:hover
{
        background: grey;
}

.open-hardware_image_3
{
        position: relative;
	background-image: url(../images/OH_img_3.svg);
        background-size: contain;
	background-repeat: no-repeat;
        margin-bottom: 15px;
        width: 65%;
        height: auto;
        z-index: 1;
	margin-right: 10px;
}

.open-hardware_image_3:hover
{
        background: grey;
}

.open-hardware_image_4
{
        position: relative;
	background-image: url(../images/OH_img_4.svg);
        background-size: contain;
	background-repeat: no-repeat;
        width: 65%;
        height: auto;
        z-index: 1;
	margin-left: 10px;
}

.open-hardware_image_4:hover
{
        background: grey;
}

.open-hardware_image_5
{
        position: relative;
        /*background-image: url(../images/pictogrammes/3.png);*/
	background-color: grey;
        background-size: contain;
        width: 65%;
        height: auto;
        z-index: 1;
	margin-right: 10px;
}

.open-hardware_image_5:hover
{
        background: grey;
}


.open-hardware_text
{
	position: relative;
	color: black;	
}