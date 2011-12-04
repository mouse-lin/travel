$.Move = function(_this){
     if(typeof(_this)=='object'){
         _this=_this;
     }else{
         _this=$("#"+_this);
     }
     if(!_this){return false;}

     _this.css({'position':'absolute'}).hover(function(){$(this).css("cursor","move");},function(){$(this).css("cursor","default");})
     _this.mousedown(function(e){

         var offset = $(this).offset();
         var x = e.pageX - offset.left;
         var y = e.pageY - offset.top;
         _this.css({'opacity':'1'});
         $(document).bind("mousemove",function(ev){//绑定鼠标的移动事件，因为光标在DIV元素外面也要有效果，所以要用doucment的事件，而不用DIV元素的事件
             _this.bind('selectstart',function(){return false;});
             var _x = ev.pageX - x;//获得X轴方向移动的值
             var _y = ev.pageY - y;//获得Y轴方向移动的值
             _this.css({'left':_x+"px",'top':_y+"px"});
         });
     });

     $(document).mouseup(function(){
         $(this).unbind("mousemove");
         _this.css({'opacity':''});
     })
 };
