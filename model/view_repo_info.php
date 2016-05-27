<?php
function view_repo_info($bdd, $view_what, $view_where, $view_value)
{
        $req = $bdd->prepare('SELECT :view_what FROM Projects WHERE :view_where = :view_value');
        $req->execute(array(
	    'view_value' => $view_value,
            'view_where' => $view_where,
            'view_what' => $view_what));

        $result = $req->fetch();

        $req->closeCursor();
        return $result;
}
?>
