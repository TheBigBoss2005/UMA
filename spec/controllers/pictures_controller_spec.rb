require 'spec_helper'

describe PicturesController do
  describe '#extract_picture' do
    before do
      10.times { FactoryGirl.create(:picture) }
    end

    describe '写真が登録済の時' do
      it '写真がランダムに抽出される' do
        get :select
        @pictures = Picture.all
        expect(@pictures).to include(assigns(:left))
        expect(@pictures).to include(assigns(:right))
      end
    end
  end
end
