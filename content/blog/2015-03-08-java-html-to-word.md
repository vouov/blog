title=Java中HTML转Word文档实现
date=2015-03-08
type=post
tags=java,html,word
status=published
~~~~~~

有这样一个需求,我们要把数据库中的HTML格式文本字段导出为word,尝试了很多方法终于找到一种比较理想的方法.
首先我们把HTML文本通过jsoup整理成xhtml,然后通过docx4j转换成word.
HTML转换成xhtml还有一个jtidy,但是因为好久没有更新,并且有bug,所以推荐使用jsoup来整理.

docx4j的maven依赖:

```xml
<dependency>
	<groupId>org.docx4j</groupId>
	<artifactId>docx4j-ImportXHTML</artifactId>
	<version>3.2.2</version>
</dependency>
<dependency>
	<groupId>org.jsoup</groupId>
	<artifactId>jsoup</artifactId>
	<version>1.8.1</version>
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

xhtml转换成word的java代码参考实现如下:

```java
/**
 * html文本转换为word
 *
 * @param html
 * @param baseURL
 * @param os
 * @throws Docx4JException
 */
public static void html2Docx(String html, String baseURL, OutputStream os) throws Docx4JException {

	// To docx, with content controls
	WordprocessingMLPackage wordMLPackage = WordprocessingMLPackage.createPackage();

	XHTMLImporterImpl XHTMLImporter = new XHTMLImporterImpl(wordMLPackage);
	//XHTMLImporter.setDivHandler(new DivToSdt());
	wordMLPackage.getMainDocumentPart().getContent().addAll(
			XHTMLImporter.convert(html, baseURL));

	/*System.out.println(XmlUtils.marshaltoString(wordMLPackage
			.getMainDocumentPart().getJaxbElement(), true, true));*/

	wordMLPackage.save(os);
}
```
