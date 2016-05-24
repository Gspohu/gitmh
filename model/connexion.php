<?php
        // Vérification des identifiants
        $req = $bdd->prepare('SELECT id FROM Member WHERE Pseudo = :pseudo AND Password = :pass');
        $req->execute(array(
            'pseudo' => $pseudo,
            'pass' => $password));

        $result = $req->fetch();

	$req->closeCursor();

	$req_droits = $bdd->prepare('SELECT Droits FROM Member WHERE Pseudo = :pseudo');
	$req_droits->execute(array(
            'pseudo' => $pseudo));

        while($donnes = $req_droits->fetch())
        {
                $droits = $donnes['Droits'];
        }

        $req_droits->closeCursor();

?>
