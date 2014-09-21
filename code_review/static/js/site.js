// This is going to hole all the non-ajax javascript stuff.
// Thought it would be easier to seperate it all

$(document).ready( function() {

    // jquery test code
    $("#logout").click(function() {
	console.log("logout");
    });
    
    //styling login form
    $("#id_username").addClass("form-control");
    $("#id_username").attr("placeholder","Username");
    $("#id_password").addClass("form-control");
    $("#id_password").attr("placeholder","Password");
    
    //styling assignment submission
    $("#id_submission_repository").addClass("form-control");
    
    
    //make drop down draggable
    $("#draggable").draggable({ axis: "y" });    

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

    $(".click").click(function() {
	console.log("click");
	console.log($(this).text());
	$("#id_start").val($(this).text());
    });

});

function annotationHighlight() {
    console.log("Even In Death I Still Serve");
    var arr = $('#startLine ul').map(function(){
        return $(this).text();
    }).get();

    console.log(arr);
    //So say we have some list or array of start points
    var array = [1,3,5,7,9];
    //We could run this function over that array and it 
    //would find and highlight all start points as per the
    //.highlight css class
    var text = '2';
    var s = $('.linenos');
    // s.contents().wrapInner("<i id=\"click\" ></i>");
    
    for(z = 0; z < arr.length; z++) {
	$( '.linenos' ).html( function ( i, html ) {
            var regexp, replacement;
            x = parseInt(arr[z]);
            console.log(x);
            regexp = RegExp( '(' + x + ')' );
            replacement = '<span class="highlight">$1</span>';
            return html.replace( regexp, replacement );
	});
    }
    $(".lineno").each(function() {
	console.log($(this).text());
	$(this).addClass("click");
    });
}



