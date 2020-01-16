teacher = User.create!(
  name: "huga",
  email: "huga@example.com",
  admin: "true",
  password: "password",
  password_confirmation: "password"
)

group = teacher.groups.create!(
  name: '3年A組'
)

30.times do |i|
  group.users.create!(
    name: "hoge#{i + 1}",
    email: "hoge#{i + 1}@example.com", 
    password: "password",
    password_confirmation: "password",
  )
end