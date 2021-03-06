<?php
   header('content-type: text/css');
   ob_start('ob_gzhandler');
   header('Cache-Control: max-age=31536000, must-revalidate');
?>


/*Slideshow*/

.content h1 
{
	font-size:48px;
	color:#000;
	text-shadow:0px 1px 1px #f4f4f4;
	text-align:center;
	padding:60px 0 30px;	
}

.container 
{
	position: relative;
	margin-left: 0px;
	width: 100%;
}

#content-slider 
{
	width:100%;
}

#slider 
{
	width: 100%;
	overflow:visible;
	position:relative;
}

#mask 
{
	overflow: hidden;
	width: 100%;
}

#slider ul 
{
	margin:0;
	padding:0;
	position:relative;
}
#slider li 
{
	width:100%;
	position:absolute;
	top:-325px;
	list-style:none;
}

.img
{
	width: 100%;
}

.dim_mask
{
	width: 100%;
}

#slider li.firstanimation 
{
	-moz-animation:cycle 80s linear infinite;	
	-webkit-animation:cycle 80s linear infinite;		
}
#slider li.secondanimation 
{
	-moz-animation:cycletwo 80s linear infinite;
	-webkit-animation:cycletwo 80s linear infinite;		
}
#slider li.thirdanimation 
{
	-moz-animation:cyclethree 80s linear infinite;
	-webkit-animation:cyclethree 80s linear infinite;		
}
#slider li.fourthanimation 
{
	-moz-animation:cyclefour 80s linear infinite;
	-webkit-animation:cyclefour 80s linear infinite;		
}
#slider li.fifthanimation 
{
	-moz-animation:cyclefive 80s linear infinite;
	-webkit-animation:cyclefive 80s linear infinite;		
}

#slider .b_next 
{
	width: 60px;
	height: 60px;
	position: absolute;
	bottom: 50%;
	right: -50%;
	opacity: 0.7;
	-moz-transition:all 0.3s ease-in-out;
	-webkit-transition:all 0.3s ease-in-out;  
}

 .b_next :active
{
	opacity: 0.2;

}

#slider:hover .b_next, 
#slider:hover .b_next, 
#slider:hover .b_next, 
#slider:hover .b_next, 
#slider:hover .b_next 
{
	right: 50px;
}

#slider .b_prev 
{
	width: 60px;
	height: 60px;
	position: absolute;
	bottom: 50%;
	left: -50%;
	opacity: 0.7;
	-moz-transition:all 0.3s ease-in-out;
	-webkit-transition:all 0.3s ease-in-out;  
}

#slider:hover .b_prev, 
#slider:hover .b_prev, 
#slider:hover .b_prev, 
#slider:hover .b_prev, 
#slider:hover .b_prev 
{
	left: 50px;
}

#slider .tooltip 
{
	background:rgba(0,0,0,0.5);
	width:150px;
	height:60px;
	position:relative;
	bottom:100px;
	left:-320px;
	-moz-transition:all 0.3s ease-in-out;
	-webkit-transition:all 0.3s ease-in-out;  
}

#slider .tooltip h1 
{
	color:#fff;
	font-size:24px;
	font-weight:300;
	line-height:60px;
	padding:0 0 0 20px;
}

#slider:hover .tooltip, 
#slider:hover .tooltip, 
#slider:hover .tooltip, 
#slider:hover .tooltip, 
#slider:hover .tooltip 
{
	left:0px;
}

#slider:hover li, 
#slider:hover .progress-bar 
{
	-moz-animation-play-state:paused;
	-webkit-animation-play-state:paused;
}

.progress-bar
{ 
	position:relative;
	top:-9px;
	width: 100%;
	height:5px;
	background:#000;
	-moz-animation:fullexpand 80s ease-out infinite;
	-webkit-animation:fullexpand 80s ease-out infinite;
}

.article
{
	position: relative;
	width: 100%;
}

/* RESET */
html, body, div, span, applet, object, iframe,
h1, h2, h3, h4, h5, h6, blockquote, pre,
 abbr, acronym, address, big, cite, code,
del, dfn, em, img, ins, kbd, q, s, samp,
small, strike, strong, sub, sup, tt, var,
b, u, i, center,
dl, dt, dd, ol, ul, li,
fieldset, form, label, legend,
table, caption, tbody, tfoot, thead, tr, th, td,
article, aside, canvas, details, embed, 
figure, figcaption, footer, header, hgroup, 
menu, nav, output, ruby, section, summary,
time, mark, audio, video {
	margin: 0;
	padding: 0;
	border: 0;
	font-size: 100%;
}

@-moz-keyframes cycle
{
	0%  { top:0px; }
	4%  { top:0px; } 
	16% { top:0px; opacity:1; z-index:0; } 
	20% { top:325px; opacity:0; z-index:0; } 
	21% { top:-325px; opacity:0; z-index:-1; }
	92% { top:-325px; opacity:0; z-index:0; }
	96% { top:-325px; opacity:0; }
	100%{ top:0px; opacity:1; }
	
}

