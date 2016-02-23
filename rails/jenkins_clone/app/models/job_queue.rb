class JobQueue < ActiveRecord::Base
  belongs_to :container
  belongs_to :job_template
end
