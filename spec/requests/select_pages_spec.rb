require 'spec_helper'

describe 'PicturesSelectPages' do
  describe 'GET /pictures/select' do
    before { @title = '写真選定' }

    describe 'ページタイトル' do
      it "は#{@title}" do
        visit pictures_select_path
        expect(page).to have_title(@title)
      end
    end
  end
end
