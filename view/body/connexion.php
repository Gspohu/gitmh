<div class="body">
	<div class="connexion">
		<p class="title_connexion" <?php modif_text('Connexion_title'); ?>><?php echo $get_text['Connexion_title']."\n"; ?></p>

                <form method="post" >
                        <p class="title_form_connexion" <?php modif_text('Connexion_form_1'); ?>><?php echo $get_text['Connexion_form_1']."\n"; ?></p> <p><input class="connexion_field" type="text" name="conn_pseudo" id="Pseudo" value="<?php echo htmlspecialchars($_POST['conn_pseudo']);?>" /></p>
                        <p class="title_form_connexion" <?php modif_text('Connexion_form_2'); ?>><?php echo $get_text['Connexion_form_2']."\n"; ?></p> <input class="connexion_field" type="password" name="conn_password" id="Mot de passe" /></p>
			<a class="text_connexion" href="forgot_passphrase.php" <?php modif_text('Connexion_text_1'); ?>><?php echo $get_text['Connexion_text_1']."</a>\n"; ?>
		        <input class="submit_connexion" type="submit" value="<?php echo $get_text['Connexion_submit']."\n"; ?>" <?php modif_text('Connexion_submit'); ?>/>
		</form>
	</div>
</div>
