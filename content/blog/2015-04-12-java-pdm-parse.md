title=java解析PDM中的表和字段以及类型
date=2015-04-12
type=post
tags=java,pdm
status=published
~~~~~~

PDM的项目文件其实都是XML文档,所以只要找到对应的标签就能找到对应的表和字段,解析XML文件我们采用的dom4j的xpath查找.
具体代码实现如下:

```
public class PDMHelper {
    public static final String TABLES_TAG = "c:Tables";
    public static final String TABLE_TAG = "o:Table";
    public static final String TABLE_NAME_TAG = "a:Code";
    public static final String TABLE_DESC_TAG = "a:Name";
    public static final String COLUMNS_TAG = "c:Columns";
    public static final String COLUMN_TAG = "o:Column";
    public static final String COLUMN_NAME_TAG = "a:Code";
    public static final String COLUMN_DESC_TAG = "a:Name";
    public static final String COLUMN_DATA_TYPE_TAG = "a:DataType";
    public static final String COLUMN_DATA_LEN_TAG = "a:Length";
    public static final String COLUMN_MANDATORY_TAG = "a:Column.Mandatory";
	public static void parsePDM(String file) throws Exception {
		SAXReader reader = new SAXReader();
		Document document = reader.read(new File(file));
		List<Node> tables = document.selectNodes("//" + TABLES_TAG + "/" + TABLE_TAG);
		for (Node table : tables) {
			Node tableName = table.selectSingleNode(TABLE_NAME_TAG);
			Node tableDesc = table.selectSingleNode(TABLE_DESC_TAG);
			System.out.println(tableName.getText() + "\t" + tableDesc.getText());
			List<Node> columns = table.selectNodes(COLUMNS_TAG + "/" + COLUMN_TAG);
			for (Node column : columns) {
				Node columnName = column.selectSingleNode(COLUMN_NAME_TAG);
				Node columnDesc = column.selectSingleNode(COLUMN_DESC_TAG);
				Node dataType = column.selectSingleNode(COLUMN_DATA_TYPE_TAG);
				//Node dataLength = column.selectSingleNode("./" + COLUMN_DATA_LEN_TAG);
				System.out.println("\t\t" + columnName.getText() + "\t" 
				+ dataType.getText() + "\t" + columnDesc.getText());
			}
		}
	}
}
```