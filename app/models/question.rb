class Question < ActiveRecord::Base
  belongs_to :users
  has_many :answers, dependent: :destroy
end
