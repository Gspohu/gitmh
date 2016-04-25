<body>
		
	<div class="inscription">
		<h1>Inscription</h1>

                <form method="post" >
                        Pseudo <p><label for="Pseudo"></label> <input type="text" name="reg_pseudo" id="Pseudo" value="<?php echo htmlspecialchars($_POST['reg_pseudo']);?>" /></p>
                        Mot de passe <p><label for="Mot de passe"></label> <input type="password" name="reg_password" id="Mot de passe" /></p>
			Re-tapez mot de passe <p><label for="ReMot de passe"></label> <input type="password" name="reg_repassword" id="ReMot de passe" /></p>
                        Adresse e-mail <p><label for="Mail"></label> <input type="text" name="reg_mail" id="Mail" value="<?php echo htmlspecialchars($_POST['reg_mail']);?>"/></p>
		        <input type="submit" value="Envoyer" />
		</form>

	</div>

</body>
