/*
	文件：WordReportUtil.js
	描述：规则操作函数
	作者：孙兵
	日期：2010-11-08
*/
//如果所选内容位于表格中，则该参数返回 True。
var wdWithInTable = 12;
//返回表格列号，在该表格列中包含所选内容或区域的起点。
var wdStartOfRangeColumnNumber = 16;
//返回表格行号，在该表格行中包含所选内容或区域的起点。
var wdStartOfRangeRowNumber = 13;
//返回表格列号，在该表格列中包含指定的所选内容或区域的结尾。
var wdEndOfRangeColumnNumber = 17;
//返回表格行号，在该表格行中包含指定的所选内容或区域的结尾。
var wdEndOfRangeRowNumber = 14;
/*
	函数：createAutoText
	描述：创建自动填写的文本域
	参数：wordDocument	Word文档对象
		  ruleName		规则名称
	返回值：成功返回true，失败返回false
*/
function createAutoText(wordDocument, ruleName) {
	try {
		//取当前文档的选区
		var wordSelection = wordDocument.ActiveWindow.Selection;
		//取当前选区对应的区域对象
		var wordRange = wordDocument.Range(wordSelection.Range.Start, wordSelection.Range.End);
		//修改区域对象内文本属性
		wordRange.Text = "${" + ruleName + "}";
		//根据当前区域创建书签
		wordDocument.Bookmarks.Add(ruleName, wordRange);
		return true;
	} catch (e)	{
		alert(e);
		return false;
	}
}
/*
	函数：deleteAutoText
	描述：删除自动填写的文本域
	参数：wordDocument	Word文档对象
		  ruleName		规则名称
	返回值：成功返回true，失败返回false
*/
function deleteAutoText(wordDocument, ruleName) {
	try {
		//判断书签是否存在
		if (wordDocument.Bookmarks.Exists(ruleName)) {
			//删除当前书签区域，书签自动删除
			wordDocument.Bookmarks(ruleName).Range.Delete();
		}
		return true;
	} catch (e) {
		alert(e);
		return false;
	}
}
/*
	函数：setAutoTextValue
	描述：设置自动填写文本域的值
	参数：wordDocument	Word文档对象
		  ruleName		规则名称
		  textValue		将设置的值
	返回值：成功返回true，失败返回false
*/
function setAutoTextValue(wordDocument, ruleName, textValue) {
	try {
		//判断书签是否存在
		if (wordDocument.Bookmarks.Exists(ruleName)) {
			//获取书签区域
			var wordRange = wordDocument.Bookmarks(ruleName).Range;
			//修改书签区域文本属性，书签将丢失
			wordRange.Text = textValue;
			//根据当前区域重新定义书签
			wordDocument.Bookmarks.Add(ruleName, wordRange);
			return true;
		} else {
			return false;
		}
	} catch (e) {
		alert(e);
		return false;
	}
}
/*
	函数：createAutoOrderlyTable
	描述：创建自动填写的规则表格，可以选择同一表格中的一行、一行中连续的单元格、一列或一列中连续的单元格
	参数：wordDocument	Word文档对象
		  ruleName		规则名称
		  textValue		将设置的值
	返回值：成功返回true，失败返回false
*/
function createAutoOrderlyTable(wordDocument, ruleName) {
	try {
		var hint = "请选择同一表格中的一行、一行中连续的单元格、一列或一列中连续的单元格！";
		//取当前文档的选区
		var wordSelection = wordDocument.ActiveWindow.Selection;
		//判断选区是否在表格中
		if (wordSelection.Information(wdWithInTable)) {
			//光标在单元格内单独处理
			if (wordSelection.Cells.Count == 1) {
				//选中光标所在的单元格
				wordSelection.Cells.Item(1).Select();
			}
			//根据当前选区创建书签
			var wordBookmark = wordDocument.Bookmarks.Add(ruleName, wordSelection.Range);
			//判断书签是否为空
			if (!wordBookmark.Empty) {
				//选择多行或者多列
				if (wordSelection.Rows.Count != 1 && wordSelection.Columns.Count != 1) {
					//由于不符合选择要求，删除书签
					wordBookmark.Delete();
					alert("不能同时选择多行或者多列！\n" + hint);
					return false;
				} else {
					//取选区的行列信息
					var startRowNumber = wordSelection.Information(wdStartOfRangeRowNumber);
					var endRowNumber = wordSelection.Information(wdEndOfRangeRowNumber);
					var startColumnNumber = wordSelection.Information(wdStartOfRangeColumnNumber);
					var endColumnNumber = wordSelection.Information(wdEndOfRangeColumnNumber);
					//获取行列所在的表格
					var wordTable = wordSelection.Tables.Item(1);
					//如果为一行
					if (wordSelection.Rows.Count == 1) {
						for (var i = startColumnNumber; i <= endColumnNumber; i++) {
							//为选中的连续单元格（行）做标识
							wordTable.Cell(startRowNumber, i).Range.Text = "${" + ruleName + "[" + (i - startColumnNumber)+ "]↓}";
						}
					} else { //如果为一列
						for (var i = startRowNumber; i <= endRowNumber; i++) {
							//为选中的连续单元格（列）做标识
							wordTable.Cell(i, startColumnNumber).Range.Text = "${" + ruleName + "[" + (i - startRowNumber)+ "]→}";
						}
					}
				}
			} else {
				//由于不符合选择要求，删除书签
				wordBookmark.Delete();
				alert("必须选择同一表格内连续的行或者列！\n" + hint);
				return false;
			}
		} else {
			alert("所选内容必须全部位于表格中！\n" + hint);
			return false;
		}
		return true;
	} catch (e) {
		alert(e);
		return false;
	}
}
/*
	函数：deleteAutoOrderlyTable
	描述：删除自动填写的规则表格
	参数：wordDocument	Word文档对象
		  ruleName		规则名称
	返回值：成功返回true，失败返回false
*/
function deleteAutoOrderlyTable(wordDocument, ruleName) {
	try {
		//判断书签是否存在
		if (wordDocument.Bookmarks.Exists(ruleName)) {
			//选中书签内容
			wordDocument.Bookmarks(ruleName).Select();
			//取当前文档选区
			var wordSelection = wordDocument.ActiveWindow.Selection;
			//取选区的行列信息
			var startRowNumber = wordSelection.Information(wdStartOfRangeRowNumber);
			var endRowNumber = wordSelection.Information(wdEndOfRangeRowNumber);
			var startColumnNumber = wordSelection.Information(wdStartOfRangeColumnNumber);
			var endColumnNumber = wordSelection.Information(wdEndOfRangeColumnNumber);
			//获取行列所在的表格
			var wordTable = wordSelection.Tables.Item(1);
			//如果为一行
			if (wordSelection.Rows.Count == 1) {
				for (var i = startColumnNumber; i <= endColumnNumber; i++) {
					//取消单元格（行）的标识
					wordTable.Cell(startRowNumber, i).Range.Text = "";
				}
			} else { //如果为一列
				for (var i = startRowNumber; i <= endRowNumber; i++) {
					//取消单元格（列）的标识
					wordTable.Cell(i, startColumnNumber).Range.Text = "";
				}
			}
			//删除当前书签
			wordDocument.Bookmarks(ruleName).Delete();
			return true;
		} else {
			if(wordDocument.Bookmarks.Exists(ruleName)){
				//选中书签内容
				wordDocument.Bookmarks(ruleName).Select();
				//取当前文档选区
				var wordSelection = wordDocument.ActiveWindow.Selection;
				//取选区的行列信息
				var startRowNumber = wordSelection.Information(wdStartOfRangeRowNumber);
				var endRowNumber = wordSelection.Information(wdEndOfRangeRowNumber);
				var startColumnNumber = wordSelection.Information(wdStartOfRangeColumnNumber);
				var endColumnNumber = wordSelection.Information(wdEndOfRangeColumnNumber);
				//获取行列所在的表格
				var wordTable = wordSelection.Tables.Item(1);
				//如果为一行
				if (wordSelection.Rows.Count == 1) {
					for (var i = startColumnNumber; i <= endColumnNumber; i++) {
						//取消单元格（行）的标识
						wordTable.Cell(startRowNumber, i).Range.Text = "";
					}
				} else { //如果为一列
					for (var i = startRowNumber; i <= endRowNumber; i++) {
						//取消单元格（列）的标识
						wordTable.Cell(i, startColumnNumber).Range.Text = "";
					}
				}
				//删除当前书签
				wordDocument.Bookmarks(ruleName).Delete();
				return true;
			}
		}
		return true;
	} catch (e) {
		alert(e);
		return false;
	}
}
/*
	函数：setAutoOrderlyTable
	描述：设置自动填写的规则表格单元格的值
	参数：wordDocument	Word文档对象
		  ruleName		规则名称
		  tableValues	二维数组
	返回值：成功返回true，失败返回false
*/
function setAutoOrderlyTable(wordDocument, ruleName, tableValues) {
	try {
		//选中书签内容
		wordDocument.Bookmarks(ruleName).Select();
		//取当前文档选区
		var wordSelection = wordDocument.ActiveWindow.Selection;
		//取选区信息
		var startRowNumber = wordSelection.Information(wdStartOfRangeRowNumber);
		var endRowNumber = wordSelection.Information(wdEndOfRangeRowNumber);
		var startColumnNumber = wordSelection.Information(wdStartOfRangeColumnNumber);
		var endColumnNumber = wordSelection.Information(wdEndOfRangeColumnNumber);
		//取选区所在表格
		var wordTable = wordSelection.Tables.Item(1);
		//如果是行

		if (endRowNumber - startRowNumber == 0) {
			for (var i = startColumnNumber; i <= endColumnNumber; i++) {
				//清除单元格标识信息，如果不清楚拆分单元格格式会发生变化
				wordTable.Cell(startRowNumber, i).Range.Text = "";
			}
			/*
				1.单元格拆分每次最多13行
				2.一次拆分能增加“拆分行数-1“行
			*/
			var loopCount = parseInt((tableValues.length - 1) / 12); //计算需要多次拆分的次数，每次拆分能增加12行
			var modCount = (tableValues.length - 1) % 12; //不需要多次拆分的行数
			var wordRange = null;
			//进行多次拆分
			for (var i = 0, count = loopCount; i < count; i++) {
				//取书签区域的第一行，拆分后书签区域将增加
				wordRange = wordDocument.Range(wordDocument.Bookmarks(ruleName).Range.Cells(1).Range.Start, wordDocument.Bookmarks(ruleName).Range.Cells(endColumnNumber - startColumnNumber + 1).Range.End);
				wordRange.Cells.Split(13, endColumnNumber - startColumnNumber + 1, true);
			}
			if (modCount > 0) {
				wordRange = wordDocument.Range(wordDocument.Bookmarks(ruleName).Range.Cells(1).Range.Start, wordDocument.Bookmarks(ruleName).Range.Cells(endColumnNumber - startColumnNumber + 1).Range.End);
				wordRange.Cells.Split(modCount + 1, endColumnNumber - startColumnNumber + 1, true);
			}
			//需重新获取表格，拆分后表格引用丢失
			wordTable = wordDocument.Bookmarks(ruleName).Range.Tables.Item(1);
			for (var rowNumber = startRowNumber, endRow = startRowNumber + tableValues.length - 1; rowNumber <= endRow; rowNumber++) {
				for (var columnNumber = startColumnNumber, endColumn = endColumnNumber; columnNumber <= endColumn; columnNumber++) {
					//根据tableValues给单元格赋值
					wordTable.Cell(rowNumber, columnNumber).Range.Text = (tableValues[rowNumber - startRowNumber][columnNumber - startColumnNumber]) ? tableValues[rowNumber - startRowNumber][columnNumber - startColumnNumber] : "";
				}
			}
		} else {

			//表格最大列数限制63行
			var allowColumnCount = (tableValues.length > (64 - wordTable.Columns.Count)) ? (64 - wordTable.Columns.Count) : tableValues.length;
			//按照连续单元格数量及tableVaues长度拆分当前选区
			wordSelection.Cells.Split(endRowNumber - startRowNumber + 1, allowColumnCount, true);
			//需重新获取表格，拆分后表格引用丢失
			wordTable = wordDocument.Bookmarks(ruleName).Range.Tables.Item(1);
			for (var columnNumber = startColumnNumber, endColumn = startColumnNumber + allowColumnCount - 1; columnNumber <= endColumn; columnNumber++) {
				for (var rowNumber = startRowNumber, endRow = endRowNumber; rowNumber <= endRow; rowNumber++) {
					//根据tableValues给单元格赋值
					wordTable.Cell(rowNumber, columnNumber).Range.Text = (tableValues[columnNumber - startColumnNumber][rowNumber - startRowNumber]) ? tableValues[columnNumber - startColumnNumber][rowNumber - startRowNumber] : "";
				}
			}
		}
		return true;
	} catch (e) {
		alert(e.message);
		return false;
	}
}
/*
	函数：createTextInput
	描述：创建手工填写文本区域
	参数：wordDocument		Word文档对象
		  ruleName			规则名称
		  options			可选参数
			statusText		当窗体域具有焦点时状态栏中显示的文本
			helpText		当窗体域具有焦点并且用户按 F1 时在消息框中显示的文本
			defaultValue	代表默认文本框内容的文本
	返回值：成功返回true，失败返回false
*/
function createTextInput(wordDocument, ruleName, options) {
	try {
		options = (options) ? options : {};
		//FormText 域
		var wdFieldFormTextInput = 70;
		//常规文字型域
		var wdRegularText = 0;
		//取当前文档选区
		var wordSelection = wordDocument.ActiveWindow.Selection;
		//体检FormText域
		var wordFormField = wordSelection.FormFields.Add(wordSelection.Range, wdFieldFormTextInput);
		//FormText域名称
		wordFormField.Name = ruleName;
		//FormField域是否可用
		wordFormField.Enabled = true;
		//指定当窗体域具有焦点时状态栏中显示的文本的源
		wordFormField.OwnStatus = !!(options.statusText);
		//当FormText域具有焦点时状态栏显示的文本
		wordFormField.StatusText = (options.statusText) ? options.statusText : "";
		//指定当窗体域具有焦点并且用户按 F1 时在消息框中显示的文本的源
		wordFormField.OwnHelp = !!(options.helpText);
		//当FormText域具有焦点时，用户按F1时在消息框中显示的文本
		wordFormField.HelpText = (options.helpText) ? options.helpText : "";
		//为指定的文字型窗体域设置选项
		wordFormField.TextInput.EditType(wdRegularText, (options.defaultValue) ? options.defaultValue : "");
		//指定文本输入域的宽度
		wordFormField.TextInput.Width = 0;
		return true;
	} catch (e) {
		alert(e);
		return false;
	}
}
/*
	函数：deleteTextInput
	描述：删除手工填写的FormText域
	参数：wordDocument	Word文档对象
		  ruleName		规则名称
	返回值：成功返回true，失败返回false
*/
function deleteTextInput(wordDocument, ruleName) {
	return deleteFormField(wordDocument, ruleName);
}
/*
	函数：setTextInputValue
	描述：设置手工填写FormText域的值
	参数：wordDocument	Word文档对象
		  ruleName		规则名称
		  value			将设置的值
	返回值：成功返回true，失败返回false
*/
function setTextInputValue(wordDocument, ruleName, value) {
	try {
		//判断书签是否存在
		if (wordDocument.Bookmarks.Exists(ruleName)) {
			//设置FormText域的值
			wordDocument.FormFields(ruleName).Result = value;
			return true;
		}
		return false;
	} catch (e) {
		alert(e);
		return false;
	}
}
/*
	函数：getTextInputValue
	描述：获取手工填写FormText域的值
	参数：wordDocument	Word文档对象
		  ruleName		规则名称
	返回值：返回指定FormText域的值
*/
function getTextInputValue(wordDocument, ruleName) {
	try {
		//判断书签是否存在
		if (wordDocument.Bookmarks.Exists(ruleName)) {
			//获取FormText域的值
			return wordDocument.FormFields(ruleName).Result;
		} else {
			return "";
		}
	} catch (e) {
		alert(e);
		return "";
	}
}
/*
	函数：createDropDown
	描述：创建手工填写下拉型窗体域
	参数：wordDocument		Word文档对象
		  ruleName			规则名称
		  options			可选参数
			statusText		当窗体域具有焦点时状态栏中显示的文本
			helpText		当窗体域具有焦点并且用户按 F1 时在消息框中显示的文本
			listEntries		这些对象代表下拉型窗体域中的所有项目
	返回值：成功返回true，失败返回false
*/
function createDropDown(wordDocument, ruleName, options) {
	try {
		options = (options) ? options : {};
		//FormDropDown 域
		var wdFieldFormDropDown = 83;
		//取当前文档选区
		var wordSelection = wordDocument.ActiveWindow.Selection;
		//添加下拉型窗体域
		var wordFormField = wordSelection.FormFields.Add(wordSelection.Range, wdFieldFormDropDown);
		//设置窗体域的名称
		wordFormField.Name = ruleName;
		//设置窗体域是否可用
		wordFormField.Enabled = true;
		//指定当窗体域具有焦点时状态栏中显示的文本的源
		wordFormField.OwnStatus = !!(options.statusText);
		//当FormText域具有焦点时状态栏显示的文本
		wordFormField.StatusText = (options.statusText) ? options.statusText : "";
		//指定当窗体域具有焦点并且用户按 F1 时在消息框中显示的文本的源
		wordFormField.OwnHelp = !!(options.helpText);
		//当FormText域具有焦点时，用户按F1时在消息框中显示的文本
		wordFormField.HelpText = (options.helpText) ? options.helpText : "";
		//删除下拉窗体域中的所有项目
		wordFormField.DropDown.ListEntries.Clear();
		if (options.listEntries) {
			var listEntries = options.listEntries;
			for (var i = 0, count = listEntries.length; i < count; i++)	{
				//返回一个 ListEntry 对象，该对象代表添加到下拉型窗体域中的项
				//alert(listEntries[i]);
				wordFormField.DropDown.ListEntries.Add(listEntries[i]);
			}
		} 
		return true;
	} catch (e) {
		alert(e);
		return false;
	}
}
/*
	函数：deleteDropDown
	描述：删除手工填写的下拉型窗体域
	参数：wordDocument	Word文档对象
		  ruleName		规则名称
	返回值：成功返回true，失败返回false
*/
function deleteDropDown(wordDocument, ruleName) {
	return deleteFormField(wordDocument, ruleName);
}
/*
	函数：setDropDownValue
	描述：设置下拉型窗体域对象的值
	参数：wordDocument	Word文档对象
		  ruleName		规则名称
		  value			下拉型窗体域项目编号
	返回值：成功返回true，失败返回false
*/
function setDropDownValue(wordDocument, ruleName, value) {
	try {
		//判断书签是否存在
		if (wordDocument.Bookmarks.Exists(ruleName)) {
			//设置下拉型窗体域中所选项目的编号
			wordDocument.FormFields(ruleName).DropDown.Value = value;
			return true;
		}
		return false;
	} catch (e) {
		alert(e);
		return false;
	}
}
/*
	函数：getDropDownValue
	描述：获取下拉型窗体域所选项目的编号
	参数：wordDocument	Word文档对象
		  ruleName		规则名称
	返回值：返回下拉型窗体域所选项目的编号
*/
function getDropDownValue(wordDocument, ruleName) {
	try {
		//判断书签是否存在
		if (wordDocument.Bookmarks.Exists(ruleName)) {
			//获取下拉型窗体域所选项目的编号
			return wordDocument.FormFields(ruleName).DropDown.Value;
		} else {
			return "";
		}
	} catch (e) {
		alert(e);
		return "";
	}
}
/*
	函数：documentProtect
	描述：文档保护，仅填写窗体可编辑
	参数：wordDocument	Word文档对象
		  password		密码
	返回值：成功返回true，失败返回false
*/
function documentProtect(wordDocument, password) {
	try {
		var wdAllowOnlyFormFields = 2;
		//文档保护，仅填写窗体可编辑
		wordDocument.Protect(wdAllowOnlyFormFields, 1, "" + password);//第二个参数0：强制使用默认值，1：参数
		return true;
	} catch (e) {
		return false;
	}
}
/*
	函数：documentUnprotect
	描述：清除对指定文档的保护
	参数：wordDocument	Word文档对象
		  password		密码
	返回值：成功返回true，失败返回false
*/
function documentUnprotect(wordDocument, password) {
	try {
		//清除对指定文档的保护
		wordDocument.Unprotect("" + password);
		return true;
	} catch (e) {
		return false;
	}

}
/*
	函数：deleteFormField
	描述：删除窗体域对象
	参数：wordDocument	Word文档对象
		  ruleName		窗体域对象名称
	返回值：成功返回true，失败返回false
*/
function deleteFormField(wordDocument, ruleName) {
	try {
		//判断书签是否存在
		if (wordDocument.Bookmarks.Exists(ruleName)) {
			//删除指定的FormText域
			wordDocument.FormFields(ruleName).Delete();
		}
		return true;
	} catch (e) {
		alert(e);
		return false;
	}
}
/*
	函数：getFormFieldsValue
	描述：获取窗口域值（仅包括：文本域和下拉列表域）
	参数：wordDocument	Word文档对象
	返回值：返回函数setFormFieldsValue参数valueObject可直接使用的JSON对象
*/
function getFormFieldsValue(wordDocument) {
	var wdFieldFormTextInput = 70; //FormText 域
	var wdFieldFormDropDown = 83; //FormDropDown 域
	var result = {}; //返回值
	try {
		for (var i = 1, count = wordDocument.FormFields.Count; i <= count; i++) { //遍历所有窗口域
			var wordFormField = wordDocument.FormFields.Item(i);
			var type = wordFormField.Type;
			if (type == wdFieldFormTextInput) { //如果是FormText域
				result[wordFormField.Name] = {type : wdFieldFormTextInput, value : wordFormField.Result};
			} else if (type == wdFieldFormDropDown && wordFormField.DropDown.Value) { //如果是FormDropDown域
				result[wordFormField.Name] = {type : wdFieldFormDropDown, name : wordFormField.DropDown.ListEntries.Item(wordFormField.DropDown.Value).Name, value : wordFormField.DropDown.Value};
			}
		}
	} catch (e) {
	}
	return result;
}
/*
	函数：setFormFieldsValue
	描述：设置窗口域值（仅包括：文本域和下拉列表域）
	参数：wordDocument	Word文档对象
		  valueObject	通过函数getFormFieldsValue获取的返回值对象
	返回值：无
*/
function setFormFieldsValue(wordDocument, valueObject) {
	var wdFieldFormTextInput = 70; //FormText 域
	var wdFieldFormDropDown = 83; //FormDropDown 域
	try {
		for (var name in valueObject) {
			if (wordDocument.Bookmarks.Exists(name)) { //判断窗口域是否存在
				if (valueObject[name].type == wordDocument.FormFields(name).type) { //判断域类型是否一致
					if (valueObject[name].type == wdFieldFormTextInput) { //如果是FormText域
						wordDocument.FormFields(name).Result = valueObject[name].value; //给FormDropDown域赋值
					} else if (valueObject[name].type == wdFieldFormDropDown) { //如果是FormDropDown域
						//如果下拉列表取值和原取值一致
						if (valueObject[name].name == wordDocument.FormFields(name).DropDown.ListEntries.Item(valueObject[name].value).Name) {
							wordDocument.FormFields(name).DropDown.Value = valueObject[name].value; //设置FormDropDown 域值
						} else { //下拉列表或有变化（删除，位置调整）
							for (var i = 1, count = wordDocument.FormFields(name).DropDown.ListEntries.Count; i <= count; i++) { //需逐个判断
								//下拉列表中有项目和原取值一直
								if (wordDocument.FormFields(name).DropDown.ListEntries.Item(i).Name == valueObject[name].name) {
									wordDocument.FormFields(name).DropDown.Value = i;
									break;
								}
							}
						}
					}
				}
			}
		}
	} catch (e) {
	}
}


