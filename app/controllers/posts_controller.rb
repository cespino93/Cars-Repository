class PostsController < ApplicationController
    before_action :redirect_if_not_logged_in

    def new
    if params[:user_id] && @user = User.find_by_id(params[:user_id])
        @post = @user.posts.build
    else
        @post = Post.new
    end
        @post.build_brand
  end

    def index
    if params[:user_id] && @user = User.find_by_id(params[:user_id])
        @posts = @user.posts.alpha
    else
        @error = "That user doesn't exist" if params[:user_id]
        @posts = Post.alpha.includes(:brand, :user)
    end
        @posts = @posts.search(params[:q].downcase) if params[:q] && !params[:q].empty?
        @posts = @posts.filter(params[:post][:brand_id]) if params[:post] && params[:post][:brand_id] != ""
  end

    def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to posts_path
    else
      render :new
    end
  end

  def edit
    @post = Post.find_by_id(params[:id])
    redirect_to posts_path if !@post || @post.user != current_user
    @post.build_brand if !@post.brand
  end

  def update
    @post = Post.find_by(id: params[:id])
    redirect_to posts_path if !@post || @post.user != current_user
    if @post.update(post_params)
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def show
    @post = Post.find_by_id(params[:id])
    redirect_to posts_path if !@post
  end

  private

  def post_params
    params.require(:post).permit(:title,:content, :brand_id, brand_attributes: [:name])
  end
end