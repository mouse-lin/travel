class ApplicationController < ActionController::Base
  protect_from_forgery

  def render_json json = "success"
    render :json => json
  end

 # def quick_search
 #   product_type = params[:type]["product"]
 #   pifa_name = params[:search][:pifu_name] 
 #   line_number = params[:search][:line_number] 
 #   line_name = params[:search][:line_name] 
 #   flash[:search_result] = []


 #   #执行跨表搜索
 #     search_hash = { :guonei_pifa_name_contains => pifa_name, :guonei_linename_name_contains => line_name, :id_equals => line_number }
 #     @result = Guoneifatuan.search(search_hash).paginate(:page => params[:quick_search_page],:per_page => 2).each do |r|
 #       r = r.attributes.merge({ 
 #         "line_name" => r.guonei.linename.name,
 #         "pifa_name" => r.guonei.pifa.name,
 #         "chufa_name" => r.guonei.chufa.name,
 #         "days" => r.guonei.days,
 #         "star" => r.star.name,
 #         "detail" => r.guonei.detail,
 #       })
 #       flash[:search_result] << r
 #     end

 #   #保存form请求前台搜索数据
 #   flash[:product_type] = product_type
 #   flash[:line_number] = line_number
 #   flash[:line_name] = line_name
 #   flash[:pifa_name] = pifa_name

 #   return @result

 #   
 # end

end
