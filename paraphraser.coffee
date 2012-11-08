Word = Backbone.Model.extend()

Sentence = Backbone.Collection.extend
  model: Word

  fromWords: (words) ->
    for word in words
      w = new Word
        name: word[0]
        synonyms: word[1]
      @push w
    return this


WordView = Backbone.View.extend

  tagName: 'li'

  render: ->
    name = @model.get('name')
    synonyms = @model.get('synonyms')
    if synonyms.length > 0
      $(@el).html '<select></select>'
      $select = $('select', @el)
      for synonym in synonyms
        $select.append '<option>' + synonym + '</option>'
    else
      $(@el).html name
    return this


SentenceView = Backbone.View.extend

  el: '#output'

  render: ->
    $(@el).append '<ul></ul>'
    _(@collection.models).each (word) ->
      wordView = new WordView
        model: word
      $('ul', @el).append wordView.render().el
    return this


makeSentence = (words) ->
  sentence = new Sentence
  for word in words
    w = new Word
      name: word[0]
      synonyms: word[1]
    sentence.push w
  sentence

$ ->
  $('form#input').submit (e) ->
    e.preventDefault()
    $.post 'http://localhost:5000/paraphrase', {"text": $('#text').val()}, (data) ->
      words = JSON.parse data
      sentenceView = new SentenceView
        collection: (new Sentence).fromWords words
      sentenceView.render()
