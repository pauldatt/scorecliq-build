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
//= require jquery_ujs
//= require bootstrap
//= require turbolinks
//= require_tree.

$(document).on('page:change', function(){
    $(".score-text").mouseover(function(){
      $(this).css('background', '#C0C0C0');
    });
     $(".score-text").mouseleave(function(){
      $(this).css('background', '#FFFFFF');
    });
 });


$(document).on('page:change', function(){
    $(".add-new-team-button").on("click", function(){
        $(".new-team-form").show();
    });
 });

$(document).on('page:change', function(){
     $(".done-add").on("click", function(){
        $(".new-team-form").hide();
    });
 });