# frozen_string_literal: true

FactoryBot.define do
  factory :update do
    id { 343 }
    content { '<p>test content</p>' }
    author { 2 }
    task_id { 701 }
    attachment { nil }
    is_system_update { false }
    deleted_at { nil }
  end
end
