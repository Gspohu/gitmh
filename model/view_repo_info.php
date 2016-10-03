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
        $req = $bdd->prepare('SELECT Name, Description, logo, Owner FROM Projects WHERE Owner = :view_value');
        $req->execute(array(
            'view_value' => $view_value));

        return $req;
}
?>

<?php
function view_repo_info_sort($bdd, $view_value, $view_sort)
{
        $req = $bdd->prepare('SELECT Name, Description, logo, Owner FROM Projects WHERE Name LIKE :view_value');
        $req->execute(array(
           'view_value' => '%'.$view_value.'%'
	   ));

        return $req;
}
?>

<?php
function view_repo_info_ext($bdd, $name, $owner)
{
        $req = $bdd->prepare('SELECT logo FROM Projects WHERE Name = :Name AND Owner = :Owner');
        $req->execute(array(
			'Name' => $name,
			'Owner' => $owner
			));

        return $req;
}
?>

