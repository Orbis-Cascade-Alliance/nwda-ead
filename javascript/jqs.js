$(document).ready(function () {
	$('.toggle-button span').click(function () {
		var list = $(this).parent('a').attr('id').split('-')[1] + '-content';
		$('.' + list).toggle();
		
		//replace minus with plus and vice versa
		//replace show/hide glyphicons
		
		if ($(this).hasClass('glyphicon-triangle-bottom')) {
			$(this).removeClass('glyphicon-triangle-bottom');
			$(this).addClass('glyphicon-triangle-right');
			$('.' + list).hide();
		} else {
			$(this).removeClass('glyphicon-triangle-right');
			$(this).addClass('glyphicon-triangle-bottom');
		}
		return false;
	});
	
	
	/*
	
	This file is used by the Item Page
	It is responsible for the "in-document" search and moving the Table of Contents
	By jean.francois.lauze@gmail.com
	Last revision: July 7 2015
	
	 */
	
	
	var originalHtml;
	
	$(document).ready(function () {
		
		// decorate the TOP links
		$('a[href="#top"] *').attr('style', '');
		$('a[href="#top"]').addClass('backtotop pull-right');
		
		//var originalTopTop = $('.toc-fixed').css('top');
		
		// move the Table of Contents
		$('.toc-fixed').prepend('<div><input type="text" class="form-control" id="innersearch" placeholder="Search this document" /></div><div id="searchinfo"></div>');
		
		// Bind the [search this document] textbox
		$('#innersearch').change(function () {
			innersearch($(this).val());
		});
		
		// load the available digital objects
		//digitalobjects();
		
		// remember this document without tags
		originalHtml = $('#docBody').html();
		
		// this will make the Table of Contents stick to the left when we scroll down the page...
		$('#headerlogotxt').unbind();
		$('#headerlogotxt').appear();
		$(document.body).on('disappear', '#headerlogotxt', function (e, $affected) {
			$('.toc-fixed').addClass('toc-fixed-top');
		});
		$(document.body).on('appear', '#headerlogotxt', function (e, $affected) {
			$('.toc-fixed').removeClass('toc-fixed-top');
		});
		
		window.scrollTo(0, 0);
	});
	
	
	function innersearch(term) {
		
		// search in the document for words begining with "term"
		var sterm2 = new RegExp(" " + term, 'gi');
		// preceded by a space
		var sterm1 = new RegExp("\>" + term, 'gi');
		// preceded by a html tag
		var sterm3 = new RegExp("	" + term, 'gi');
		// preceded by a Tab
		
		// restore document without markup
		$('#docBody').html(originalHtml);
		
		// query needs to be at least 2 characters
		if (term.length > 1) {
			// mark the search term in all valid elements
			$('#docBody p, #docBody td div, #docBody dd, #docBody dt, #docBody a, #docBody h1, #docBody h2, #docBody h3, #docBody h4, #docBody li').each(function () {
				$(this).html($(this).html().replace(sterm1, '<span class="innersearchterm">' + term + '</span>'));
				$(this).html($(this).html().replace(sterm2, '<span class="innersearchterm">' + term + '</span>'));
				$(this).html($(this).html().replace(sterm3, '<span class="innersearchterm">' + term + '</span>'));
			});
			
			// mark the parent elements of the found items
			$('.innersearchterm').each(function () {
				$(this).parent().addClass('found-passage');
			});
			
			// show info...
			var cnt = $('.innersearchterm').length;
			$('#searchinfo').html(cnt + ' results. <a href="javascript:clearsearch();">clear</a>');
		} else {
			$('#searchinfo').html('Please enter at least 2 characters!');
			$('#innersearch').select();
		}
	}
	
	function clearsearch() {
		$('#innersearch').val('');
		$('#searchinfo').html('');
		$('#docBody').html(originalHtml);
	}
});
