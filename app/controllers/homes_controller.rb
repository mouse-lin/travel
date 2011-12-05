# -*- encoding : utf-8 -*-
class HomesController < ApplicationController
  def index
    #调用快速查找方式，@results 与 @search_results 为分别数据,提供@results作为外部数据接口
    quick_search
  end

  #即时搜索方法
  def autocomplete_search
    data = []
    data = params[:model].classify.constantize.where(["name like ?","%#{params[:q]}%"])
    render_json data
  end

private
  #快速查找
  def quick_search
    #一开是就赋值给product
    @product_name = flash[:product_type] = Product.first.name  

    if params[:quick_search] || params[:quick_search_page]
      product_type = params[:type]["product"]
      pifa_name = params[:quick_search][:pifa_name] 
      line_number = params[:quick_search][:line_number] 
      line_name = params[:quick_search][:line_name] 
      @search_results = []

      #保存form请求前台搜索数据,前台也可以直接使用params来赋值，这里使用了flash cookide保存方式
      flash[:product_type] = product_type
      flash[:line_number] = line_number
      flash[:line_name] = line_name
      flash[:pifa_name] = pifa_name
      #分页
      page = 10

      #执行跨表搜索
      if product_type == "国内跟团游"
        search_hash = { :guonei_pifa_name_contains => pifa_name, :guonei_linename_name_contains => line_name, :id_equals => line_number }
        @results = Guoneifatuan.search(search_hash).paginate(:page => params[:quick_search_page],:per_page => page).each do |r|
          r = r.attributes.merge({ 
            "line_name" => r.guonei.linename.name,
            "pifa_name" => r.guonei.pifa.name,
            "chufa_name" => r.guonei.chufa.name,
            "days" => r.guonei.days,
            "star" => r.star.name,
            "detail" => r.guonei.detail,
          })
          @search_results << r
        end
      elsif product_type == "出境跟团游"
        search_hash = { :chujing_pifa_name_contains => pifa_name, :chujing_linename_name_contains => line_name, :id_equals => line_number }
        @results = Chujingfatuan.search(search_hash).paginate(:page => params[:quick_search_page],:per_page => page).each do |r|
          r = r.attributes.merge({ 
            "line_name" => r.chujing.linename.name,
            "pifa_name" => r.chujing.pifa.name,
            "chufa_name" => r.chujing.chufa.name,
            "days" => r.chujing.days,
            "star" => r.star.name,
            "detail" => r.chujing.detail,
          })
          @search_results << r
        end
      elsif product_type == "自由人"
        search_hash = { :zhiyou_pifa_name_contains => pifa_name, :zhiyou_linename_name_contains => line_name, :id_equals => line_number }
        @results = Zhiyoufatuan.search(search_hash).paginate(:page => params[:quick_search_page],:per_page => page).each do |r|
          r = r.attributes.merge({ 
            "line_name" => r.zhiyou.linename.name,
            "pifa_name" => r.zhiyou.pifa.name,
            "chufa_name" => r.zhiyou.chufa.name,
            "days" => r.zhiyou.days,
            "star" => r.star.name,
            "house_name" => r.house.name,
            "detail" => r.zhiyou.detail,
          })
          @search_results << r
        end
      elsif product_type == "签证"
        search_hash = { :pifa_name_contains => pifa_name, :linename_name_contains => line_name, :id_equals => line_number }
        @results = Qianzheng.search(search_hash).paginate(:page => params[:quick_search_page],:per_page => page).each do |r|
          r = r.attributes.merge({ 
            "line_name" => r.linename.name,
            "visatype_name" => r.visatype.name,
            "pifa_name" => r.pifa.name,
            "days" => r.days,
            "detail" => r.detail,
          })
          @search_results << r
        end
      end
    end
  end

end
