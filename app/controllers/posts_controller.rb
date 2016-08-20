class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :owned_post, only: [:edit, :update, :destroy]
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.order('created_at desc')
  end

  def show
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      flash[:success] = "Post created."
      redirect_to posts_path
    else
      flash[:alert] = "Oops! Something went wrong. Please check the form and try again."
      render :new
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      flash[:success] = "Post updated."
      redirect_to post_path(post)
    else
      flash.now[:alert] = "Update failed. Please check the form."
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:id, :image, :caption, :user_id)
  end

  def owned_post
    unless current_user == @post.user
      flash[:alert] = "That post doesn't belong to you, asshole!"
      redirect_to root_path
    end
  end

end
