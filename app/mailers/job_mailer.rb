class JobMailer < ApplicationMailer
  def single(job)
    @job = job
    mail(to: Settings.mailers.single.to, subject: "Job: #{job.display_title}")
  end
  
  def digest(jobs)
    @jobs = jobs
    mail(to: Settings.mailers.digest.to, subject: 'Code4Lib Jobs weekly digest')
  end
end
