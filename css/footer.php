<?php
header('content-type: text/css');
header('Cache-Control: max-age=31536000, must-revalidate');
?>


footer
{
	position: relative;
	display: block;
	background-color: <?php echo $color['background_element']; ?>;
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
	color: <?php echo $color['text_color']; ?>;
	margin-left: 0px;
	margin-bottom: 10px;
	background-color: <?php echo $color['background_1']; ?>;
	border-radius: 0px 2px 2px 0px;
	box-shadow: 0px 1px 5px 1px rgba(0, 0, 0, 0.7);
}

.copyright_text a
{
	margin-left: 10px;
	color: <?php echo $color['text_color']; ?>;
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
	color: <?php echo $color['text_color']; ?>;
	margin-right: 10%;
	margin-bottom: 20px;
	text-align: center;
}

.text_footer a
{
	color: <?php echo $color['text_color']; ?>;
	text-decoration: none;
}

.text_footer a:hover
{	
	color: white;
}
