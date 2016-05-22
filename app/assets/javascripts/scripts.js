//Flash messages
$(document).ready(function(){ 
   $('.alert').delay(3000).slideUp(500);
});

$(document).ready(function(){
    $(".best_in_place").best_in_place();
});

//search queries
$(document).ready(function(){
   $("#member-search-form input").keyup(function() {
    $.get($("#member-search-form").attr("action"), $("#member-search-form").serialize(), null, "script");
    return false;
  });
});

// TEAMS/ STANDINGS PAGE 
$(document).ready(function(){ 
   
   $(".team-create").on("click", function(){ 
       $(".new-team-form").show(100);
       $(".team-name-field").focus();
       $("html, body").animate({ scrollTop: $(document).height() }, 500);
   });


   $(".hide-team-new").on("click", function(){ 
       $("#new-team-entry").trigger("reset");
       $(".new-team-form").hide(100);
   });
   
   
});



