class Zhiyou < ActiveRecord::Base
  belongs_to :pifa
  belongs_to :chufa
  belongs_to :linename
  has_and_belongs_to_many :dests
  has_and_belongs_to_many :linetypes
  has_many :zhiyoufatuans
end
