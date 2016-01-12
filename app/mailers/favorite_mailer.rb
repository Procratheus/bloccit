class FavoriteMailer < ApplicationMailer
  
  def new_comment(user, post, comment)

    ## New headers
    headers['Message-ID'] = '<comments/#{comment.id}@fierce-lake-9253.herokuapp.com>'
    headers['In-Reply-To'] = '<post/#{post.id}@fierce-lake-9253.herokuapp.com>'
    headers['References'] = '<post/#{post.id}@fierce-lake-9253.herokuapp.com>'

    @user = user
    @post = post
    @comment = comment

    mail(to: user.email, subject: "New comment on #{post.title}")
  end
end
