class Post < ActiveRecord::Base
  has_many :comments
  belongs_to :user
  belongs_to :topic

  ## Scopes
  default_scope { order("created_at DESC")}
  scope :ordered_by_title, -> { order("title DESC")}
  scope :ordered_by_reversed_created_at, -> { order("created_at ASC")}

  ## Validations
  validates :user, presence: true
  validates :topic, presence: true
  validates :title, length: { minimum: 5 }, presence: true
  validates :body, length: { minimum: 20 }, presence: true
end
