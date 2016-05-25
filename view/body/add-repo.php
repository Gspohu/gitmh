<div class="body">
	<div class="form_add">
		<div class="title_form_add">
			Create a new project
		</div>
		
		<form method="post" action="traitement.php">
			<div class="inline">
				<p class="title_form_add">Name</p>
				<img class="logo_repo_add" src="images/logo_repo_base.png">
			</div>

			<div class="inline">
				<input class="form_name_add" type="text" name="name" />
				<input type="file" name="nom" />
			</div>
			
			<div class="inline">
				<input type="radio" name="pubpriv" value="public" id="public" /> Public
			</div>

			<div class="inline">
				<input type="radio" name="pubpriv" value="private" id="private" /> Private
				<input type="checkbox" name="encryption" id="encryption" /> Encryption
			</div>

			<div class="inline">
				Type :
				<select name="type" id="type">
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
			
			Description :
			<textarea name="description" id="description"></textarea>

                        <div class="inline">
                                License :
                                <select name="type" id="type">
                                        <option value="electronic">GPLv2</option>
                                        <option value="audio_electronics">GPLv3</option>
                                        <option value="clothes_fabric">Tarp</option>
                                </select>
                        </div> 

                        <p class="title_form_add">Tags :</p>
			<input class="form_name_add" type="text" name="name" />

			<input type="submit" value="Submit" ></code>

		</form>	
	</div>
</div>
