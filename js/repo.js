function selectFolder(e) 
{
	var theFiles = e.target.files;
	var relativePath = theFiles[0].webkitRelativePath;

	if (relativePath === undefined)
	{
		var folder = prompt("Attention votre navigateur ne permet pas l'upload de dossiers, pour fonctionner l'upload nécéssite le nom du dossier :", "");
        	document.uploadForm.folder_name.value = folder;	
	}
	else
	{
	        var folder = relativePath.split("/");
	        document.uploadForm.folder_name.value = folder[0];
	}
}
