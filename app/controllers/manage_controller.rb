class ManageController < ApplicationController
  def list
    @pictures = Picture.ranking
  end
end
