class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]
  before_action :logged_in_user, only: [:new, :create, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

  # GET /posts or /posts.json
  def index
    if params[:my_posts]&.present? && params[:my_posts] == "true" 
      @posts = current_user.posts.includes(:comments).paginate(page: params[:page], per_page: 2)
    else
      @posts = Post.includes(:comments).paginate(page: params[:page], per_page: 2)
    end
  end

  # GET /posts/1 or /posts/1.json
  def show
    @post = Post.find(params[:id])
    @posts = Post.limit(7).order('id desc') #to populate the sidebar
    @comment = @post.comments.build
    @comment.user = current_user
    @comments = @post.comments.paginate(page: params[:page], per_page: 3)
  end

  # GET /posts/new
  def new
    @post = current_user.posts.build
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts or /posts.json
  def create
    @post = current_user.posts.build(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to post_url(@post), notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to post_url(@post), notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    if @post.comments.any?
      redirect_to @post, notice: "Cannot delete a post with comments."
    else
      @post.destroy
      respond_to do |format|
        format.html { redirect_to posts_url, notice: "Post was successfully deleted." }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :description, :user_id)
    end

    #Only logged in user can create a post. Check this before entering the create action. 
    def logged_in_user
      unless user_signed_in?
        respond_to do |format|
          format.html { redirect_to posts_path, notice: 'You must be logged in to create a post.' }
          format.json { head :no_content }      
        end
      end    
    end

    def correct_user
      @post = current_user.posts.find_by(id: params[:id])
      redirect_to posts_path, notice: "Not authorized to edit or delete this post" if @post.nil?
    end
end
