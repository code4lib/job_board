class JobMailer < ApplicationMailer
  def single(job)
    @job = job
    mail(to: Settings.mailers.single.to, subject: "#{@job.title} at #{@job.employer.name}")
  end
  
  def digest(jobs)
    @jobs = jobs
    mail(to: Settings.mailers.digest.to, subject: 'Code4Lib Jobs weekly digest')
  end
end
