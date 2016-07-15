<?php
	$req = $bdd->prepare('UPDATE Content_EN SET Content = :Content WHERE Name = :Name');
	$req->execute(array(
	        'Name' => $name,
        	'Content' => $content,
	        ));

	$req->closeCursor();
?>
