class ManageController < ApplicationController
  def list
    only_choosed = params[:only_choosed] == 'true'
    @pictures = only_choosed ? Picture.choosed : Picture.ranking(30, params[:page])
    @total_choosed = Picture.total_choosed
    @years_choosed = (2005..2015).each_with_object({}) do |year, res|
      res[year.to_s] = Picture.total_choosed(year)
    end
  end
end
