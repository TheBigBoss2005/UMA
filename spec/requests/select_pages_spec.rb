require 'spec_helper'

describe 'PicturesSelectPages' do
  describe 'GET /select' do
    title = '写真選定'

    before do
      10.times { FactoryGirl.create(:picture) }
    end

    describe 'ページタイトル' do
      it "は#{title}" do
        visit select_path
        expect(page).to have_title(title)
      end
    end

    describe '写真が未登録の時' do
      describe 'メイン部分' do
        it '写真が未登録である旨のメッセージが表示される' do
          Picture.delete_all
          visit select_path
          pending 'メッセージ表示はエラーページにて実施(未実装)'
          expect(page).to have_content('写真が存在しません')
        end
      end
    end

    describe '写真が登録済の時' do
      describe 'メイン部分' do
        it '２つのボタンが表示される' do
          visit select_path
          expect(page.all('button').count).to be_equal(2)
        end
      end

      (0..1).each do |n|
        describe "#{n + 1}番目のボタン押下時" do
          let(:button) { page.all('button')[n] }
          let(:click) { button.click }

          before { visit select_path }

          it '写真選定画面が更新される' do
            click
            expect(page).to have_title(title)
          end
        end
      end
    end
  end
end
