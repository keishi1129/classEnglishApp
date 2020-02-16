crumb :root do
  link "トップページ", root_path
end

crumb :mypage do
  link "マイページ", student_mypage_path(current_student.id)
end

crumb :teacher_mypage do
  link "先生ページ", teacher_mypage_path(current_teacher.id)
end

crumb :teacher_classrooms do
  link "クラス一覧", teacher_classrooms_path(current_teacher.id)
  parent :teacher_mypage
end

crumb :classroom do |classroom|
  classroom = Classroom.find_by(id: params[:id] || params[:classroom_id])
  link classroom.name, classroom_path(classroom)
  parent :teacher_classrooms
end

crumb :new_teacher_classrooms_student do
  link "生徒登録", new_classroom_student_path(current_teacher.id)
  parent :teacher_classrooms
end

# crumb :edit_student do
#   link "生徒編集", edit_student_path
#   parent :classroom
# end

# crumb :projects do
#   link "Projects", projects_path
# end

# crumb :project do |project|
#   link project.name, project_path(project)
#   parent :projects
# end

# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).



