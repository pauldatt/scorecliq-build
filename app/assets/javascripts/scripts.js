// the following code is for the flash messages
$(document).ready(function(){ 
   $('.alert').delay(1500).slideUp(500);
});

// the following code is for the responsive navbar

$(document).ready(function(){
    $(".mobile-nav-icon").on("click", function(){ 
        var nav = $('.main-nav');
        var icon = $('.mobile-nav-icon i');
        
        nav.slideToggle();
        
        if (icon.hasClass('fa-bars')){
           icon.switchClass('fa-bars','fa-times'); 
        }
        else
        {
            icon.switchClass('fa-times','fa-bars');
        }
        
    });
});

//the following code is to make the pagination work by ajax on the scoreboard index page



// the following buttons toggle between the score-app div and the schedule div

$(document).ready(function(){
     $(".schedule-app-button").on("click", function(){
        $(".app-score-div").hide();
        $(".score-app-options").hide();
        $(".schedule-app-options").show(300);
        $(".app-schedule-div").show(300);
    });
 });
 
 $(document).ready(function(){
     $(".score-app-button").on("click", function(){ 
        $(".app-schedule-div").hide();
        $(".schedule-app-options").hide();
        $(".score-app-options").show(300);
        $(".app-score-div").show(300);
    });
 });
// the following buttons make the score-app function work 

$(document).ready(function (){ 
      $(".add-new-team-button").on("click", function(){
        $(".orig").hide(300);
        $(".finish-adding-team-button").show(300);
        $(".new-team-form").show();
        $(".form-1").focus();
        $(".score-app").scrollTop(1E10);
        $(".score-app")[0].scrollIntoView({
            block: "end"
        });
    });
});

 $(document).ready(function(){
      $(".finish-adding-team-button").on("click", function(){
          $(".finish-adding-team-button").hide();
          $(".new-team-form").hide();
          $(".orig").show(300);
      });
 });
 
 $(document).ready(function(){
      $(".edit-teams-button").on("click", function(){
          $(".orig").hide();
          $(".finish-edit-team-button").show(300);
          $(".boxin3").show(300);
      });
 });
 
 $(document).ready(function(){
      $(".finish-edit-team-button").on("click", function(){
          $(".finish-edit-team-button").hide();
          $(".orig").show(300);
          $(".boxin3").hide(300);
      });
 });
 


 //score app  code ends 
 
  //the follow code is for the User Profile Page 

 
 
 //the following codes after this line make the schedule app work & includes code to make modal work 
 //the code to make the pagination work is also included 
 
$(document).ready(function(){
    $("#add-match").click(function(){
        $("#match-modal").modal();
    });
});
 
$(document).ready(function(){
      $(".edit-schedule-button").on("click", function(){
          $(".orig2").hide();
          $(".finish-edit-schedule-button").show(300);
          $(".sched-buttons").show(300);
      });
 });
 
$(document).ready(function(){
      $(".finish-edit-schedule-button").on("click", function(){
          $(".finish-edit-schedule-button").hide();
          $(".orig2").show(300);
          $(".sched-buttons").hide(300);
      });
 });
 

$(function(){
  $(".all-schedules").on("click", ".pagination a", function(){
    $.getScript(this.href);
    return false;
  });
});


// the code for the schedule app ends here  



// Below is the code for images. The code makes the images appear inside the modal

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


$(document).ready(function(){
    var preview = $(".upload-preview img");
    
    $(".hidden").change(function(event){
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

// below is the code for the status update in place editing
$(document).ready(function(){
    $(".best_in_place").best_in_place();
});

//below is the code for scoreboard show page menu


$(document).ready(function(){
     $(".schedule-app-button").on("click", function(){
        $(".app-score-div").hide();
        $(".score-app-options").hide();
        $(".schedule-app-options").show(300);
        $(".app-schedule-div").show(300);
    });
 });
 
 $(document).ready(function(){
     $(".score-app-button").on("click", function(){ 
        $(".app-schedule-div").hide();
        $(".schedule-app-options").hide();
        $(".score-app-options").show(300);
        $(".app-score-div").show(300);
    });
 });


// this is the code for the dynamic states in the create scoreboard form
$(document).ready(function(){
$('#country').on('change', function() {
    if ($('option:selected', this).val() === 'Canada') {
        $("#american_states").hide();
        $("#other_states").hide();
        $("#canadian_provinces").show();
    } else {
        $("#other_states").show(); // only if Canada isn't selected
        $("#canadian_provinces").hide();
    }
    
});
  
});
    
$(document).ready(function(){
$('#country').on('change', function() {
    if ($('option:selected', this).val() === 'United States of America'){
        $("#canadian_provinces").hide();
        $("#other_states").hide();
        $("#american_states").show();
    } else {
        $("#american_states").hide();
    }
    
  });
  
});

