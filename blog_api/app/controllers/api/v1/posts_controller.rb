class Api::V1::PostsController < ApplicationController
  before_action :set_post, only: %i[show update destroy]

  def index
    @posts = Post.all
    render json: @posts
  end

  def show
    render json: @post
  end

  def create
    @post = Post.new post_params
    if @post.save
      render json: @post, status: :created
    else
      render json: @post.errors, status: :unprocessable_entity # 422
    end
  end

  def update
    if @post.update(post_params)
      render json: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    # requireでPOSTで受け取る値のキーを設定
    # permitで許可するカラムを設定
    params.require(:post).permit(:title, :content)
  end
end
