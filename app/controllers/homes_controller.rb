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

private
   def quick_search
     #一开是就赋值给product
     # flash[:product_type] = Product.first.name  

     if params[:quick_search] || params[:quick_search_page] || params[:search]
       #分页
       page = 10
       product_type = params[:type][:product][0]
       if params[:search]
       debugger
         #详细搜索
         chufa_name = params[:search][:chufa_name]
         dest_name = params[:search][:dest_name]
         linetype_name = params[:search][:linetype_name]
         days = params[:search][:days]
         price = params[:search][:price]
         daystart = params[:search][:daystart]
         dayend = params[:search][:dayend]
         flash[:chufa_name] = chufa_name
         flash[:dest_name] = dest_name
         flash[:linetype_name] = linetype_name
         flash[:days] = days
         flash[:price] = price
         flash[:daystart] = daystart
         flash[:dayend] = dayend

         #解释前台传来的目的地，并且判断是否只有一级目的地
         dest_array = dest_name.split("-") if dest_name
         linetype_array = linetype_name.split("-") if linetype_name
         if dest_array.count == 1
           destcat_name = dest_array[0]
           dest_array.delete(destcat_name)
         end

       else
         #快速搜索
         pifa_name = params[:quick_search][:pifa_name] 
         line_number = params[:quick_search][:line_number] 
         line_name = params[:quick_search][:line_name] 
         #保存form请求前台搜索数据,前台也可以直接使用params来赋值，这里使用了flash cookide保存方式
         flash[:line_number] = line_number
         flash[:line_name] = line_name
         flash[:pifa_name] = pifa_name
       end
       flash[:product_type] = params[:type][:product]
       search_hash = {  }
       @search_results = []

       #判断价格范围
       if price
         unless price.include? "以"
           price_array = price.split("-")
           search_hash.merge!({ :zhike_gte => price_array[0], :zhike_lt => price_array[1] })
         else 
           price == "500以内" ? search_hash.merge!({ :zhike_lt => 500 }) : search_hash.merge!({ :zhike_gt => 10000 })
         end
       end


       #执行跨表搜索
       if product_type == "国内跟团游"
         search_hash.merge!({ 
           :guonei_chufa_name_contains => chufa_name,
           :guonei_dests_name_in => dest_array,
           :guonei_dests_destcat_name_contains => destcat_name,
           :guonei_linetypes_name_in => linetype_array,
           :daystart_equals => daystart,
           :dayend_equals => dayend,
           :guonei_pifa_name_contains => pifa_name,
           :guonei_linename_name_contains => line_name,
           :id_equals => line_number
         })
         if days == "15天以上"
           search_hash.merge!({ :guonei_days_greater_than => 15})
         else
           search_hash.merge!({ :guonei_days_equals => days})
         end
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
         search_hash.merge!({ 
           :chujing_chufa_name_contains => chufa_name,
           :chujing_dests_name_in => dest_array,
           :chujing_dests_destcat_name_contains => destcat_name,
           :chujing_linetypes_name_in => linetype_array,
           :daystart_equals => daystart,
           :dayend_equals => dayend,
           :chujing_pifa_name_contains => pifa_name,
           :chujing_linename_name_contains => line_name,
           :id_equals => line_number
         })
         if days == "15天以上"
           search_hash.merge!({ :chujing_days_greater_than => 15})
         else
           search_hash.merge!({ :chujing_days_equals => days})
         end
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
         search_hash.merge!({ 
           :zhiyou_chufa_name_contains => chufa_name,
           :zhiyou_dests_name_in => dest_array,
           :zhiyou_dests_destcat_name_contains => destcat_name,
           :zhiyou_linetypes_name_in => linetype_array,
           :daystart_equals => daystart,
           :dayend_equals => dayend,
           :zhiyou_pifa_name_contains => pifa_name,
           :zhiyou_linename_name_contains => line_name,
           :id_equals => line_number
         })
         if days == "15天以上"
           search_hash.merge!({ :zhiyou_days_greater_than => 15})
         else
           search_hash.merge!({ :zhiyou_days_equals => days})
         end
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
         search_hash.merge!({ 
           :dests_destcat_name_contains => destcat_name,
           :daystart_equals => daystart,
           :dayend_equals => dayend,
           :pifa_name_contains => pifa_name,
           :linename_name_contains => line_name,
           :id_equals => line_number
         })
         if days == "15天以上"
           search_hash.merge!({ :days_greater_than => 15})
         else
           search_hash.merge!({ :days_equals => days})
         end
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
       @search_results.uniq!
       @results.uniq!
     end
   end

end
