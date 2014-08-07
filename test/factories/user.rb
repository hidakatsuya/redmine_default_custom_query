FactoryGirl.define do
  factory :user do
    sequence(:login, '000') {|n| "user#{n}"}
    sequence(:lastname, '0000')

    firstname 'User'
    status 1
    language 'ja'
    mail {|u| "#{u.login}@example.co.jp" }
    mail_notification 'only_my_events'
    password '12345678'
    password_confirmation {|u| u.password }
    admin false
    type 'User'
  end
end
