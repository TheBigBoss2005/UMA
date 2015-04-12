require 'spec_helper'

describe 'PicturesSelectPages' do
  describe 'GET /select' do
    title = '写真選定'

    before do
      FactoryGirl.create(:user)
      10.times { FactoryGirl.create(:picture) }
    end

    describe 'セッション情報が無いとき' do
      it 'あなたは誰？画面に遷移する' do
        visit select_path
        expect(page).to have_title('あなたは誰？')
      end
    end

    describe 'ページタイトル' do
      it "は#{title}" do
        visit root_path
        find('input[type=submit]').click
        expect(page).to have_title(title)
      end
    end

    describe '写真が未登録の時' do
      describe 'メイン部分' do
        it '写真が未登録である旨のメッセージが表示される' do
          Picture.delete_all
          visit root_path
          find('input[type=submit]').click
          pending 'メッセージ表示はエラーページにて実施(未実装)'
          expect(page).to have_content('写真が存在しません')
        end
      end
    end

    describe '写真が登録済の時' do
      describe 'メイン部分' do
        it '２つのボタンが表示される' do
          visit root_path
          find('input[type=submit]').click
          expect(page.all('button[name=iine_id]').count).to be_equal(2)
        end

        it 'どちらも不要ボタンが表示される' do
          visit root_path
          find('input[type=submit]').click
          expect(page.all('button[name=neither]').count).to be_equal(1)
        end

        it '元画像へのリンクが表示される' do
          visit root_path
          find('input[type=submit]').click
          expect(page.all("a[class='btn btn-info']").count).to be_equal(2)
        end
      end

      (0..2).each do |n|
        describe "#{n + 1}番目のボタン('どちらも不要'ボタン含む)押下時" do
          let(:button) { page.all('button')[n] }
          let(:click) { button.click }

          before do
            visit root_path
            find('input[type=submit]').click
          end

          it '写真選定画面が更新される' do
            click
            expect(page).to have_title(title)
          end
        end
      end
    end
  end
end
