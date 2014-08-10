$(document).ready( function() {
    $("#logout").click(function() {
	console.log("logout");
    });
    $("input[id$=date_0]").addClass("datepicker");
    $("input[id$=date_1]").addClass("timepicker");
    $(".datepicker").datepicker({ dateFormat: "yy-mm-dd" });
    $(".timepicker").timepicker({ 'timeFormat': 'H:i:s'});
});

