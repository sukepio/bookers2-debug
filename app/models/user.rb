class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  attachment :profile_image, destroy: false

  validates :name, length: {maximum: 20, minimum: 2}, uniqueness: true
  validates :introduction, length: {maximum: 50}
  
  # フォロー機能
  has_many :follower, class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy
  has_many :following_user, through: :follower, source: :followed
  has_many :followed, class_name: 'Relationship', foreign_key: 'followed_id', dependent: :destroy
  has_many :follower_user, through: :followed, source: :follower
  
  def follow(user_id)
    follower.create(followed_id: user_id)
  end
  
  def unfollow(user_id)
    follower.find_by(followed_id: user_id).destroy
  end
  
  def following?(user)
    following_user.include?(user)
  end
  
  # 住所自動入力
  
  validates :postcode, presence: true
  validates :prefecture_code, presence: true
  validates :address_city, presence: true
  validates :address_street, presence: true
  
  include JpPrefecture
    jp_prefecture :prefecture_code
    
  def prefecture_name
    JpPrefecture::Prefecture.find(code: prefecture_code).try(:name)
  end
  
  def prefecture_name=(prefecture_name)
    self.prefecture_code = JpPrefecture::Prefecture.find(name: prefecture_name).code
  end  
  
  has_many :user_rooms, dependent: :destroy
  has_many :chats, dependent: :destroy
end
