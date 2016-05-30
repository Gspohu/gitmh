<?php
function update_search_option($bdd, $sort, $in, $reduce, $pseudo)
{
	$req = $bdd->prepare('UPDATE Member SET Option_search_sort = :sort, Option_search_in = :in, Option_search_reduce = :reduce WHERE Pseudo = :pseudo');
	$req->execute(array(
       		'sort' => $sort,
	        'in' => $in,
        	'reduce' => $reduce,
		'pseudo' => $pseudo
        	));

	$req->closeCursor();
}
?>
