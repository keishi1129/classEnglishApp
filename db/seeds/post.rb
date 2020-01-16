

file = File.open("#{Rails.root}/public/csv/seed_post.csv")

User.find(1).posts.import(file)
