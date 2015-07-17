$(document).ready(function () {
	$('.info-text').each(function () {
		var parsed = replaceURLWithHTMLLinks($(this).text());		
		$(this).html(parsed);
	});
	
	$('.toggle-button span').click(function(){		
		$(this).parent('a').next().toggle();
		
		//replace minus with plus and vice versa
		if ($(this).attr('class').indexOf('minus') > 0) {
			$(this).removeClass('glyphicon-triangle-bottom');
			$(this).addClass('glyphicon-triangle-right');
			$('.' + list).hide();
		} else {
			$(this).removeClass('glyphicon-triangle-right');
			$(this).addClass('glyphicon-triangle-bottom');
		}
		return false;
	});
	
	/********** URI PARSING **********/
	//construct HTML links from regular expressions
	function replaceURLWithHTMLLinks(text) {
		var exp = /(\b(https?|ftp|file):\/\/[-A-Z0-9+&@#\/%?=~_|!:,.;]*[-A-Z0-9+&@#\/%=~_|])/ig;
		return text.replace(exp, constructLink);
	}
	function constructLink(match, p1, offset, string) {
		return "<a href='" + p1 + "'>" + p1 + "</a>";
	}
});