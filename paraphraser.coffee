$ ->
  id = ->
    Math.random().toString().slice(2, 10)

  output = (words) ->
    sentenceId = id()
    $('#output').append '<ul id='+sentenceId+'></ul>'
    selIndex = 0
    for word in words
      if word instanceof Array
        $('<li><select class="select'+selIndex+'"></select></li>').appendTo 'ul#'+sentenceId
        for w in word
          $('<option>' + w + '</option>').appendTo 'ul#'+sentenceId+' select.select'+selIndex
        selIndex++
      else
        $('ul#'+sentenceId).append '<li>' + word + '</li>'

  $('form#input').submit (e) ->
    e.preventDefault()
    $.post 'http://localhost:5000/paraphrase', {"text": $('#text').val()}, (data) ->
      output JSON.parse data
