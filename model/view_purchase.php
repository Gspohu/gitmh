<?php
function view_purchase($bdd, $view_what, $view_who)
{
        $req = $bdd->prepare('SELECT :view_what FROM Member WHERE Pseudo = :view_who');
        $req->execute(array(
            'view_who' => $view_who,
            'view_what' => $view_what));

        $result = $req->fetch();

        $req->closeCursor();
	return $result;
}
?>
