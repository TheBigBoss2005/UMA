FactoryGirl.define do
  factory :picture do
    sequence(:path) { |n| "/picture#{n}.jpg" }
    sequence(:original_path) { |n| "/picture#{n}_original.jpg" }
    original_width 1920
    original_height 1920
  end
end
