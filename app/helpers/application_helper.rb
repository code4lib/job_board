module ApplicationHelper
  def nav_link text, url, options = {}
    current = current_page?(url)
    content_tag :li, class: ['nav-item', ('active' if current)].join(' ') do
      link_to url, options.merge(class: "#{options[:class]} nav-link") do
        safe_join [text, ((content_tag(:span, ' (current)', class: 'sr-only') if current) || '')]
      end
    end
  end
end
