<div class="repoperso_body">
	<div class="aside_repoperso" >
		<div class="aside_repoperso_profil" >
		<img src="<?php echo '/repository/'.$_SESSION['pseudo'].'_repo/.profil/avatar.png'; ?>" class="aside_repoperso_profil_img"/>
         <p class="aside_repoperso_profil_text" >
				<?php echo $_SESSION['pseudo']; ?>
         </p>
		</div>

		<div class="aside_repoperso_title" >
				Search in
		</div>

<div class="aside_repoperso_choix_container" >
		<div class="aside_repoperso_choix" >
			<a href="" title="Recent update" class="text_white" >
				🕒
			</a>
			 <div class="aside_repoperso_choix_temoin" ></div>
		</div>

		<div class="aside_repoperso_choix" >
			<a href="" title="Public" class="text_green" >
				🔓
			</a>
         <div class="aside_repoperso_choix_temoin" ></div>
		</div>

		<div class="aside_repoperso_choix" >
			<a href="" title="Private" class="text_red" >
				🔒
			</a>
         <div class="aside_repoperso_choix_temoin" ></div>
		</div>

		<div class="aside_repoperso_choix" >
			<a href="" title="Fork" class="text_blue" >
				⑂
			</a>
         <div class="aside_repoperso_choix_temoin" ></div>
		</div>

		<div class="aside_repoperso_choix" >
			<a href="" title="Group" class="text_purple" >
				🚹🚹
			</a>
         <div class="aside_repoperso_choix_temoin" ></div>
		</div>
</div>

        <div class="aside_repoperso_title" >
			  <a href="">
					To do list
				</a>
        </div>

		<div class="aside_repoperso_todo" >
         <a href="" class="aside_repoperso_todo_text" >
            ↳ php aff
			</a>
         <a href="" class="aside_repoperso_todo_text" >
            ↳ php aff
			</a>
			<a href="" class="aside_repoperso_todo_text" >
				+More
			</a>
		</div>

		<div class="aside_repoperso_space" data-color="<?php echo $weight_color; ?>"></div> 
		<style>
			.aside_repoperso_space:before {width: <?php echo $weight_percent; ?>%;}
			.aside_repoperso_space:after {width: <?php echo $weight_percent; ?>%;}
		</style>

		<div class="aside_repoperso_work_track">
		</div>

		<div class="aside_repoperso_edit_profil">
	      <a href="" >
		      Edit profil
			</a>
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
		         <a href="'.$data['Owner'].'🜉/'.$data['Name'].'📂/"class="project_logo" > <img src="/repository/'.$data['Owner'].'_repo/'.$data['Name'].'/.cairn/repo_logo'.$data['logo'].'" /></a>
			      <div class="project_name_description">
					   <a class="title_repo" href="'.$data['Owner'].'🜉/'.$data['Name'].'📂/">'.$data['Name'].'</a>
						<a href="'.$data['Owner'].'🜉" class="sub_title_repo">'.$data['Owner'].'</a>
						<div class="description">'.$data['Description'].'</div>
						</div>
					</div>';
	       }
	       $data_sql->closeCursor();
		?>
	</div>
</div>
