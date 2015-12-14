// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require jquery-ui
//= require bootstrap
//= require turbolinks
//= require_tree.

$(document).ready(function(){
    $(".score-text").mouseover(function(){
      $(this).css('background', '#C0C0C0');
    });
     $(".score-text").mouseleave(function(){
      $(this).css('background', '#FFFFFF');
    });
 });

// the following code is for the flash messages
$(document).ready(function(){ 
   $('.alert').delay(1500).slideUp(500);
});

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
 
 // form code for the datepicker 
 
 $(document).ready(function(){
     $(".datepicker").datepicker( {dateFormat: "yy-mm-dd"});
 });
 
 
 //score app  code ends 
 
 //the following codes after this line make the schedule app work 
 
 $(document).ready(function (){ 
      $(".add-new-schedule-button").on("click", function(){
        $(".orig2").hide(300);
        $(".finish-adding-schedule-button").show(300);
        $(".new-schedule-form").show();
        $(".team1-form").focus();
    });
});

$(document).ready(function(){
    $(".finish-adding-schedule-button").on("click", function(){
          $(".finish-adding-schedule-button").hide();
          $(".new-schedule-form").hide();
          $(".orig2").show(300);
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
// the code for the schedule app ends here  



// below is the js for images
 
 $(document).ready(function(){
     $("#files").change(function(){
         $("#modal-1").modal('show');
     });
 });
 
 $(document).ready(function(){
    $('#pictureframe').popover({html: true});   
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
                    .width(300)
                    .height(300);

           image_base64 = e.target.result;
           preview.attr("src", image_base64);
       };
       reader.readAsDataURL(file);
       
    });
});

