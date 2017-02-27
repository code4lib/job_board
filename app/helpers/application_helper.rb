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
      sanitize content
    else
      GitHub::Markup.render(format || '.md', content).html_safe
    end
  end
end
