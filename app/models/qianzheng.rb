class Qianzheng < ActiveRecord::Base
  belongs_to :pifa
  belongs_to :linename
  belongs_to :visatype
  has_and_belongs_to_many :dests
end
