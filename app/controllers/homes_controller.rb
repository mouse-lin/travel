class HomesController < ApplicationController

  def index
    @index = "active"
  end

  def line_detail
    @line_detail = "active"
  end

  def quick_search
    data = []
    data = Product.where(["name like ?","%#{params[:q]}%"])  if params[:type] == "product"
    #data = Chufa.where(["name like ?","%#{params[:q]}%"])
    render_json data
  end

end
