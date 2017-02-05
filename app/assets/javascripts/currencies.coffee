# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

@swapCurrencies = ->
  from = document.getElementById("from").value
  to = document.getElementById("to").value
  document.getElementById("from").value = to.toString()
  document.getElementById("to").value = from.toString()