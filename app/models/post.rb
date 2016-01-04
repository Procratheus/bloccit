class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :topic
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy

  ## Scopes
  default_scope { order("rank DESC")}
  scope :ordered_by_title, -> { order("title DESC")}
  scope :ordered_by_reversed_created_at, -> { order("created_at ASC")}

  ## Validations
  validates :user, presence: true
  validates :topic, presence: true
  validates :title, length: { minimum: 5 }, presence: true
  validates :body, length: { minimum: 20 }, presence: true

  ## Image uploading and processing
  mount_uploader :image, ImageUploader

  ## Markdown
  def markdown_title
    render_as_markdown(self.title)
  end

  def markdown_body
    render_as_markdown(self.body)
  end

  ## Votes counters for posts

  def up_votes
    votes.where(value: 1).count
  end

  def down_votes
    votes.where(value: -1).count
  end

  def points
    votes.sum(:value)
  end

  ## Ranking Algorithym
  def update_rank
    age_in_days = (created_at - Time.new(1970,1,1))/(60*60*24)
    new_rank = age_in_days + points
    update_attribute(:rank, new_rank)
  end

  private

    def render_as_markdown(text)
      renderer = renderer = Redcarpet::Render::HTML.new
      extensions = {fenced_code_blocks: true}
      redcarpet = Redcarpet::Markdown.new(renderer, extensions={})
      (redcarpet.render text).html_safe
    end

    def create_vote
      user.votes.create(value: 1, post_id: self.id)
    end
end
