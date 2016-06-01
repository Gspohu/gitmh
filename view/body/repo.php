<div class="repoperso_body">
	<div id="reduce" >
        	<div class="aside_repoperso" >
        	        <div class="aside_repoperso_choix<?php if(htmlspecialchars($_GET['in']) == "project" ){ echo "_active"; } ?>" >
        	               <img class="aside_icon" src="images/pictogrammes/sources.png"/> <a href="<?php echo $_SERVER['REQUEST_URI']; ?>?sort=<?php echo htmlspecialchars($_GET['sort']); ?>&in=project" class="aside_repoperso_choix_text" >Sources</a>
        	        </div>
		
        	        <div class="aside_repoperso_choix<?php if(htmlspecialchars($_GET['in']) == "project" ){ echo "_active"; } ?>" >
        	                <img class="aside_icon" src="images/pictogrammes/bug_track.png"/> <a href="<?php echo $_SERVER['REQUEST_URI']; ?>?sort=<?php echo htmlspecialchars($_GET['sort']); ?>&in=project" class="aside_repoperso_choix_text" >Bug track</a>
       	         	</div>
		
        	        <div class="aside_repoperso_choix<?php if(htmlspecialchars($_GET['in']) == "user" ){ echo "_active"; } ?>" >
        	               <img class="aside_icon" src="images/pictogrammes/wiki.png"/> <a href="<?php echo $_SERVER['REQUEST_URI']; ?>?sort=<?php echo htmlspecialchars($_GET['sort']); ?>&in=user" class="aside_repoperso_choix_text" >Wiki</a>
       	         	</div>
		
        	        <div class="aside_repoperso_choix<?php if(htmlspecialchars($_GET['in']) == "group" ){ echo "_active"; } ?>" >
        	               <img class="aside_icon" src="images/pictogrammes/progest.png"/> <a href="<?php echo $_SERVER['REQUEST_URI']; ?>?sort=<?php echo htmlspecialchars($_GET['sort']); ?>&in=group" class="aside_repoperso_choix_text" >Progest</a>
        	        </div>
	
       	         	<div class="aside_repoperso_choix<?php if(htmlspecialchars($_GET['in']) == "project" ){ echo "_active"; } ?>" >
       	                	<img class="aside_icon" src="images/pictogrammes/setting.png"/> <a href="<?php echo $_SERVER['REQUEST_URI']; ?>?sort=<?php echo htmlspecialchars($_GET['sort']); ?>&in=project" class="aside_repoperso_choix_text" >Setting</a>
		        </div>
	
	        </div>
	</div>
	
	
	<div class="repo_list_contain">
		
		<div class="title_repo_list_contain">
