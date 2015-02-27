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
      </div>
    </div>
  </div>

  <#include "footer.ftl">
</body>
</html>