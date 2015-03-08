class Picture < ActiveRecord::Base
  validates :path, presence: true

  def self.extract
    random(2)
  end

  def self.random(count)
    all.to_a.sample(count)
  end

  private_class_method :random
end
