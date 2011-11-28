class Movie < ActiveRecord::Base
	validates_presence_of :title, :description
	validates_format_of	:url,
		:with		=> %r{\.(gif|jpg|jpeg|png)$}i,
		:message	=> "must be a URL for a GIF, JPG or PNG image"
end
