module ApplicationHelper

  def render_js_template(template)
    content_tag :script, type: "text/x-handlebars-template", id: "js_template_#{template}" do
      render partial: template
    end
  end
  
end
