# frozen_string_literal: true

FactoryBot.define do
  factory :test do
    id { 701 }
    name { 'watch tv for 1 hour' }
    task_status { 'Nie przypisano' }
    board_id { 17 }
    order { 1 }
    task_group { nil }
    user_id { 2 }
    assigned { {} }
    deleted_at { nil }
  end
end
