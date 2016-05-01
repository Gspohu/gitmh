<?php
        // Vérification des identifiants
        $req = $bdd->prepare('SELECT id FROM Member WHERE Pseudo = :pseudo AND Password = :pass');
        $req->execute(array(
            'pseudo' => $pseudo,
            'pass' => $password));

        $result = $req->fetch();
?>
