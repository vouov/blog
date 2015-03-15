<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<title><#if (content.title)??><#escape x as x?xml>${content.title}</#escape><#else>清晨迷雾</#if></title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta name="description" content="">
	<meta name="author" content="">
	<meta name="keywords" content="">
	<meta name="generator" content="清晨迷雾">

	<!-- Fav and touch icons -->
	<link rel="shortcut icon" href="<#if (content.rootpath)??>${content.rootpath}<#else></#if>favicon.ico">

	<!-- Custom CSS -->
	<link rel="stylesheet" href="<#if (content.rootpath)??>${content.rootpath}<#else></#if>css/pixyll.css" type="text/css">

	<!-- Fonts -->
	<link href='//fonts.useso.com/css?family=Merriweather:900,900italic,300,300italic' rel='stylesheet' type='text/css'>
	<link href='//fonts.useso.com/css?family=Lato:900,300' rel='stylesheet' type='text/css'>
	<link href="//maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" rel="stylesheet">
	<link rel="stylesheet" href="<#if (content.rootpath)??>${content.rootpath}<#else></#if>css/highlight/default.css">
	<script src="<#if (content.rootpath)??>${content.rootpath}<#else></#if>js/highlight.pack.js"></script>
	<script>hljs.initHighlightingOnLoad();</script>
</head>