module ApplicationHelper
  def form_group_tag(errors, &block)
    if errors.any?
      content_tag :div, capture(&block), class: "form-group has-error"
    else
      content_tag :div, capture(&block), class: "form-group"
    end
  end

  def upvote_link_classes(post)
    current_user.voted(post).upvote? ? 'voted' : ''
  end

  def downvote_link_classes(post)
    current_user.voted(post).downvote? ? 'voted' : ''
  end


end
