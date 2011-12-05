class Dest < ActiveRecord::Base
  belongs_to :destcat
  has_and_belongs_to_many :chujins
  has_and_belongs_to_many :zhiyous
  has_and_belongs_to_many :qianzhengs
  has_and_belongs_to_many :guoneis 
end
