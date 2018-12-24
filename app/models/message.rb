class Message < ApplicationRecord
  default_scope { order(created_at: :desc).limit(50) }
  validates :body, presence: true
  
  belongs_to :user
  belongs_to :room

  after_create_commit :broadcast_message

  private

  def broadcast_message
    MessageBroadcastJob.perform_later(self)
  end
end
