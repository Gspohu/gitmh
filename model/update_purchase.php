<?php
function update_purchase($bdd, $update_value, $update_what, $update_who)
{
        $req = $bdd->prepare('UPDATE Member SET :update_what = :update_value WHERE Pseudo = :update_who');
        $req->execute(array(
		'update_what' => $update_what,
                'update_value' => $update_value,
                'update_who' => $update_who,
                ));

        $req->closeCursor();
}
?>
