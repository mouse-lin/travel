class Zhiyoufatuan < ActiveRecord::Base
  belongs_to :guonei
  belongs_to :star
  belongs_to :house
end
