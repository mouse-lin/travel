# -*- encoding : utf-8 -*-
class HomesController < ApplicationController
  def index
    #调用快速查找方式，@results 与 @search_results 为分别数据,提供@results作为外部数据接口
    quick_search

    @products = (Product.all.collect { |product| { "value" => product.name, "children" => product.companies.collect(&:name) } }).to_json.html_safe
    @chufas = (Chufa.all.collect &:name).to_json.html_safe
    unless(flash[:product][0] == '签证')
      @destcats = (Destcat.all.collect { |destcat| { "value" => destcat.name, "children" => destcat.dests.collect(&:name) } }).to_json.html_safe
    else
      @destcats = (Destcat.all.collect { |destcat| { "value" => destcat.name, "children" => (destcat.dests.collect { |dest| dest[:name] unless dest[:country].blank? }).compact } }).to_json.html_safe
    end
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
       chufa_name =  days = price = daystart = dayend = destcat_name = line_number = pifa_name = line_name = ""
       linetype_name = dest_name = []
       @search_results = []
       search_hash = {  }
       #触发了详细搜索条件
       if params[:search] 
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
         if dest_name.count == 1
           destcat_name = dest_name[0]
           dest_name.delete(destcat_name)
         end
         #判断是否为游轮
         if params[:type][:product].count != 1
           company_array = params[:type][:product].clone
           company_array.delete_at(0)
           search_hash.merge!({ :line_company_name_in => company_array })
         end
        flash[:product] = params[:type][:product].clone
        flash[:quick_product] = flash[:product][0]
      else
        #快速搜索
        pifa_name = params[:quick_search][:pifa_name] 
        line_number = params[:quick_search][:line_number] 
        line_name = params[:quick_search][:line_name] 
        #保存form请求前台搜索数据,前台也可以直接使用params来赋值，这里使用了flash cookide保存方式
        flash[:line_number] = line_number
        flash[:line_name] = line_name
        flash[:pifa_name] = pifa_name
        flash[:quick_product] = params[:type][:quick_product]
        flash[:product] = [flash[:quick_product]]
      end
       product = flash[:quick_product]  #构造product类型的查询条件
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
          :line_chufa_name_contains => chufa_name,
          :line_product_name_contains => product,
          :line_dests_name_in => dest_name,
          :line_dests_destcat_name_contains => destcat_name,
          :line_linetypes_name_in => linetype_name,
          :daystart_equals => daystart,
          :dayend_equals => dayend,
          :line_pifa_name_contains => pifa_name,
          :line_linename_name_contains => line_name,
          :id_equals => line_number
      })
      days == "15天以上" ? search_hash.merge!({ :line_days_greater_than => 15}) : search_hash.merge!({ :line_days_equals => days})
     # @results = Linefatuan.search(search_hash).paginate(:page => params[:quick_search_page],:per_page => page).each do |l|
     #  l = l.attributes.merge({ 
     #    "product_type" => l.line.product.name,
     #    "line_name" => l.line.try(:linename).try(:name),
     #    "pifa_name" => l.line.pifa.try(:name),
     #    "chufa_name" => l.line.chufa.try(:name),
     #    "dest_name" => (l.line.dests.collect &:name),
     #    "days" => l.line.days,
     #    "star" => l.star.try(:name),
     #    "detail" => l.line.detail,
     #  })
     #  @search_results << l
      count = Linefatuan.search(search_hash).count
      limit = 10
      params[:page] = 1 unless params[:page] 
      @results = Linefatuan.search(search_hash).page(params[:page]).limit(limit).each do |l|
       l = l.attributes.merge({ 
         "product_type" => l.line.product.name,
         "line_name" => l.line.try(:linename).try(:name),
         "pifa_name" => l.line.pifa.try(:name),
         "chufa_name" => l.line.chufa.try(:name),
         "dest_name" => (l.line.dests.collect &:name),
         "days" => l.line.days,
         "star" => l.star.try(:name),
         "detail" => l.line.detail,
       })
       @search_results << l
     end
      @results.uniq!
      @search_results.uniq!
      render_json @search_results,count
     end
   end

end
