{% extends '_layout.swig' %}
{% import '_macro/post.swig' as post_template %}
{% import '_macro/sidebar.swig' as sidebar_template %}


{% block title %}{{ page.title }} | {{ config.title }}{% endblock %}

{% block page_class %}page-post-detail{% endblock %}


{% block content %}

 {% if page.copyright %}
      <script>
          function setClipboardText(event){
              // clipboardData 对象是为通过编辑菜单、快捷菜单和快捷键执行的编辑操作所保留的，也就是你复制或者剪切内容
              let clipboardData = event.clipboardData || window.clipboardData;
              // 如果未复制或者未剪切，则return出去
              if (!clipboardData) { return; }
              event.preventDefault();
              // Selection 对象，表示用户选择的文本范围或光标的当前位置。
              //     声明一个变量接收 -- 用户输入的剪切或者复制的文本转化为字符串
              let text = window.getSelection().toString();
    
              if (text) {
                // 如果文本存在则先取消文本默认事件
                event.preventDefault();
                // 通过调用常clipboardData对象的 setData(format, data) 方法；来设置相关文本
                // format: 一个DOMString 表示要添加到 drag object的拖动数据的类型。
                // data: 一个 DOMString表示要添加到 drag object的数据。
                var copyright = '\n\n'
                                + '\n著作权归作者所有。'
                                + '\n商业转载请联系作者获得授权，非商业转载请注明出处。'
                                + '\n作者: jzz'
                                + '\n邮箱: root_jz@163.com'
                                + '\n原文地址: {{ page.permalink }}'
    
                clipboardData.setData('text/plain', text + copyright);
    
              }
          };
          var contents = document.getElementsByClassName("content");
          // 监听文章内容的copy事件
          contents[0].addEventListener('copy',function(e){
              setClipboardText(e);
          });
      </script>
{% endif %}





  <div id="posts" class="posts-expand">
    {{ post_template.render(page) }}

    <div class="post-spread">
      {% if theme.jiathis %}
        {% include '_partials/share/jiathis.swig' %}
      {% elseif theme.baidushare %}
        {% include '_partials/share/baidushare.swig' %}
      {% elseif theme.add_this_id %}
        {% include '_partials/share/add-this.swig' %}
      {% elseif theme.duoshuo_shortname and theme.duoshuo_share %}
        {% include '_partials/share/duoshuo_share.swig' %}
      {% endif %}
    </div>
  </div>

{% endblock %}

{% block sidebar %}
  {{ sidebar_template.render(true) }}
{% endblock %}

{% block script_extra %}
  {% include '_scripts/pages/post-details.swig' %}
{% endblock %}
