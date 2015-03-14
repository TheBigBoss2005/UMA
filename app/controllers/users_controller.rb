class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    # TODO: user情報を常に保持し続ける必要あり(cookieに保持かなぁ)
    # 参考: http://qiita.com/kidachi_/items/ebdb4b29336955903029
    # user = User.find_by(id: params[:id])
    redirect_to controller: :pictures, action: :select
  end
end
