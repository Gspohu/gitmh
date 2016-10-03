(function() 
{
	function createThumbnail(file) 
	{
		var reader = new FileReader();

		reader.addEventListener('load', function() 
		{
			while (prev.firstChild) 
			{
				prev.removeChild(prev.firstChild);
			}
				var imgElement = document.createElement('img');
				imgElement.style.maxWidth = '100%';
				imgElement.style.maxHeight = '100%';
				imgElement.src = this.result;
				prev.appendChild(imgElement);
		}, false);

		reader.readAsDataURL(file);
	}

	var allowedTypes = ['png', 'jpg', 'jpeg', 'gif', 'svg', 'PNG', 'JPG', 'JPEG', 'GIF', 'SVG'],
	fileInput = document.querySelector('#file'),
	prev = document.querySelector('#prev'),
	logo_base = document.getElementById("logo_base"),
	max_img_size = 10000000;

	fileInput.addEventListener('change', function() 
	{
		var files = this.files,
		filesLen = files.length,
		imgType;

		for (var i = 0 ; i < filesLen ; i++) 
		{
			imgType = files[i].name.split('.');
			imgType = imgType[imgType.length - 1]

			if(allowedTypes.indexOf(imgType) != -1 && files[i].size < max_img_size) 
			{
				createThumbnail(files[i]);
			}
			else
			{
				alert("The file must be less than " + (max_img_size/1000/1000) + "MB");
				fileInput.value= "";
			}
		}

	}, false);
})();
