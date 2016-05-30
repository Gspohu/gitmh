<?php
function view_member_search_option($bdd, $view_pseudo)
{
        $req = $bdd->prepare('SELECT Option_search_sort, Option_search_in, Option_search_reduce FROM Member WHERE Pseudo = :view_pseudo');
        $req->execute(array(
            'view_pseudo' => $view_pseudo));

        return $req;
}
?>
