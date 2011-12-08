class Product < ActiveRecord::Base
  has_many :lines
  has_many :companies
  accepts_nested_attributes_for :companies
end
