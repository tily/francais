'use strict';

# TODO: does not work properly on pages with jquery.tipsy already loaded
# ex) http://onehackoranother.com/projects/jquery/tipsy/#

format = (results)->
  return '(non trouvée)' if results.length == 0
  html = ''
  for result in results
    #html += '<strong>' + result[0] + '</strong> '
    #text = result.slice(1, 2).join(' ')
    text = result.join(' ')
    texts = text.match(/.{1,100}/g)
    for text in texts
      html += text + '<br />'
  html

search = (word)->
  results = []
  #word = word.replace(/s$/i, '')
  regexp = new RegExp("^" + word, "i")
  for entry in window.Francais
    if entry[0].match(regexp)
      results.push(entry)
  results

show = (params)->
  tipsy = $('<div>')
  $(document.body).append(tipsy)
  tipsy.tipsy(trigger: 'manual', html: true)
  tipsy.css
    position: 'absolute'
    visibility: 'hidden'
    top: $(window).scrollTop() + params.clientRect.top
    left: $(window).scrollLeft() + params.clientRect.left
    width: params.clientRect.width
    height: params.clientRect.height
  tipsy.attr 'title', params.html
  tipsy.tipsy 'show'
  setTimeout ()->
    $(document.body).one 'click', (e)->
      tipsy.tipsy('hide')
      tipsy.remove()
  , 1000

$(window).on 'mouseup', ()->
  selection = window.getSelection()
  clientRect = selection.getRangeAt(0).getBoundingClientRect()
  word = selection.toString()

  return if word == ''

  results = search(word)
  #results = results.slice(0, 10)

  show
    clientRect: clientRect
    html: format(results)
