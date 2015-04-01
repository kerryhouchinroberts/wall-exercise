class PostsController < ApplicationController

  def index
    @posts = Post.all
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @posts, notice: 'Wall post was successfully created.'}
        format.js {}
        format.json { render json: @posts, status: :created, location: @post}
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  def post_params
    params.require(:post).permit(:name, :status)
  end
end
