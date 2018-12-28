require "rails_helper"

RSpec.describe MessageBroadcastJob, type: :job do
  it "broadcasts message" do
    ActiveJob::Base.queue_adapter = :test
    message = create(:message)
    expect {
      MessageBroadcastJob.perform_later(message)
    }.to have_enqueued_job
  end
end
