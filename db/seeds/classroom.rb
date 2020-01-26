teacher = Teacher.create!(
  name: "huga",
  email: "huga@gmail.com",
  password: "password",
  password_confirmation: "password"
)

classroom = teacher.classrooms.create!(
  name: '1年A組',
  classroom_code: "1111"
)

30.times do |i|
  classroom.students.create!(
    name: "hoge#{i + 1}",
    email: "hoge#{i + 1}@example.com", 
    password: "password",
    password_confirmation: "password",
  )
end