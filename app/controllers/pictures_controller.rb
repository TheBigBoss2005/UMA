class PicturesController < ApplicationController
  def select
    @left, @right = extract_picture
  end

  private

  def extract_picture
    Picture.all.to_a.sample(2)
  end
end
