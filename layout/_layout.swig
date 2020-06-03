<!DOCTYPE html>

{% set html_class = 'theme-next ' + theme.scheme %}
{% if theme.motion.enable %}
  {% set html_class = html_class + ' use-motion' %}
{% endif %}

<html class="{{ html_class | lower }}" lang="{{ config.language }}">
<head>





  {% include '_partials/head.swig' %}
  <title>{% block title %}{% endblock %}</title>
  {% include '_third-party/analytics/index.swig' %}


   <!--开启列表滚动条-->
<style type="text/css">

body {
    cursor: url(https://cdn.jsdelivr.net/gh/TRHX/CDN-for-itrhx.com@2.1.6/images/mouse.cur),auto;
    background-color: @theme_background;
}
 .aplayer-list ol{
 overflow-y:auto;
 height:300px;
 width:400px;
 }

 #honehoneclock{
	position:fixed;
	top:0;
	left:0;
	z-index:999;
 }



</style>

<script src="/js/src/jquery-3.4.1.min.js" type="text/javascript"></script>
<script src="/js/src/jquery.pjax.js" type="text/javascript"></script>

</head>

<!--loading动画-->
 <script src="https://hm.baidu.com/hm.js?382f81c966395258f239157654081890"></script>

    <script type="text/javascript">
        $(document).ready(function () {
			$(".header").css({"display":"none"});
            function fixHeight() {
                $("#iframe").attr("height", $(window).height()+ "px");
            }
            $(window).resize(function () {
                fixHeight();
            }).resize();

            $('.icon-monitor').addClass('active');

            $(".icon-mobile-3").click(function () {
                $("#by").css("overflow-y", "auto");
                $('#iframe-wrap').removeClass().addClass('mobile-width-3');
                $('.icon-tablet,.icon-mobile-1,.icon-monitor,.icon-mobile-2,.icon-mobile-3').removeClass('active');
                $(this).addClass('active');
                return false;
            });

            $(".icon-mobile-2").click(function () {
                $("#by").css("overflow-y", "auto");
                $('#iframe-wrap').removeClass().addClass('mobile-width-2');
                $('.icon-tablet,.icon-mobile-1,.icon-monitor,.icon-mobile-2,.icon-mobile-3').removeClass('active');
                $(this).addClass('active');
                return false;
            });

            $(".icon-mobile-1").click(function () {
                $("#by").css("overflow-y", "auto");
                $('#iframe-wrap').removeClass().addClass('mobile-width');
                $('.icon-tablet,.icon-mobile,.icon-monitor,.icon-mobile-2,.icon-mobile-3').removeClass('active');
                $(this).addClass('active');
                return false;
            });

            $(".icon-tablet").click(function () {
                $("#by").css("overflow-y", "auto");
                $('#iframe-wrap').removeClass().addClass('tablet-width');
                $('.icon-tablet,.icon-mobile-1,.icon-monitor,.icon-mobile-2,.icon-mobile-3').removeClass('active');
                $(this).addClass('active');
                return false;
            });

            $(".icon-monitor").click(function () {
                $("#by").css("overflow-y", "hidden");
                $('#iframe-wrap').removeClass().addClass('full-width');
                $('.icon-tablet,.icon-mobile-1,.icon-monitor,.icon-mobile-2,.icon-mobile-3').removeClass('active');
                $(this).addClass('active');
                return false;
            });

            clicktoLoadingHide();
            
        });
    </script>

    <script type="text/javascript">
        function Responsive($a) {
            if ($a == true) $("#Device").css("opacity", "100");
            if ($a == false) $("#Device").css("opacity", "0");
            $('#iframe-wrap').removeClass().addClass('full-width');
            $('.icon-tablet,.icon-mobile-1,.icon-monitor,.icon-mobile-2,.icon-mobile-3').removeClass('active');
            $(this).addClass('active');
            return false;
        };
        function clicktoLoading() {
		
            $("#iframe-wrap,#iframe").css({"display":"block","z-index":"9999","position":"fixed"});
			$(".header").css({"display":"none"});
        }
        function clicktoLoadingHide() {
		setTimeout(function(){
			$("#iframe-wrap,#iframe").css({"display":"none"});	
			$(".header").css({"display":"block"});
		},500);
            
        }
    </script>

