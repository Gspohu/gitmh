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
							.'<a href="'.$data['Owner'].'🜉/'.$data['Name'].'📂/" class="project_logo">'.PHP_EOL
								.'<img src="/repository/'.$data['Owner'].'_repo/'.$data['Name'].'/.cairn/repo_logo'.$data['logo'].'"/>'.PHP_EOL
								.'<div class="title">'.$data['Name'].'</div>'.PHP_EOL
								.'<div class="owner">'.$data['Owner'].'</div>'.PHP_EOL
							.'</a>'.PHP_EOL
							.'<div class="repo_button">'.PHP_EOL
								.'<a href="&button=rating" class="repo_button_rating">'.PHP_EOL
									.'<div class="repo_button_text">'.PHP_EOL
										.'<div class="repo_button_nombre">'.PHP_EOL
											.'42'.PHP_EOL
										.'</div>'.PHP_EOL
										.'✩ Rating'.PHP_EOL
									.'</div>'.PHP_EOL
									.'<div class="repo_button_design"></div>'.PHP_EOL
								.'</a>'.PHP_EOL
								.'<a href="&button=fork" class="repo_button_fork">'.PHP_EOL
									.'<div class="repo_button_text">'.PHP_EOL
										.'<div class="repo_button_nombre">'.PHP_EOL
											.'0'.PHP_EOL
										.'</div>'.PHP_EOL
										.'⑂ Fork'.PHP_EOL
									.'</div>'.PHP_EOL
									.'<div class="repo_button_design"></div>'.PHP_EOL
					         .'</a>'.PHP_EOL
                     .'</div>'.PHP_EOL
							.'<div class="description">'.$data['Description'].'</div>'.PHP_EOL
						.'</div>'.PHP_EOL;
				}
			}
			$data_sql_repo->closeCursor();
		?>
	</div>			
</div>
