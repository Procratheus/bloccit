class Topic < ActiveRecord::Base
  has_many :posts, dependent: :destroy

  # Scopes for public and private topics
  scope :visible_to, -> (user) { user ? privately_viewable : publicly_viewable }
  scope :publicly_viewable, -> { where(public:true) }
  scope :privately_viewable, -> { where(public: true) && where(public: false) }

  ## Will paginate customization
  self.per_page = 20

  validates :name, length: { minimum: 5 }, presence: true
  validates :description, length: { minimum: 20 }, presence: true
end
