$(function(){
	//highlight current page
  $('a').each(function() {
    if ($(this).prop('href') == window.location.href) {
      $(this).addClass('current');
    }
  });

    $( "#accordion" ).accordion({
	collapsible: true,
	autoHeight: false,
	activate: function( event, ui ) {
	    var h = accordHeight();
	    console.log(h);
	    $(".ui-accordion-content-active").css('height', h);
	}
    });

   var accordHeight = function() {
     var h = $("p#comment").height() + 200;
     return h;
   };
});



