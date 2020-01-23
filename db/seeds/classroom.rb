teacher = Teacher.create!(
  name: "huga先生",
  email: "huga@gmail.com",
  password: "password",
  password_confirmation: "password"
)

classroom = teacher.classrooms.create!(
  name: '1年A組',
  password: '1111'
)

30.times do |i|
  classroom.students.create!(
    name: "hoge#{i + 1}",
    email: "hoge#{i + 1}@example.com", 
    password: "password",
    password_confirmation: "password"
  )
end