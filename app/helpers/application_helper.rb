module ApplicationHelper
  def nav_link text, url, options = {}
    current = current_page?(url)
    content_tag :li, class: ['nav-item', ('active' if current)].join(' ') do
      link_to url, options.merge(class: "#{options[:class]} nav-link") do
        safe_join [text, ((content_tag(:span, ' (current)', class: 'sr-only') if current) || '')]
      end
    end
  end

  def moderation_text_with_badge
    safe_join ['Moderation', ' ', content_tag(:span, Job.unpublished.count, class: 'badge badge-default job-unpublished-count')]
  end

  def render_marked_up_description(content, format:)
    case format
    when '.html'
      sanitize_content(content)
    when '.md'
      GitHub::Markup.render(format, content).html_safe
    else
      sanitize_content(auto_link(simple_format(content, {}, sanitize: false), sanitize: false))
    end
  end

  private
  
    def sanitize_content(content)
      white_list_sanitizer.sanitize(Loofah.fragment(content).tap { |x| x.scrub!(:prune) }.to_s, tags: %w(a div p strong b i em blockquote ul ol li table tr td thead tbody br)).html_safe
    end

    def white_list_sanitizer
      Rails::Html::WhiteListSanitizer.new
    end
end
