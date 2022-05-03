class UsersController < ApplicationController
  before_action :authenticate_user!
  def index
    @user = current_user
    @users = User.all
    @book = Book.new
    @books = Book.all

  end

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new

    #特定の日に保存された投稿数
    @today_book = @books.created_today
    @yesterday_book = @books.created_yesterday
    #今週、前週
    @this_week_book = @books.created_this_week
    @last_week_book = @books.created_last_week
  end

  def edit
    @user = User.find(params[:id])
    if current_user != @user
      redirect_to user_path(current_user.id)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user),notice: 'You have updated user successfully.'
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:name,:introduction,:profile_image)
  end
end
