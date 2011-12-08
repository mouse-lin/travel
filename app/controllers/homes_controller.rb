# -*- encoding : utf-8 -*-
class HomesController < ApplicationController
  def index
    #调用快速查找方式，@results 与 @search_results 为分别数据,提供@results作为外部数据接口
    quick_search

    @products = (Product.all.collect { |product| { "value" => product.name, "children" => product.companies.collect(&:name) } }).to_json.html_safe
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

     flash[:quick_product] = Product.first.name
     flash[:product] = [flash[:quick_product]]
     #一开是就赋值给product

     #是否有触发 查询 || 分页条件
     if params[:quick_search] || params[:quick_search_page] || params[:search]
       page = 10 #分页

         
        # flash[:quick_product] = params[:type][:quick_product]
        # flash[:product] = [flash[:quick_product]]


       chufa_name =  days = price = daystart = dayend = destcat_name = line_number = line_name =  ""
       linetype_name = dest_name = []
       if params[:search] #触发了详细搜索条件

         flash[:product] = params[:type][:product]
         flash[:quick_product] = flash[:product][0]

         #详细搜索
         chufa_name = params[:search][:chufa_name][0] if params[:search][:chufa_name]
         dest_name = params[:search][:dest_name] if params[:search][:dest_name]
         linetype_name = params[:search][:linetype_name] if params[:search][:linetype_name]
         days = params[:search][:days][0] if params[:search][:days]
         price = params[:search][:price][0] if params[:search][:price]
         daystart = params[:search][:daystart][0] if params[:search][:daystart]
         dayend = params[:search][:dayend][0] if params[:search][:dayend]

         flash[:chufa_name] = [chufa_name]
         flash[:dest_name] = dest_name.clone
         flash[:linetype_name] = linetype_name
         flash[:days] = [days]
         flash[:price] = [price]
         flash[:daystart] = daystart
         flash[:dayend] = dayend
       end

       if dest_name.count == 1
         destcat_name = dest_name[0]
         dest_name.delete(destcat_name)
       end

      # else
      #   #快速搜索
      #   pifa_name = params[:quick_search][:pifa_name] 
      #   line_number = params[:quick_search][:line_number] 
      #   line_name = params[:quick_search][:line_name] 
      #   #保存form请求前台搜索数据,前台也可以直接使用params来赋值，这里使用了flash cookide保存方式
      #   flash[:line_number] = line_number
      #   flash[:line_name] = line_name
      #   flash[:pifa_name] = pifa_name
      # end
      # flash[:product_type] = params[:type][:product]
      search_hash = {  }
      product = flash[:quick_product]  #构造product类型的查询条件
      @search_results = []

      

       #判断价格范围
       unless price.blank?
         unless price.include? "以"
           price_array = price.split("-")
           search_hash.merge!({ :zhike_gte => price_array[0], :zhike_lt => price_array[1] })
         else 
           price == "500以内" ? search_hash.merge!({ :zhike_lt => 500 }) : search_hash.merge!({ :zhike_gt => 10000 })
         end
       end

      #构造查询条件
      search_hash.merge!({ 
          :line_product_name_contains => product,
          :line_dests_name_in => dest_name,
          :line_dests_destcat_name_contains => destcat_name,
          :line_linetypes_name_in => linetype_name,
          :daystart_equals => daystart,
          :dayend_equals => dayend,
          :line_pifa_name_contains => line_name,
          :id_equals => line_number
      })
      days == "15天以上" ? search_hash.merge!({ :line_days_greater_than => 15}) : search_hash.merge!({ :line_days_equals => days})
      @results = Linefatuan.search(search_hash).paginate(:page => params[:quick_search_page],:per_page => page).each do |l|
       l = l.attributes.merge({ 
         "line_name" => l.line.linename.name,
         "pifa_name" => l.line.pifa.name,
         "chufa_name" => l.line.chufa.name,
         "days" => l.line.days,
         "star" => l.star.name,
         "detail" => l.line.detail,
       })
       @search_results << l
     end


      # #执行跨表搜索
      # if product_type == "国内跟团游"
      #   search_hash.merge!({ 
      #     :guonei_chufa_name_contains => chufa_name,
      #     :guonei_dests_name_in => dest_array,
      #     :guonei_dests_destcat_name_contains => destcat_name,
      #     :guonei_linetypes_name_in => linetype_array,
      #     :daystart_equals => daystart,
      #     :dayend_equals => dayend,
      #     :guonei_pifa_name_contains => pifa_name,
      #     :guonei_linename_name_contains => line_name,
      #     :id_equals => line_number
      #   })
      #   if days == "15天以上"
      #     search_hash.merge!({ :guonei_days_greater_than => 15})
      #   else
      #     search_hash.merge!({ :guonei_days_equals => days})
      #   end
      #   @results = Guoneifatuan.search(search_hash).paginate(:page => params[:quick_search_page],:per_page => page).each do |r|
      #     r = r.attributes.merge({ 
      #       "line_name" => r.guonei.linename.name,
      #       "pifa_name" => r.guonei.pifa.name,
      #       "chufa_name" => r.guonei.chufa.name,
      #       "days" => r.guonei.days,
      #       "star" => r.star.name,
      #       "detail" => r.guonei.detail,
      #     })
      #     @search_results << r
      #   end

      # elsif product_type == "出境跟团游"
      #   search_hash.merge!({ 
      #     :chujing_chufa_name_contains => chufa_name,
      #     :chujing_dests_name_in => dest_array,
      #     :chujing_dests_destcat_name_contains => destcat_name,
      #     :chujing_linetypes_name_in => linetype_array,
      #     :daystart_equals => daystart,
      #     :dayend_equals => dayend,
      #     :chujing_pifa_name_contains => pifa_name,
      #     :chujing_linename_name_contains => line_name,
      #     :id_equals => line_number
      #   })
      #   if days == "15天以上"
      #     search_hash.merge!({ :chujing_days_greater_than => 15})
      #   else
      #     search_hash.merge!({ :chujing_days_equals => days})
      #   end
      #   @results = Chujingfatuan.search(search_hash).paginate(:page => params[:quick_search_page],:per_page => page).each do |r|
      #     r = r.attributes.merge({ 
      #       "line_name" => r.chujing.linename.name,
      #       "pifa_name" => r.chujing.pifa.name,
      #       "chufa_name" => r.chujing.chufa.name,
      #       "days" => r.chujing.days,
      #       "star" => r.star.name,
      #       "detail" => r.chujing.detail,
      #     })
      #     @search_results << r
      #   end

      # elsif product_type == "自由人"
      #   search_hash.merge!({ 
      #     :zhiyou_chufa_name_contains => chufa_name,
      #     :zhiyou_dests_name_in => dest_array,
      #     :zhiyou_dests_destcat_name_contains => destcat_name,
      #     :zhiyou_linetypes_name_in => linetype_array,
      #     :daystart_equals => daystart,
      #     :dayend_equals => dayend,
      #     :zhiyou_pifa_name_contains => pifa_name,
      #     :zhiyou_linename_name_contains => line_name,
      #     :id_equals => line_number
      #   })
      #   if days == "15天以上"
      #     search_hash.merge!({ :zhiyou_days_greater_than => 15})
      #   else
      #     search_hash.merge!({ :zhiyou_days_equals => days})
      #   end
      #   @results = Zhiyoufatuan.search(search_hash).paginate(:page => params[:quick_search_page],:per_page => page).each do |r|
      #     r = r.attributes.merge({ 
      #       "line_name" => r.zhiyou.linename.name,
      #       "pifa_name" => r.zhiyou.pifa.name,
      #       "chufa_name" => r.zhiyou.chufa.name,
      #       "days" => r.zhiyou.days,
      #       "star" => r.star.name,
      #       "house_name" => r.house.name,
      #       "detail" => r.zhiyou.detail,
      #     })
      #     @search_results << r
      #   end

      # elsif product_type == "签证"
      #   search_hash.merge!({ 
      #     :dests_destcat_name_contains => destcat_name,
      #     :daystart_equals => daystart,
      #     :dayend_equals => dayend,
      #     :pifa_name_contains => pifa_name,
      #     :linename_name_contains => line_name,
      #     :id_equals => line_number
      #   })
      #   if days == "15天以上"
      #     search_hash.merge!({ :days_greater_than => 15})
      #   else
      #     search_hash.merge!({ :days_equals => days})
      #   end
      #   @results = Qianzheng.search(search_hash).paginate(:page => params[:quick_search_page],:per_page => page).each do |r|
      #     r = r.attributes.merge({ 
      #       "line_name" => r.linename.name,
      #       "visatype_name" => r.visatype.name,
      #       "pifa_name" => r.pifa.name,
      #       "days" => r.days,
      #       "detail" => r.detail,
      #     })
      #     @search_results << r
      #   end
      # end
      @search_results.uniq!
      @results.uniq!
     end
   end

end
