<!DOCTYPE html>
<html>
<#include "head.ftl">
<body class="">
  <div class="site-wrap">
    <#include "header.ftl">

    <div class="post p2 p-responsive wrap" role="main">
      <div class="measure">
	  <ul>
		<#list published_posts as post>
		<#if (last_month)??>
			<#if post.date?string("MMMM yyyy") != last_month>
				</ul>
				<h4>${post.date?string("yyyy年MM月")}</h4>
				<ul>
			</#if>
		<#else>
			<h4>${post.date?string("yyyy年MM月")}</h4>
			<ul>
		</#if>
		
		<li>${post.date?string("dd")} - <a href="${post.uri}"><#escape x as x?xml>${post.title}</#escape></a></li>
		<#assign last_month = post.date?string("MMMM yyyy")>
		</#list>
		</ul>
	</div>
    </div>
  </div>

  <#include "footer.ftl">
</body>
</html>