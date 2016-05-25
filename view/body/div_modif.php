        <div id="Modif">
                <script>
                var name;
                function title_modif(name) 
                {
                        Modif.innerHTML='<div class="title_modif_container"><div class="title_modif">Modification de '+name+'</div>\n<a href="#"><img class="exit_modif" src="images/pictogrammes/exit_modif.png" alt="Exit" title="Exit" /></div></a>\n<form method="post" id="modif_text" class="form_modif" action="<?php echo $_SERVER['REQUEST_URI']; ?>">\n<input class="hidden" type="text" name="name" value="'+name+'"/><textarea name="content" class="textarea_modif" id="modif_text">\n</textarea>\n<div class="menu_modif">\n<a href="modification-generales" target=_blank><img class="modif_gen_logo" src="images/pictogrammes/roue.png" alt="Modifications générales" title="Modifications générales" /></a>\n<select class="select_modif" name="langue" id="langue">\n<option value="Français">Français</option>\n<option value="English">English</option>\n<option value="Deutsch">Deutsch</option>\n<option value="Español">Español</option>\n<option value="Nederlands">Nederlands</option>\n</select>\n<input type="submit" class="submit_modif" value="Modifier" ></div></form>';
                }
                </script>
        </div>
