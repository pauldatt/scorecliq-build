# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


counter = 1
limit = 3

addInput = (divName) ->
  if counter == limit
    alert 'You have reached the limit of adding ' + counter + ' inputs'
  else
    newdiv = document.createElement('div')
    newdiv.innerHTML = 'Entry ' + counter + 1 + ' <br><input type=\'text\' name=\'myInputs[]\'>'
    document.getElementById(divName).appendChild newdiv
    counter++
  return