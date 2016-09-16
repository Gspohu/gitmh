<div class="body">
	<div class="form_add">
		<div class="title_add">
			Create a new project
		</div>
		
		<form method="post" action="add-repo" enctype="multipart/form-data">
			<p class="title_form_add">Name</p>
			<input class="field_add" type="text" name="repo_name" required/>

			<div class="inline_block">			
			<div class="add_publpriv_select">
				<div class="inline">
					<img width="25px" height="25px" src="images/pictogrammes/Picto_publproj.png" />
					<input type="radio" name="publpriv" value="public" id="public" onclick="checkbox();" checked/> Public
				</div>
	
				<div class="inline">
					<img width="25px" height="25px" src="images/pictogrammes/Picto_privproj.png" />
					<input type="radio" name="publpriv" value="private" id="private" onclick="checkbox();" /> Private
					<input type="checkbox" name="encryption" id="encryption" disabled/> Encryption
				</div>
                        <p class="title_form_add_select">Type</p>
                        <select class="select_add_first" name="repo_type" id="type" required>
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

			</div>
			<div class="add_logo">
				<div id="prev" class="div_logo_repo_add">
                                        <img id="logo_base" class="logo_repo_add" src="images/logo/logo_base_proj.png"/>
                                </div>

                                <div class="inputfile">
                                        <input type="file" class="file" name="repo_logo" id="file"/>
                                        <div class="mask">
                                                <input class="button_file" type="button" value="Add a logo" />
                                        </div>
                                </div>
			</div>
                                <script src="js/aff_dyna_img.js" ></script>

			</div>

			<p class="title_form_add">Description</p>
			<textarea class="field_add_textarea" name="repo_description" id="repo_description" maxlength="590"></textarea>

                                <p class="title_form_add">License</p>
                                <select class="select_add" name="repo_license" id="repo_licence" required>
                                        <option value="electronic">GPLv2</option>
                                        <option value="audio_electronics">GPLv3</option>
                                        <option value="clothes_fabric">Tarp</option>
                                </select>

                        <p class="title_form_add">Tags</p>
			<input class="field_add" type="text" name="repo_tags" />

			<input class="submit_add" type="submit" value="Submit" name="submit">

		</form>	
	</div>
</div>
