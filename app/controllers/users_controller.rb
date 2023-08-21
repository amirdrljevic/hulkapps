class UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :correct_user, only: [:show]
  
    def show
        @user = User.find(params[:id])
        @post_count = @user.posts.count
        @comment_count = @user.comments.count
    end

    private

    def correct_user
        @user = User.find(params[:id])
        unless current_user == @user
          redirect_to root_path, notice: "Access denied! You are not supposed to see other people profiles."
        end
      end
  end
  