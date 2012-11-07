$ ->
  id = ->
    Math.random().toString().slice(2, 10)

  output = (words) ->
    sentenceId = id()
    $('#output').append '<ul class=dropdown id='+sentenceId+'></ul>'
    for word in words
      if word instanceof Array
        wordId = id()
        $('<li><a href="#" class=dropdown-toggle data-toggle=dropdown>'+word[0]+'</a><ul role=menu class=dropdown-menu id='+wordId+'></ul></li>').appendTo 'ul#'+sentenceId
        for w in word
          $('<li>' + w + '</li>').appendTo 'ul#'+wordId
      else
        $('ul#'+sentenceId).append '<li>' + word + '</li>'

  $('form#input').submit (e) ->
    e.preventDefault()
    $.post 'http://localhost:5000/paraphrase', {"text": $('#text').val()}, (data) ->
      output JSON.parse data
