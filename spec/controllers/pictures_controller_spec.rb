require 'spec_helper'

describe PicturesController do
  describe '#select' do
    describe '写真が未登録のとき' do
      it '例外が発生すること' do
        expect { get :select }.to raise_error
      end
    end
  end

  describe '#iine' do
    describe '正常な入力のとき' do
      before do
        User.delete_all
        @user = FactoryGirl.create(:user)
        session[:user_id] = @user.id
        @another_user = FactoryGirl.create(:user)
        Picture.delete_all
        3.times { FactoryGirl.create(:picture) }
        @iine, @not_iine, @out_of_selection = Picture.all
        params = {
          iine_id: @iine.id,
          picture_ids: [@iine.id, @not_iine.id]
        }
        post :iine, params
      end

      describe 'いいね対象の写真' do
        it 'の「いいね回数」がカウントアップされる' do
          expect { @iine.reload }.to change(@iine, :iine_count).by(1)
        end

        it 'の「トータル評価回数」がカウントアップされる' do
          expect { @iine.reload }.to change(@iine, :total_count).by(1)
        end
      end

      describe 'いいね対象でない写真' do
        it 'の「いいね回数」は変化しない' do
          expect { @not_iine.reload }.not_to change(@not_iine, :iine_count)
        end

        it 'の「トータル評価回数」がカウントアップされる' do
          expect { @not_iine.reload }.to change(@not_iine, :total_count).by(1)
        end
      end

      describe '選定対象外の写真' do
        it 'の「いいね回数」は変化しない' do
          expect { @out_of_selection.reload }.not_to change(@out_of_selection, :iine_count)
        end

        it 'の「トータル評価回数」は変化しない' do
          expect { @out_of_selection.reload }.not_to change(@out_of_selection, :total_count)
        end
      end

      describe '選択中のユーザ' do
        it 'の「選択回数」がカウントアップされる' do
          expect { @user.reload }.to change(@user, :selection_count).by(1)
        end
      end

      describe '選択中以外のユーザ' do
        it 'の「選択回数」は変化しない' do
          expect { @another_user.reload }.not_to change(@another_user, :selection_count)
        end
      end
    end
  end
  describe '#choose' do
    before do
      @picture = FG.create(:picture)
    end
    it 'はchooseがトグルされて確定写真の総数が返却されること' do
      expect(@picture.choosed).to be_false

      post :choose, id: @picture.id

      expect(Picture.find(@picture.id).choosed).to be_true
      result = JSON.parse(response.body)
      expect(result['success']).to be_true
      expect(result['total_choosed']).to eq(1)
    end
  end
end
