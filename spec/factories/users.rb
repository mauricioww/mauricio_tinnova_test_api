FactoryBot.define do
  factory :user, class: User do 
    name        { 'Admin' }
    last_name   { 'Admin' }
    username    { 'admin' }
    email       { 'admin@factoro_test.com' } 
    password    { 'admin' }
    password_confirmation {'admin'}
  end
end