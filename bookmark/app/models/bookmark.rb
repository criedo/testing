class Bookmark < ActiveRecord::Base
  acts_as_taggable
  has_one :page
  has_many :categories, :through => :categorizations
  has_many :categorizations
  validates_presence_of :url, :title,
    :message => "Ogni bookmark inserito deve avere un URL e un titolo"
  validates_uniqueness_of :url,
    :message => "Due bookmark devono avere URL differenti"
  validates_length_of :url, :title, :maximum => 256,
    :message => "L'URL e il titolo di non devono essere più lungi di 255 caratteri"
end
