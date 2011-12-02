class Destcat < ActiveRecord::Base
  has_many :dests
  accepts_nested_attributes_for :dests 
end
