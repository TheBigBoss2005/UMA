class PicturesController < ApplicationController
  def select
    @pictures = Picture.extract
    fail '写真がありません' unless @pictures
  end
end
