<?php
        // Vérification pseudo
        $req = $bdd->prepare('SELECT id FROM Member WHERE Pseudo = :pseudo');
        $req->execute(array(
            'pseudo' => $pseudo));

        $result_pseudo = $req->fetch();
	$req->closeCursor();

        // Vérification mail
        $req = $bdd->prepare('SELECT id FROM Member WHERE Email = :email');
        $req->execute(array(
            'email' => $email));

        $result_email = $req->fetch();
	$req->closeCursor();
?>
