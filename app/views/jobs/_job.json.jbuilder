json.id job.id
json.attributes do
  json.extract! job, :title, :origin, :url, :description, :job_type, :telecommute, :location, :contact, :published, :created_at, :updated_at, :published_at
end

json.relationships do
  if job.user
    json.user do
      json.data do
        json.extract! job.user, :id
      end
    end
  end

  json.employer do
    json.links do
      json.self employer_url(job.employer)
    end
    json.data do
      json.extract! job.employer, :id, :name
    end
  end
end

json.links do
  json.self job_url(job)
end
