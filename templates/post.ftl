<!DOCTYPE html>
<html>
<#include "head.ftl">
<body class="">
  <div class="site-wrap">
    <#include "header.ftl">

    <div class="post p2 p-responsive wrap" role="main">
      <div class="measure">
		<div class="post-header mb2">
		  <h1 class="py2"><#escape x as x?xml>${content.title}</#escape></h1>
		  <span class="post-meta">${content.date?string("yyyy年MM月dd日")}</span><br>
		  <#-- <span class="post-meta small">{{ minutes }} minute read</span> -->
		</div>

		<article class="post-content">
		  ${content.body}
		</article>
		
<script type="text/javascript">
(function(){
var url = "http://widget.weibo.com/distribution/comments.php?width=0&url=auto&border=1&brandline=y&appkey=2941738165&dpc=1";
url = url.replace("url=auto", "url=" + encodeURIComponent(document.URL)); 
document.write('<iframe id="WBCommentFrame" src="' + url + '" scrolling="no" frameborder="0" style="width:100%"></iframe>');
})();
</script>
<script src="http://tjs.sjs.sinajs.cn/open/widget/js/widget/comment.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript">
window.WBComment.init({
    "id": "WBCommentFrame"
});
</script>
		
		<#include "post_footer.ftl">
      </div>
    </div>
  </div>

  <#include "footer.ftl">
</body>
</html>