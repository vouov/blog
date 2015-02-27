<!DOCTYPE html>
<html>
<#include "head.ftl">
<body class="">
  <div class="site-wrap">
    <#include "header.ftl">

    <div class="post p2 p-responsive wrap" role="main">
      <div class="measure">
        <div class="post">
		  <header class="post-header">
			<h1 class="h2">${content.title}</h1>
		  </header>
		  <article class="post-content">
		  ${content.body}
		  </article>
		</div>
      </div>
    </div>
  </div>

  <#include "footer.ftl">
</body>
</html>