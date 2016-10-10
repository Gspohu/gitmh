<div class="body">
	<div class="project_list">
		<div class="sort">
			Sort : Rating | All |
		</div>
      <?php 
         while($data = $data_sql_repo->fetch())
			{
				if ($data['Publpriv'] == 'public')
				{
					echo '
						<div class="project">'.PHP_EOL
							.'<div class="project_logo">'.PHP_EOL
								.'<a href="'.$data['Owner'].'🜉/'.$data['Name'].'📂/">'.PHP_EOL
									.'<img src="/repository/'.$data['Owner'].'_repo/'.$data['Name'].'/.cairn/repo_logo'.$data['logo'].'"/>'.PHP_EOL
								.'</a>'.PHP_EOL
							.'</div>'.PHP_EOL	
							.'<a href="'.$data['Owner'].'🜉/'.$data['Name'].'📂/" class="title">'.$data['Name'].'</a>'.PHP_EOL
							.'<div class="inline_explore">'.PHP_EOL
							   .'<a href="'.$data['Owner'].'🜉/'.$data['Name'].'📂/" class="owner">'.$data['Owner'].'</a>'.PHP_EOL
								.'<div class="inline_explore">'.PHP_EOL
									.'<a href="&button=rating" class="button_fork_rate">'.PHP_EOL
										.'<div class="button_text">'.PHP_EOL
											.'<div class="button_nombre">'.PHP_EOL
												.$data['Rating'].PHP_EOL
											.'</div>'.PHP_EOL
											.'✩'.PHP_EOL
										.'</div>'.PHP_EOL
									.'</a>'.PHP_EOL
									.'<a href="&button=fork" class="button_fork_rate">'.PHP_EOL
										.'<div class="button_text">'.PHP_EOL
											.'<div class="button_nombre">'.PHP_EOL
												.$data['Fork'].PHP_EOL
											.'</div>'.PHP_EOL
											.'⑂'.PHP_EOL
										.'</div>'.PHP_EOL
						         .'</a>'.PHP_EOL
								.'</div>'.PHP_EOL
                  	.'</div>'.PHP_EOL
							.'<div class="description">'.$data['Description'].'</div>'.PHP_EOL
						.'</div>'.PHP_EOL;
				}
			}
			$data_sql_repo->closeCursor();
		?>
	</div>			
</div>
