$(document).ready(function() {
    console.log("Goliath standing by");
    console.log("Red 5 standing by");

    $("#reviewFile").click(function() {
	console.log("Red File standing by");
	var uuid = $(this).attr("fileUuid");
	var route = "/review/annotation_test";
	$.ajax({
	    url: route,
	    data: uuid
	}).done(function(data) {
	    $("#code").html(data);
	}).always(function(data) {
	    console.log(data);
	    console.log("ajax Complete");
	});
	    
    });
    
    $("#createAnnotation").click(function() {
	console.log("Ajax standing by");

	$.ajax({
	    url: '/review/annotation_test/',
	    data: '1'
	}).done(function(data) {
	    console.log(data);
	    $("#mutherfuckingCode").html(data);
	    console.log("firing ajax");
	}).always(function(data) {
	    console.log("ajax complete");
	});
    });

});
