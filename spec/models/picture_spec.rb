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
    it 'はある条件に応じて写真を抽出する' do
      sample = FactoryGirl.create(:picture)
      pictures = Picture.extract
      expect(pictures).to include(sample)
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
end
