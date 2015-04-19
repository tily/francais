'use strict';
# 前の検索を無効化する

DEBUG = true

debug = ()->
  console.log.apply console, arguments if DEBUG

protocol = ()->
  location.href.match(/^(https?):/)
  RegExp.$1

toDefinition = (data)->
  text = ''
  for e, i in data
    text += [e.mid, e.hat, e.yak, e.yor].join(" ") + "<br>"
  text

tipsy = null

$(window).on 'mouseup', (e)->
  selection = window.getSelection()
  clientRect = selection.getRangeAt(0).getBoundingClientRect()
  word = selection.toString()

  return if word == ""
  debug "[francais] word: ", word, ", clientRect: ", clientRect

  tipsy = $("<div>francais</div>")
  $(document.body).append(tipsy)
  tipsy.tipsy(trigger: 'manual').css
    position: 'absolute'
    visibility: 'hidden'
    top: clientRect.top - 15
    left: clientRect.left
  tipsy.attr 'title', "Un instant ..."
  tipsy.tipsy "show"
  $(document.body).on 'click', (e)->
    tipsy.tipsy("hide")

  url = protocol() + "://francais-proxy.herokuapp.com/"
  debug "[francais] url: ", url

  $.get url, {erab: 'tango', ktype: 1, mado: word}, (data)->
    debug "[francais] data: ", data
    if data.length == 0
      definition = '(non trouvée)'
    else
      definition = toDefinition(data)
    debug "[francais] definition: ", definition
    tipsy.attr 'title', definition
    tipsy.tipsy "show"
  , 'json'

