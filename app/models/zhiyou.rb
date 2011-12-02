class Zhiyou < ActiveRecord::Base
  belongs_to :pifa
  belongs_to :chufa
  belongs_to :linename
end
