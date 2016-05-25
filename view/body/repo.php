<div class="body">
	<div id="reduce" >
        	<div class="aside_repoperso" >
        	        <div class="aside_repoperso_choix<?php if(htmlspecialchars($_GET['in']) == "project" ){ echo "_active"; } ?>" >
        	                <a href="<?php echo $_SERVER['REQUEST_URI']; ?>?sort=<?php echo htmlspecialchars($_GET['sort']); ?>&in=project" class="aside_repoperso_choix_text" >Source</a>
        	        </div>
		
        	        <div class="aside_repoperso_choix<?php if(htmlspecialchars($_GET['in']) == "project" ){ echo "_active"; } ?>" >
        	                <a href="<?php echo $_SERVER['REQUEST_URI']; ?>?sort=<?php echo htmlspecialchars($_GET['sort']); ?>&in=project" class="aside_repoperso_choix_text" >Public</a>
       	         	</div>
		
        	        <div class="aside_repoperso_choix<?php if(htmlspecialchars($_GET['in']) == "user" ){ echo "_active"; } ?>" >
        	                <a href="<?php echo $_SERVER['REQUEST_URI']; ?>?sort=<?php echo htmlspecialchars($_GET['sort']); ?>&in=user" class="aside_repoperso_choix_text" >Private</a>
       	         	</div>
		
        	        <div class="aside_repoperso_choix<?php if(htmlspecialchars($_GET['in']) == "group" ){ echo "_active"; } ?>" >
        	                <a href="<?php echo $_SERVER['REQUEST_URI']; ?>?sort=<?php echo htmlspecialchars($_GET['sort']); ?>&in=group" class="aside_repoperso_choix_text" >Fork</a>
        	        </div>
	
		                <div class="aside_repoperso_title" >
	                        <p class="aside_repoperso_title_text" >Group :</p>
	                </div>
	
       	         	<div class="aside_repoperso_choix<?php if(htmlspecialchars($_GET['in']) == "project" ){ echo "_active"; } ?>" >
       	                	 <a href="<?php echo $_SERVER['REQUEST_URI']; ?>?sort=<?php echo htmlspecialchars($_GET['sort']); ?>&in=project" class="aside_repoperso_choix_text" >Me</a>
		        </div>
	
       	         	<div class="aside_repoperso_title" >
		                 <p class="aside_repoperso_title_text" >Type :</p>
	                </div>
	
       	         	<div class="aside_repoperso_choix<?php if(htmlspecialchars($_GET['in']) == "project" ){ echo "_active"; } ?>" >
		                 <a href="<?php echo $_SERVER['REQUEST_URI']; ?>?sort=<?php echo htmlspecialchars($_GET['sort']); ?>&in=project" class="aside_repoperso_choix_text" >All</a>
	                </div>
	
       	         	<div class="aside_repoperso_space" data-color="<?php echo $weight_color; ?>"></div>
       	         	<style>
		                .aside_repoperso_space:before {width: <?php echo $weight_percent; ?>%;}
	                        .aside_repoperso_space:after {width: <?php echo $weight_percent; ?>%;}
	                </style>
	                
			<div class="aside_repoperso_work_track"></div>
	
	        </div>
	</div>
	
</div>
