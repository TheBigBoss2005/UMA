class Picture < ActiveRecord::Base
  validates :path, presence: true

  class << self
    def extract
      random(2)
    end

    def random(count)
      all_pics = all.to_a
      zero_pics = where(total_count: 0).to_a
      case zero_pics.count
      when 0
        all_pics.sample(count)
      when 1..(count - 1)
        (zero_pics << all_pics.sample(count - zero_pics.count)).shuffle
      else
        zero_pics.sample(count)
      end
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
        from_date = Date.new(year) + 3.month
        to_date = Date.new(year).yesterday.next_year + 3.month - 1.day
        where(choosed: true, date: from_date..to_date).count
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
