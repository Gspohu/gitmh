<div class="repoperso_body">

<div id="reduce" >
	<div class="aside_repoperso" >

		<div class="aside_repoperso_title" >
                	<p class="aside_repoperso_title_text" >Search in :</p>
        	</div>

	        <div class="aside_repoperso_choix" >
                	<a href="" class="aside_repoperso_choix_text" >Recent update</a>
       		</div>
	
		<div class="aside_repoperso_choix" >
	                <a href="" class="aside_repoperso_choix_text" >Public</a>
	        </div>
        
		<div class="aside_repoperso_choix" >
	                <a href="" class="aside_repoperso_choix_text" >Private</a>
	        </div>
	
		<div class="aside_repoperso_choix" >
	                <a href="" class="aside_repoperso_choix_text" >Fork</a>
	        </div>

	        <div class="aside_repoperso_title" >
	                <p class="aside_repoperso_title_text" >Group :</p>
	        </div>
        
		<div class="aside_repoperso_choix" >
	                <a href="" class="aside_repoperso_choix_text" >Me</a>
	        </div>

	        <div class="aside_repoperso_title" >
	                <p class="aside_repoperso_title_text" >Type :</p>
	        </div>
        
		<div class="aside_repoperso_choix" >
	                <a href="" class="aside_repoperso_choix_text" >All</a>
	        </div>

       		<div class="aside_repoperso_space" data-color="<?php echo $weight_color; ?>"></div> 
		<style>
			.aside_repoperso_space:before {width: <?php echo $weight_percent; ?>%;}
			.aside_repoperso_space:after {width: <?php echo $weight_percent; ?>%;}
		</style>
		<div class="aside_repoperso_work_track"></div>

	</div>
</div>


<div class="repo_list">
        <div class="repo_list_title">
                Project
        </div>

	<?php
		if(isset($_SESSION['pseudo']))
		{
			if($owner == $_SESSION['pseudo'])
			{
			echo '
	<a class="repo_list_add_repo" href="add-repo">
        	        New project
	</a>';
			}
		}
	?>	

        <?php
                while($data = $data_sql->fetch())
                {
	                echo '
	<div class="repo_list_result">
		<img class="project_logo" src="repository/'.$owner.'_repo/'.$data['Name'].'/.cairn/repo_logo'.$data['logo'].'"/>
		<div class="project_name_description">
	        	<a href="'.$owner.'🜉/'.$data['Name'].'📂/">'.$data['Name'].'</a>
			<p class="description">'.$data['Description'].'</p>
		</div>
        </div>';
                }
		$data_sql->closeCursor();
        ?>
</div>

</div>
