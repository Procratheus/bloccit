class Topic < ActiveRecord::Base
  has_many :posts

  ## Will paginate customization
  self.per_page = 20

  validates :name, length: { minimum: 5 }, presence: true
  validates :description, length: { minimum: 20 }, presence: true
end
