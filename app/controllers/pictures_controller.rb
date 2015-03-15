class PicturesController < ApplicationController
  def select
    redirect_to root_path unless session[:user_id]
    @pictures = Picture.extract
    fail '写真がありません' unless @pictures
  end

  def iine
    Picture.increment_counter(:iine_count, params[:iine_id])
    params[:picture_ids].each do |picture_id|
      Picture.increment_counter(:total_count, picture_id)
    end
    User.increment_counter(:selection_count, session[:user_id])

    redirect_to select_path
  end
end
