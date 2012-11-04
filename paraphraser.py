import operator

from pprint import pprint
from nltk.tokenize import word_tokenize
from nltk.tag import pos_tag
from nltk.corpus import wordnet as wn

def concat(lists):
  if lists == []:
    return []
  return reduce(operator.add, lists)

def tag(sentence):
  words = word_tokenize(sentence)
  words = pos_tag(words)
  return words

def paraphraseable(tag):
  return tag.startswith('NN') or tag == 'VB'

def pos(tag):
  if tag.startswith('NN'):
    return wn.NOUN
  elif tag.startswith('V'):
    return wn.VERB

def synonyms(word, tag):
  return set(concat([w.lemma_names for w in wn.synsets(word, pos(tag))]))

def synonymIfExists(sentence):
  for (word, t) in tag(sentence):
    if paraphraseable(t):
      syns = synonyms(word, t)
      if syns:
        if len(syns) > 1:
          yield list(syns)
          continue
    yield word

def paraphrase(sentence):
  return [x for x in synonymIfExists(sentence)]

if __name__ == '__main__':
  pprint(paraphrase("This house is made of red brick"))
