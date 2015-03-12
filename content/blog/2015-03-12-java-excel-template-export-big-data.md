title=POI根据Excel模板导出大数据
date=2015-03-12
type=post
tags=java,poi,excel,大数据
status=published
~~~~~~

在一些项目中,需要导出数据, 如果编程实现POI样式等比较麻烦,所以一般根据模板来导出数据,之前使用过JXLS来实现,对于小数据比较好用,但是对于数据量比较大就比较慢,甚至死掉,不能导出.

经过一段时间研究POI,发现POI的SXSSF支持大数据导出,经过测试有很好的性能.实现有两种思路:

 * 通过Excel文件copy样式等, 经过长时间验证和测试,有缺陷,会丢掉一些样式,不能完美达到目标
 * 通过修改模板文件,然后直接输出,经过测试验证,这种能够很好的解决大数据导出问题.
 
下面我们给出第二种思路的具体实现,经过测试导出5W条数据大概需要4S,这个测试结果非常快. 如果使用标准POI XSSF来实现,会卡死不会输出.

```java
/**
     * 根据Excel模板导出数据,支持大数据导出
     *
     * @param templateInputStream
     * @param data
     * @param outputStream
     * @param <T>
     * @throws IOException
     * @throws InvalidFormatException
     */
public static <T> void generateExcel(InputStream templateInputStream, Iterator<T> data, OutputStream outputStream) throws IOException, InvalidFormatException {
	// 通过类加载器获取模板
	XSSFWorkbook workbook = new XSSFWorkbook(templateInputStream);
	XSSFSheet sheet = workbook.getSheetAt(0);
	XSSFRow row = sheet.getRow(1);

	List<CellStyle> cellStyles = new ArrayList<CellStyle>();
	List<String> cellValues = new ArrayList<String>();
	Map<Integer, String> cellFormatMap = new HashMap<Integer, String>();
	Pattern pattern = Pattern.compile("^\\$\\{([\\w\\.]+)\\}$");
	for (int i = 0; i < row.getLastCellNum(); i++) {
		XSSFCell cell = row.getCell(i);
		cellStyles.add(cell.getCellStyle());
		String cellValue = cell.getStringCellValue();
		cellValues.add(cellValue);
		if (cellValue != null) {
			Matcher matcher = pattern.matcher(cellValue);
			if (matcher.find()) {
				cellFormatMap.put(i, matcher.group(1));
			}
		}
	}

	sheet.removeRow(row);
	SXSSFWorkbook newWorkbook = new SXSSFWorkbook(workbook); // keep 100 rows in memory, exceeding rows will be flushed to disk
	Sheet newSheet = newWorkbook.getSheetAt(0);
	int rowNum = 1;
	while (data.hasNext()) {
		T t = data.next();
		JSONObject item = null;
		if (t instanceof JSONObject) {
			item = (JSONObject) t;
		} else {
			String json = JSON.toJSONString(t);
			item = JSON.parseObject(json);
		}

		Row newRow = newSheet.createRow(rowNum);
		for (int i = 0; i < cellValues.size(); i++) {
			Cell newCell = newRow.createCell(i);
			newCell.setCellStyle(cellStyles.get(i));
			String newCellValue = cellValues.get(i);
			if (newCellValue != null && cellFormatMap.containsKey(i)) {
				newCellValue = JsonUtils.getJSONValue(item, cellFormatMap.get(i));
			}
			newCell.setCellValue(newCellValue);
		}

		rowNum++;
	}
	newWorkbook.write(outputStream);
}
```
