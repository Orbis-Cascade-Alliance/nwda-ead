$(document).ready(function(){
	$('.toggle-button span').click(function(){
		var list = $(this) .parent('a').attr('id').split('-')[1] + '-content';
		$('#' + list).toggle();
		
		//replace minus with plus and vice versa
		if ($(this).attr('class').indexOf('minus') > 0) {
			$(this).removeClass('glyphicon-minus');
			$(this).addClass('glyphicon-plus');
			$('#' + list).hide();
		} else {
			$(this).removeClass('glyphicon-plus');
			$(this).addClass('glyphicon-minus');
		}
		return false;
	});
});