class Categorization < ActiveRecord::Base
  belongs_to :bookmark
  belongs_to :category
end
