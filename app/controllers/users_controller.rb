class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    session[:user_id] = params[:id].to_i
    redirect_to controller: :pictures, action: :select
  end
end
