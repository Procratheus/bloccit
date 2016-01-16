class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  ## Relationships
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :questions, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :favorites, dependent: :destroy

  ## Image uploading and processing
  mount_uploader :avatar, AvatarUploader

  ## Roles
  def admin?
    role == 'admin'
  end

  def moderator?
    role == 'moderator'
  end

  ## Favorites
  def favorited(post)
    favorites.where(post_id: post.id).first
  end

  ## votes partial arrow
  def voted(post)
    votes.where(post_id: post.id).first
  end
end
