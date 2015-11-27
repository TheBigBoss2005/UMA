class Picture < ActiveRecord::Base
  validates :path, presence: true

  class << self
    def extract
      random(2)
    end

    def random(count)
      zero_pic_ids = where(total_count: 0).pluck(:id).to_a
      case zero_pic_ids.count
      when 0
        random_from_all(count)
      when 1..(count - 1)
        where(id: zero_pic_ids.sample(count)).push(random_from_all(count - zero_pic_ids.count).to_a).flatten
      else
        where(id: zero_pic_ids.sample(count))
      end
    end

    def random_from_all(count)
      where(id: (first.id..last.id).to_a.sample(count)) if self.count > 0
    end

    def ranking(per_page = 100, page_num = 1)
      iine2_total(per_page, page_num)
    end

    def choosed
      iine2_total(100, 1).where(choosed: true)
    end

    def iine2_total(per_page = 100, page_num = 1)
      # 0除算を避けるためにtotal_countに+1して除算している
      order('((iine_count * 1000) * 2 + 1) / (total_count + 1) desc, iine_count desc').page(page_num).per(per_page)
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

  private_class_method :random, :random_from_all, :iine2_total

  def score
    total_count == 0 ? 0 : ((iine_count * 1000) * 2 + 1) / (total_count + 1)
  end
end
