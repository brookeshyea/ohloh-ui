FactoryGirl.define do
  factory :alias do
    association :project
    association :commit_name, factory: :name
    association :preferred_name, factory: :name
  end
end
