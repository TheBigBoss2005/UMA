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
end
