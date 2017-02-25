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
                    'badge-default'
                  end
    content_tag :div, job.job_type.humanize, class: "badge #{badge_class}"
  end
end
