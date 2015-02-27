<!DOCTYPE html>
<html>
<#include "head.ftl">
<body class="">
  <div class="site-wrap">
    <#include "header.ftl">
    <div class="post p2 p-responsive wrap" role="main">
      <div class="measure">
		<div class="home">
		  <div class="posts">
			<#list pagination_posts as post>
				<#if (post.status == "published")>
					<div class="post">
						<a href="${post.uri}" class="post-link">
						  <h3 class="h2 post-title"><#escape x as x?xml>${post.title}</#escape></h3>
						  <p class="post-meta">${post.date?string("yyyy年MM月dd日")}</p>
						  <p class="post-summary">${post.body}</p>
						</a>
					 </div>
				</#if>
			</#list>
		  </div>
		  <#include "pagination.ftl">
		</div>
      </div>
    </div>
  </div>

  <#include "footer.ftl">
</body>
</html>


	