<!--loading动画结束-->


<script type="text/javascript">



function isMobile() {
  let mobile = navigator.userAgent.match(/(phone|pad|pod|iPhone|iPod|ios|iPad|Android|Mobile|BlackBerry|IEMobile|MQQBrowser|JUC|Fennec|wOSBrowser|BrowserNG|WebOS|Symbian|Windows Phone)/i)
  return mobile!= null
}

(function($){



/**
//支持表单提交事件无刷新
   $(document).on('submit', 'form', function (event) {
          //这是提交表单的pjax。form表示所有的提交表单都会执行pjax，比如搜索和提交评论，可自行修改改成你想要执行pjax的form id或class。#container 同上改成你主题的内容主体id或class。
        $.pjax.submit(event, '#container', {
            fragment:'#container', timeout:6000
        });
    });
*/


var containerId = '#mains';




    var MyApp = {
        initPjax: function(){
            var self = this;
			sidebar_show();
			/**
* 捕获 a 事件，当点击后要在 300 毫秒以后才会跳转。
*/
//搜索框新增的所有a标签绑定事件
	$('#local-search-result').on('click','a',function(event){
		console.log('target');  //被点击了
		//alert($(this).attr("href"));
		var url=$(this).attr("href");
		//alert(url);
		 setTimeout(function () {
	 $.pjax({ url: url, container: containerId, fragment: containerId, timeout: 30000 });

    }, 400);
onPopupClose();//关闭搜索框
    return false;
});


$(document).on('click', 'a[target!=_blank]', function () {

    //$("#pjax-container").fadeOut();
    //NProgress.start();
    var url = $(this).attr("href");
    setTimeout(function () {

	//$(document).pjax('a[target!=_blank]', '#pjax-container', {fragment: '#pjax-container',timeout: 30000});
        $.pjax({ url: url, container: containerId, fragment:containerId, timeout: 30000 });

    }, 300);

    return false;
});


			/**
            // 初始化
            $(document).pjax('a[target!="_blank"]', '#mains', {
            	fragment: "#mains",
            	timeout: 30000
            });
			*/
            // pjax请求开始
            $(document).on('pjax:start', function () {
				clicktoLoading();
            });
            // PJAX 渲染结束时
            $(document).on('pjax:end', function() {
                self.siteBootUp();
				//内容不显示bug
				opacity_js();

				//侧边栏bug
				sidebar_show();


	$("#comments").css({opacity: 1});






			//valine评论
			if($("#comments").length>0){
			console.log("valine 重载");
			var GUEST = ['nick','mail','link'];
    var guest = 'nick,mail,link';
    guest = guest.split(',').filter(item=>{
      return GUEST.indexOf(item)>-1;
    });

   window.valine= new Valine({
        el: '#comments' ,
        verify: false,
        notify: false,
        appId: 'M7OkzmDiLVfdEb2n2QPsyVBR-gzGzoHsz',
        appKey: 'KKlp9GtMfNQQAjFzcIBSseJo',
        placeholder: 'Just go go ~~',
        avatar:'robohash',
        guest_info:guest,
        pageSize:'10' || 10,
		 recordIP: true,
		path: window.location.pathname
    });
			}


clicktoLoadingHide();
                //在「局部刷新」时才会运行
                console.log("局部执行");
            });
            self.siteBootUp();
        },
        /*
        * Things to be execute when normal page load
        * and pjax page load.
        */
        siteBootUp: function(){
            //「局部刷新」和「页面刷新」都需要运行的代码
            console.log("全局执行");


        }
    };
    window.MyApp = MyApp;



})(jQuery);

