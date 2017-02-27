# Preview all emails at http://localhost:3000/rails/mailers/job_mailer
class JobMailerPreview < ActionMailer::Preview
  def single
    JobMailer.single(Job.first)
  end

  def digest
    JobMailer.digest(Job.first(10))
  end
end
