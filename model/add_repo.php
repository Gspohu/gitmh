<?php
$req = $bdd->prepare('INSERT INTO Projects(Name, Publpriv, Encryption, Type, Description, License, Tag, Owner, logo) VALUES(:Name, :Publpriv, :Encryption, :Type, :Description, :License, :Tag, :Owner, :logo)');
$req->execute(array(
        'Name' => $repo_name,
        'Publpriv' => $publpriv,
        'Encryption' => $encryption,
        'Type' => $repo_type,
        'Description' => $repo_description,
        'License' => $repo_license,
        'Tag' => $repo_tags,
        'Owner' => $_SESSION['pseudo'],
	'logo' => $ext
        ));

$req->closeCursor();
?>

