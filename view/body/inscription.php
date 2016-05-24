<div class="body">
	<div class="inscription">
		<p class="title_inscription" <?php modif_text('Inscription_title'); ?>><?php echo $get_text['Inscription_title']."\n"; ?></p>

                <form method="post" action="inscription.php" >
                        <p class="title_form_inscription" <?php modif_text('Inscription_form_1'); ?>><?php echo $get_text['Inscription_form_1']."\n"; ?><p> <p><label for="Pseudo"></label> <input class="inscription_field" type="text" name="reg_pseudo" id="Pseudo" value="<?php if(isset($_POST['reg_pseudo'])){ echo htmlspecialchars($_POST['reg_pseudo']); } ?>" /></p>
                        <p class="title_form_inscription" <?php modif_text('Inscription_form_2'); ?>><?php echo $get_text['Inscription_form_2']."\n"; ?><p> <p><label for="Mot de passe"></label> <input class="inscription_field" type="password" name="reg_password" id="reg_password" placeholder="<?php echo $get_text['Inscription_form_placeholder_2'].'"'; modif_text('Inscription_form_placeholder_2')?>"/></p>
			<p class="title_form_inscription" <?php modif_text('Inscription_form_3');?>><?php echo $get_text['Inscription_form_3']."\n";?><p> <p><label for="ReMot de passe"></label> <input class="inscription_field" type="password" name="reg_repassword" id="reg_repassword" placeholder="<?php echo $get_text['Inscription_form_placeholder_3'].'"'; modif_text('Inscription_form_placeholder_3')?>"/></p>
                        <p class="title_form_inscription" <?php modif_text('Inscription_form_4'); ?>><?php echo $get_text['Inscription_form_4']."\n"; ?><p> <p><label for="Mail"></label> <input class="inscription_field" type="email" name="reg_mail" id="Mail" value="<?php if(isset($_POST['reg_mail'])){ echo htmlspecialchars($_POST['reg_mail']); } ?>"/></p>
			<p class="title_form_inscription" <?php modif_text('Inscription_form_5'); ?>><?php echo $get_text['Inscription_form_5']."\n"; ?><p> <p><label for="captcha"></label> <input class="captcha_field" type="text" name="captcha" id="captcha" placeholder="<?php echo $get_text['Inscription_form_placeholder_5'].'"'; modif_text('Inscription_form_placeholder_5')?>" /><div class="captcha" ><div class="captcha1"></div><div class="captcha2"></div><div class="captcha3"></div><div class="captcha4"></div></div></p>
			<p class="error_inscription" ><?php echo $error_pass_length;
							    echo $error_bad_email;
							    echo $error_existing_pseudo;
							    echo $error_existing_email;
							    echo $error_pass_doesnt_match;
							    echo $error_bad_captcha; ?></p>
		        <input class="submit_inscription" type="submit" value="<?php echo $get_text['Inscription_submit'];?>" <?php modif_text('Inscription_submit'); ?>/>
		</form>
	</div>
</div>
