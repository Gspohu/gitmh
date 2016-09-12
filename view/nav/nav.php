<header>
<div class="nav">
	<a href="index"><img class="nav_logo" src="images/logo_alpha.png" alt="Logo" /></a>

	<div class="nav_link_div">
		<a class="nav_link" href="open-hardware" <?php modif_text('Nav_menu_1'); ?>><?php echo $get_text['Nav_menu_1']."</a>\n"; ?></a>
		<a class="nav_link" href="explore" <?php modif_text('Nav_menu_2');  ?>><?php echo $get_text['Nav_menu_2']."</a>\n"; ?></a> 
		<a class="nav_link" href="pricing" <?php modif_text('Nav_menu_3');?>><?php echo $get_text['Nav_menu_3']."</a>\n"; ?></a>
	</div>

	 <div class="div_searchbar">
	<form method="get" action="search<?php if(isset($_GET['sort']) || isset($_GET['in']) ){ echo "?sort=".$_GET['sort']."&in=".$_GET['in']; }else{ echo "?sort=recentupdate&in=project"; } ?>">
        	<input class="searchbar" type="text" name="searchbar" id="searchbar" placeholder="<?php if(isset($_POST['searchbar']) && htmlspecialchars($_POST['searchbar'] != '')) { echo '" value="'.$_POST['searchbar']; }else{ echo $get_text['Nav_placeholder_search']; } ?>" <?php modif_text('Nav_placeholder_search');?>/>

		<?php if( ! preg_match( "#.*search.*#", $_SERVER['REQUEST_URI'])) {echo '</form>';}?>
         </div>
	<?php 
		if(strlen($_SESSION['pseudo']) > 6)
		{
			$profil_nav_name = 'Profil';
		}
		else
		{
			$profil_nav_name = $_SESSION['pseudo'];
		}	
		
		if(isset($_SESSION['pseudo']))
		{
                	if(strlen($_SESSION['pseudo']) > 6)
                	{
                		$profil_nav_name = 'Profil';
                	}
                	else
        	        {
       	        	        $profil_nav_name = $_SESSION['pseudo'];
	                }


			echo '
				<ul class="nav_profil">
					<li>
						<div class="nav_profil_Wcircle nav_profil_avatar">
							<div class="nav_profil_link">
								<h3><a href="'.$_SESSION['pseudo'].'🜉">'.$profil_nav_name.'</a></h3>
								<a class="nav_profil_linka" href="deconnexion">Sign out</a>
							</div>
						</div>
					</li>							
				</ul>
				<style>.nav_profil_avatar{ background-image: url(repository/'.$_SESSION['pseudo'].'_repo/.profil/avatar.png); background-size: contain; background-position: center; background-repeat: no-repeat; }</style>';
		}
		else
		{
			echo '
	<div class="div_button">
		<a class="bouton_connexion" href="connexion">'.$get_text['Nav_button_connexion'].'</a>
		<a class="bouton_inscription" href="inscription">'.$get_text['Nav_button_inscription'].'</a>
	</div>';
		}
	?>	

</div>
</header>
