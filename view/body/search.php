<div class="aside_searchbar" >

	<div class="aside_searchbar_title" >
		<p class="aside_searchbar_title_text" >Sort by :</p>
	</div>
	<div class="aside_searchbar_choix<?php if(htmlspecialchars($_GET['sort']) == "recentupdate" ){ echo "_active"; } ?>" >
                <a href="search.php?sort=recentupdate&in=<?php echo htmlspecialchars($_GET['in']); ?>" class="aside_searchbar_choix_text" >Recent update</a>
        </div>
	<div class="aside_searchbar_choix<?php if(htmlspecialchars($_GET['sort']) == "bestnoted" ){ echo "_active"; } ?>" >
                <a href="search.php?sort=bestnoted&in=<?php echo htmlspecialchars($_GET['in']); ?>" class="aside_searchbar_choix_text" >Best noted</a>
        </div>
	<div class="aside_searchbar_choix<?php if(htmlspecialchars($_GET['sort']) == "mostforked" ){ echo "_active"; } ?>" >
                <a href="search.php?sort=mostforked&in=<?php echo htmlspecialchars($_GET['in']); ?>" class="aside_searchbar_choix_text" >Most forked</a>
        </div>
	

	<div class="aside_searchbar_title" >
                <p class="aside_searchbar_title_text" >Search in :</p>
        </div>
	<div class="aside_searchbar_choix<?php if(htmlspecialchars($_GET['in']) == "project" ){ echo "_active"; } ?>" >
                <a href="search.php?sort=<?php echo htmlspecialchars($_GET['sort']); ?>&in=project"class="aside_searchbar_choix_text" >Project</a>
        </div>
        <div class="aside_searchbar_choix<?php if(htmlspecialchars($_GET['in']) == "user" ){ echo "_active"; } ?>" >
                <a href="search.php?sort=<?php echo htmlspecialchars($_GET['sort']); ?>&in=user" class="aside_searchbar_choix_text" >User</a>
        </div>
	<div class="aside_searchbar_choix<?php if(htmlspecialchars($_GET['in']) == "group" ){ echo "_active"; } ?>" >
                <a href="search.php?sort=<?php echo htmlspecialchars($_GET['sort']); ?>&in=group" class="aside_searchbar_choix_text" >Group</a>
        </div>
</div>
