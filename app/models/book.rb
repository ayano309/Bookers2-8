class Book < ApplicationRecord
  belongs_to :user
  has_many :comments ,dependent: :destroy
  has_many :favorites, dependent: :destroy
  validates :title, presence: true
  validates :body, presence: true, length: { maximum: 200 }

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  def self.looks(search, word)
    if search == "perfect_match"
      @book = Book.where("title LIKE?","#{word}")
    elsif search == "forward_match"
      @book = Book.where("title LIKE?","#{word}%")
    elsif search == "backward_match"
      @book = Book.where("title LIKE?","%#{word}")
    elsif search == "partial_match"
      @book = Book.where("title LIKE?","%#{word}%")
    else
      @book = Book.all
    end
  end

  #特定の日に保存されたレコードを取得する
  #今日の投稿数
  scope :created_today, -> { where(created_at: Time.zone.now.all_day) }
  #前日の投稿数
  scope :created_yesterday, -> { where(created_at: 1.day.ago.all_day) }
  #今週の投稿数,all_weeks
  scope :created_this_week, -> { where(created_at: 6.day.ago.beginning_of_day..Time.zone.now.end_of_day) } 
  #先週の投稿数
  scope :created_last_week, -> { where(created_at: 2.week.ago.beginning_of_day..1.week.ago.end_of_day) } 


  #７日間の投稿データ取得
  scope :created_2day_ago, -> { where(created_at: 2.day.ago.all_day) } # 2日前
  scope :created_3day_ago, -> { where(created_at: 3.day.ago.all_day) } # 3日前
  scope :created_4day_ago, -> { where(created_at: 4.day.ago.all_day) } # 4日前
  scope :created_5day_ago, -> { where(created_at: 5.day.ago.all_day) } # 5日前
  scope :created_6day_ago, -> { where(created_at: 6.day.ago.all_day) } # 6日前
  
  
  #リファクタリング
  # scope :created_days_ago, ->(n) { where(created_at: n.days.ago.all_day) }

 #0~6になってしまうので、反転させるためにreverse
  # def self.past_week_count
  #   (1..6).map { |n| created_days_ago(n).count }.reverse
  # end
end