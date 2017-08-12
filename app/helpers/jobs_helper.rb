module JobsHelper
  def render_job_badge(job)
    badge_class = case job.job_type
                  when 'full_time'
                    'badge-success'
                  when 'part_time'
                    'badge-info'
                  when 'internship'
                    'badge-danger'
                  when 'temporary', 'contract', 'rfp'
                    'badge-warning'
                  else
                    'badge-secondary'
                  end
    link_to job.job_type.humanize, type_jobs_path(job_type: job.job_type), class: "badge #{badge_class}"
  end
end
