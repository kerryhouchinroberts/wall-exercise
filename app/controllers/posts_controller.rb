class PostsController < ApplicationController

  def index
    @posts = Post.all
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.update_attributes(:likes)

    respond_to do |format|
      if @post.save
        #format.html { redirect_to @posts, notice: 'Wall post was successfully created.'}
        format.js {}
        format.json { render json: @post, status: :created, location: @post}
      else
        #format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def like
    @post = Post.find(params[:id])
    @like = @post.increment!(:likes)

    respond_to do |format|
      format.js {}
      format.json { render json: @post, status: :created, location: @post}
    end
  end

  private
  def post_params
    params.require(:post).permit(:name, :status, :likes)
  end
end
