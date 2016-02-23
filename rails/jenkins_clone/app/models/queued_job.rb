class QueuedJob < ActiveRecord::Base
  belongs_to :container
  belongs_to :template_job
end