//「页面刷新」事件触发运行
$(document).ready(function() {


    MyApp.initPjax();
});


$(document).on('pjax:complete', function () {

});

function opacity_js() {
//文章不显示
    $(".post-block").css({opacity: 1});
    $(".post-header").css({opacity: 1});
    $(".post-body").css({opacity: 1});
    $(".pagination").css({opacity: 1});

}

//侧边栏
function sidebar_show(){


//侧边栏不显示
	$("#sidebar").css({"margin-top":"358px","margin-left":"initial","opacity":"1"});
	$(".sidebar-inner").css({"display":"block","transform":"initial","opacity":"1"});
	$(".site-overview").css({"opacity":"1"});



	//点击切换侧边栏样式
				$("[data-target='post-toc-wrap']").click(function(){
				$("[data-target='post-toc-wrap']").css({"color":"#fc6423","border-bottom-color":"#fc6423"});
				$("[data-target='site-overview-wrap']").css({"color":"#555","border-bottom-color":"transparent"});
				$(".post-toc-wrap").css({"opacity":"1","transform":"translateY(0px)","display":"block"});
							$(".site-overview-wrap").css({"opacity":"0","transform":"translateY(0px)","display":"none"});
				})

				$("[data-target='site-overview-wrap']").click(function(){
				$("[data-target='site-overview-wrap']").css({"color":"#fc6423","border-bottom-color":"#fc6423"});
				$("[data-target='post-toc-wrap']").css({"color":"#555","border-bottom-color":"transparent"});
				$(".post-toc-wrap").css({"opacity":"0","transform":"translateY(0px)","display":"none"});
				$(".site-overview-wrap").css({"opacity":"1","transform":"translateY(0px)","display":"block"});
				})
				//滚动条事件  固定侧边栏
					$(document).scroll(function() {
						var scroH = $(document).scrollTop();
						if(scroH>=346){
							$(".sidebar-inner").css({"position":"fixed","top":"12px"});
						}else{
						$(".sidebar-inner").css({"position":"initial"});
						}
						});

						//侧边栏悬浮时样式判断
				$("[data-target='post-toc-wrap'],[data-target='site-overview-wrap']").hover(function(){

				if($(this).css("border-bottom-color")!="rgb(252, 100, 35)"){
					$(this).css("color","#fc6423");
				}

			},function(){

					if($(this).css("border-bottom-color")!="rgb(252, 100, 35)"){
					  $(this).css("color","#555");//非 hover时效果
				}

        });

}





</script>



