	<div class="inscription">
		<p class="title_inscription" >Sign in</p>

                <form method="post" action="inscription.php" >
                        <p class="title_form_inscription" >Username<p> <p><label for="Pseudo"></label> <input class="inscription_field" type="text" name="reg_pseudo" id="Pseudo" value="<?php if(isset($_POST['reg_pseudo'])){ echo htmlspecialchars($_POST['reg_pseudo']); } ?>" /></p>
                        <p class="title_form_inscription" >Passphrase<p> <p><label for="Mot de passe"></label> <input class="inscription_field" type="password" name="reg_password" id="reg_password" /></p>
			<p class="title_form_inscription" >Re-passphrase<p> <p><label for="ReMot de passe"></label> <input class="inscription_field" type="password" name="reg_repassword" id="reg_repassword"/></p>
                        <p class="title_form_inscription" >Email<p> <p><label for="Mail"></label> <input class="inscription_field" type="email" name="reg_mail" id="Mail" value="<?php if(isset($_POST['reg_mail'])){ echo htmlspecialchars($_POST['reg_mail']); } ?>"/></p>
			<p class="title_form_inscription" >Captcha<p> <p><label for="captcha"></label> <input class="captcha_field" type="text" name="captcha" id="captcha" placeholder="Copy the text to your right" /><div class="captcha" ></div></p>
		        <input class="submit_inscription" type="submit" value="Submit" />
		</form>

	</div>
