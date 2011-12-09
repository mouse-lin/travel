(function ($) { 
    $.fn.tilesearch = function (ops){ 
        var ts = $.fn.tilesearch,
            ops = $.extend({  }, ts.defaults, ops),
            container = $("<div class='tilesearch-contain'><div class='tilesearch-second'></div><div class='tilesearch-result'></div></div>").appendTo(this),
            genFirstSearch = function () { 
                var str = "<ul class='tilesearch-first'><li class='tilesearch-all'>全部</li>";
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
            //putSaveAndClear = function () {
            //    var resultStr = "<a class='tilesearch-result-save'>保存</a><a class='tilesearch-result-clear'>清除</a>";
            //    $("<div>" + resultStr + "</div>").appendTo(container.find(".tilesearch-result"));
            //    genSaveListening();
            //    genClearListening();
            //},
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
                var el = $("<a class='tilesearch-result-item'>" + str + "</a>" + "<a class='tilesearch-result-remove'>×</a>").appendTo(container.find(".tilesearch-result"));
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

                if(ops.select === 4) {
                    var firstEl = container.find(".tilesearch-result-item")[0];
                    container.find(".tilesearch-result").empty().append(firstEl).append("<a class='tilesearch-result-item' style='display:none;'>" + $(el).text() + "</a>");
                    $(el).parent().find(".tilesearch-second-item").css("color", "inherit")
                    $(el).css("color", "#02ACEE");
                } else { 
                    putResult($(el).text());
                }
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
                        ops.callback.clear.call(ops.callback.scope || this, ts);
                    }

                    //putSaveAndClear();
                });
            },
            putOriginValues = function () { 

                if(typeof ops.callback.beforeorigin === "function") {
                    ops.callback.beforeorigin.call(ops.callback.scope || this, ts);
                }

                if(ops.origin.length == 0 || (ops.origin.length == 1 && ops.origin[0] === "")) {
                    container.find(".tilesearch-all").css("color", "#02ACEE");
                }

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
                            $("<a class='tilesearch-result-item' style='display:none'>" + ops.origin[i] + "</a>").appendTo(container.find(".tilesearch-result"));
                        } else { 
                            putResult(ops.origin[i]);
                        }
                    }
                } else if (ops.select === 4) { 
                    for(var i = 0; i < firsts.length; i ++) { 
                        if($(firsts[i]).text() === ops.origin[0]){ 
                            $("<a class='tilesearch-result-item' style='display:none'>" + ops.origin[0] + "</a>").appendTo(container.find(".tilesearch-result"));
                            $(firsts[i]).css("color", "#02ACEE");
                            break;
                        }
                    }
                    var j = 0;
                    for(; j < ops.children.length; j ++) { 
                        if(ops.children[j].value === ops.origin[0]) { 
                            break;
                        }
                    }
                    if(typeof ops.children[j] !== "undefined" && typeof ops.children[j].children !== "undefined" && ops.children[j].children.length > 0) { 
                        container.find(".tilesearch-second").show().empty().append(putSecondSearch($(firsts[i])));
                        for(var i = 1; i < ops.origin.length; i ++) { 
                            $("<a class='tilesearch-result-item' style='display:none'>" + ops.origin[i] + "</a>").appendTo(container.find(".tilesearch-result"));
                        }
                        var seconds = container.find(".tilesearch-second-item");
                        for(var i = 1; i < ops.origin.length; i ++) {
                            for(var j = 1; j < seconds.length; j ++) { 
                                if($(seconds[j]).text() == ops.origin[i]) { 
                                    $(seconds[j]).css("color", "#02ACEE");
                                }
                            }
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
            },
            emptyResult = function () { 
                container.find(".tilesearch-first-item").css("color", "inherit");
                container.find(".tilesearch-second").empty().hide();
                container.find(".tilesearch-result-item").remove();
                container.find(".tilesearch-result-remove").remove();
            };

        /* init */ 
        $(genFirstSearch()).prependTo(container);
        //putSaveAndClear();
        if(ops.select === 1) { 
            container.find(".tilesearch-result").hide();
        }
        if(ops.hideall) { 
            container.find(".tilesearch-all").hide();
        } else { 
            container.find(".tilesearch-all").click (function () { 
                $(this).css("color", "#02ACEE");
                emptyResult();

                if(typeof ops.callback.allsearch === "function") {
                    ops.callback.allsearch.call(ops.callback.scope || this, save(), ts);
                }
            })
        }
        putOriginValues();
        container.find(".tilesearch-first-item").click(function () {

            $(this).parent().find(".tilesearch-all").css("color", "inherit");

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
                //putSaveAndClear();
                $(this).parent().find(".tilesearch-first-item").css("color", "inherit")
                $(this).css("color", "#02ACEE");
                $("<a class='tilesearch-result-item tilesearch-result-first-index'>" + $(this).text() + "</a>").prependTo(container.find(".tilesearch-result"));
                putSecondSearch(this);
            } else if (ops.select === 4) { 
                container.find(".tilesearch-result").empty();
                container.find(".tilesearch-second").hide();

                $("<a class='tilesearch-result-item' style='display:none;'>" + $(this).text() + "</a>").appendTo(container.find(".tilesearch-result"));
                $(this).parent().find(".tilesearch-first-item").css("color", "inherit")
                $(this).css("color", "#02ACEE");

                var i = 0;
                for(; i < ops.children.length; i ++) {
                    if(ops.children[i].value == $(this).text()) {
                        break;
                    }
                }
                if(typeof ops.children[i] !== "undefined" && typeof ops.children[i].children !== "undefined" && ops.children[i].children.length > 0) { 
                    putSecondSearch(this);
                }
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
        hideall : false,
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