<body id="by" itemscope itemtype="http://schema.org/WebPage" lang="{{ page.lang || page.language || config.language }}">


  {% set container_class = "container " %}
     <div class="headband">
	<a href="https://github.com/git-jzzz/git-jzzz.github.io" class="github-corner" aria-label="View source on GitHub"><svg width="80" height="80" viewBox="0 0 250 250" style="fill:#151513; color:#fff; position: absolute; top: 0; border: 0; right: 0;" aria-hidden="true"><path d="M0,0 L115,115 L130,115 L142,142 L250,250 L250,0 Z"></path><path d="M128.3,109.0 C113.8,99.7 119.0,89.6 119.0,89.6 C122.0,82.7 120.5,78.6 120.5,78.6 C119.2,72.0 123.4,76.3 123.4,76.3 C127.3,80.9 125.5,87.3 125.5,87.3 C122.9,97.6 130.6,101.9 134.4,103.2" fill="currentColor" style="transform-origin: 130px 106px;" class="octo-arm"></path><path d="M115.0,115.0 C114.9,115.1 118.7,116.5 119.8,115.4 L133.7,101.6 C136.9,99.2 139.9,98.4 142.2,98.6 C133.8,88.0 127.5,74.4 143.8,58.0 C148.5,53.4 154.0,51.2 159.7,51.0 C160.3,49.4 163.2,43.6 171.4,40.1 C171.4,40.1 176.1,42.5 178.8,56.2 C183.1,58.6 187.2,61.8 190.9,65.4 C194.5,69.0 197.7,73.2 200.1,77.6 C213.8,80.2 216.3,84.9 216.3,84.9 C212.7,93.1 206.9,96.0 205.4,96.6 C205.1,102.4 203.0,107.8 198.3,112.5 C181.9,128.9 168.3,122.5 157.7,114.1 C157.9,116.9 156.7,120.9 152.7,124.9 L141.0,136.5 C139.8,137.7 141.6,141.9 141.8,141.8 Z" fill="currentColor" class="octo-body"></path></svg></a><style>.github-corner:hover .octo-arm{animation:octocat-wave 560ms ease-in-out}@keyframes octocat-wave{0%,100%{transform:rotate(0)}20%,60%{transform:rotate(-25deg)}40%,80%{transform:rotate(10deg)}}@media (max-width:500px){.github-corner:hover .octo-arm{animation:none}.github-corner .octo-arm{animation:octocat-wave 560ms ease-in-out}}</style>
	</div>
  {% if theme.sidebar.position %}
    {% set container_class = container_class + 'sidebar-position-' + theme.sidebar.position %}
  {% endif %}

  <div class="{{ container_class }} {% block page_class %}{% endblock %}">
 




    <header id="header" class="header" itemscope itemtype="http://schema.org/WPHeader">
      <div class="header-inner"> {%- include '_partials/header.swig' %} </div>
    </header>
<div id="iframe-wrap">
    <iframe id="iframe" src="https://www.17sucai.com/preview/602230/2019-07-15/loading/index.html" frameborder="0" width="100%" height="97px"></iframe>
</div>
    <main id="main" class="main">
	<div id="mains">
      <div  class="main-inner">


        <div  class="content-wrap">

          <div id="content" class="content">
            {% block content %}{% endblock %}
          </div>

          {% include '_third-party/duoshuo-hot-articles.swig' %}
          {% include '_partials/comments.swig' %}
        </div>



        {% if theme.sidebar.display !== 'remove' %}
          {% block sidebar %}{% endblock %}
        {% endif %}
			</div>
     </div>
    </main>

    <footer id="footer" class="footer">
      <div class="footer-inner">
        {% include '_partials/footer.swig' %}
        {% include '_third-party/analytics/analytics-with-widget.swig' %}
        {% block footer %}{% endblock %}
      </div>
    </footer>

    {% if not theme.sidebar.b2t %}
      <div class="back-to-top">
        <i class="fa fa-arrow-up"></i>
        {% if theme.sidebar.scrollpercent %}
          <span id="scrollpercent"><span>0</span>%</span>
        {% endif %}
      </div>
    {% endif %}

    {% if theme.needmoreshare2.enable and theme.needmoreshare2.float.enable %}
      <div id="needsharebutton-float">
        <span class="btn">
          <i class="fa fa-share-alt" aria-hidden="true"></i>
        </span>
      </div>
    {% endif %}



  </div>


  {% include '_scripts/vendors.swig' %}
  {% include '_scripts/commons.swig' %}

  {% set scheme_script = '_scripts/schemes/' + theme.scheme | lower + '.swig' %}
  {% include scheme_script %}

  {% block script_extra %}{% endblock %}

  {% include '_scripts/boostrap.swig' %}

  {% include '_third-party/comments/index.swig' %}
  {% include '_third-party/search/index.swig' %}
  {% include '_third-party/analytics/lean-analytics.swig' %}
  {% include '_third-party/analytics/firestore.swig' %}
  {% include '_third-party/seo/baidu-push.swig' %}
  {% include '_third-party/needsharebutton.swig' %}
  {% include '_third-party/rating.swig' %}
  {% include '_third-party/mathjax.swig' %}
  {% include '_third-party/scroll-cookie.swig' %}
  {% include '_third-party/exturl.swig' %}

   </div>
     <!-- {% if !isMobile() %} 只能渲染模板
		alert(1);
	 {% endif %} -->
   <script type="text/javascript" >
		window.onload=function(){
		//网页加载完毕后立刻执行的操作  属性设置成功
		if(!isMobile()){
			console.log('pc');
			var new_element=document.createElement("script");
    new_element.setAttribute("type","text/javascript");
	 new_element.setAttribute("color","196,226,216");
	  new_element.setAttribute("opacity","1");
	   new_element.setAttribute("zIndex","-1");
	    new_element.setAttribute("count","199");
    new_element.setAttribute("src","//cdn.bootcss.com/canvas-nest.js/1.0.0/canvas-nest.min.js");
    document.body.appendChild(new_element);
		}
		}

   </script>
 <!--  <script type="text/javascript"
