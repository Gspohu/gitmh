<div class="admin-interface_body">

	<div class="admin-interface_block">
		<div class="admin-interface_title">
			Language
		</div>
      <div class="admin-interface_text">
			Import :
			<form method="post" action="admin-interface">
					<select name="language" id="language">
						<?php
							$cpt = 0;
							while($data = $data_sql_languages->fetch())
							{
								if($cpt == 0)
								{
									$cpt++;
								}
								else
								{	
									$languages[$cpt] = $data['Field'];
									echo '<option value="'.$languages[$cpt].'">'.$languages[$cpt].'</option>'.PHP_EOL;
									$cpt++;
								}
							}
							$data_sql_languages->closeCursor();
						?>
					</select>
			</form>
			Export :
         <form method="post" action="admin-interface">
               <select name="language" id="language">
                  <?php
                     $cpt = 1;
                     while(isset($languages[$cpt]))
							{
								echo '<option value="'.$languages[$cpt].'">'.$languages[$cpt].'</option>'.PHP_EOL;
								$cpt++;
                     }
                  ?>
               </select>
         </form>
      </div>
	</div>

   <div class="admin-interface_block">
      <div class="admin-interface_title">
			Design
      </div>
      <div class="admin-interface_text">
         <form method="post" action="admin-interface">
               <select name="design" id="design">
                  <?php
                     $cpt = 0;
                     while($data = $data_sql_design->fetch())
                     {
                        if($cpt == 0)
                        {
                           $cpt++;
                        }
                        else
                        {
                           echo '<option value="'.$data['Field'].'">'.$data['Field'].'</option>'.PHP_EOL;
                           $cpt++;
                        }
                     }
                     $data_sql_design->closeCursor();
                  ?>
               </select>
			</form>
      </div>
   </div>

   <div class="admin-interface_block">
      <div class="admin-interface_title">
			User
      </div>
      <div class="admin-interface_text">
         <form method="post" action="admin-interface">
				<table>
					<thead>
						<tr>
							<th>Pseudo</th>
							<th>Email</th>
							<th>ID</th>
							<th>Timestamp</th>
							<th>Rights</th>
						</tr>
					</thead>
					<tbody>
						<?php
                     while($data = $data_sql_member->fetch())
							{
								echo '<tr>'.PHP_EOL;
								echo '<td>'.$data['Pseudo'].'</td>'.PHP_EOL;
								echo '<td>'.$data['Email'].'</td>'.PHP_EOL;
								echo '<td>'.$data['ID'].'</td>'.PHP_EOL;
								echo '<td>'.$data['Timestamp'].'</td>'.PHP_EOL;
								echo '<td>'.$data['Droits'].'</td>'.PHP_EOL;
								echo '</tr>'.PHP_EOL;
                     }
                     $data_sql_member->closeCursor();
						?>
					</tbody>
         </form>
      </div>
   </div>


</div>
