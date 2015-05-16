class ManageController < ApplicationController
  def list
    @pictures = Picture.ranking
    @total_choosed = Picture.total_choosed
    @years_choosed = (2005..2015).each_with_object({}) do |year, res|
      res[year.to_s] = Picture.total_choosed(year)
    end
  end
end
