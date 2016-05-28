<?php
function view_repo_info_name($bdd, $view_what, $view_value)
{
        $req = $bdd->prepare('SELECT id FROM Projects WHERE Name = :view_what AND Owner = :view_value');
        $req->execute(array(
		'view_what' => $view_what,
		'view_value' => $view_value));

        $result = $req->fetch();

        $req->closeCursor();
        return $result;
}
?>

<?php
function view_repo_info_table($bdd, $view_value)
{
        $req = $bdd->prepare('SELECT Name, Description, logo FROM Projects WHERE Owner = :view_value');
        $req->execute(array(
            'view_value' => $view_value));

        return $req;
}
?>

<?php
function view_repo_info_noCond($bdd, $view_what)
{
        $req = $bdd->prepare('SELECT :view_what FROM Projects');
        $req->execute(array('view_what' => $view_what));

        $result = $req->fetch();

        $req->closeCursor();
        return $result;
}
?>

