function checkbox()
{
	if(document.getElementById('private').checked)
	{
		document.getElementById('encryption').disabled = '';
	}
	else
	{
		document.getElementById('encryption').disabled = 'disabled';
	}
}
