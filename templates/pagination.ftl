<div class="pagination clearfix mb1 mt4">
  <div class="left">
	<#if pagination_pre>
        <a class="pagination-item" href="${pagination_pre_url}">上一页</a>
    <#else>
		<span class="pagination-item disabled">上一页</span>
    </#if>
  </div>
  <div class="right">
    <#if pagination_next>
      <a class="pagination-item" href="${pagination_next_url}">下一页</a>
    <#else>
      <span class="pagination-item disabled">下一页</span>
    </#if>
  </div>
</div>
