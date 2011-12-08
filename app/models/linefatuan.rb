class Linefatuan < ActiveRecord::Base
  belongs_to :line
	belongs_to :star
	belongs_to :house
	belongs_to :visatype    #仅仅是签证类型使用
end
