# -*- encoding : utf-8 -*-
class HomesController < ApplicationController

  def index
    @index = "active"
    @products = Product.all
  end

  def line_detail
    @line_detail = "active"
  end

  def autocomplete_search
    data = []
    data = params[:model].classify.constantize.where(["name like ?","%#{params[:q]}%"])
  end

  #快速查找
  def quick_search
    product_type = params[:type]["product"]
    pifa_name = params[:search][:pifu_name] 
    line_number = params[:search][:line_number] 
    line_name = params[:search][:line_name] 

    #执行跨表搜索
    if product_type == "国内跟团游"
      search_hash = { :guonei_pifa_name_contains => pifa_name, :guonei_linename_name_contains => line_name, :id_equals => line_number }
      flash[:search_result] = Guoneifatuan.search(search_hash).all
    elsif product_type == "出境跟团游"
      search_hash = { :chujing_pifa_name_contains => pifa_name, :chujing_linename_name_contains => line_name, :id_equals => line_number }
      flash[:search_result] = Chujingfatuan.search(search_hash).all
    end

    #保存form请求前台搜索数据
    flash[:product_type] = product_type
    flash[:line_number] = line_number
    flash[:line_name] = line_name
    flash[:pifa_name] = pifa_name

    redirect_to :controller => "homes" 
  end

end
