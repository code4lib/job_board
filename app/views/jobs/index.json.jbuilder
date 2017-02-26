json.links do
  json.self jobs_url(page: @jobs.current_page)
  json.next jobs_url(page: @jobs.next_page) if @jobs.next_page
  json.last jobs_url(page: @jobs.total_pages)
end

json.data do
  json.array! @jobs, partial: 'jobs/job', as: :job
end
