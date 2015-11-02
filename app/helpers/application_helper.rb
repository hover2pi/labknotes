module ApplicationHelper

  def title(page_title)
    content_for(:title) { page_title }
  end

  def possessive(name)
    name =~ /s$/ ? "#{name}'" : "#{name}'s"
  end

  def no_current_link(name, options = {}, html_options = {}, *parameters_for_method_reference)
    html_options[:class] = "no-link" if current_page?(options)
    link_to(name, options, html_options, *parameters_for_method_reference)
  end

end
