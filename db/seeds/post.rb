

file = File.open("#{Rails.root}/public/csv/seed_post.csv")

Teacher.first.posts.import(file)
