class Zhiyoufatuan < ActiveRecord::Base
  belongs_to :zhiyou
  belongs_to :star
  belongs_to :house
end
