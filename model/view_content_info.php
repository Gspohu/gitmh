<?php
function view_content_column_info($bdd)
{
        $req = $bdd->prepare('SHOW COLUMNS FROM Text_content');
        $req->execute();

        return $req;
}
?>
