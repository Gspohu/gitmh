<div id="reduce" >
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

        <div class="reduire" >
		<a href="#reduce" ><label for="reducebutton"></label><input type="radio" name="reducebutton" id="reducebutton" value="reduce" onclick="document.location.href='#reduce'"></a>
		<a href="#reduce" class="hide_checkbox">&#8249;</a>
        </div>

</div>

<div class="aside_searchbar_lit" >

        <div class="aside_searchbar_title" >
                <p class="aside_searchbar_title_text" ><img class="picto_title" src="images/pictogrammes/trier.png" alt="Sort" title="Sort" /></p>
        </div>
        <div class="aside_searchbar_choix<?php if(htmlspecialchars($_GET['sort']) == "recentupdate" ){ echo "_active"; } ?>" >
                <a href="search.php?sort=recentupdate&in=<?php echo htmlspecialchars($_GET['in']); ?>#reduce" class="aside_searchbar_choix_text" ><img class="picto" src="images/pictogrammes/rcupdate.png" alt="Recently update" title="Recently update"/></a>
        </div>
        <div class="aside_searchbar_choix<?php if(htmlspecialchars($_GET['sort']) == "bestnoted" ){ echo "_active"; } ?>" >
                <a href="search.php?sort=bestnoted&in=<?php echo htmlspecialchars($_GET['in']); ?>#reduce" class="aside_searchbar_choix_text" ><img class="picto" src="images/pictogrammes/bestnoted.png" alt="Best noted" title="Best noted"/></a>
        </div>
        <div class="aside_searchbar_choix<?php if(htmlspecialchars($_GET['sort']) == "mostforked" ){ echo "_active"; } ?>" >
                <a href="search.php?sort=mostforked&in=<?php echo htmlspecialchars($_GET['in']); ?>#reduce" class="aside_searchbar_choix_text" ><img class="picto" src="images/pictogrammes/mostforked.png" alt="Most forked" title="Most forked"/></a>
        </div>
        

        <div class="aside_searchbar_title" >
                <p class="aside_searchbar_title_text" ><img class="picto_title" src="images/pictogrammes/where.png" alt="Search in" title="Search in"/></p>
        </div>
        <div class="aside_searchbar_choix<?php if(htmlspecialchars($_GET['in']) == "project" ){ echo "_active"; } ?>" >
                <a href="search.php?sort=<?php echo htmlspecialchars($_GET['sort']); ?>&in=project#reduce"class="aside_searchbar_choix_text" ><img class="picto" src="images/pictogrammes/project.png" alt="Project" title="Project"/></a>
        </div>
        <div class="aside_searchbar_choix<?php if(htmlspecialchars($_GET['in']) == "user" ){ echo "_active"; } ?>" >
                <a href="search.php?sort=<?php echo htmlspecialchars($_GET['sort']); ?>&in=user#reduce" class="aside_searchbar_choix_text" ><img class="picto" src="images/pictogrammes/user.png" alt="User" title="User"/></a>
        </div>
        <div class="aside_searchbar_choix<?php if(htmlspecialchars($_GET['in']) == "group" ){ echo "_active"; } ?>" >
                <a href="search.php?sort=<?php echo htmlspecialchars($_GET['sort']); ?>&in=group#reduce" class="aside_searchbar_choix_text" ><img class="picto" src="images/pictogrammes/group.png" alt="Group" title="Group"/></a>
        </div>

        <div class="agrandir" >
                <a href="#" ><label for="reducebutton"></label><input type="radio" name="reducebutton" id="reducebutton" value="noreduce" onclick="document.location.href='#'"></a>
                <a href="#" class="hide_checkbox_agrandir" >&#8250;</a>
        </div>

</div>
</div>
</form>
