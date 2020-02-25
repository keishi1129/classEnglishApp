json.array! @messages do |message|
  json.content message.content
  json.image message.image.url
  json.date message.created_at.to_s
  json.name message.student.name
  json.id message.id
end