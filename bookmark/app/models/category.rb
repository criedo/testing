class Category < ActiveRecord::Base
  has_many :categories, :through => :categorizations
  has_many :categorizations
  validates_presence_of :title,
    :message => "Ogni categoria inserita deve avere un titolo"
  validates_uniqueness_of :title,
    :message => "Due categorie devono avere titolo differenti"
  validates_length_of :title, :maximum => 256,
    :message => "Il titolo non deve essere più lungi di 255 caratteri"
end
