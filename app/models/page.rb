class Page < ApplicationRecord
  scope :board_layout, -> (board_layout) { where board_layout: board_layout }
  scope :board_permissions, -> (get_current_user) { 
    where("board_type = 0 OR (board_type = 1 AND ?=ANY(assigned))", get_current_user)
  }
end
