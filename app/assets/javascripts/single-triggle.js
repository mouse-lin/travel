(function ($) { 
    $.fn.singleTriggle = function (ops) { 
        var sm = $.fn.singleTriggle,
            operateEl = this,
            ops = $.extend({}, sm.defaults, ops),
            container = $("<div class='search-contain'><div class='single-title'>" + ops.title + "</div><div class='single-value'></div><a class='single-number-value'></a><a class='single-cancel'>取消</a><a class='single-save'>保存</a></div>").appendTo("body"),
            genItemsStr = function (items) { 
                var str = "<table>"
                for(var i = 0; i < items.length / 4 | 0; i ++) { 
                    str += "<tr>";
                    for(var j = 0; j < 4 && i*4 + j < items.length; j ++) { 
                        str += "<td class='item'><a class='index'>" + (i * 4 + j) + "</a>" + items[i*4 + j] + "</td>";
                    }
                    str += "</tr>";
                }
                return str + "</table>"
            },
            putValue = function (index) { 
                var numberEl = $(container).find(".single-number-value"),
                    number = numberEl.text().split("-");
                for(var i = 0; i < number.length; i ++) { 
                    if(number[i] == index) return;
                }
                
                var el = $("<a class='single-multi-value'>" + ops.children[index] + "</a><a class='single-remove'>×</a>").appendTo(".single-value");
                if(number.length == 1 && number[0] === "") {
                    numberEl.text(index);
                } else { 
                    numberEl.text(numberEl.text() + "-" + index);
                }
                
                el.next().click(function (e) { 
                    e.stopPropagation();
                    removeValue(el, index);
                });
            },
            removeValue = function (el, index) {
                var numberEl = $(container).find(".single-number-value"),
                    number = numberEl.text().split("-"),
                    str = "";

                for(var i = 0; i < number.length; i ++) { 
                    if(number[i] == index)continue;
                    if(str.length == 0) { 
                        str += number[i];
                    } else {
                        str += "-" + number[i];
                    }
                }

                $(el).remove();
                numberEl.text(str);
            },
            getSingleValues = function () { 
                var indexs = $(container).find(".single-number-value").text().split("-"),
                    str = "";
                for(var i = 0; i < indexs.length; i ++) { 
                    if(str.length == 0) { 
                        str += ops.children[indexs[i]];
                    } else {
                        str += "-" + ops.children[indexs[i]];
                    }
                }

                return str;
            },
            listeners = function () { 
                $(container).find(".item").click (function (e) { 
                    e.stopPropagation();
                    var index = parseInt($(this).find(".index").text());
                    if(typeof ops.callback.click === "function") { 
                        ops.callback.click.call(ops.callback.scope || this, this, ops.children[index], e);
                    }

                    if(ops.select == 'single') { 
                        $(container).hide();
                    } else if(ops.select == 'multi') {
                        putValue(index);
                    }
                });

                $("body").click(function (e) { 
                    if(!$(e.target).is(operateEl)) { 
                        container.hide();
                    }
                });
            };

        if(typeof ops.children !== 'undefined') { 
            $(genItemsStr(ops.children)).insertAfter(container.find(".single-title"));

            $(container).find(".single-save").click(function (e) { 
                if(typeof ops.callback.save == "function") { 
                    ops.callback.save.call(ops.callback.scope || this, getSingleValues(), e);
                }
                $(container).hide();
            });
            $(container).find(".single-cancel").click(function (e) { 
                $(container).hide();
            });
        }

        $(this).each(function () { 
            if(ops.select == "single") { 
                container.find(".single-value").hide();
                container.find(".single-number-value").hide();
                container.find(".single-save").hide();
                container.find('.single-cancel').hide();
            }
            $(this).focus(function (e) { 
                container.css("left", parseInt($(e.target).offset().left) + 50).css("top", parseInt($(e.target).offset().top) + 20).show();
            });
        })

        listeners.call(this);
    }

    var sm = $.fn.singleTriggle;
    sm.defaults = { 
        children : [],
        select : 'single',
        callback : {}
    };
})(jQuery)
