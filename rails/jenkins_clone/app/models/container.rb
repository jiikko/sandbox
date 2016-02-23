class Container < ActiveRecord::Base
  has_many :job_queues
end