//作用：保存文档到服务器上，正文和文档附加信息都已经保存。不过是分两步保存的。isCreateIndex:是否建索引
function SaveDocument(saveNum,isCreateIndex){
  if(IsSpace(saveNum)){
      saveNum = 2;
  }
  var iWebOffice = document.getElementsByName("WebOffice")[0];  //获取控件对象。
  iWebOffice.Compressed = true;
  iWebOffice.WebSetMsgByName("saveAsOfficeDoc","0");
  iWebOffice.WebSetMsgByName("CONTENT",WebGetWordContent());
  iWebOffice.WebSetMsgByName("isCreateIndex",isCreateIndex);
  if(typeof(saveToFile) != "undefined" && (saveToFile == "1" ||saveToFile == "2") ){
	  iWebOffice.Compressed = false;
	  iWebOffice.WebSetMsgByName("saveToFile",saveToFile);
	  if(typeof(path) != "undefined" ){
		  iWebOffice.WebSetMsgByName("path",path);
	  }
	  if(typeof(filename) != "undefined" ){
		  iWebOffice.WebSetMsgByName("filename",filename);
	  }
  }  
  if(iWebOffice.WebGetMsgByName("saveToFile")=="1"||iWebOffice.WebGetMsgByName("saveToFile")=="2"){
	  if (!iWebOffice.WebSave(true)){    //交互OfficeServer的OPTION="SAVEFILE"  注：WebSave()是保存复合格式文件，包括OFFICE内容和手写批注文档；如只保存成OFFICE文档格式，那么就设WebSave(true)
		     StatusMsg(iWebOffice.Status);
		     if(iWebOffice.Status.indexOf("文件大于设定值")!=-1){
		         alert("文件大小超过允许保存的最大值：" + (iWebOffice.MaxFileSize/1024) +"M");
		         return false;
		     }
		     var time = 1;
		     var fastRet = false;
		     while(time < saveNum && !fastRet){
		         fastRet = iWebOffice.WebFastSave();
		         time++;
		     }
		     if(!fastRet){
		         return false;
		     }
		  }else{
		     StatusMsg(iWebOffice.Status);     
		  }
  }else  if (!iWebOffice.WebSave()){//交互OfficeServer的OPTION="SAVEFILE"  注：WebSave()是保存复合格式文件，包括OFFICE内容和手写批注文档；如只保存成OFFICE文档格式，那么就设WebSave(true)
	  StatusMsg(iWebOffice.Status);
     if(iWebOffice.Status.indexOf("文件大于设定值")!=-1){
         alert("文件大小超过允许保存的最大值：" + (iWebOffice.MaxFileSize/1024) +"M");
         return false;
     }
     var time = 1;
     var fastRet = false;
     while(time < saveNum && !fastRet){
         fastRet = iWebOffice.WebFastSave();
         time++;
     }
     if(!fastRet){
         return false;
     }
  }else{
     StatusMsg(iWebOffice.Status);     
  }

  iWebOffice.WebSetMsgByName("Subject","主题");
  iWebOffice.WebSetMsgByName("FileDate","时间");
  iWebOffice.WebSetMsgByName("HTMLPath","HTMLPath");
  iWebOffice.WebSetMsgByName("SaveStatus","READ");
  //iWebOffice.WebSetMsgByName("djid",fcpubdata.djid);//--------------------------
  iWebOffice.WebSetMsgByName("djid","20090611102416046338");
  iWebOffice.WebSetMsgByName("TEMPLATE",iWebOffice.Template);   //template本该控件本身去设，但后台取值发现没有，所以在此自己设。

  iWebOffice.WebSetMsgByName("COMMAND","saveToTableDocument");

  if(iWebOffice.WebSendMessage()){ //将文档相关的信息发送到服务器后台处理页面：OfficeServer.jsp
  	 StatusMsg(iWebOffice.Status);    
  	 return true; 
  }else{
     StatusMsg(iWebOffice.Status);
     return false;
  }
}

