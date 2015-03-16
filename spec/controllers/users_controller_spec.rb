require 'spec_helper'

describe UsersController do
  describe '#show' do
    describe 'ユーザ選択時' do
      before do
        User.delete_all
        @user = FactoryGirl.create(:user)
      end

      it 'セッションにidが保存されること' do
        get :show, id: @user.id
        expect(session[:user_id]).to eq(@user.id)
      end
    end
  end
end
