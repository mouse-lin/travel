(function ($) { 
    $.fn.tilesearch = function (ops){ 
        var ts = $.fn.tilesearch,
            ops = $.extend({  }, ts.defaults, ops),
            container = $("<div class='tilesearch-contain'><div class='tilesearch-second'></div><div class='tilesearch-result'></div></div>").appendTo(this),
            genFirstSearch = function () { 
                var str = "<ul class='tilesearch-first'>";
                if(ops.select === 1 || ops.select === 2) { 
                    for(var i = 0; i < ops.children.length; i ++) { 
                        str += "<li class='tilesearch-first-item'>" + ops.children[i] + "</li>";
                    }
                } else if (ops.select === 3 || ops.select === 4) { 
                    for(var i = 0; i < ops.children.length; i ++) { 
                        str += "<li class='tilesearch-first-item'>" + ops.children[i].value + "</li>";
                    }
                }
                return str + "</ul>";
            },
            putSaveAndClear = function () {
                var resultStr = "<a class='tilesearch-result-save'>保存</a><a class='tilesearch-result-clear'>清除</a>";
                $("<div>" + resultStr + "</div>").appendTo(container.find(".tilesearch-result"));
                genSaveListening();
                genClearListening();
            },
            putFirstResultItem = function (el) { 
                var values = [];
                container.find(".tilesearch-result-item").each(function () { 
                    values.push($(this).text());
                });

                for(var i = 0; i < values.length; i ++) { 
                    if($(el).text() === values[i])return;
                }

                putResult($(el).text());
            },
            putResult = function (str) { 
                var el = $("<a class='tilesearch-result-item'>" + str + "</a>" + "<a class='tilesearch-result-remove'>×</a>").insertBefore(container.find(".tilesearch-result-save"));
                $(el.next()[0]).click(function (e) { 
                    $(this).prev().remove();
                    $(this).remove();

                    if(typeof ops.callback.remove === "function") { 
                        ops.callback.remove.call(ops.callback.scope || this, save(), ts);
                    }
                });
                return el;
            },
            putSecondResultItem = function (el) {
                var values = [], first = null;
                container.find(".tilesearch-result-item").each(function () {
                    values.push($(this).text());
                });

                for(var i = 0; i < ops.children.length; i ++) { 
                    if(values[0] === ops.children[i].value) { 
                        first = i;
                        i = ops.children.length;
                    }
                }
                
                for(var j = 1; j < values.length; j ++) {
                    if(values[j] === $(el).text())return "";
                }

                putResult($(el).text());
            },
            genSecondSearch = function (el) { 
                var str = "", first = null;
                for(var i = 0; i < ops.children.length; i ++) { 
                    if(ops.children[i].value == $(el).text()) { 
                        first = i;
                        i = ops.children.length;
                    }
                }
                for(var j = 0; j < ops.children[first].children.length; j ++) { 
                    str += "<div class='tilesearch-second-item'>" + ops.children[first].children[j] + "</div>";
                }
                return str;
            },
            save = function () { 
                var values = [];
                container.find(".tilesearch-result-item").each(function () {
                    values.push($(this).text());
                });
                return values;
            },
            genSaveListening = function () { 
                container.find(".tilesearch-result-save").click(function () { 
                    if(typeof ops.callback.save === "function") {
                        ops.callback.save.call(ops.callback.scope || this, ops.result(save()));
                    }
                });
            },
            genClearListening = function () { 
                container.find(".tilesearch-result-clear").click(function () { 
                    container.find(".tilesearch-result").empty();
                    
                    if(typeof ops.callback.clear === "function") {
                        ops.callback.clear.call(ops.callback.scope, ts);
                    }

                    putSaveAndClear();
                });
            },
            putOriginValues = function () { 
                var firsts = container.find(".tilesearch-first-item");
                if(ops.select === 1) { 
                    for(var i = 0; i < ops.origin.length; i ++) { 
                        var el = putResult(ops.origin[i]);
                        for(var j = 0; j < firsts.length; j ++) { 
                            if(ops.origin[i] == $(firsts[j]).text()){ 
                                $(firsts[j]).css("color", "#02ACEE");
                            }
                        }
                    }
                } else if (ops.select === 2) { 
                    for(var i = 0; i < ops.origin.length; i ++) { 
                        var el = putResult(ops.origin[i]);
                    }
                } else if (ops.select === 3) { 
                    for(var i = 0; i < firsts.length; i ++) { 
                        if($(firsts[i]).text() === ops.origin[0]){ 
                            $(firsts[i]).css("color", "#02ACEE");
                            container.find(".tilesearch-second").show().empty().append(putSecondSearch($(firsts[i])));
                        }
                    }
                    for(var i = 0; i < ops.origin.length; i ++) { 
                        if(i == 0) { 
                            $("<a class='tilesearch-result-item' style='display:none'>" + ops.origin[i] + "</a>").insertBefore(container.find(".tilesearch-result-save"));
                        } else { 
                            putResult(ops.origin[i]);
                        }
                    }
                }

            },
            putSecondSearch = function (el) {
                container.find(".tilesearch-second").show().empty().append(genSecondSearch(el));
                container.find(".tilesearch-second-item").click(function (){
                    putSecondResultItem(this, el);

                    if(typeof ops.callback.secondclick === "function") {
                        ops.callback.secondclick.call(ops.callback.scope || this, save(), ts);
                    }
                });
            };

        /* init */ 
        $(genFirstSearch()).prependTo(container);
        putSaveAndClear();
        if(ops.select === 1) { 
            container.find(".tilesearch-result").hide();
        }
        putOriginValues();
        container.find(".tilesearch-first-item").click(function () {
            var el = this;
            if(ops.select === 1) {
                container.find(".tilesearch-result").empty();
                $("<a class='tilesearch-result-item'>" + $(this).text() + "</a>").appendTo(container.find(".tilesearch-result"));
                $(this).parent().find(".tilesearch-first-item").css("color", "inherit")
                $(this).css("color", "#02ACEE");
            } else if (ops.select === 2) { 
                putFirstResultItem(this);
            } else if (ops.select === 3) {
                container.find(".tilesearch-result").empty();
                putSaveAndClear();
                $(this).parent().find(".tilesearch-first-item").css("color", "inherit")
                $(this).css("color", "#02ACEE");
                $("<a class='tilesearch-result-item tilesearch-result-first-index'>" + $(this).text() + "</a>").prependTo(container.find(".tilesearch-result"));
                putSecondSearch(this);
            }

            if(typeof ops.callback.firstclick === "function") {
                ops.callback.firstclick.call(ops.callback.scope || this, save());
            }
        });
        /* end init */
    };
    var ts = $.fn.tilesearch;
    ts.defaults = { 
        children : [],
        select : 1, /*
                        1 ： 一层单选
                        2 ： 一层多选
                        3 ： 二层多选
                    */
        result : function (value) { return value; },
        callback : {},
        origin : []
    };
})(jQuery);
