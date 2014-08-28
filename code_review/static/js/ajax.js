// This will hold all the ajax calls we'll need to make

$(document).ready(function() {
    console.log("Goliath standing by");

    $(".reviewFile").click(function() {
	console.log("Red File standing by");
	$("#annotations").empty();

	// grab the file uuid and add it to the context dict
	var uuid = $(this).attr("data-fileuuid");
	var dict = {"uuid" :uuid };
	var route = "/review/file";

	$.ajax({
	    url: route,
	    data: dict
	}).done(function(data) {
	    var json = $.parseJSON(data);
	    console.log(json);
	    // console.log(data);
	    // the formatted code will always be the first
	    // item in the json struct
	    $("#code").html(json[0]);
	    $("#annotationForm").css("visibility", "visible");
	    // get the information from the annotations
	    // creates the annotation list items with the range and the text
	    // this is grabbed from the parsed json
	    console.log(json[1].length);
	    for (var i = 1; i < json.length; i++) {
		var annote = "<li id=\"" + i + "\">" +
			json[i][0][1]["start"] + " - " +
			json[i][0][1]["end"] + ": " +
			json[i][0][0]["text"] +
			"</li>"; 
		$("#annotations").append(annote);
		// $("#annotationFormItem").insertBefore(annote);
		console.log(json[i][0][0]["text"]);
		console.log(json[i][0][1]["start"]);
		console.log(json[i][0][1]["end"]);
	    }

	    console.log("Completed");
	}).fail(function(data) {
	    console.log("failed");
	    console.log(data);
	}).always(function(data) {
	});
    });
    
    $("#annotationForm").submit(function(e) {
	e.preventDefault();
	console.log("Ajax standing by");
	// $.ajax({
	//     url: '/review/annotation_test/',
	//     data: '1'
	// }).done(function(data) {
	//     console.log(data);
	//     $("#mutherfuckingCode").html(data);
	//     console.log("firing ajax");
	// }).always(function(data) {
	//     console.log("ajax complete");
	// });
    });

});

