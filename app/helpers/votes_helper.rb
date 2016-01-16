module VotesHelper

  def upvote_link_classes(post)
    current_user.voted(post).upvote? ? 'voted' : ''
  end

  def downvote_link_classes(post)
    current_user.voted(post).downvote? ? 'voted' : ''
  end

end
