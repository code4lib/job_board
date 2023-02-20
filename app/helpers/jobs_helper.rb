module JobsHelper
  def render_job_badge(job)
    badge_class = case job.job_type
                  when 'full_time'
                    'bg-success'
                  when 'part_time'
                    'bg-info'
                  when 'internship'
                    'bg-danger'
                  when 'temporary', 'contract', 'rfp'
                    'bg-warning'
                  else
                    'bg-secondary'
                  end
    link_to job.job_type.humanize, type_jobs_path(job_type: job.job_type), class: "badge #{badge_class}"
  end
end
