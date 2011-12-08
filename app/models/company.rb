class Company < ActiveRecord::Base
  has_many :lines
  belongs_to :product
end
