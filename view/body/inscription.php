<body>
		
	<div class="inscription">
		<p class="title_inscription" >Sign in</p>

                <form method="post" >
                        <p class="title_form_inscription" >Username<p> <p><label for="Pseudo"></label> <input class="inscription_field" type="text" name="reg_pseudo" id="Pseudo" value="<?php echo htmlspecialchars($_POST['reg_pseudo']);?>" /></p>
                        <p class="title_form_inscription" >Password<p> <p><label for="Mot de passe"></label> <input class="inscription_field" type="password" name="reg_password" id="Mot de passe" /></p>
			<p class="title_form_inscription" >Re-password<p> <p><label for="ReMot de passe"></label> <input class="inscription_field" type="password" name="reg_repassword" id="ReMot de passe" /></p>
                        <p class="title_form_inscription" >Email<p> <p><label for="Mail"></label> <input class="inscription_field" type="text" name="reg_mail" id="Mail" value="<?php echo htmlspecialchars($_POST['reg_mail']);?>"/></p>
		        <input class="submit_inscription" type="submit" value="Submit" />
		</form>

	</div>

</body>