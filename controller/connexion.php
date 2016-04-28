<?php
include_once('model/get_text.php');

include_once('view/nav/nav.php');

include_once('view/body/connexion.php');

if (isset($_POST['conn_pseudo']) && isset($_POST['conn_password']))
{
	$pseudo= $_POST['conn_pseudo'];
	$password = hash('sha256', $_POST['conn_password']);

	// Vérification des identifiants
	$req = $bdd->prepare('SELECT id FROM Member WHERE Pseudo = :pseudo AND Password = :pass');
	$req->execute(array(
	    'pseudo' => $pseudo,
	    'pass' => $password));

	$result = $req->fetch();

	if (!$result)
	{
	    echo 'Mauvais identifiant ou mot de passe !';
	}
	else
	{
	    session_start();
	    $_SESSION['id'] = $resultat['id'];
	    $_SESSION['pseudo'] = $pseudo;
	    echo 'Vous êtes connecté !';
	}
}

include_once('view/footer/footer.php');
?>