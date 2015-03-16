class Picture < ActiveRecord::Base
  validates :path, presence: true

  def self.extract
    random(2)
  end

  def self.random(count)
    all.to_a.sample(count)
  end

  def self.ranking(num = 100)
    iine2_total(num)
  end

  def self.iine2_total(num)
    # 0除算を避けるためにtotal_countに+1して除算している
    limit(num).order('(iine_count * 2 + 1) / (total_count + 1) desc, iine_count desc')
  end

  private_class_method :random, :iine2_total

  def score
    total_count == 0 ? 0 : iine_count * 2 / total_count
  end
end
