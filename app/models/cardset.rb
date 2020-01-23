class Cardset < ApplicationRecord
  has_many :cardset_words
  has_many :words, through: :cardset_words, dependent: :destroy
  accepts_nested_attributes_for :words, allow_destroy: true, reject_if: :reject_words
  validates :name, presence: {message: "名前を入力してください"}
  validates :words, length: { minimum: 5, message: "必ず5個は単語を入れてください"}
  belongs_to :student
  has_many :duplicated_cardsets, class_name: "DuplicatedCardset", foreign_key: "origin_id",  dependent: :destroy

  def reject_words(attributes)
    attributes['name'].blank? && attributes['meaning'].blank?
  end

  enum use: {
    練習用:1,
    テスト用:2
  }

  def self.other_origin_cardsets(duplicated_cardsets)
    ids = []
    duplicated_cardsets.each do |cardset|
      ids << cardset.origin.id
    end
    Cardset.where.not(id: ids)
  end

  def duplicate
    duplicated_cardset = DuplicatedCardset.create!(name: self.name, origin_id: self.id)
    self.words.each do |word|
      duplicated_cardset.words << word
    end
    return duplicated_cardset
  end
end
