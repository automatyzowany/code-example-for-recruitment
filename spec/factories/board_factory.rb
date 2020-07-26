# frozen_string_literal: true

FactoryBot.define do
  factory :board do
    id { 17 }
    board_name { 'Produkcja' }
    board_type { 'prywatna' }
    board_layout { 1 }
    deleted_at { nil }
  end
end
