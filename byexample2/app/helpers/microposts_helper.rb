# app/helpers/microposts_helper.rb crfr110925
module MicropostsHelper
  def line(object)
    "<span>#{ link_to object.user.name, @microposts }</span> - <span class='timestamp'>#{ time_ago_in_words(object.created_at) } ago:</span> <span>#{ object.content }</span>"
  end
  def wrap(content)
    sanitize(raw(content.split.map{ |s| wrap_long_string(s) }.join(' ')))
  end

  private
  def wrap_long_string(text, max_width = 50)
    zero_width_space = "&#8203;"
    regex = /.{1,#{max_width}}/
    (text.length < max_width) ? text : text.scan(regex).join(zero_width_space)
  end
end
