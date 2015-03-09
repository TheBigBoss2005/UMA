class PicturesController < ApplicationController
  def select
    @pictures = Picture.extract
    fail '写真がありません' unless @pictures
  end

  def iine
    Picture.increment_counter(:iine_count, params[:iine_id])
    params[:picture_ids].each do |picture_id|
      Picture.increment_counter(:total_count, picture_id)
    end

    redirect_to select_path
  end
end
