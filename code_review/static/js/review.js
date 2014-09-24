$(function(){

	//highlight current page
  $('a').each(function() {
    if ($(this).prop('href') == window.location.href) {
      $(this).addClass('current');
    }
  });

  $( "#accordion" ).accordion();
});