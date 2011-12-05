(function ($) {
    $.fn.multiTriggle = function (ops) {
        var mt = $.fn.multiTriggle,
            operateEl = this,
            ops = $.extend({}, mt.defaults, ops), 
            container = $(
                "<div class='multi-contain'><div class='multi-title'>" + ops.title + "</div> \
                    <table> \
                        <td id='multi-td1' style='width:45%;'><table class='multi-first'></table></td> \
                        <td id='multi-td2' style='width:50%;'><table class='multi-second'></table></td> \
                    </table> \
                    <div class='multi-value'></div><a class='number-value'></a> \
                    <a class='multi-cancel'>取消</a><a class='multi-save'>保存</a> \
                </div>"
            ).appendTo("body"),
            genFirstItems = function (items) { 
                var str = "";
                for(var i = 0; i < items.length / ops.firstCounts | 0; i ++) { 
                    str += "<tr>";
                    for(var j = 0; j < ops.firstCounts && i*ops.firstCounts + j < items.length; j ++) { 
                        str += "<td class='first-item'><a class='multi-index'>" + (i * ops.firstCounts + j) + "</a>" + items[i*ops.firstCounts + j].value + "</td>";
                    }
                    str += "</tr>";
                }
                //var str = ""; $.each(items, function (i) { 
                //    str += "<tr><td class='first-item'><a class='multi-index'>" + i + "</a>" + items[i].value + "</td></tr>";
                //});
                return str;
            },
            putFirstValue = function (el) { 
                var index = parseInt($(el).find(".multi-index").text()),
                    tmp = ops.children[index],
                    value = $(el).parents(".multi-contain").find('.multi-value');
                value.empty();
                value.append("<a class='first-value'>" + tmp.value + ":" + "</a>");
                $(el).parents(".multi-contain").find(".number-value").text(index);
            },
            putSecondValue = function (el) { 
                var second = parseInt($(el).find(".multi-index").text()),
                    number = $(".number-value").text().split("-");
                var tmp = ops.children[parseInt(number[0])].children[second],
                    value = $(el).parents(".multi-contain").find('.multi-value'),
                    numberEl = $(el).parents(".multi-contain").find(".number-value");
                
                for(var i = 1; i < number.length; i ++) { 
                    if(number[i] == second)return;
                }
                
                var el = $("<a class='second-value'>" + tmp + "</a><a class='multi-remove'>×</a>").appendTo(value);
                el.next().click(function (e) { 
                    e.stopPropagation();
                    removeSecondValue(el, second);
                });
                numberEl.text(numberEl.text() + "-" + second);

            },
            removeSecondValue = function (el, secondIndex) {
                $(el).remove();
                var numberEl = $(container).find(".number-value"),
                    number = numberEl.text().split("-"),
                    str = number[0];
                
                for(var i = 1; i < number.length; i ++) { 
                    if(parseInt(number[i]) == secondIndex)continue;
                    str += "-" + number[i];
                }
                
                numberEl.text(str);
            },
            getMultiValues = function () { 
                var indexs = $(container).find(".number-value").text().split("-"),
                    str = ops.children[indexs[0]].value;
                for(var i = 1; i < indexs.length; i ++) { 
                    str += "-" + ops.children[indexs[0]].children[indexs[i]];
                }
                return str;
            },
            genSecondItems = function (el) { 
                var index = parseInt($(el).find("a").text()),
                    tmp = ops.children[index],
                    second = $(el).parents(".multi-contain").find('.multi-second');
                if(typeof tmp.children !== "undefined") {
                    second.empty();
                    for(var i = 0; i < tmp.children.length / ops.secondCounts | 0; i ++) { 
                        var str = "<tr>";
                        for(var j = 0; j < ops.secondCounts && i*ops.secondCounts + j < tmp.children.length; j ++) { 
                            str += "<td class='second-item'><a class='multi-index'>" + (i*ops.secondCounts + j) + "</a>" + tmp.children[i*ops.secondCounts + j] + "</td>"
                        }
                        second.append(str + "</tr>");
                    }
                    //$.each(tmp.children, function (i) { 
                    //    var str = "<tr><td class='second-item'><a class='multi-index'>" + i + "</a>" + tmp.children[i] + "</td><tr>";
                    //    second.append(str);
                    //});
                } else { 
                    second.empty();
                }

                $(second).find(".second-item").click(function (e) { 
                    e.stopPropagation();
                    putSecondValue(this);
                });
            };
            
        if(typeof ops.children !== 'undefined') { 
            $(container).find(".multi-first").append(genFirstItems(ops.children));
            $(container).find(".multi-first").find(".first-item").click(function (e) { 
                e.stopPropagation();
                putFirstValue(this);
                genSecondItems(this);
            });
            $(container).find(".multi-save").click(function (e) { 
                e.stopPropagation();
                if(typeof ops.callback.save == "function") { 
                    ops.callback.save.call(ops.callback.scope || this, getMultiValues(), e);
                }
                $(container).hide();
            });
            $(container).find(".multi-cancel").click(function (e) { 
                e.stopPropagation();
                $(container).hide();
            })
            container.click(function (e) { 
                e.stopPropagation();
            });
            $("body").click(function (e) { 
                if(!$(e.target).is(operateEl)) { 
                    container.hide();
                }
            });
        }

        $(this).click(function (e) {
            $(container).css("left", parseInt($(e.target).offset().left) + 50).css("top", parseInt($(e.target).offset().top) + 20).show();
        });
    };
    var mt = $.fn.multiTriggle;
    mt.defaults = {
        children : [],
        callback : {},
        firstCounts : 5,
        secondCounts : 5
    };
})(jQuery);
