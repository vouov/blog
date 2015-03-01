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
		  <span class="post-meta">${content.date?string("yyyy年MM月dd日")}</span>
		  
		  <span class="bdsharebuttonbox" style="float:right;"><a href="#" class="bds_more" data-cmd="more"></a><a href="#" class="bds_weixin" data-cmd="weixin" title="分享到微信"></a><a href="#" class="bds_tsina" data-cmd="tsina" title="分享到新浪微博"></a><a href="#" class="bds_qzone" data-cmd="qzone" title="分享到QQ空间"></a><a href="#" class="bds_douban" data-cmd="douban" title="分享到豆瓣网"></a><a href="#" class="bds_youdao" data-cmd="youdao" title="分享到有道云笔记"></a><a href="#" class="bds_fbook" data-cmd="fbook" title="分享到Facebook"></a><a href="#" class="bds_linkedin" data-cmd="linkedin" title="分享到linkedin"></a><a href="#" class="bds_twi" data-cmd="twi" title="分享到Twitter"></a><a href="#" class="bds_print" data-cmd="print" title="分享到打印"></a></span>
<script>window._bd_share_config={"common":{"bdSnsKey":{},"bdText":"","bdMini":"2","bdMiniList":["mshare","weixin","tsina","douban","youdao","bdhome","thx","ibaidu","taobao","hi","meilishuo","mogujie","fbook","twi","print","copy","linkedin","diandian","huaban","duitang","hx","fx","sdo","qingbiji","people","xinhua","mail","kanshou","isohu","yaolan","wealink","ty","iguba"],"bdPic":"","bdStyle":"1","bdSize":"24"},"share":{}};with(document)0[(getElementsByTagName('head')[0]||body).appendChild(createElement('script')).src='http://bdimg.share.baidu.com/static/api/js/share.js?v=89860593.js?cdnversion='+~(-new Date()/36e5)];</script>
		  
		  <#-- <span class="post-meta small">{{ minutes }} minute read</span> -->
		  <br style="clear:both;"/>
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