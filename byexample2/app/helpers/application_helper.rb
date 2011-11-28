module ApplicationHelper
  def logo
    logo = image_tag("logo.png", :alt => "Sample App", :class => "round")
  end
  # Return a title on a per-page basis.
  def title
    base_title = "Ruby on Rails Tutorial Sample App"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end
  def reference
    prefix = "<h1>"
    sufix = "</h1>"
    if @reference.nil? && ! @title.nil?
      "#{prefix}#{@title} #{sufix}"
    else
      if ! @reference.nil?
        "#{prefix}#{@reference} #{sufix}"
      end
    end
  end
  def intro
    if @intro.nil?
      ""
    else
      "#{@intro}"
    end
  end
  def logo
    image_tag("logo.png", :alt => "Sample App", :class => "round")
  end
  def img_delete
    image_tag("x-ed.gif")
  end
end