@-moz-keyframes cycletwo 
{
	0%  { top:-325px; opacity:0; }
	16% { top:-325px; opacity:0; }
	20% { top:0px; opacity:1; }
	24% { top:0px; opacity:1; } 
	36% { top:0px; opacity:1; z-index:0; } 
	40% { top:325px; opacity:0; z-index:0; }
	41% { top:-325px; opacity:0; z-index:-1; } 
	100%{ top:-325px; opacity:0; z-index:-1; }
}

@-moz-keyframes cyclethree 
{
	0%  { top:-325px; opacity:0; }
	36% { top:-325px; opacity:0; }
	40% { top:0px; opacity:1; }
	44% { top:0px; opacity:1; } 
	56% { top:0px; opacity:1; } 
	60% { top:325px; opacity:0; z-index:0; }
	61% { top:-325px; opacity:0; z-index:-1; } 
	100%{ top:-325px; opacity:0; z-index:-1; }
}

@-moz-keyframes cyclefour 
{
	0%  { top:-325px; opacity:0; }
	56% { top:-325px; opacity:0; }
	60% { top:0px; opacity:1; }
	64% { top:0px; opacity:1; }
	76% { top:0px; opacity:1; z-index:0; }
	80% { top:325px; opacity:0; z-index:0; }
	81% { top:-325px; opacity:0; z-index:-1; }
	100%{ top:-325px; opacity:0; z-index:-1; }
}

@-moz-keyframes cyclefive 
{
	0%  { top:-325px; opacity:0; }
	76% { top:-325px; opacity:0; }
	80% { top:0px; opacity:1; }
	84% { top:0px; opacity:1; }
	96% { top:0px; opacity:1; z-index:0; }
	100%{ top:325px; opacity:0; z-index:0; }
}

@-webkit-keyframes cycle 
{
	0%  { top:0px; }
	4%  { top:0px; }
	16% { top:0px; opacity:1; z-index:0; } 
	20% { top:325px; opacity:0; z-index:0; }
	21% { top:-325px; opacity:0; z-index:-1; }
	50% { top:-325px; opacity:0; z-index:-1; }
	92% { top:-325px; opacity:0; z-index:0; }
	96% { top:-325px; opacity:0; }
	100%{ top:0px; opacity:1; }
	
}

@-webkit-keyframes cycletwo 
{
	0%  { top:-325px; opacity:0; }
	16% { top:-325px; opacity:0; }
	20% { top:0px; opacity:1; }
	24% { top:0px; opacity:1; } 
	36% { top:0px; opacity:1; z-index:0; } 
	40% { top:325px; opacity:0; z-index:0; }
	41% { top:-325px; opacity:0; z-index:-1; }  
	100%{ top:-325px; opacity:0; z-index:-1; }
}

@-webkit-keyframes cyclethree 
{
	0%  { top:-325px; opacity:0; }
	36% { top:-325px; opacity:0; }
	40% { top:0px; opacity:1; }
	44% { top:0px; opacity:1; } 
	56% { top:0px; opacity:1; z-index:0; } 
	60% { top:325px; opacity:0; z-index:0; } 
	61% { top:-325px; opacity:0; z-index:-1; }
	100%{ top:-325px; opacity:0; z-index:-1; }
}

@-webkit-keyframes cyclefour 
{
	0%  { top:-325px; opacity:0; }
	56% { top:-325px; opacity:0; }
	60% { top:0px; opacity:1; }
	64% { top:0px; opacity:1; }
	76% { top:0px; opacity:1; z-index:0; }
	80% { top:325px; opacity:0; z-index:0; }
	81% { top:-325px; opacity:0; z-index:-1; }
	100%{ top:-325px; opacity:0; z-index:-1; }
}

@-webkit-keyframes cyclefive 
{
	0%  { top:-325px; opacity:0; }
	76% { top:-325px; opacity:0; }
	80% { top:0px; opacity:1; }
	84% { top:0px; opacity:1; }
	96% { top:0px; opacity:1; z-index:0; }
	100%{ top:325px; opacity:0; z-index:0; }
}

@-moz-keyframes fullexpand 
{
    0%, 20%, 40%, 60%, 80%, 100% { width:0%; opacity:0; }
    4%, 24%, 44%, 64%, 84% { width:0%; opacity:0.3; }
   16%, 36%, 56%, 76%, 96% { width:100%; opacity:0.7; }
   17%, 37%, 57%, 77%, 97% { width:100%; opacity:0.3; }
   18%, 38%, 58%, 78%, 98% { width:100%; opacity:0; }	
}

@-webkit-keyframes fullexpand 
{
    0%, 20%, 40%, 60%, 80%, 100% { width:0%; opacity:0; }
    4%, 24%, 44%, 64%, 84% { width:0%; opacity:0.3; }
   16%, 36%, 56%, 76%, 96% { width:100%; opacity:0.7; }
   17%, 37%, 57%, 77%, 97% { width:100%; opacity:0.3; }
   18%, 38%, 58%, 78%, 98% { width:100%; opacity:0; }	
}
