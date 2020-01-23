# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...


  
# DB設計
<!-- 
## schoolテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null:false (例) ABC小学校英語科


### Association
- has_many :teachers, dependent: :destroy
- has_many :classrooms, dependent: :destroy
- has_many :posts dependent: :destroy
- has_many :cardsets dependent: :destroy
 -->

## teachersテーブル
|Column|Type|Options|
|------|----|-------|
|email|string|null: false|unique: true
|name|string|null:false (名前）
|password|string|null:false (パスワード）
|password_confirmation|string|null:false| 
|school-id|string|foreign_key: true| 

### Association
- has_many :classrooms, dependent: :destroy
- has_many :students, through: :classrooms
- has_many :posts, dependent: :destroy
- has_many :cardsets

## classroomテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null:false  (例）1年A組
|password|string|null:false (パスワード）

### Association
- belongs_to :teacher
- has_many :students, dependent: :destroy

## studentsテーブル
|Column|Type|Options|
|------|----|-------|
|email|string|null: false|unique: true 
|name|string|null:false (名前）
|password|string|null:false (パスワード）
|password_confirmation|string|null:false| 
|classroom-id|string|foreign_key: true|
|vocabulary|integer|default: 0|| 
|WPM|integer|default: 0|| 

### Association
- belong_to :classroom

## cardsetsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null:false (名前）テスト用単語帳
|school-id|string|foreign_key: true| <
|use|integer|default: 1（練習用かテスト用か）| 


### Association
- belongs_to :teacher
- belongs_to :student
- has_many :words, through: :cardset_words
- has_many :duplicated_cardsets, class_name: "DuplicatedCardset", foreign_key: "origin_id",  dependent: :destroy

## duplicated_cardsetsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null:false (名前）テスト用単語帳
|origin-id|string|foreign_key: { to_table: :cardsets }| 

### Association
- has_many :words, dependent: :destroy
- belongs_to :cardset, optional: true
