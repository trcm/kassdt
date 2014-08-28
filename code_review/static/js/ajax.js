// This will hold all the ajax calls we'll need to make

$(document).ready(function() {
    console.log("Goliath standing by");
    console.log("Red 5 standing by");

    $(".reviewFile").click(function() {
	console.log("Red File standing by");
	var uuid = $(this).attr("data-fileuuid");
	var dict = {"uuid" :uuid };
	var route = "/review/file";
	$.ajax({
	    url: route,
	    data: dict
	}).done(function(data) {
	    $("#code").html(data);
	    console.log("Completed");
	}).fail(function(data) {
	    console.log("failed");
	    console.log(data);
	}).always(function(data) {
	    console.log($(this));
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
