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


.open-hardware
{
	position: relative;
	display: flex;
	flex-direction: column;
	justify-content: space-around;
	width: 80%;
	margin-left: 10%;
	margin-top: 10px;
	margin-bottom: 150px;
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

.tools_container
{
	width: 80%;
	margin: 10px auto 30px auto;
	text-align: left;
	border-radius: 2px;
	background-color: #2B2422;
}

.tools_container label
{
	padding: 5px 20px;
	position: relative;
	z-index: 20;
	display: flex;
	justify-content: flex-start;
	height: 30px;
	cursor: pointer;
	color: #A0A0A0;
	line-height: 33px;
	font-size: 19px;
	background: #ffffff;
	background-image: url(../images/texture_nav.png); 
	border: 1px solid #45403F;
   border-radius: 2px;
}

.tools_container label:hover
{
	background-image: url(../images/texture_inscription.png);
	color: #DAD7D0;
	border: 1px solid #277676;
}

.tools_container input:checked + label,
.tools_container input:checked + label:hover
{
	background-image: url(../images/texture_inscription.png);
	color: #DAD7D0;
}

.tools_container label:hover:after,
.tools_container input:checked + label:hover:after
{
	content: '';
	position: absolute;
	width: 24px;
	height: 24px;
	right: 13px;
	top: 7px;
	background: transparent url(../images/down.png) no-repeat center center;	
}

.tools_container input:checked + label:hover:after
{
	background-image: url(../images/up.png);
}

.tools_container input
{
	display: none;
}

.tools_container article
{
	background: #F5F5F5;
	margin-top: -1px;
	overflow: hidden;
	height: 0px;
	position: relative;
	z-index: 10;
	transition: height 0.3s ease-in-out, box-shadow 0.6s linear;
}

.tools_container article p
{
	color: #777;
	line-height: 23px;
	font-size: 14px;
	padding: 20px;
}

.tools_container input:checked ~ article{
	transition: height 0.5s ease-in-out, box-shadow 0.1s linear;
	border: 1px solid #45403F;
}

.tools_container input:checked ~ article.volet_small
{
	height: 140px;
}

.tools_container input:checked ~ article.volet_medium
{
	height: 180px;
}

.tools_container input:checked ~ article.volet_large
{
	height: 230px;
}

.tools_picto_1
{
	background-image: url(../images/pictogrammes/Picto_Git.png);
	background-size: contain;
	width: 33px;
	height: 33px;
	margin-right: 10px;
	margin-top: -2px;
}

.tools_picto_2
{
        background-image: url(../images/pictogrammes/Picto_OH.png);
        background-size: contain;
	background-position: center;
	background-repeat: no-repeat;
        width: 33px;
        height: 33px;
        margin-right: 10px;
        margin-top: -2px;
}

.tools_picto_3
{
        background-image: url(../images/pictogrammes/Picto_tip.png);
        background-size: contain; 
        background-position: center; 
        background-repeat: no-repeat;
        width: 33px;
        height: 33px;
        margin-right: 10px;
        margin-top: -2px;
}

.tools_picto_4
{
        background-image: url(../images/pictogrammes/Picto_cloud.png);
        background-size: contain;
        background-position: center;
        background-repeat: no-repeat;
        width: 33px;
        height: 33px;
        margin-right: 10px;
        margin-top: -2px;
}

.tools_picto_5
{
        background-image: url(../images/pictogrammes/Picto_collab.png);
        background-size: contain;
        background-position: center;
        background-repeat: no-repeat;
        width: 33px;
        height: 33px;
        margin-right: 10px;
        margin-top: -2px;
}

.tools_picto_6
{
        background-image: url(../images/pictogrammes/Picto_lidproj.png);
        background-size: contain;
        background-position: center;
        background-repeat: no-repeat;
        width: 33px;
        height: 33px;
        margin-right: 10px;
        margin-top: -2px;
}

.tools_picto_7
{
        background-image: url(../images/pictogrammes/Picto_bug.png);
        background-size: contain;
        background-position: center;
        background-repeat: no-repeat;
        width: 33px;
        height: 33px;
        margin-right: 10px;
        margin-top: -2px;
}

.tools_picto_8
{
        background-image: url(../images/pictogrammes/Picto_intell.png);
        background-size: contain;
        background-position: center;
        background-repeat: no-repeat;
        width: 33px;
        height: 33px;
        margin-right: 10px;
        margin-top: -2px;
}

.tools_picto_9
{
        background-image: url(../images/pictogrammes/Picto_privproj.png);
        background-size: contain;
        background-position: center;
        background-repeat: no-repeat;
        width: 33px;
        height: 33px;
        margin-right: 10px;
        margin-top: -2px;
}

.tools_picto_10
{
        background-image: url(../images/pictogrammes/Picto_toolsedu.png);
        background-size: contain;
        background-position: center;
        background-repeat: no-repeat;
        width: 33px;
        height: 33px;
        margin-right: 10px;
        margin-top: -2px;
}

.tools_picto_11
{
        background-image: url(../images/pictogrammes/Picto_viewW.png);
        background-size: contain;
        background-position: center;
        background-repeat: no-repeat;
        width: 33px;
        height: 33px;
        margin-right: 10px;
        margin-top: -2px;
}

.tools_picto_12
{
        background-image: url(../images/pictogrammes/Picto_contrib.png);
        background-size: contain;
        background-position: center;
        background-repeat: no-repeat;
        width: 33px;
        height: 33px;
        margin-right: 10px;
        margin-top: -2px;
}


.tools_picto_13
{
        background-image: url(../images/pictogrammes/Picto_vps.png);
        background-size: contain;
        background-position: center;
        background-repeat: no-repeat;
        width: 33px;
        height: 33px;
        margin-right: 10px;
        margin-top: -2px;
}

<?php
	include_once('footer.php');
?>
