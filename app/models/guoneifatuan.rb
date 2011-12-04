class Guoneifatuan < ActiveRecord::Base
  belongs_to :guonei
  belongs_to :star

  def linename
    self.guonei.linename.name
  end

end
