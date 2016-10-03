<?php
	header('content-type: text/css');
	ob_start('ob_gzhandler');
	header('Cache-Control: max-age=31536000, must-revalidate');

	include_once('../model/connexion_sql.php');

	include_once('../model/design.php');

	include_once('style.php');

	include_once('modification.php');

	include_once('nav_bar_no_log.php');
?>


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
}

.price_bulle
{
	width: 270px;
	height: 520px;
	background: #E8E8E8;
	box-shadow: 1px 1px 3px #000000;
	border-radius: 2px 2px 2px 2px;
	padding: 0; 
	list-style: none;
	margin-bottom: 50px;
	border: 1px solid grey;
}

@media screen and (max-width: 1024px)
{
	.price_bulle
	{
	margin-right: 7%;
	margin-left: 7%;
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
	margin-bottom: 130px;
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
	margin-bottom: 130px;
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
	margin-bottom: 130px;
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
	margin-bottom: 130px;
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
	margin-top: 15px;
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

.pricing_service
{
	width: 90%;
	height: 15px;
	margin-top: 20px;
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
