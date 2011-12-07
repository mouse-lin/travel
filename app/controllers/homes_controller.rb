# -*- encoding : utf-8 -*-
class HomesController < ApplicationController
  def index
    #调用快速查找方式，@results 与 @search_results 为分别数据,提供@results作为外部数据接口
    quick_search

    @products = (Product.all.collect &:name).to_json.html_safe
    @chufas = (Chufa.all.collect &:name).to_json.html_safe
    @destcats = (Destcat.all.collect { |destcat| { "value" => destcat.name, "children" => destcat.dests.collect(&:name) } }).to_json.html_safe
    @linetypes = (Linetype.all.collect &:name).to_json.html_safe

  end

  #即时搜索方法，需要使用到application_controller中封装的render_json方法来返回 ajax的 data json
  def autocomplete_search
    data = []
    data = params[:model].classify.constantize.where(["name like ?","%#{params[:q]}%"])
    render_json data
  end

end