color="203,199,203" opacity='1' zIndex="-1" count="399" src="//cdn.bootcss.com/canvas-nest.js/1.0.0/canvas-nest.min.js"></script>

   -->
   <!--浏览器搞笑标题-->
<script type="text/javascript" src="/js/src/FunnyTitle.js"></script>


   <canvas class="fireworks" style="position: fixed;left: 0;top: 0;z-index: 1; pointer-events: none;" ></canvas>
<script type="text/javascript" src="//cdn.bootcss.com/animejs/2.2.0/anime.min.js"></script>
<script type="text/javascript" src="/js/src/fireworks.js"></script>




 <!--Live-2D看板娘模型-->
<script src="https://eqcn.ajz.miesnfu.com/wp-content/plugins/wp-3d-pony/live2dw/lib/L2Dwidget.min.js"></script>
<!--Live-2D看板娘模型-->
<script type="text/javascript">
    //Live-2D看板娘模型
    L2Dwidget.init({
        model: {
            //jsonpath控制显示那个小萝莉模型 //hijiki hibiki  z16  //izumi //shizuku //koharu
            jsonPath: "https://unpkg.com/live2d-widget-model-koharu@1.0.5/assets/koharu.model.json", //这里改模型，前面后面都要改
            scale: 1,
        },
        display: {
            position: "left", //设置看板娘的上下左右位置

            width: 120,  //小萝莉的宽度
            height: 200, //小萝莉的高度
            hOffset: 80,  //水平偏移
            vOffset: 10  //垂直偏移
        },
        mobile: {
            show: true,  //在移动端显示
            scale: 0.5   //移动设备上的缩放
        },
        react: {
            opacityDefault: 0.9, //设置透明度
            opacityOnHover: 0.2
        },
    });
</script>

<!--单击显示文字-->
<script type="text/javascript" src="/js/src/click_show_text.js"></script>


<!--鼠标跟随特效-->
<script type="text/javascript" src="/js/src/FollowMouse.js"></script>

<!--封面自定义颜色-->
<script src="https://cdn.jsdelivr.net/npm/color-thief-don@2.0.2/src/color-thief.js"></script>
<link rel="stylesheet" href="/dist/APlayer.min.css">
<div   id="aplayer"></div>
<script type="text/javascript" src="/dist/APlayer.min.js"></script>
<script type="text/javascript" src="/dist/music.js"></script>

                <script type="text/javascript">
<!-- 根据封面自适应主题色，主要是作用于进度条 -->
                      const colorThief = new ColorThief();
                      const setTheme = (index) => {
                        if (!ap.list.audios[index].theme) {
                          colorThief.getColorAsync(ap.list.audios[index].cover, function(color) {
                            ap.theme(`rgb(${color[0]}, ${color[1]}, ${color[2]})`, index);
                          });
                        }
                      };
                      setTheme(ap.list.index);
                      ap.on('listswitch', (data) => {
                        setTheme(data.index);
                      });
                </script>

</body>
 <!--人体时钟背景透明-->
  <script type="text/javascript" charset="Shift_JIS" src="/js/src/clock/honehone_clock_tr.js"></script>


</html>
