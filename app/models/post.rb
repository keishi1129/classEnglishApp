class Post < ApplicationRecord
  has_rich_text :content
  validates :title, presence: true
  validates :content, presence: true
  belongs_to :teacher, optional: true
  belongs_to :student, optional: true


  def self.csv_attributes
    ["title", "url", "content", "created_at", "updated_at"]
  end

  def self.generate_csv
    CSV.generate(headers: true) do |csv|
      csv << csv_attributes
      all.each do |post|
        csv << csv_attributes.map{|attr| post.send(attr)}
      end
    end
  end

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      post = new
      post.attributes = row.to_hash.slice(*csv_attributes)
      post.save!
    end
  end

  enum use: {
    練習用:1,
    テスト用:2
  }

end
