class Room < ApplicationRecord
  scope :visible, -> { where(hidden: false) }
  validates :title, presence: true

  has_many :messages, dependent: :destroy
end
