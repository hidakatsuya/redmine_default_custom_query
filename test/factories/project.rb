FactoryGirl.define do
  factory :project do
    sequence(:name) {|n| "Project#{n}"}
    sequence(:identifier) {|n| "project-#{n}"}

    trait :with_default_custom_query do
      after(:create) do |project|
        create :default_custom_query_module, project: project
      end
    end
  end
end
