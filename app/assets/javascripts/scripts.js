//Flash messages
$(document).ready(function(){ 
  $('.alert').delay(3000).slideUp(500);
});

//search queries for new members
$(document).ready(function(){
   $("#member-search-form input").keyup(function() {
    $.get($("#member-search-form").attr("action"), $("#member-search-form").serialize(), null, "script");
    return false;
  });
});

//search queries for admin select
$(document).ready(function(){
   $("#admin-search-form input").keyup(function() {
    $.get($("#admin-search-form").attr("action"), $("#admin-search-form").serialize(), null, "script");
    return false;
  });
});

//search queries for followers
$(document).ready(function(){
   $("#follower-search-form input").keyup(function() {
    $.get($("#follower-search-form").attr("action"), $("#follower-search-form").serialize(), null, "script");
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

// SCOREBOARD PROFILE PAGE /USER PROFILE PAGE IMAGES
// Below is the code for images. The code makes the images appear inside the modal

$(document).ready(function(){ 
    $("#score-prof-upload").click(function(){
      $("#files").click();
    });
});


$(document).ready(function(){
    

$('#files').on('change', function() {
     var size_in_megabytes = this.files[0].size/1024/1024;
     if (size_in_megabytes < 3) {
      $("#picmodal").modal('show');
     } else {
        alert('Maximum file size is 3MB. Please choose a smaller file.');
     }
 });
});

// this is a javascipt code for pictures
$(document).ready(function(){
    var preview = $(".upload-preview img");
    
    $("#files").change(function(event){
       var input = $(event.currentTarget);
       var file = input[0].files[0];
       var reader = new FileReader();
       reader.onload = function(e){
           $('#image')
                    .attr('src', e.target.result)
                    .width(307)
                    .height(317);
           image_base64 = e.target.result;
           preview.attr("src", image_base64);
       };
       reader.readAsDataURL(file);
       
    });
});

// BELOW IS THE CODE FOR SCOREBOARD PROFILE

$(document).ready(function(){
    $(".best_in_place").best_in_place();
});

//BELOW IS THE CODE FOR TEAM MATCHES 

$(document).ready(function() {
   $('#datepicker').datetimepicker({format: 'LL'});
});

//BELOW IS THE CODE FOR EVENTS 
$(document).ready(function() {
   $('#event-datepicker').datetimepicker({format: 'LL'});
});

//the code for edit events 
$(document).ready(function() {
   $('#event-edit').datetimepicker({format: 'DD/MM/YYYY'});
});

//BELOW IS THE CODE FOR TOPICS AND COMMENTS 
$(document).ready(function(){ 
    
    $(".post-comment").click(function(){
      $("#new-comment-entry")[0].reset();
      $(".new-comment-form").show();
    });
    
    $(".hide-comment").click(function(){
      $(".new-comment-form").hide();
    });
    

    $('.comment-list').on('click', '.hide-reply-form', function() {
    $(".comment-reply-form").hide();
    });
});

// $(document).ready(function(){ 
//   if ($('#infinite-scrolling').size() > 0) {
//     return $(window).on('scroll', function() {
//       var more_posts_url;
//       more_posts_url = $('.pagination .next_page a').attr('href');
//       if (more_posts_url && $(window).scrollTop() > $(document).height() - $(window).height() - 60) {
//         $('.pagination').html('<img src="/assets/ajax-loader.gif" alt="Loading..." title="Loading..." />');
//         $.getScript(more_posts_url);
//       }
//       return;
//     });
//   }
// });

  




