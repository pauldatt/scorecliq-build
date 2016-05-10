// This file contains the code for the custom dialog messages

$(document).ready(function(){
    
    $.rails.allowAction = function(link) {
          if (!link.attr('data-confirm')) {
            return true;
          }
          $.rails.showConfirmDialog(link);
          return false;
    };

    $.rails.confirmed = function(link) {
      link.removeAttr('data-confirm');
      if(link.hasClass("reset-link")){
         window.location.replace("" + link.attr('href') + "");
      } else {
          return link.trigger('click.rails');
      }
      };
     
     
     $.rails.showConfirmDialog = function(link) {
          var html, message;
          message = link.attr('data-confirm');
          html = "<div class=\"modal\" id=\"dialog-confirm\">\n<div class=\"modal-dialog\">\n<div class=\"modal-content\">\n<div class=\"modal-header\">\n       <p> Warning! <p>\n</div>\n<div class=\"modal-body\">\n   <p> " + message + " <p>\n</div>\n<div class=\"modal-footer\">\n   <a data-dismiss=\"modal\" class=\"btn unconfirm\">Cancel</a>\n   <a data-dismiss=\"modal\" class=\"btn btn-primary confirm\">OK</a>\n</div>\n</div>\n</div>\n</div>";
          $(html).modal();
          return $('#dialog-confirm .confirm').on('click', function() {
            return $.rails.confirmed(link);
          });
          };
});

//Custom alert box 

$(document).ready(function(){
  
  window.alert = function (message) {
     html = "<div class=\"modal\" id=\"dialog-confirm\">\n<div class=\"modal-dialog\">\n<div class=\"modal-content\">\n<div class=\"modal-header\">\n       <p> ALERT! <p>\n</div>\n<div class=\"modal-body\">\n   <p> " + message + " <p>\n</div>\n<div class=\"modal-footer\">\n   <a data-dismiss=\"modal\" class=\"btn unconfirm\">CLOSE</a>\n </div>\n</div>\n</div>\n</div>";
     $(html).modal();
  };
  
});

