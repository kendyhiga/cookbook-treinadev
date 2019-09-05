FactoryBot.define do
  factory :user do
    name { 'John Doe' }
    email { 'john.doe@email.com' }
    password { '123456' }
  end
end
