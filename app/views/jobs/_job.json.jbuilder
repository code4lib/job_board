json.extract! job, :id, :title, :origin, :url, :description, :user, :type, :telecommute, :employer, :location, :contact, :published, :created_at, :updated_at
json.url job_url(job, format: :json)
