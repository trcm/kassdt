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

    // $("#annotationForm").hide();
});

function annotationHighlight() {
    console.log("Even In Death I Still Serve");
     var arr = $('#startLine ul').map(function(){
         return $(this).text();
     }).get();

     console.log(arr);
     //So say we have some list or array of start points
     //We could run this function over that array and it 
     //would find and highlight all start points as per the
     //.highlight css class
     var text = '2';
     var s = $('.linenos');
      s.contents().wrapInner("<i id=\"click\" ></i>");
    
    for(z = 0; z < arr.length; z++) {
      $( '.lineno' ).html( function ( i, html ) {
        var regexp, replacement;
        x = parseInt(arr[z]);
        //console.log(x);
        regexp = RegExp( '(' + x + ')' );
        replacement = '<span class="highlight">$1</span>';
        return html.replace( regexp, replacement );
      });
    }
    $(".lineno").each(function() {
	    console.log($(this).text());
	    $(this).addClass("click");
    });
    $("#annotationForm").hide();

    $(".click").click(function() {
      p = parseInt( $(this).text());
      console.log(p);
      $("input[name*='start']").val(p); 

      $("#annotationForm").show();
      $("#annotationForm #id_text").focus();
    });

    $("form[id^='editForm']").each(function() {
      console.log("form hide");
      $(this).hide();
    });

    $("a[id^='saveBtn']").each(function() {
      $(this).hide();
    });

    $("a[id^='cancelBtn']").each(function() {
      $(this).hide();
    });  /*  */
   
    $("a[id^='editBtn']").click(function() {
      $(this).prev("form").show();
      $(this).next("a[id^='saveBtn']").show();
      $(this).next("a[id^='cancelBtn']").show();
      $(this).hide();
      $(this).next('div[id^=showEditBtns]').show();
      console.log("show");
    });

}



