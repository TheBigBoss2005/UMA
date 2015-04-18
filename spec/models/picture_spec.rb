require 'spec_helper'

describe Picture do
  before { @picture = FactoryGirl.build(:picture) }

  subject { @picture }

  it { expect(subject).to respond_to(:path) }
  it { expect(subject).to respond_to(:iine_count) }
  it { expect(subject).to respond_to(:total_count) }
  it { expect(subject).to respond_to(:choosed) }
  it { expect(subject).to respond_to(:date) }
  it { expect(subject).to respond_to(:original_path) }
  it { expect(subject).to respond_to(:original_width) }
  it { expect(subject).to respond_to(:original_height) }

  it { expect(Picture).to respond_to(:extract) }

  describe '#path' do
    it 'は空文字列不可' do
      @picture.path = ' '
      expect(subject).not_to be_valid
    end
  end

  describe '#extract' do
    context '評価回数が0の写真を含む場合' do
      it 'はその写真が優先して抽出される' do
        zero1  = FactoryGirl.create(:picture, total_count: 0)
        zero2  = FactoryGirl.create(:picture, total_count: 0)
        pictures = Picture.extract
        expect(pictures).to include(zero1, zero2)
      end
    end

    context '評価回数が0の写真を含まない場合' do
      it 'はある条件に応じて写真を抽出する' do
        sample = FactoryGirl.create(:picture)
        pictures = Picture.extract
        expect(pictures).to include(sample)
      end
    end
  end

  describe '#ranking' do
    describe '#iine2_total' do
      before do
        @no1 = FG.create(:picture, iine_count: 2, total_count: 2)
        @no2 = FG.create(:picture, iine_count: 1, total_count: 1)
        @no3 = FG.create(:picture, iine_count: 1, total_count: 2)
        @no4 = FG.create(:picture, iine_count: 0, total_count: 2)
      end
      it 'はiine * 2 / total_countで同着の場合はiine獲得数でソートされること' do
        pictures = Picture.send(:iine2_total, 4)
        expect(@no1).to eq(pictures.first)
        expect(@no2).to eq(pictures.second)
        expect(@no3).to eq(pictures.third)
        expect(@no4).to eq(pictures.fourth)
      end
    end
  end

  describe '#score' do
    before do
      @picture1 = FG.create(:picture, iine_count: 1, total_count: 1)
      @picture2 = FG.create(:picture, iine_count: 0, total_count: 0)
    end
    it 'は適切な値が返却されること' do
      expect(@picture1.score).to eq(2)
      expect(@picture2.score).to eq(0)
    end
  end

  describe '#total_choosed' do
    before do
      @picture0 = FG.create(:picture, date: '2005/3/30', choosed: true)
      @picture1 = FG.create(:picture, date: '2005/4/1', choosed: true)
      @picture2 = FG.create(:picture, date: '2010/1/1', choosed: true)
      @picture3 = FG.create(:picture, date: '2010/1/1', choosed: false)
    end
    it 'は引数がない場合に選択写真の総数が返却されること' do
      expect(Picture.total_choosed).to eq(3)
    end
    it 'は引数がある場合に指定年度の選択写真の総数が返却されること' do
      expect(Picture.total_choosed(2005)).to eq(1)
    end
    it 'は写真の日付が取得出来なかった選択写真の総数が返却されること' do
      pending 'ふなのExif情報の調査結果を踏まえて対応'
    end
  end
end
