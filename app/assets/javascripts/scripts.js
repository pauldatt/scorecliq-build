// TEAMS/ STANDINGS PAGE 

$(document).ready(function(){ 
   $(".team-create").on("click", function(){ 
       $(".new-team-form").show(100);
       $(".team-name-field").focus();
       $("html, body").animate({ scrollTop: $(document).height() }, 500);
   });
});

$(document).ready(function(){ 
   $(".hide-team-new").on("click", function(){ 
       $("#new-team-entry").trigger("reset");
       $(".new-team-form").hide(100);
   });
});