<?php
?>
			<div class="title_repo_list_contain_a">
                        <?php 
				echo '<img class="project_logo" src="repository/'.$owner.'_repo/'.$repo.'/.cairn/repo_logo'.$ext.'"/>';
                                if(isset($_GET['tab'])) 
                                {       
                                        echo '<a href="'.$owner.'🜉/">'.$owner.'/</a><a href="'.$owner.'🜉/'.$repo.'📂/">'.$repo.'/</a><a href="'.$owner.'🜉/'.$repo.'📂/'.$tab.'⚙"">'.$tab.'</a>';
                                }
                                else
                                {
                                      echo '<a href="'.$owner.'🜉/">'.$owner.'/</a><a href="'.$owner.'🜉/'.$repo.'📂/">'.$repo.'/</a>';
                                }
                                
                         ?>
			</div>

			<div class="title_repo_list_link_group">	
				<form class="inline_button" method="post" name="uploadForm" enctype="multipart/form-data" >
				<div class="select_files">
	                                <div class="inputfile">
	                                        <input type="file" class="file" name="folder[]" id="folder" directory="" webkitdirectory="" mozdirectory="" msdirectory="" odirectory="" multiple="" onchange="selectFolder(event)">
        	                                <div class="mask">
                	                                <input class="button_file" type="button" value="Folder">
                        	                </div>
                                	</div>

                                        <div class="inputfile">
                                                <input type="file" class="file" name="files[]" id="files" multiple="">
                                                <div class="mask">
                                                        <input class="button_file" type="button" value="File" />
                                                </div>
                                        </div>
				</div>
					<input name="folder_name" type="hidden" value="">
					<input class="button_upload" type="submit" value="Upload" />
				</form> 
                	        <a href="<?php echo $owner."🜉/".$repo."📂/new-folder"; ?>" class="button_new_folder">Create new folder</a> 			
				<a href="<?php echo $owner."🜉/".$repo."📂/#GitLink"; ?>" class="button_git" >Git link</a>
			</div>
		</div>

                	<div id="GitLink">
                        	<div class="inline-between">
                                	<h3 onclick="document.getElementById('link').select();">Clone this project using Git :</h3>
                                        <a href="<?php echo $owner."🜉/".$repo."📂/"; ?>#">Close</a>
                                </div>
                                <textarea id="link" class="lien_git"><?php echo "http://".$_SERVER['HTTP_HOST']."/repository/".$owner."_repo/".$repo.".git"; ?></textarea>
                        </div>

	 	<div class="tabgroup_repo_list_contain">
			<a href="<?php echo $owner."🜉/".$repo."📂"; ?>/commit⚙" id="Commit" class="tab_repo_list_contain">
				<br/>Commit
                	</a>
                        <a href="<?php echo $owner."🜉/".$repo."📂"; ?>/branch⚙" id="Branch" class="tab_repo_list_contain">
				<br/>Branch
                        </a> 
                        <a href="<?php echo $owner."🜉/".$repo."📂"; ?>/release⚙" id="Release" class="tab_repo_list_contain">
				<br/>Release
                        </a> 
                        <a href="<?php echo $owner."🜉/".$repo."📂"; ?>/contributors⚙" id="Contibutors" class="tab_repo_list_contain">
				<br/>Contibutors
                        </a> 
                </div>
	
		<div class="file_repo_list_contain">
			<?php 
				if(isset($_GET['tab']))
				{
					if($tab == 'commit')
					{
						echo 'Commit';
					}
                                        else if($tab == 'branch')
                                        {
                                                echo 'branch';
                                        }
                                        else if($tab == 'release')
                                        {
                                                echo 'Release';
                                        }
                                        else if($tab == 'contributors')
                                        {
                                                echo 'Contributors';
                                        }

				}
				else if (isset($_GET['file']))
				{
					$file_path = 'repository/'.$owner."_repo/".$repo."/".htmlspecialchars($_GET['file']);
					$file = fopen($file_path, 'r+');

					echo '<pre><code>';
	
					if ($file)
					{
						while (!feof($file))
						{
							$buffer = fgets($file);
							echo $buffer;
						}
					}
					
					echo '</code></pre>';
					
					fclose($file);
				}
				else
				{
					echo '<div class="repo_files">';
					$cpt = 2;
 					while(isset($repo_files[$cpt]))
					{
						$path_file = "repository/".$owner."_repo/".$repo."/".$repo_files[$cpt];
						if($repo_files[$cpt] == '.cairn' || $repo_files[$cpt] == '.git')
						{
							$cpt++;
						}
						else if (is_dir($path_file))
						{
							echo '<div class="repo_list_result">';
							echo '<img class="repo_icon" src="images/pictogrammes/folder_icon.png"/>';
							echo $repo_files[$cpt];
							echo "</div>";
							$cpt++;
						}
						else
						{
							echo '<a href="'.$owner."🜉/".$repo."📂/".$repo_files[$cpt].'⏵">';
							echo '<div class="repo_list_result">';
                                                        echo '<img class="repo_icon" src="images/pictogrammes/file_icon.png"/>';
                                                        echo $repo_files[$cpt];
                                                        echo "</div>";
							echo '</a>';
                                                        $cpt++;
						}
					}
					echo '</div>';
				}
				
			 ?>
		</div>
		
	</div>
	
</div>
