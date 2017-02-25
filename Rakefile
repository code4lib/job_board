# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'

Rails.application.load_tasks


task :import, [:file] => [:environment] do |t, args|
  old_jobs_data = JSON.parse(File.read(File.expand_path(ENV['FILE'] || args[:file])))
  old_jobs_data.each do |job|
    Job.create(
      id: job['id'],
      title: job['title'],
      description: job['description'],
      description_markup: '.html',
      url: job['url'],
      telecommute: job['telecommute'],
      type: job['type'].parameterize('_'),
      contact: job['contact']['name'],
      location: job['location']['name'],
      published: job['published'].present?,
      created_at: job['published'],
      published_at: job['published'],
      employer: Employer.find_or_create_by(name: job['employer']['name'])
    )
  end
end
