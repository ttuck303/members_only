class PostsController < ApplicationController
  before_action :require_login, only: [:new, :create]

  def new
  	@post = Post.new
  end

  def create
  	@post = Post.new(post_params)
  	@post.user_id = current_user.id
  	if @post.save
  		flash[:success] = "Post saved successfully"
  		redirect_to posts
  	else
  		flash[:danger] = "Incorrect post"
  		render :new
  	end

  end

  def index
  	@posts = Post.all
  end

  private

  	def post_params
  		params.require(:post).permit(:title, :body) 
  	end

end
