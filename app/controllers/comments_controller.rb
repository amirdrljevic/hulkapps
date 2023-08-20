class CommentsController < ApplicationController
  before_action :get_post
  before_action :logged_in_user, only: [:create, :destroy]

  # GET /comments or /comments.json
  def index
    @comments = @post.comments
  end

  # GET /comments/new
  def new
    @post = Post.find(params[:id])
    @comment = @post.comments.build(comment_params)
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments or /comments.json
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user

    respond_to do |format|
      if @comment.save
        format.html { redirect_to post_path(@post), notice: "Comment created." }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { redirect_to post_path(@post), notice: "Comment cannot be empty!" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1 or /comments/1.json
  def destroy
    @comment = @post.comments.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to post_path(@post), notice: "Comment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def get_post
      @post = Post.find(params[:post_id])
    end

    def comment_params
      params.require(:comment).permit(:user_id, :post_id, :comment)
    end

    #Only logged in user can post a comment. Check this before entering the create action. 
    def logged_in_user
      unless user_signed_in?
        respond_to do |format|
          format.html { redirect_to post_path(@post), notice: 'You must be logged in to post a comment.' }
          format.json { head :no_content }      
        end
      end    
    end
end
