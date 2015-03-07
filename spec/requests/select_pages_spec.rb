require 'spec_helper'

describe 'PicturesSelectPages' do
  describe 'GET /pictures/select' do
    title = '写真選定'

    before do
      10.times { FactoryGirl.create(:picture) }
    end

    describe 'ページタイトル' do
      it "は#{title}" do
        visit pictures_select_path
        expect(page).to have_title(title)
      end
    end

    describe '写真が未登録の時' do
      describe 'メイン部分' do
        it '写真が未登録である旨のメッセージが表示される' do
          Picture.delete_all
          visit pictures_select_path
          expect(page).to have_content('写真が存在しません')
        end
      end
    end

    describe '写真が登録済の時' do
      describe 'メイン部分' do
        it '２つのボタンが表示される' do
          visit pictures_select_path
          expect(page).to have_selector('button#left img')
          expect(page).to have_selector('button#right img')
        end
      end

      describe '左側ボタン押下時' do
        it '写真選定画面が更新される' do
          visit pictures_select_path
          click_button 'left'
          expect(page).to have_title(title)
        end
      end

      describe '右側ボタン押下時' do
        it '写真選定画面が更新される' do
          visit pictures_select_path
          click_button 'right'
          expect(page).to have_title(title)
        end
      end
    end
  end
end
