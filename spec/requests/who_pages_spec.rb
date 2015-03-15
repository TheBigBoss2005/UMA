require 'spec_helper'

describe 'WhoPages' do
  describe 'GET /' do
    title = 'あなたは誰？'
    before { 2.times { FG.create(:user) } }
    it "はページタイトルが#{title}である" do
      visit root_path
      expect(page).to have_title(title)
    end

    it 'は登録ユーザが全て表示される' do
      visit root_path
      expect(page.all('.user-line').count).to eq(User.all.count)
    end

    describe 'ユーザ選択時' do
      before { visit root_path }
      it 'は写真を選ぶ画面に遷移する' do
        all('input[type=submit]').each do |submit|
          submit.click
          expect(page).to have_title('写真選定')
        end
      end
    end
  end
end
