class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :follower, class_name: "Relationship", foreign_key:"follower_id", dependent: :destroy #ユーザーとフォロ-先を結ぶ
  has_many :followed, class_name: "Relationship", foreign_key:"followed_id", dependent: :destroy #ユーザーとフォロ‐してくれた人を結ぶ
  has_many :following_users, through: :follower, source: :followed #どういうこと？
  has_many :follower_users, through: :followed, source: :follower #どういうこと？

  	# ユーザーをフォローする
	def follow(user_id)
  		follower.create(followed_id: user_id)
	end

	# ユーザーのフォローを外す
	def unfollow(user_id)
  		follower.find_by(followed_id: user_id).destroy
	end

	# フォローしていればtrueを返す
	def following?(user)
  		following_users.include?(user)
	end


  attachment :profile_image, destroy: false

  #バリデーションは該当するモデルに設定する。エラーにする条件を設定できる。
  validates :name, length: {maximum: 20, minimum: 2}
  validates :introduction, length: {maximum: 50}
end
