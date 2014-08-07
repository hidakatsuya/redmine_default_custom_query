FactoryGirl.define do
  factory :issue_query do
    sequence(:name) {|n| "IssueQuery#{n}"}

    user_id { User.current.id }

    if ::Redmine::VERSION.to_s < '2.4'
      trait :private do
        is_public false
      end

      trait :public do
        is_public true
      end
    else
      trait :private do
        visibility ::Query::VISIBILITY_PRIVATE
      end

      trait :roles do
        visibility ::Query::VISIBILITY_ROLES

        before(:create) do |query|
          query.roles << create(:role)
        end
      end

      trait :public do
        visibility ::Query::VISIBILITY_PUBLIC
      end
    end
  end
end
