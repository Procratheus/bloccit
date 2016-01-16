class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :post

  ## Validations
  validates :value, inclusion: { in: [1,-1], message: "%{value} is not a valid vote."}

  ## Callbacks
  after_save :update_post

  def upvote?
    value == 1
  end

  def downvote?
    value == -1
  end

  private

    def update_post
      post.update_rank
    end
end
