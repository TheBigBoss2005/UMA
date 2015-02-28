class Picture < ActiveRecord::Base
  validates :path, presence: true
end
