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

