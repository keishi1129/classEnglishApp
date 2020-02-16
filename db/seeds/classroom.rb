teacher = Teacher.create!(
  name: "山田太郎",
  email: "huga@example.com",
  password: "password",
  password_confirmation: "password"
)

classroom = teacher.classrooms.create!(
  name: '1年1組',
  classroom_code: "1111"
)

30.times do |i|
  classroom.students.create!(
    name: "生徒#{i + 1}",
    email: "st#{i + 1}@example.com", 
    password: "password",
    password_confirmation: "password",
  )
end