class Post < ActiveRecord::Base
  has_many :comments
  belongs_to :user

  default_scope { order("created_at DESC")}
  scope :ordered_by_title, -> { order("title DESC")}
  scope :ordered_by_reversed_created_at, -> { order("created_at ASC")}
end
