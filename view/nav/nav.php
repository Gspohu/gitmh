<header>
<div class="nav">
	<a href="index.php"><img class="nav_logo" src="images/logo_alpha.png" alt="Logo" /></a>

	<div class="nav_link_div">
		<a class="nav_link" href="open-hardware.php">Open-Hardware</a> 
		<a class="nav_link" href="tools.php">Tools</a> 
		<a class="nav_link" href="pricing.php">Pricing</a>
	</div>

	 <div class="div_searchbar">
	<form method="post" action="search.php<?php if(isset($_GET['sort']) || isset($_GET['in']) ){ echo "?sort=".$_GET['sort']."&in=".$_GET['in']; }else{ echo "?sort=recentupdate&in=project"; } ?>">
        	<label for="Search"></label><input class="searchbar" type="text" name="searchbar" id="searchbar" placeholder=" Search" />
        </form>
	 </div>

	<div class="div_button">
		<a class="bouton_connexion" href="connexion.php">Sign up</a>
		<a class="bouton_inscription" href="inscription.php">Sign in</a>
	</div>

</div>
</header>
