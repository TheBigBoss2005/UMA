class ManageController < ApplicationController
  def list
    only_choosed = params[:only_choosed] == 'true'
    page_size = 30
    @ranking_offset = calc_ranking_offset(page_size)
    @pictures = only_choosed ? Picture.choosed : Picture.ranking(page_size, params[:page])
    @total_choosed = Picture.total_choosed
    @years_choosed = (2005..2015).each_with_object({}) do |year, res|
      res[year.to_s] = Picture.total_choosed(year)
    end
  end

  private

  def calc_ranking_offset(page_size)
    page_size * ((params[:page] || 1).to_i - 1)
  end
end
