title=Java中HTML转PDF文档实现
date=2015-03-09
type=post
tags=java,html,pdf
status=published
~~~~~~

之前我们讲述了如果通过html转换成word文档,现在我们讲述如何通过java实现转换HTML为PDF文档.
首先我们把HTML文本通过jsoup整理成xhtml,然后通过flying-saucer-pdf-itext5或者itextpdf xmlworker转换成PDF.
对于flying-saucer和itextpdf xmlworker都可以转换xhtml为PDF,但是在使用中我们发现flying-saucer对于样式的转换更加自然,而itextpdf的转换会丢失部分样式,所以接下来我们会给出两种实现方式,方便根据需要选择其中一种.

itextpdf xmlworker的maven依赖:

```xml
<dependency>
	<groupId>com.itextpdf</groupId>
	<artifactId>itextpdf</artifactId>
	<version>5.5.4</version>
</dependency>
<dependency>
	<groupId>com.itextpdf.tool</groupId>
	<artifactId>xmlworker</artifactId>
	<version>5.5.4</version>
</dependency>
```

flying-saucer的maven依赖:

```xml
<dependency>
	<groupId>org.xhtmlrenderer</groupId>
	<artifactId>flying-saucer-pdf-itext5</artifactId>
	<version>9.0.7</version>
</dependency>
```

html转成xhtml的jsoup参考实现如下:

```java
/**
 * 清理HTML内容,转换成标准xhtml
 * @param html
 * @return
 */
public static String tidyHtml(String html){
	Document doc = Jsoup.parse(html);
	// Clean the document.
	//doc = new Cleaner(Whitelist.basicWithImages()).clean(doc);
	doc.outputSettings().escapeMode(Entities.EscapeMode.xhtml);
	doc.outputSettings().prettyPrint(true);

	doc.outputSettings().syntax(Document.OutputSettings.Syntax.xml);
	// Get back the string of the body.
	return doc.html();
}
```

html转换成PDF的itextpdf xmlworker代码参考实现如下:

```java
/**
 * 使用IText默认实现
 *
 * @param html
 * @param baseURL
 * @param os
 * @throws DocumentException
 * @throws IOException
 */
public static void html2Pdf(String html, String baseURL, OutputStream os) throws DocumentException, IOException {
	String xhtml = HtmlUtils.tidyHtml(html);
	xhtml = HtmlUtils.fillImageURL(xhtml, baseURL, null);
	// step 1
	Document document = new Document();
	// step 2
	PdfWriter writer = PdfWriter.getInstance(document, os);
	// step 3
	document.open();
	// step 4
	XMLWorkerHelper.getInstance().parseXHtml(writer, document, new ByteArrayInputStream(xhtml.getBytes("UTF-8")), Charset.forName("UTF-8"));
	//step 5
	document.close();
}
```

html转换成PDF的flying-saucer代码参考实现如下:

```java
/**
 * 使用flying-saucer-pdf-itext5实现
 *
 * @param html
 * @param baseURL
 * @param os
 * @throws IOException
 * @throws DocumentException
 */
public static void html2Pdf(String html, String baseURL, OutputStream os) throws IOException, DocumentException {
	ITextRenderer renderer = new ITextRenderer();
	String xhtml = HtmlUtils.tidyHtml(html);

	renderer.setDocumentFromString(xhtml, baseURL);

	// 解决中文支持问题
	ITextFontResolver fontResolver = renderer.getFontResolver();
	fontResolver.addFont("C:/Windows/Fonts/SIMSUN.TTC", BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);
	//解决图片的相对路径问题
	renderer.getSharedContext().setBaseURL(baseURL);
	renderer.layout();
	renderer.createPDF(os);
}
```
