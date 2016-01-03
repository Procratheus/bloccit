class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :topic
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy

  ## Scopes
  default_scope { order("created_at DESC")}
  scope :ordered_by_title, -> { order("title DESC")}
  scope :ordered_by_reversed_created_at, -> { order("created_at ASC")}

  ## Validations
  #validates :user, presence: true
  #validates :topic, presence: true
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
    up_votes - down_votes
  end

  private

    def render_as_markdown(text)
      renderer = renderer = Redcarpet::Render::HTML.new
      extensions = {fenced_code_blocks: true}
      redcarpet = Redcarpet::Markdown.new(renderer, extensions={})
      (redcarpet.render text).html_safe
    end
end
