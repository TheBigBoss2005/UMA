class Picture < ActiveRecord::Base
  validates :path, presence: true

  class << self
    def extract
      random(2)
    end

    def random(count)
      all.to_a.sample(count)
    end

    def ranking(num = 100)
      iine2_total(num)
    end

    def iine2_total(num)
      # 0除算を避けるためにtotal_countに+1して除算している
      limit(num).order('(iine_count * 2 + 1) / (total_count + 1) desc, iine_count desc')
    end

    def total_choosed(year = nil)
      if year
        date = Date.new(year)
        where(choosed: true, date: date..date.yesterday.next_year).count
      else
        where(choosed: true).count
      end
    end
  end

  private_class_method :random, :iine2_total

  def score
    total_count == 0 ? 0 : iine_count * 2 / total_count
  end
end
