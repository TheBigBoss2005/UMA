FactoryGirl.define do
  factory :picture do
    sequence(:path) { |n| "/picture#{n}.jpg" }
    iine_count 0
    total_count 0
    choosed false
    date '2015/04/01'
    sequence(:original_path) { |n| "/picture#{n}_original.jpg" }
    original_width 1920
    original_height 1920
  end
end
