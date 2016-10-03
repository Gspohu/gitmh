<?php
	header('content-type: text/css');
	ob_start('ob_gzhandler');
	header('Cache-Control: max-age=31536000, must-revalidate');
?>


/*Barre de navigation hors connexion */

.nav
{
	position: relative;
	display: flex;
	justify-content: space-around;
	align-items: center;
	background-color: <?php echo $color['background_element']; ?>;
	height: 65px;
	width: 100%;
	box-shadow: 0px 1px 5px 1px rgba(0, 0, 0, 0.7); 
	z-index: 2000;
}

.nav_link_div
{
	width: 25%;
	max-width: 380px;
	min-width: 240px;
	display: flex;
	justify-content: space-around;
}

.nav_link
{
	color: <?php echo $color['text_color']; ?>;
}

.nav_link:hover
{
	color: white;
}

.nav_logo
{
	height: 60px;
}

.div_button
{
	width: 20%;
	max-width: 270px;
	min-width: 190px;
	display: flex;
	justify-content: space-around;
}

.bouton_connexion
{
	min-width: 75px;
	height: 28px;
	color: #171B1D;
	background-color: #8748E6;
	border-radius: 2px;
	padding-top: 7px;
	border: solid #8748E6 1px;
	text-decoration: none;
	text-align: center
}

.bouton_connexion:hover
{
	background-color: <?php echo $color['background_element']; ?>;
	color: #8748E6;
}

.bouton_inscription
{
	min-width: 75px;
	height: 28px;
	color: #171B1D;
	background-color: #4BBC3A;
	border-radius: 2px;
	padding-top: 7px;
	border: solid #4BBC3A 1px;
	text-decoration: none;
	text-align: center
}

.bouton_inscription:hover
{
	background-color: <?php echo $color['background_element']; ?>;
	color: #4BBC3A;
}

.div_searchbar
{
	width: 30%;
	margin-left: 10%;
	margin-right: 5%;
}

.searchbar
{
	width: 100%;
	min-width: 100px;
	height: 25px;
	border: solid 2px white;
	border-radius: 2px;
}

/* Barre nav en mode connecté */

.nav_profil_Wcircle
{
	width: 100%;
	height: 100%;
	border-radius: 50%;
	position: relative;
	cursor: default;
	box-shadow: 
					inset 0 0 0 8px rgba(255,255,255,0.25),
					0 1px 2px rgba(0,0,0,0.1);
	transition: all 0.4s ease-in-out;
}

.nav_profil_link 
{
	position: absolute;
	background: rgba(33,100,40, 0.8);
	width: inherit;
	height: inherit;
	border-radius: 50%;
	opacity: 0;
	transition: all 0.4s ease-in-out;
	transform: scale(0);
}

.nav_profil_link h3
{
	margin-top: 5px;
	margin-bottom: 3px;
}

.nav_profil_link h3 a 
{
	color: #fff;
	text-transform: uppercase;
	letter-spacing: 2px;
	font-size: 10px;
	height: 0px;
	text-shadow: 
					0 0 1px #fff, 
					0 1px 2px rgba(0,0,0,0.3);
	text-decoration: none;
}

.nav_profil_linka 
{
	display: block;
	color: #fff;
	color: rgba(255,255,255,1);
	text-transform: uppercase;
	font-size: 8px;
	letter-spacing: 1px;
}

.nav_profil_link a:hover 
{
	color: rgba(255,255,255, 0.8);
}

.nav_profil_Wcircle:hover 
{
	box-shadow: 
					inset 0 0 0 1px rgba(255,255,255,0.1),
					0 1px 2px rgba(0,0,0,0.1);
}
.nav_profil_Wcircle:hover .nav_profil_link 
{
	transform: scale(1);
	opacity: 1;
}

.nav_profil_Wcircle:hover .nav_profil_link p 
{
	opacity: 1;
}

.nav_profil 
{
	padding: 0;
	list-style: none;
	display: block;
	text-align: center;
}

.nav_profil:after,
.nav_profil_Wcircle:before 
{
	content: '';
	display: table;
}

.nav_profil:after 
{
	clear: both;
}

.nav_profil li 
{
	width: 55px;
	height: 55px;
}

.mobile_button
{
	display: none;
}

.nav_link_mobile
{
	display: none;
}

.nav_mobile_extend
{
	display: none;
}

/*Media_Queries*/

@media screen and (max-device-width: 480px)
{
	.nav_link_div
	{
		display: none;
	}

	.nav_link_mobile
	{
		width: 80%;
		margin-left: 10%;
		flex-direction: column;
	}
		
	.mobile_button a
	{
		display: initial;
		width: 30px;
		height: 55px;
		margin-top: 5px;
		font-weight: bold;
		font-size: 15px;
		border-radius: 2px;
		border: solid 1px grey;
		background-color: <?php echo $color['text_color']; ?>;
		text-decoration: none;
	}
	
	.div_button
	{
		display: none;
	}
	
	.div_button_mobile
	{
		display: initial;
	}
	
	.nav_mobile_extend:visited
	{
		background-color: <?php echo $color['background_element']; ?>;
		height: 150px;
		width: 100%;
	}
}
