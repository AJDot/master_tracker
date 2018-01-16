ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
  # this code modified from
  # https://rubyplus.com/articles/3401-Customize-Field-Error-in-Rails-5

  html = %(<div class="field_with_errors">#{html_tag}</div>).html_safe

  form_fields = [
    'textarea',
    'input',
    'select',
  ]

  elements = Nokogiri::HTML::DocumentFragment.parse(html_tag).css "label, " + form_fields.join(', ')

  elements.each do |e|
    if e.node_name.eql? 'label'
      html = %(<div class="danger">#{e}</div>).html_safe
    elsif form_fields.include? e.node_name
      msg = instance.error_message
      msg = msg.uniq.join(', ') if msg.kind_of? Array

      html = %(<div class="danger">#{html_tag}<span class="help-inline">&nbsp;#{msg}</span></div>).html_safe
    end
  end
  html
end
