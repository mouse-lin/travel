class Linetype < ActiveRecord::Base
  has_and_belongs_to_many :guoneis
  has_and_belongs_to_many :chujings
  has_and_belongs_to_many :zhiyous
end
