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


.transition, .pricing_service_container,.details_box i:before, .details_box i:after 
{
	transition: all 0.25s ease-out;
}

.flip, .details_box 
{
	animation: flipdown 0.5s ease both;
}

.unselect, .h2 
{
	user-select: none;
}

.pricing
{
	padding-top: 30px;
	margin-right: 4%;
	margin-left: 4%;
	display: flex;
	flex-direction: column;
	justify-content: space-around;
}

.price_bulle_align
{
	display: flex;
	flex-direction: row;
	justify-content: space-around;
	flex-wrap: wrap;
	margin-bottom: 70px;
}

.price_bulle
{
	width: 270px;
	height: 300px;
	background: #E8E8E8;
	box-shadow: 1px 1px 3px rgba(0,0,0, 0.5);
	border-radius: 2px 2px 2px 2px;
	padding: 0; 
	list-style: none;
	border: 1px solid grey;
}

@media screen and (max-width: 1197px)
{
	.price_bulle_align > div
	{
		margin-right: 10%;
		margin-left: 10%;
	}
}														

.price_bulle_1 
{
	list-style: none;
	display: block;
	text-align: center;
	width: 270px;
	height: 115px;
	border-radius: 2px 2px 0px 0px;
	background: linear-gradient(#53C035, #46A22D);
	padding-top: 10px;
	margin-bottom: 115px;
	border-bottom: 1px solid grey;
}

.price_bulle_2
{
	list-style: none;
	display: block;
	text-align: center;
	width: 270px;
	height: 115px; 
	border-radius: 2px 2px 0px 0px;
	padding-top: 10px;
	margin-bottom: 115px;
	background: linear-gradient(#46B2C0, #3B96A2);
	border-bottom: 1px solid grey;
}

.price_bulle_3
{
	list-style: none;
	display: block;
	text-align: center;
	width: 270px;
	height: 115px; 
	border-radius: 2px 2px 0px 0px;
	padding-top: 10px;
	margin-bottom: 115px;
	background: linear-gradient(#488CD4, #3E78B6);
	border-bottom: 1px solid grey;
}

.price_bulle_4
{
	list-style: none;
	display: block;
	text-align: center;
	width: 270px;
	height: 115px; 
	border-radius: 2px 2px 0px 0px;
	padding-top: 10px;
	margin-bottom: 115px;
	background: linear-gradient(#6E3BB6, #562E8E);
	border-bottom: 1px solid grey;
}

.price_bulle_1:after,
.price_circle:before 
{
	content: '';
	display: table;
}

.price_bulle_1:after 
{
	clear: both;
}

.price_bulle_1 li 
{
	width: 220px;
	height: 220px;
	display: inline-block;
	margin: 0px;
}

.price_bulle_2:after
{
	content: '';
	display: table;
}

.price_bulle_2:after 
{
	clear: both;
}

.price_bulle_2 li 
{
	width: 220px;
	height: 220px;
	display: inline-block;
	margin: 0px;
	margin-top: 0px;
}

.price_bulle_3:after
{
	content: '';
	display: table;
}

.price_bulle_3:after 
{
	clear: both;
}

.price_bulle_3 li 
{
	width: 220px;
	height: 220px;
	display: inline-block;
	margin: 0px;
}


.price_bulle_4:after
{
	content: '';
	display: table;
}

.price_bulle_4:after 
{
	clear: both;
}

.price_bulle_4 li 
{
	width: 220px;
	height: 220px;
	display: inline-block;
	margin: 0px;
}


.price_circle 
{
	width: 100%;
	height: 100%;
	border-radius: 50%;
	position: relative;
	cursor: default;
	box-shadow: 
	inset 0 0 0 0 rgba(29,50,119, 0.4),
	inset 0 0 0 14px rgba(0,0,0,0.6),
	0 1px 2px rgba(0,0,0,0.1);
	transition: all 0.4s ease-in-out;
}

.price_img_1 
{ 
	background-image: url(../images/img_pack_1.png);
	background-size: contain;
	background-position: center;
	background-repeat: no-repeat;
}

.price_img_2
{
	background-image: url(../images/img_pack_2.png);
	background-size: contain;
	background-position: center;
	background-repeat: no-repeat;
}

.price_img_3
{
	background-image: url(../images/img_pack_3.png);
	background-size: contain;
	background-position: center;
	background-repeat: no-repeat;
}

.price_img_4
{
	background-image: url(../images/img_pack_4.png);
	background-size: contain;
	background-position: center;
	background-repeat: no-repeat;
}

.price_description 
{
	position: absolute;
	width: 100%;
	height: 100%;
	border-radius: 50%;
	opacity: 0;
	transition: all 0.4s ease-in-out;
	transform: scale(0);
}

.price_description h3 
{
	color: #fff;
	text-transform: uppercase;
	position: relative;
	letter-spacing: 2px;
	font-size: 38px;
	margin: 0 30px;
	margin-top: -10px;
	padding: 65px 0 0 0;
	height: 60px;
	text-shadow: 
	0 0 1px #fff, 
	0 1px 2px rgba(0,0,0,0.3);
}

.price_description p 
{
	color: #fff;
	padding: 10px 5px;
	font-style: italic;
	margin: 0 30px;
	font-size: 15px;
	border-top: 1px solid rgba(255,255,255,0.5);
}

.price_description p a 
{
	display: block;
	width: 70px;
	margin-top: 2px;
	margin-left: 40px;
	padding-bottom: 3px;
	color: white;
	font-style: normal;
	font-weight: 500;
	font-size: 15px;
	letter-spacing: 1px;
	border-radius: 2px;
	border: 1px solid #298A0D;
	background: linear-gradient(#3ED315, #2D990E);
}

.price_description p a:hover 
{
	background: linear-gradient(#2D990E, #3ED315);
}

.price_circle:hover 
{
	box-shadow: 
	inset 0 0 0 110px rgba(29,50,119, 0.65),
	inset 0 0 0 14px rgba(0,0,0,0.8),
	0 1px 2px rgba(0,0,0,0.1);
}

.price_circle:hover .price_description 
{
	opacity: 1;
	transform: scale(1);	
}

.h2 
{
	color: #646464;
	font-size: 26px;
	font-weight: 300;
	display: block;
	background-color: #E8E8E8;
	margin: 0;
	cursor: pointer;
	padding-left: 16px;
	border-radius: 2px;
	border-top: 1px solid grey;
	height: 35px;
	padding-top: 5px;
}

.pricing_service_container 
{
	position: relative;
	width: 270px;
	height: 250px;
	color: #646464;
	overflow: hidden;
	opacity: 1;
	transform: translate(0, 0);
	margin-top: 0px;
	z-index: 2;
	background-color: #E8E8E8;
	border-radius: 0px 0px 2px 2px;
	border: 1px solid grey;
	box-shadow: 1px 1px 3px rgba(0,0,0, 0.5);
	margin-left: -1px;
}

.details_box 
{
	width: 270px;
	position: relative;
	padding: 0;
	margin-left: 1px;
	margin-top: -76px;
	padding-bottom: 4px;
	padding-top: 18px;
}

.details_box:nth-of-type(1) 
{
	animation-delay: 0.5s;
}

.details_box:nth-of-type(2) 
{
	animation-delay: 0.75s;
}

.details_box:nth-of-type(3) 
{
	animation-delay: 1s;
}

.details_box:last-of-type 
{
	padding-bottom: 0;
}

.details_box i 
{
	position: absolute;
	transform: translate(-6px, 0);
	margin-top: 16px;
	right: 16px;
}

.details_box i:before, .details_box i:after 
{
	content: "";
	position: absolute;
	background-color: #646464;
	width: 3px;
	height: 9px;
}

.details_box i:before 
{
	transform: translate(-2px, 0) rotate(45deg);
}

.details_box i:after 
{
	transform: translate(2px, 0) rotate(-45deg);
}

.details_box input[type=checkbox] 
{
	position: absolute;
	cursor: pointer;
	width: 100%;
	height: 41px;
	z-index: 1;
	opacity: 0;
	margin: 0px;
}
.details_box input[type=checkbox]:checked ~ .pricing_service_container 
{
	margin-top: 0;
	max-height: 0;
	opacity: 0;
	transform: translate(0, -20%);
}

.details_box input[type=checkbox]:checked ~ i:before 
{
	transform: translate(2px, 0) rotate(45deg);
}

.details_box input[type=checkbox]:checked ~ i:after 
{
	transform: translate(-2px, 0) rotate(-45deg);
}

@keyframes flipdown {
	0% 
	{
		opacity: 0;
		transform-origin: top center;
		transform: rotateX(-90deg);
	}
	5%
	{
		opacity: 1;
	}
	80% 
	{
		transform: rotateX(8deg);
	}
	83% 
	{
		transform: rotateX(6deg);
	}
	92% 
	{
		transform: rotateX(-3deg);
	}
	100% 
	{
		transform-origin: top center;
		transform: rotateX(0deg);
	}
}

.pricing_service
{
	width: 90%;
	height: 15px;
	margin-top: 18px;
	margin-left: 5%;
	font-size: 15px;
	color: #646464;
	text-align: center;
	display: flex;
	justify-content: space-between;	
}

.pricing_service a
{
	display: block;
	margin-top: 20px;
	text-decoration: none;
	color: #3188CA;
}

.pricing_service a:hover
{
	color: #3EACFF;
}

.green_tick
{
	margin-top: 5px;
	color: green;
	font-size: 27px;
}

/* Tableau */

table 
{
	border-collapse: separate;
	border-spacing: 0;
	width: 80%;
	margin-left: 10%;
	margin-top: 30px;
	margin-bottom: 50px;
}

th,
td 
{
	padding: 3px 15px;
}

th 
{
	background: #4B124E;
	color: #fff;
	text-align: left;
	border-right: 1px solid #55145A ;
	border-left: 1px solid rgba(0,0,0,0);
}

tr:first-child th:first-child 
{
	height: 31px;
	border-radius: 2px 0px 0px 0px;
}

tr:first-child th:last-child 
{
	border-radius: 0px 2px 0px 0px;
}

td 
{
	height: 31px;
	border-right: 1px solid #c6c9cc;
	border-bottom: 1px solid #c6c9cc;
}

td:first-child 
{
	border-left: 1px solid #c6c9cc;
}

tr:nth-child(even) td 
{
	background: rgba(75,18,78, 0.05);
}

tr:last-child td:first-child 
{
	border-radius: 0px 0px 0px 2px;
}

tr:last-child td:last-child
{
	border-radius: 0px 0px 2px 0px;
}

.center
{
	text-align: center;
}

.pricing_tab_select
{
	position: relative;
	margin-left: 45%;
	background: #4B124E;
}

.princing_tab_buy
{
	display: block;
	width: 60px;
	margin-top: 2px;
	margin-left: calc(50% - 30px);
	padding-bottom: 3px;
	color: white;
	font-style: normal;
	font-weight: 500;
	font-size: 15px;
	letter-spacing: 1px;
	border-radius: 2px;
	border: 1px solid #298A0D;
	background: linear-gradient(#16CF22, #0F9218);
	cursor: pointer;
}

.buy_nb
{
	width: 40px;
	height: 25px;
	border-radius: 2px;
	border: 1px solid #D5CFDC;
}

.free
{
	color: #00BA00;
}

.pricing_download_all
{
	display: flex;
	justify-content: space-around;
	width: 40%;
	margin-left: 30%;
}

.pricing_download
{
	display: flex;
	justify-content: space-around;
	flex-direction: column;
}

.pricing_download_img
{
	position: relative;
	width: 90px;
}

.pricing_download_description
{
	margin-top: 35px;
	margin-bottom: 50px;
	font-size: large;
	font-weight: bold;
	text-align: center;
	color: #414141;
}

.pricing_download_logo
{
	position: relative;
	width: 40px;
	margin-top: -80px;
}

.pricing_links
{
	margin-top: 10px;
	margin-left: 60px;
	color: #414141;
	font-weight: bold;
}

<?php
	include_once('footer.php');
?>
