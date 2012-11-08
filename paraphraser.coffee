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

  events:
    'click .name'        : 'showOptions'
    'click .synonyms li' : 'select'

  render: ->
    name = @model.get('name')
    synonyms = @model.get('synonyms')
    if synonyms.length > 0
      $(@el).html _.template $('#synonym-word').html(),
        name: name
        synonyms: synonyms
    else
      $(@el).html _.template $('#simple-word').html(),
        name: name
    @in('.synonyms').hide()
    return this

  in: (elem) -> $(elem, @el)

  showOptions: ->
    @in('.synonyms').toggle()

  select: (e) ->
    selected = $(e.target).text()
    @in('.name').html selected
    @in('.synonyms').hide()


SentenceView = Backbone.View.extend

  el: '#output'

  render: ->
    $(@el).append '<ul class=word></ul>'
    _(@collection.models).each (word) ->
      wordView = new WordView
        model: word
      $('ul.word', @el).append wordView.render().el
    return this


$ ->
  $('form#input').submit (e) ->
    e.preventDefault()
    $.post 'http://localhost:5000/paraphrase', {"text": $('#text').val()}, (data) ->
      words = JSON.parse data
      sentenceView = new SentenceView
        collection: (new Sentence).fromWords words
      $('#output').html ''
      sentenceView.render()
