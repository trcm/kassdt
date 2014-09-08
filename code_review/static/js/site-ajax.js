$(document).ready(function() {
    console.log("Ajax Standing by");
    // As always i'm going to make an assumption here with which selector i'm using
    $("#ajaxTest").click(function() {
	console.log("Creating annotation");
	// sent post request with all the information in it
	var requestcontext = {'thing': "stuff1"};
	$.ajax({
	    url:"/review/annotation/create/",
	    data: requestcontext,
	}).done(function(data) {
	    // if successful, then change the html
	    console.log(data);
	    console.log("done");
	}).fail(function(data) {
	    // handling a failed ajax request
	    console.log(data);
	    console.log("fail");
	}).always(function(data) {
	    console.log("congratulations, you just made an ajax call");
	    $("#ajaxTest").html(data + "Ajax");
	});
    });
});
