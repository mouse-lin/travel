class Line < ActiveRecord::Base
  belongs_to :product 
	belongs_to :company
	belongs_to :chufa
	belongs_to :lianxiren
	belongs_to :pifa
	belongs_to :linename
	has_and_belongs_to_many :dests		   #签证的这个为送签国家，其他为目的地
	has_and_belongs_to_many :linetypes
	belongs_to :visatype
	has_many :linefatuans 
end
