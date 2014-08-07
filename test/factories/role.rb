FactoryGirl.define do
  factory :role, aliases: [:role_with_manage_default_query] do
    sequence(:name) {|n| "Role#{n}"}
    sequence(:position)
    assignable 1
    builtin 0
    issues_visibility 'all'
    permissions {
      perms = Redmine::AccessControl.permissions -
                Redmine::AccessControl.public_permissions
      perms.map &:name
    }

    factory :role_without_manage_default_query do
      permissions {
        perms = Redmine::AccessControl.permissions -
                  Redmine::AccessControl.public_permissions
        perms.map(&:name) - [:manage_default_query]
      }
    end
  end
end
