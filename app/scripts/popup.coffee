'use strict';

$(document).ready ()->
  $('#text').on 'keyup', (e)->
    $('#results').empty()
    text = $(e.target).val()
    return if text == ''
    regexp = new RegExp("^" + text, 'i')
    for entry, i in window.Francais
      #$('body').append i
      #$('body').append regexp + '' + entry[0]
      if entry[0].match(regexp)
        item = $('<li class="list-group-item">').append('<strong>' + entry[0] + '</strong> ', entry.slice(1, 2).join(' '))
        $('#results').append(item)
