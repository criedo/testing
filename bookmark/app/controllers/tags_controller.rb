class TagsController < ApplicationController
  def show
    # recupero il tag dal parametro :id
    @tag = params[:id] 
    # estraggo tutti i bookmark con il tag desiderato
    @bookmarks = Bookmark.find_tagged_with(@tag)
  end
end
