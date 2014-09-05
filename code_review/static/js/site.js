// This is going to hole all the non-ajax javascript stuff.
// Thought it would be easier to seperate it all

$(document).ready( function() {

    // jquery test code
    $("#logout").click(function() {
	console.log("logout");
    });
    

    $("#appTest").click(function() {
	console.log("app");
	var data = $(this).val();
	var html = "<p> Test </p>";
	$(this).parent().html(html);
	var next = "<li><button href=\"#\" id=\"appTest\">Test</button></li>"; 
	$("#testList").append(next);
	$(this).attr("id", "saved");
    });
    
    // I couldn't find a real way to add classes to django forms
    // so I used jquery to add them based on the input id tag
    $("input[id$=date_0]").addClass("datepicker");
    $("input[id$=date_1]").addClass("timepicker");

    // Initialises the date and time pickers and gives them
    // the correct formats to meet the models standards
    $(".datepicker").datepicker({ dateFormat: "yy-mm-dd" });
    $(".timepicker").timepicker({ 'timeFormat': 'H:i:s'});

});

function annotationHighlight() {
  console.log("Even In Death I Still Serve");
    
  //So say we have some list or array of start points
    var array = [1,3,5,7,9];
    //We could run this function over that array and it 
    //would find and highlight all start points as per the
    //.highlight css class
    var text = '2';

    for(z = 0; z < array.length; z++) {
      $( '.linenos' ).html( function ( i, html ) {
          var regexp, replacement;
          regexp = RegExp( '(' + array[z] + ')' );
          replacement = '<span class="highlight">$1</span>';
          return html.replace( regexp, replacement );
      });
    }

}



