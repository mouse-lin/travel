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
function initForm(){ 
    //日期选择定义
    $("#dateEnd").glDatePicker({
        onChange: function(target, newDate){
             target.val
             (
                 newDate.getFullYear() + "-" +
                 (newDate.getMonth() + 1) + "-" +
                 newDate.getDate()
             );
             search();
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

        search();
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
