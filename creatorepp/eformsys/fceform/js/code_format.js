//HTML文本格式化：jihongwei 2010-08-13
function formatHtmlText(strInnerHTML, iSwitchLevel)
{
	var strChar, strBuffer = new PStringBuffer();
	var i, iCount = strInnerHTML.length;
	var sSign = "'", dSign = '"';
	var bSign = "<", eSign = ">";
	var beSign = "</", spSign = " ";
	var sLine = unescape("%0D"), rLine = unescape("%0A");
	var insSrLine = unescape("%0D%0A");
	var strTab = "   ";
	//字符位置状态：0 文本 1|2 hmtl元素 3|4 字符串(html元素中的属性)
	var iStatusFlag = 0;
	var iOldHtmFlag = 0;	
	var iInsetLevel = 0;
	var bInFillText = false;
	var bInJsScript = false;
	var bFirst2Text = true;
	var bTdHtmlFlag = false;
	
	if(!iSwitchLevel) iSwitchLevel = 0;	
	for(i = 0; i < iCount; i ++)
	{
		strChar = strInnerHTML.substr(i, 1);	
		if(!bInJsScript)
		{		
			if((iStatusFlag == 0) && (strChar == spSign)) continue;
			if((strChar == sLine) || (strChar == rLine)) continue;
		}
														
		if(iStatusFlag == 0)
		{
			//javaSript代码
			if(bInJsScript)
			{
				if(strInnerHTML.substr(i, 9).toUpperCase() != "</SCRIPT>")
				{
					strBuffer.append(strChar);
					continue;
				}
			}
			
			//html文本					
			if(strChar == bSign) 
			{			
				var iTabSpCount = iInsetLevel;
				var bTabSpFlag = false;
				var str2Char = strInnerHTML.substr(i, 2);
					
				//换行处理	
				if(str2Char != beSign)
				{
					if(bTdHtmlFlag)
					{
						var str7Char = strInnerHTML.substr(i, 7);
						if((str7Char == "<TABLE ") || (str7Char == "<TABLE>")) bTdHtmlFlag = false;
					}
					
					//html元素前标记
					if((i > 0) && !bTdHtmlFlag)
					{		
						strBuffer.append(insSrLine);
						if(iInsetLevel <= iSwitchLevel) strBuffer.append(insSrLine);			
						bTabSpFlag = true;
					}
				}
				else
				{
					//html元素后标记
					if((iOldHtmFlag == 2) && !bTdHtmlFlag)
					{
						strBuffer.append(insSrLine);
						bTabSpFlag = true;
					}
				}
								
				iStatusFlag = 1;
				if(str2Char == beSign) iStatusFlag = 2;
				bInFillText = false;
				
				if(iStatusFlag == 1)
				{
					//html元素前标记
					var str7Char = strInnerHTML.substr(i, 7);
					var str4Char = strInnerHTML.substr(i, 4);
					if((strInnerHTML.substr(i, 5) != "<IMG ") && (str7Char != "<INPUT ")
						&& (str7Char != "<PARAM ") && (str4Char != "<BR>") && (str4Char != "<HR>")
						&& (strInnerHTML.substr(i, 6) != "<AREA "))
					{
						iInsetLevel = iInsetLevel + 1;
					}
					else
					{
						iStatusFlag = 2;
					}
					
					var str8Char = strInnerHTML.substr(i, 8).toUpperCase();
					var str4Char = strInnerHTML.substr(i, 4);
					bInJsScript = (str8Char == "<SCRIPT ") || (str8Char == "<SCRIPT>");
					if((str4Char == "<TD ") || (str4Char == "<TD>")) bTdHtmlFlag = true;										
				}
				else
				{					
					//html元素后标记
					if(strInnerHTML.substr(i, 5) == "</TD>") bTdHtmlFlag = false;
					bInJsScript = false;
					if(iInsetLevel > 0)
					{
						iInsetLevel = iInsetLevel - 1;
						iTabSpCount = iInsetLevel;
					}
				}
				
				if(bTabSpFlag) strBuffer.append(multString(strTab, iTabSpCount - iSwitchLevel));
				strBuffer.append(strChar);	
				
				iOldHtmFlag = iStatusFlag;
				bFirst2Text = true;	
			}
			else
			{	
				//处理文本部分
				bInFillText = true;
				if(bFirst2Text)
				{
					bFirst2Text = false;		
					if((iOldHtmFlag == 2) || ((iInsetLevel <= iSwitchLevel) && (iOldHtmFlag > 0)))
					{	
						if(!bTdHtmlFlag) strBuffer.append(insSrLine);
						if(iInsetLevel <= iSwitchLevel) 
						{
							if(!bTdHtmlFlag) strBuffer.append(insSrLine);
						}
						else
						{
							if(!bTdHtmlFlag) strBuffer.append(multString(strTab, iInsetLevel - iSwitchLevel));
						}
					}
				}
				
				strBuffer.append(strChar);
			}
		}
		else if((iStatusFlag == 1) || (iStatusFlag == 2))
		{
			//html元素					
			strBuffer.append(strChar);
			if(strChar == sSign) 
			{				
				iStatusFlag = 3;
			}
			else if(strChar == dSign) 
			{
				iStatusFlag = 4;						
			}
			else if(strChar == eSign) 
			{
				iStatusFlag = 0;
				if(strInnerHTML.substr(i - 1, 2) == "/>")
				{
					bInJsScript = false;
					iInsetLevel = iInsetLevel - 1;
				}
			}
		}
		else
		{	
			//html元素中属性字符串
			strBuffer.append(strChar);
			if((iStatusFlag == 3) && (strChar == sSign)) iStatusFlag = iOldHtmFlag;
			if((iStatusFlag == 4) && (strChar == dSign)) iStatusFlag = iOldHtmFlag;
		}				
	}
	
	return strBuffer.toString();
}

function multString(str, n)
{
	var strBuffer = new PStringBuffer();
	var i = 0;
	
	for(i = 1; i <= n; i ++)
	{
		strBuffer.append(str);
	}
	
	return strBuffer.toString();
}

function PStringBuffer() 
{
	this._strs = new Array();
	
	this.append = function(str)
	{
		this._strs.push(str);
		return this;
	};
		
	this.toString = function() 
	{
		return this._strs.join("");
	};
}