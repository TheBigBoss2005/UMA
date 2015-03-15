FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "uma#{n}" }
    sequence(:icon) { |n| "http://twitter.com/hoge_#{n}" }
  end
end
