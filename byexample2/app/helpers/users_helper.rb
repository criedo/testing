# app/helpers/_users_helpers.rb crfr110911
module UsersHelper
  def gravatar_for(user, options = { :size => 50 })
    gravatar_image_tag(user.email.downcase, :alt => user.name, :title => user.name, :class => 'gravatar', :gravatar => options)
  end
end
