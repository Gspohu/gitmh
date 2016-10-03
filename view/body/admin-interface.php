<div class="admin-interface_body">

Language


Design


User


	<?php
         while($data = $data_sql->fetch())
				         {
								            echo '
            <div class="repo_list_result">
               <a href="'.$data['Owner'].'🜉/'.$data['Name'].'📂/"class="project_logo" > <img src="/repository/'..
$data['Owner'].'_repo/'.$data['Name'].'/.cairn/repo_logo'.$data['logo'].'" /></a>
               <div class="project_name_description">
                  <a class="title_repo" href="'.$data['Owner'].'🜉/'.$data['Name'].'📂/">'.$data['Name'].'</a>
                  <a href="'.$data['Owner'].'🜉" class="sub_title_repo">'.$data['Owner'].'</a>
                  <div class="description">'.$data['Description'].'</div>
               </div>
            </div>';
         }
         $data_sql->closeCursor();
      ?>
</div>
