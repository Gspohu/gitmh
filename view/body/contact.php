<div class="body">
	<div class="contact">
		<p class="title_contact" <?php modif_text('Contact_title'); ?>><?php echo $get_text['Contact_title']."\n"; ?></p>

                <form method="post" action="contact" >
                        <p class="title_form_contact" <?php modif_text('Contact_form_1'); ?>><?php echo $get_text['Contact_form_1']."\n"; ?><p> <p><label for="Mail"></label> <input class="contact_field" type="email" name="email_contact" id="Email" value="<?php if(isset($_POST['email_contact'])){ echo htmlspecialchars($_POST['email_contact']); } ?>" /></p>
                        <p class="title_form_contact" <?php modif_text('Contact_form_2'); ?>><?php echo $get_text['Contact_form_2']."\n"; ?><p> <p><textarea class="contact_field_message" name="message" id="message"></textarea></p>
			<p class="title_form_contact" <?php modif_text('Contact_form_3'); ?>><?php echo $get_text['Contact_form_3']."\n"; ?><p> <p><label for="captcha"></label> <input class="captcha_field" type="text" name="captcha" id="captcha" placeholder="<?php echo $get_text['Contact_form_placeholder_3'].'"'; modif_text('Contact_form_placeholder_3')?>" /><div class="captcha" ><div class="captcha1"></div><div class="captcha2"></div><div class="captcha3"></div><div class="captcha4"></div></div></p>
			<p class="error_contact" ><?php	    echo $error_bad_email;
							    echo $error_bad_captcha; ?></p>
		        <input class="submit_contact" type="submit" value="<?php echo $get_text['Contact_submit'];?>" <?php modif_text('Contact_submit'); ?>/>
		</form>
	</div>
</div>
