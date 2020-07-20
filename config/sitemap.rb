SitemapGenerator::Sitemap.default_host = "https://jobs.code4lib.org"
SitemapGenerator::Sitemap.create do
  Job.recent.find_each do |job|
    add job_path(job), lastmod: job.updated_at
  end

  Employer.with_published_jobs.find_each do |employer|
    add employer_path(employer), lastmod: employer.updated_at
  end
end
