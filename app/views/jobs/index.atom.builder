xml.instruct!(:xml, :encoding => "UTF-8")

xml.feed("xmlns" => "http://www.w3.org/2005/Atom") do

  xml.title   'code4lib jobs'
  # an author is required, so we'll just use the app name
  xml.author { xml.name 'code4lib jobs' }
  
  xml.link    "rel" => "self", "href" => jobs_url(page: @jobs.current_page)
  xml.id      jobs_url(page: @jobs.current_page)

  # Navigational and context links
  
  xml.link( "rel" => "next", 
            "href" => jobs_url(page: @jobs.next_page)
           ) unless @jobs.last_page?
  
  xml.link( "rel" => "previous", 
            "href" => jobs_url(page: @jobs.prev_page)
           ) unless @jobs.first_page?
           
  xml.link( "rel" => "first", 
            "href" => jobs_url(page: 1))
  
  xml.link( "rel" => "last",
            "href" => jobs_url(page: @jobs.total_pages))

  xml.updated @jobs.first.published_at.iso8601
  
  @jobs.published.each do |job|
    xml.entry do
      xml.title job.title
      xml.updated job.published_at.iso8601
      xml.link("href" => job_url(job))
      xml.id job_url(job)
      
      xml.author { xml.name(job.user&.email) }
      xml.content type: 'html' do |content_element|
        content_element.text! render_marked_up_description(job.description, format: job.description_markup)
      end
    end
  end
end