//作用：获取文档Txt正文
function WebGetWordContent(){
  try{
    var iWebOffice = document.getElementsByName("WebOffice")[0];  //获取控件对象。
    if(IsSpace(iWebOffice.WebObject.Content.Text)){
    	return "";
    }else{
    	return iWebOffice.WebObject.Content.Text;
    }
  }catch(e){
  //alert(e.description);
  }
}

//作用：显示操作状态
function StatusMsg(mString){  
  //StatusBar.innerText=mString;
  //alert(mString);
}

//打印份数控制
function WebCopysCtrlPrint(){
	try{
	  var mCopies,objPrint;
	  var iWebOffice = document.getElementsByName("WebOffice")[0];  //获取控件对象。
	  objPrint = iWebOffice.WebObject.Application.Dialogs(88);     //打印设置对话框
	  if (objPrint.Display==-1){
	      mCopies=objPrint.NumCopies;    //取得需要打印份数    
	      iWebOffice.WebSetMsgByName("COMMAND","COPIES");
	      iWebOffice.WebSetMsgByName("OFFICEPRINTS",mCopies+"");   //设置变量OFFICEPRINTS的值，在WebSendMessage()时，一起提交到OfficeServer中
	      iWebOffice.WebSendMessage();                              //交互OfficeServer的OPTION="SENDMESSAGE"
	      if (iWebOffice.Status=="1") {
	         // alert("可以允许打印，注：该实例设置总文档打印份数2份");
	          StatusMsg("可以允许打印，注：该实例设置总文档打印份数2份");
	          objPrint.Execute;
	      }else{
	      	  alert("已超出允许的打印份数");
	      	  StatusMsg("已超出允许的打印份数");
	      	  return false;
	      }
	  }
	}catch(e){alert(e.description);}
}