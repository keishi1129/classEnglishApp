json.array! @words do |word|
  json.id  word.id
  json.name  word.name
  json.meaning word.meaning
end