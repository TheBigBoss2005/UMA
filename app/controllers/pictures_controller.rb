class PicturesController < ApplicationController
  def select
    redirect_to root_path unless session[:user_id]
    @pictures = Picture.extract
    @user = User.find_by(id: session[:user_id])
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

  def choose
    picture = Picture.find_by(id: params[:id])
    if picture.toggle(:choosed).save
      render json: { success: true, total_choosed: Picture.total_choosed }, status: :ok
    else
      render json: { success: false }, status: :ok
    end
  end
end
