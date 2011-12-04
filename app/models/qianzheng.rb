class Qianzheng < ActiveRecord::Base
  belongs_to :pifa
  has_and_belongs_to_many :dests
end
