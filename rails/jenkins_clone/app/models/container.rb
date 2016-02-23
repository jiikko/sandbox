class Container < ActiveRecord::Base
  has_many :queued_jobs
  has_many :executable_jobs

  after_create :create_excutable_job_from_temmlate

  def create_excutable_jobs_from_temmlate
    TemplateJob.all.each do |template_job|
      executable_jobs.create!(
        name: template_job.name,
        script: template_job.script
      )
    end
  end
end
