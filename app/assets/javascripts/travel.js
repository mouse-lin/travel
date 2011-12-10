//前台搜索方式
search = function (type) { 
    var result = { 
        type : { product : [] }, 
        search : { chufa_name : [], dest_name : [], linetype_name : [], daystart : [], dayend : [], days : [], price : [] } 
    };

    $(".tilesearch-chufa").find(".tilesearch-result-item").each (function () { 
        result.search.chufa_name.push($(this).text());
    })
    $(".tilesearch-product").find(".tilesearch-result-item").each (function () { 
        result.type.product.push($(this).text());
    })
    $(".tilesearch-destcat").find(".tilesearch-result-item").each (function () { 
        result.search.dest_name.push($(this).text());
    })
    if(result.type.product[0] !== "签证") { 
        $(".tilesearch-linetype").find(".tilesearch-result-item").each (function () { 
            result.search.linetype_name.push($(this).text());
        })
    }
    if(result.type.product[0] !== "签证") { 
        $(".tilesearch-day").find(".tilesearch-result-item").each (function () { 
            result.search.days.push($(this).text());
        })
    }
    $(".tilesearch-price").find(".tilesearch-result-item").each (function () { 
        result.search.price.push($(this).text());
    })
    result.search.daystart.push($("#dateStart").val());
    result.search.dayend.push($("#dateEnd").val());

    if(type == "ajax")
        ajax_request(1,$.param(result));
    else
        window.location.href = "homes?" + $.param(result);
}


//autocomplete扩展方法
function autocompleteSearch(dom,url,itemString){
    $(dom).autocomplete(url,{ 
        max:12,
        delay:1,
        dataType: "json",
        parse: function(data) {  
          return $.map(eval(data.content), function(row) {  
              return {  
                   data: row,  
                   result: row.name
                }  
            });
        },  
        formatItem: function(item) {  
            if(!itemString)
              return   item.name  ;  
            else
              return itemString;
        },  
    });
}

//定义autocomplete函数
function initForm(type){ 
     callback = { 
         firstclick : function (result) { 
             search(type);
         },
         secondclick : function (result) { 
             search(type);
         },
         remove : function(result, tilesearch) { 
             search(type);
         },
         allsearch : function (result) { 
             search(type);
         }
     }
  
     $(".tilesearch-chufa").tilesearch ({ 
         children : triggle.chufas,
         origin : originValue.chufa,
         select : 1,
         result : function (f_value) { 
             return f_value;
         },
         callback : callback
     });

     $(".tilesearch-product").tilesearch ({ 
         children : triggle.products,
         select : 4,
         hideall : true,
         origin : originValue.product,
         result : function (f_value) {
             return f_value;
         },
         callback : $.extend({  }, callback, { 
             beforeorigin : function () { 
                 if( originValue.product.length > 0 && originValue.product[0] === "签证") {
                     $(".tilesearch-chufa strong").text("送签地:");
                     $(".tilesearch-destcat strong").text("送签国:");
                     $(".tilesearch-linetype").hide();
                     $(".tilesearch-day").hide();
                 }
                 return;
             }
         })
     });
     $(".tilesearch-linetype").tilesearch ({ 
         children : triggle.linetypes,
         select : 2,
         origin : originValue.linetype,
         result : function (f_value) { 
             return f_value;
         },
         callback : callback
     });
     $(".tilesearch-price").tilesearch ({ 
         children : [
             "500以内", "500-1000", "1000-2000", "2000-4000", "4000-10000", "10000以上"
         ],
         select : 1,
         origin : originValue.price,
         result : function (f_value) { 
             return f_value;
         },
         callback : callback
     });
     $(".tilesearch-day").tilesearch ({ 
         children : [
             "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "15天以上"
         ],
         select : 1,
         origin : originValue.days,
         result : function (f_value) { 
             return f_value;
         },
         callback : callback
     });
     $(".tilesearch-destcat").tilesearch ({ 
         children : triggle.destcats,
         select : 3,
         result : function (value) { 
             return value;
         },
         origin : originValue.destcat,
         callback : callback
     });
     var class2 = [ ".tilesearch-product", ".tilesearch-time", ]
    //日期选择定义
    $("#dateEnd").glDatePicker({
        onChange: function(target, newDate){
             target.val
             (
                 newDate.getFullYear() + "-" +
                 (newDate.getMonth() + 1) + "-" +
                 newDate.getDate()
             );
             search(type);
       }
    });

    $("#dateStart").glDatePicker({
        onChange: function(target, newDate){
            target.val
            (
                newDate.getFullYear() + "-" +
                (newDate.getMonth() + 1) + "-" +
                newDate.getDate()
            );
            $("#dateEnd")[0].focus();
       }
    });
    $(".tilesearch-time u").click (function () { 
        $("#dateStart").val("");
        $("#dateEnd").val("");

        search(type);
    });
    //autocomplete定义标签
    autocompleteSearch("#pifaName","/homes/auto_search.json?model=Pifa");
    autocompleteSearch("#lineName","/homes/auto_search.json?model=Linename");
}


/**
    @fileOverview  
    @author mouse
*/

/**
   @description
       发送的ajax请求
   @example
*/
function ajax_request(page,condition){ 
    var url = "/homes?page=" + page;
    $("#homecontent").waiting({ imgsrc: "../images/loading.gif" });
    $.ajax({ 
      url : url,
      data: condition,
      dataType: "json",
      success: function(data){ 
          $("#homecontent").stopWaiting();
          if(data.count !=0 ){  
              var result_title = "<h2>旅游团发团搜索结果</h2>";
              var result_content = "<ul>"; 
              $.each(data.content,function(index,value){ 
                  result_content += '<li><div class="imgholder"><a href="#"><img src="/images/demo/794_s.jpg" alt="" /></a></div> <b>线路名称:</b><strong><a href="#"> ' + value.line_name + "</a></strong><br>" + "<b>产品类型:</b>" + value.product_type + "<br>" + "<b>线路编号:</b>" + value.id + "<br></li>" ; 
              })
              result_content += "</ul>";
              result_content += "<div id='page'><div>";
              $(".column2").html(result_content);
              $("#page").paginate({ 
                   count: data.count, 
                   start: page,
                   border                    : true, 
                   border_color            : '#BEF8B8', 
                   text_color              : '#79B5E3', 
                   background_color        : '#E3F2E1',     
                   border_hover_color        : '#68BA64', 
                   text_hover_color          : '#2573AF', 
                   images                    : false, 
                   mouse                    : 'press', 
                   background_hover_color    : '#CAE6C6',  
                   onChange: function(page){  ajax_request(page,condition); }
              });
          }else{ 
              $(".column2").html("没有该类型的发团 ");
          }
      },
      failure: function(){ 
          $("#homecontent").stopWaiting();
          alert("获取数据失败");
      }
    })
 }
