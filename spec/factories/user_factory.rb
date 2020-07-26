# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    id { 2 }
    email { 'test@test.pl' }
    roles { 'user' }
    name { 'Pawel' }
    surname { 'Deweloper' }
    password { 'hunter2' }
  end
end
