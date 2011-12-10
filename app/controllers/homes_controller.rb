# -*- encoding : utf-8 -*-
class HomesController < ApplicationController
  #第一个参数，"form" || "ajax"，分别使用form、ajax请求；第二个参数：分页数量
  #返回结果: 
  # =>  form:  @results 与 @search_results 为分别数据,提供@results作为外部数据接口
  # =>  ajax:  data.content 
  def index
    quick_search "ajax",10
  end

  def auto_search
    autocomplete_search  
  end
end
