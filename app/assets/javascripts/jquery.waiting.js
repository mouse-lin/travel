(function($){

$.fn.waiting = function(options) {
	var settings = $.extend({
		css: {'opacity':'0.6','background-color':'#777'},
		imgsrc: "aj-blue.gif"
	},options);
	var offset = this.offset();
	var height = this.height();
	var width = this.width();
	var id = this[0].id;
	var newid = id + "waiting";
	this[0].waitid = newid;
	var div = $("<div />").css({'position':'absolute','top':offset.top,'left':offset.left,'height':height,'width':width}).css(settings.css)
	.attr('id',newid).appendTo("body");
	var img = $("<img />").attr("src",settings.imgsrc);
	var imgheight = img.height();
	var imgwidth = img.width();
	img.css({'position':'absolute','top':((height/2)-(imgheight/2))/*offset.top +(height/2)-(imgheight/2)*/,'left':((width/2)-(imgwidth/2)),'z-index':3000});
	img.appendTo(div);
	return this;
}

$.fn.stopWaiting = function() {
	var waitid = this[0].waitid;
	$("#"+waitid).remove();
	return this;
}

})(jQuery);
