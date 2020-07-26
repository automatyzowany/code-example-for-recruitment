class Board < ApplicationRecord
  has_many :tests
  belongs_to :companies, optional: true
	board_types = { publiczna: 0, prywatna: 1, shareable: 2 }
  enum board_type: board_types
  
  def self.not_removed
    where(deleted_at: nil)
  end

  def self.unarchived
    where(archived_at: nil)
  end

  def self.archived
    where(deleted_at: nil).where.not(archived_at: nil)
  end

  def soft_delete
    update_attribute(:deleted_at, DateTime.now)
  end

  def soft_archive
    update_attribute(:archived_at, DateTime.now)
  end

  def unarchive
    update_attribute(:archived_at, nil)
  end

	scope :board_layout, -> (board_layout) { where board_layout: board_layout }
	scope :board_permissions, -> (get_current_user) { 
		where("board_type = 0 OR (board_type = 1 AND ?=ANY(assigned))", get_current_user)
	}
end
