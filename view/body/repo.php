<div class="repo_body">
	<div class="aside_repo" >
		<div class="aside_repo_choix<?php if(htmlspecialchars($_GET['in']) == "project" ){ echo "_active"; } ?>" >
			<img class="aside_icon" src="/images/pictogrammes/sources.png"/> <a href="/<?php echo $_SERVER['REQUEST_URI']; ?>?sort=<?php echo htmlspecialchars($_GET['sort']); ?>&in=project" class="aside_repo_choix_text" >Sources</a>
		</div>

		<div class="aside_repo_choix<?php if(htmlspecialchars($_GET['in']) == "project" ){ echo "_active"; } ?>" >
			<img class="aside_icon" src="/images/pictogrammes/bug_track.png"/> <a href="/<?php echo $_SERVER['REQUEST_URI']; ?>?sort=<?php echo htmlspecialchars($_GET['sort']); ?>&in=project" class="aside_repo_choix_text" >Bug track</a>
		</div>

		<div class="aside_repo_choix<?php if(htmlspecialchars($_GET['in']) == "user" ){ echo "_active"; } ?>" >
			<img class="aside_icon" src="/images/pictogrammes/wiki.png"/> <a href="/<?php echo $_SERVER['REQUEST_URI']; ?>?sort=<?php echo htmlspecialchars($_GET['sort']); ?>&in=user" class="aside_repo_choix_text" >Wiki</a>
		</div>

		<div class="aside_repo_choix<?php if(htmlspecialchars($_GET['in']) == "group" ){ echo "_active"; } ?>" >
			<a href="/<?php echo $_SERVER['REQUEST_URI']; ?>?sort=<?php echo htmlspecialchars($_GET['sort']); ?>&in=group" class="aside_repo_choix_text" >⇆ Collab tools</a>
		</div>

		<div class="aside_repo_choix<?php if(htmlspecialchars($_GET['in']) == "group" ){ echo "_active"; } ?>" >
			<img class="aside_icon" src="/images/pictogrammes/progest.png"/> <a href="/<?php echo $_SERVER['REQUEST_URI']; ?>?sort=<?php echo htmlspecialchars($_GET['sort']); ?>&in=group" class="aside_repo_choix_text" >Progest</a>
		</div>

		<div class="aside_repo_choix<?php if(htmlspecialchars($_GET['in']) == "group" ){ echo "_active"; } ?>" >
			<img class="aside_icon" src="/images/pictogrammes/edu.png"/> <a href="/<?php echo $_SERVER['REQUEST_URI']; ?>?sort=<?php echo htmlspecialchars($_GET['sort']); ?>&in=group" class="aside_repo_choix_text" >Edu tools</a>
		</div>

		<div class="aside_repo_choix<?php if(htmlspecialchars($_GET['in']) == "project" ){ echo "_active"; } ?>" >
			<img class="aside_icon" src="/images/pictogrammes/setting.png"/> <a href="/<?php echo $owner.'🜉/'.$repo.'📂/setting'; ?>" class="aside_repo_choix_text" >Setting</a>
		</div>

	</div>


	<div class="repo_list_contain">
		<div class="title_repo_list_contain">
			<div class="title_repo_list_contain_a">
				<?php 
					echo '<img class="project_logo" src="/repository/'.$owner.'_repo/'.$repo.'/.cairn/repo_logo'.$ext.'"/>';
					if(isset($_GET['tab'])) 
					{ 
						echo '<a href="/'.$owner.'🜉">'.$owner.'/</a><a href="/'.$owner.'🜉/'.$repo.'📂">'.$repo.'/</a><a href="/'.$owner.'/🜉'.$repo.'📂/'.$tab.'⚙"">'.$tab.'</a>';
					}
				else
					{
						echo '<a href="/'.$owner.'🜉">'.$owner.'/</a><a href="/'.$owner.'🜉/'.$repo.'📂">'.$repo.'/</a>';
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
			<a href="/<?php echo $owner."🜉".$repo."📂new-folder"; ?>" class="button_new_folder">Create new folder</a> 
			<a href="/<?php echo $owner."🜉".$repo."📂#GitLink"; ?>" class="button_git" >Git link</a>
			</div>
		</div>

		<div id="GitLink">
			<div class="inline-between">
				<h3 onclick="document.getElementById('link').select();">Clone this project using Git :</h3>
				<a href="/<?php echo $owner."🜉".$repo."📂"; ?>#">Close</a>
			</div>
			<textarea id="link" class="lien_git"><?php echo "http://".$_SERVER['HTTP_HOST']."/repository/".$owner."_repo/".$repo.".git"; ?></textarea>
		</div>

		<div class="tabgroup_repo_list_contain">
			<a href="/<?php echo $owner."🜉".$repo."📂"; ?>/commit⚙" id="Commit" class="tab_repo_list_contain">
				<br/>Commit
			</a>
			<a href="/<?php echo $owner."🜉".$repo."📂"; ?>/branch⚙" id="Branch" class="tab_repo_list_contain">
				<br/>Branch
			</a> 
			<a href="/<?php echo $owner."🜉".$repo."📂"; ?>/release⚙" id="Release" class="tab_repo_list_contain">
				<br/>Release
			</a> 
			<a href="/<?php echo $owner."🜉".$repo."📂"; ?>/contributors⚙" id="Contibutors" class="tab_repo_list_contain">
				<br/>Contibutors
			</a> 
		</div>

		<div class="file_repo_list_contain" id="file_repo_list_contain" onclick="if(click_on_element ==0){click_on_element= 1;}else{click_on_element= 0;}" oncontextmenu="if(click_on_element ==0){click_on_element= 1;}else{click_on_element= 0;}">
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
$path_file = 'repository/'.$owner."_repo/".$repo."/".htmlspecialchars($_GET['file']);
$finfo = finfo_open(FILEINFO_MIME_TYPE);
$type= explode("/", finfo_file($finfo, $path_file));

if($type[0] == "text")
{
$file = fopen($path_file, 'r+');

echo '<pre><code>';

if ($file)
{
$cpt = 0;
while (!feof($file))
{
$buffer = fgets($file);
echo $cpt." ".htmlspecialchars($buffer, ENT_NOQUOTES, ENT_SUBSTITUTE);
$cpt++;
}
}

echo '</code></pre>';
 
fclose($file);
}
else if ($type[0] == "image")
{
echo '<img class="aff_media" src="'.$path_file.'">';
}
else if ($type[0] == "video")
{
echo '<video class="aff_media" src="'.$path_file.'" controls ></video>';
}
else
{
$path_info = pathinfo($path_file);

if($path_info['extension'] == "mp3" || $path_info['extension'] == "ogg")
{
echo '<audio class="aff_media" src="'.$path_file.'" controls></audio>';
}
else if($path_info['extension'] == "stl" || $path_info['extension'] == "STL")
{

echo '<script src="/js/three.js"></script>
<script src="/js/loaders/STLLoader.js"></script>
<script src="/js/Detector.js"></script>
<script src="/js/TrackballControls.js"></script>';

echo '<script src="/js/aff_3d.js"></script>';

}
else
{
echo $type[0]."/".$type[1];
}
}
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
echo '<img class="repo_icon" src="/images/pictogrammes/folder_icon.png"/>';
echo $repo_files[$cpt];
echo "</div>";
$cpt++;
}
else
{
echo '<a href="/'.$owner."🜉".$repo."📂".$repo_files[$cpt].'⏵">';
echo '<div class="repo_list_result">';
echo '<img class="repo_icon" src="/images/pictogrammes/file_icon.png"/>';
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
