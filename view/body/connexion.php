<body>
		
	<div class="connexion">
		<p class="title_connexion" >Sign up</p>

                <form method="post" >
                        <p class="title_form_connexion" >Username<p> <p><label for="Pseudo"></label> <input class="connexion_field" type="text" name="reg_pseudo" id="Pseudo" value="<?php echo htmlspecialchars($_POST['reg_pseudo']);?>" /></p>
                        <p class="title_form_connexion" >Passphrase<p> <p><label for="Mot de passe"></label> <input class="connexion_field" type="password" name="reg_password" id="Mot de passe" /></p>
			<a class="text_connexion" href="forgot_passphrase.php" >Forgot passphrase ?</a>
		        <input class="submit_connexion" type="submit" value="Submit" />
		</form>
	</div>

</body>
