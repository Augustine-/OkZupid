class PostsController < ApplicationController

  def update
    post = current_user.posts.find_by(prompt: params[:post][:prompt])
    if post
      post.update_attributes(post_params)
      redirect_to "/"
    else
      fail
      flash.now[:errors] = ["No such field!"]
      redirect_to "/"
    end
  end
  
  private
  def post_params
    params.require(:post).permit(:prompt, :content)
  end
end