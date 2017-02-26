# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

dump_file = ENV['DUMP_FILE'] || Rails.root + 'tmp' + 'dump' + 'jobs.json'

Job.delete_all
Job.where(origin: dump_file.to_s).delete_all

old_jobs_data = JSON.parse(File.read(dump_file))
old_jobs_data.each do |job|
  Job.create(
    id: job['id'],
    origin: dump_file.to_s,
    title: job['title'],
    description: job['description'],
    description_markup: '.html',
    url: job['url'],
    telecommute: job['telecommute'],
    job_type: job['type'].underscore,
    contact: job['contact']['name'],
    location: job['location']['name'],
    published: job['published'].present?,
    created_at: job['published'],
    published_at: job['published'],
    employer_name: job['employer']['name'],
    tag_list: job['subjects'].map { |x| x['name'] }.join(',')
  )
end
