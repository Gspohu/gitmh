<div class="repo_list_body">
	<div class="aside_searchbar" >
                <div class="aside_searchbar_title">
                        Sort by
                </div>
		<a href="search?searchbar=<?php echo htmlspecialchars($_GET['searchbar']); ?>&sort=🕒&in=<?php echo htmlspecialchars($_GET['in']); ?>" class="aside_searchbar_tab<?php if( $_SESSION['sort'] == "🕒")  { echo "_active" ;}  ?>" >
			<div class="aside_temoin<?php if( $_SESSION['sort'] == "🕒" ) { echo "_active"; } ?>" ></div>
			<div class="aside_logo" >
				🕒
				<div class="aside_text" >Recent update</div>
			</div>
		</a>
                <a href="search?searchbar=<?php echo htmlspecialchars($_GET['searchbar']); ?>&sort=✩&in=<?php echo htmlspecialchars($_GET['in']); ?>" class="aside_searchbar_tab<?php if( $_SESSION['sort'] == "✩" ) { echo "_active"; } ?>" >
                        <div class="aside_temoin<?php if( $_SESSION['sort'] == "✩" ) { echo "_active"; } ?>" ></div>
                        <div class="aside_logo" >
				✩
                        	<div class="aside_text" >Best noted</div>
			</div>
                </a>
                <a href="search?searchbar=<?php echo htmlspecialchars($_GET['searchbar']); ?>&sort=⑂&in=<?php echo htmlspecialchars($_GET['in']); ?>" class="aside_searchbar_tab<?php if( $_SESSION['sort'] == "⑂" ) { echo "_active"; } ?>" >
                        <div class="aside_temoin<?php if( $_SESSION['sort'] == "⑂" ) { echo "_active"; } ?>" ></div>
                        <div class="aside_logo" >
				⑂
                        	<div class="aside_text" >Most fork</div>
			</div>
                </a>
                <div class="aside_searchbar_title">
                        Search in
                </div>
                <a href="search?searchbar=<?php echo htmlspecialchars($_GET['searchbar']); ?>&sort=<?php echo htmlspecialchars($_GET['sort']); ?>&in=📁" class="aside_searchbar_tab<?php if( $_SESSION['in'] == "📁" ) { echo "_active"; } ?>" >
                        <div class="aside_temoin<?php if( $_SESSION['in'] == "📁" ) { echo "_active"; } ?>" ></div>
                        <div class="aside_logo" >
				📁
                        	<div class="aside_text" >Projects</div>
			</div>
                </a>
                <a href="search?searchbar=<?php echo htmlspecialchars($_GET['searchbar']); ?>&sort=<?php echo htmlspecialchars($_GET['sort']); ?>&in=🚹" class="aside_searchbar_tab<?php if( $_SESSION['in'] == "🚹" ) { echo "_active"; } ?>" >
                        <div class="aside_temoin<?php if( $_SESSION['in'] == "🚹" ) { echo "_active"; } ?>" ></div>
                        <div class="aside_logo" >
				🚹
                        	<div class="aside_text" >Users</div>
			</div>
                </a>
                <a href="search?searchbar=<?php echo htmlspecialchars($_GET['searchbar']); ?>&sort=<?php echo htmlspecialchars($_GET['sort']); ?>&in=🚹🚹" class="aside_searchbar_tab<?php if($_SESSION['in'] == "🚹🚹" ) { echo "_active"; } ?>" >
                        <div class="aside_temoin<?php if( $_SESSION['in'] == "🚹🚹" ) { echo "_active"; } ?>" ></div>
                        <div class="aside_logo" >
				🚹🚹
                  	      <div class="aside_text" >Groups</div>
			</div>
                </a>
                <div class="aside_searchbar_title">
                        Type
                </div>
                <div class="aside_searchbar_tab">
			<form method="post" action="traitement.php">
				<select class="select_type" name="repo_type" id="type" >
					<option value="All">All</option>
               <option value="electronic">Electronic</option>
	            <option value="audio_electronics">Audio electronics</option>
        	      <option value="video_electronics">Video electronics</option>
               <option value="cameras">Cameras</option>
               <option value="robotics">Robotics</option>
               <option value="telephony">Telephony</option>
	                                <option value="computer">Computer</option>
        	                        <option value="car">Car</option>
                	                <option value="wireless_networking">Wireless networking</option>
                        	        <option value="amateur_radio">Amateur radio</option>
                       	        	<option value="renewable_energy">Renewable energy</option>
                       	      		<option value="measure_scientific">Measure scientific</option>
                                	<option value="3d_printers">3D printers</option>
                                	<option value="medical">Medical</option>
                                	<option value="carpentry">Carpentry</option>
                                	<option value="furniture">Furniture</option>
                                	<option value="design">Design</option>
                                	<option value="model_aircraft">Model aircraft</option>
                                	<option value="tools">Tools</option>
                               		<option value="home_automation">Home automation</option>
                                	<option value="musical_instrument">Musical instrument</option>
                                	<option value="fixing">Fixing</option>
                                	<option value="software">Software</option>
                                	<option value="clothes_fabric">Clothes/Fabric</option>
				</select>
			</form>	
                </div>
	</div>
<div class="repo_list">
        <?php
                while($data = $data_sql->fetch())
                {
                        echo '
        <div class="repo_list_result">
                <img class="project_logo" src="repository/'.$data['Owner'].'_repo/'.$data['Name'].'/.cairn/repo_logo'.$data['logo'].'"/>
                <div class="project_name_description">
                        <a class="title_repo" href="'.$data['Owner'].'🜉/'.$data['Name'].'📂/">'.$data['Name'].'</a>
			<p class="sub_title_repo">'.$data['Owner'].'</p>
                        <p class="description">'.$data['Description'].'</p>
                </div>
        </div>';
                }
                $data_sql->closeCursor();
        ?>
</div>
</div>
