class Container < ActiveRecord::Base
  has_many :queued_jobs
  has_many :executable_jobs

  after_create :create_excutable_jobs_from_temmlate

  def create_excutable_jobs_from_temmlate
    TemplateJob.all.each do |template_job|
      self.executable_jobs.create!(
        name: template_job.name,
        template_job: template_job,
        script: template_job.script,
      )
    end
  end
end
