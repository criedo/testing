class PagesController < ApplicationController
  def home
    if signed_in?
      @title = "Microposts"
      @reference = "What's up?"
      @micropost = Micropost.new
      @feed_items = current_user.feed.paginate(:page => params[:page])
      @user_img = true
    else
      @title = "Home"
      @reference = "Sample App"
      @intro = "<p>This is the home page for the <a href='http://railstutorial.org/'>Ruby on Rails Tutorial</a> sample application.</p>"
    end
  end
  def contact
    @title = "Contact"
    @intro = "<p>Contact Ruby on Rails Tutorial about the sample app at the <a href='http://railstutorial.org/feedback'>feedback page</a>.</p>"
  end
  def about
    @title = "About"
    @reference = "About Us"
    @intro = "<p><a href='http://railstutorial.org/'>Ruby on Rails Tutorial</a> is a project to make a book and screencasts to teach web development with <a href='http://rubyonrails.org/'>Ruby on Rails</a>. This is the sample application for the tutorial.</p>"
  end
  def help
    @title = "Help"
    @intro = "<p>Get help on Ruby on Rails Tutorial at the <a href='http://railstutorial.org/help'>Rails Tutorial help page</a>. To get help on this sample app, see the <a href='http://railstutorial.org/book'>Rails Tutorial book</a>.</p>"
  end
end
