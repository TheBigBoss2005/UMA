require 'spec_helper'

describe PicturesController do
  describe '#select' do
    describe '写真が未登録のとき' do
      it '例外が発生すること' do
        get :select
        expect(get :select).to raise_error
      end
    end
  end
end
