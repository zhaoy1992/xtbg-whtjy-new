function SaveBill(iTag, sProc) {
	var currentSystemID = creator_getSession("subsystem_id_nouse");
	var appUserName = "";
	if (!IsSpace(currentSystemID) && currentSystemID != "module") {
		appUserName = "APP_" + currentSystemID.toUpperCase() + "."
	}
	var d = new Date();
	var t = d.getTime();
	if (NotCanSave())
		return "展现状态不能保存";
	var owin = ShowWait("正在保存......");
	var draftTable = "draft";
	var draftsubTable = "draftsub";
	var draftdescValue = "";
	if (iTag == 5) {
		draftdescValue = window
				.showModalDialog(fcpubdata.Path
						+ "/fceform/common/inputmsg.htm", "请输入草稿说明:",
						"status:no;dialogHeight:105px;dialogWidth:470px;dialogTop:180;dialogLeft:250px")
	}
	var oDsMain = GetDsMainObj();
	if (oDsMain == null)
		return "只有表单上含有主数据集控件(就是指没有绑定到表格的数据集控件)时才能保存!";
	var arrImgValue = "";
	var arrImgName = "";
	var arrImgChange = "";
	var sProcName = SKbillsheet.runsave;
	var billkeyfield = SKbillsheet.keyfield;
	var strRet = "";
	var xmlSql = new StringBuffer();
	var sInsert = "";
	var s1 = "";
	var gzid = "";
	if ((isSpace(sProcName) == false && fcpubdata.databaseTypeName != "mysql")
			|| iTag == 4) {
		gzid = getgzid();
		if (gzid == fcpubdata.pub_sendhttp_errmsg)
			return fcpubdata.pub_sendhttp_errmsg
	}
	if (oDsMain.Empty != "null") {
		oDsMain.bEdit = true;
		if (oDsMain.Update() == 1) {
			ShowWait("end");
			return "主数据集不能通过数据校验"
		}
		var tmpTable = appUserName + oDsMain.temptable;
		var saveasTable = oDsMain.saveastable;
		if (iTag == 4)
			saveasTable = "";
		var xmlFields = oDsMain.format;
		var oXmlField = SetDom(xmlFields);
		var arrField = Save_GetFieldArr(oDsMain, oXmlField);
		if (arrField == null) {
			return fcpubdata.pub_sendhttp_errmsg
		}
		var kk = arrField.length;
		var sF = Save_GetsF(arrField, oXmlField, "主");
		var sV = "";
		var sU = "";
		var ltmp = oDsMain.FieldCount;
		for (var j = 0;j < ltmp; j++) {
			if (oDsMain.Fields.Field[j].DataType == "图象") {
				arrImgValue = oDsMain.Fields.Field[j].Value;
				arrImgName = oDsMain.Fields.Field[j].FieldName;
				arrImgChange = oDsMain.Fields.Field[j].valid;
				break
			}
		}
		for (var arri = 0;arri < kk; arri++) {
			i = arrField[arri];
			if (SKbillsheet.idtype == "3"
					&& pubdjbh == ""
					&& oDsMain.Fields.Field[i].FieldName.toUpperCase() == SKbillsheet.keyfield
							.toUpperCase()) {
				sV += SKbillsheet.codeheader + ".nextval,";
				continue
			}
			var arrRet = Save_GetsVsU(oDsMain, 0, i, billkeyfield, sV, sU, "是");
			sV = arrRet.sV;
			sU = arrRet.sU;
			sV = sV.replace("\r\n", "  ")
		}
		if ((isSpace(sProcName) == false && fcpubdata.databaseTypeName != "mysql")
				|| iTag == 4) {
			var tmp_sF = InsertTmpTableFields(oDsMain);
			sInsert = new StringBuffer().append("Insert into ")
					.append(tmpTable).append("(").append(tmp_sF)
					.append("GZID) Values(").append(InsertTmpTableSql(oDsMain,
							oDsMain.RecNo)).append("'").append(gzid)
					.append("')");
			xmlSql.append("<no>").append(repXml(sInsert.toString()))
					.append("</no>");
			if (SKbillsheet.idtype == "3" && pubdjbh == "") {
				sV = RepStr(sV, SKbillsheet.codeheader + ".nextval",
						":get_keyfield")
			}
		}
		if (isSpace(saveasTable) == false) {
			if (sV.length > 0)
				sV = sV.substring(0, sV.length - 1);
			if (sU.length > 0)
				sU = sU.substring(0, sU.length - 1);
			if (pubdjbh == "") {
				sInsert = new StringBuffer().append("Insert into ")
						.append(saveasTable).append(" (").append(sF)
						.append(") Values (").append(sV).append(")")
			} else {
				var sWhere1 = "";
				if (SKbillsheet.idtype == "5") {
					sWhere1 = MultiKeyWhere(MultiKeyTmp(oDsMain),
							oDsMain.RecNo, oDsMain)
				} else {
					var sQuot = "'";
					if (oDsMain.Fields.Field[billkeyfield].DataType == "整数"
							|| oDsMain.Fields.Field[billkeyfield].DataType == "实数")
						sQuot = "";
					sWhere1 = billkeyfield + "=" + sQuot + pubdjbh + sQuot
				}
				sInsert = new StringBuffer().append("Update ")
						.append(saveasTable).append(" set ").append(sU)
						.append(" where ").append(sWhere1)
			}
			xmlSql.append("<no>").append(repXml(sInsert.toString()))
					.append("</no>");
			if (iTag == 5) {
				sInsert = new StringBuffer().append("Insert into ")
						.append(draftTable).append(" (").append(sF)
						.append(",draftdesc) Values (").append(sV).append(",'")
						.append(draftdescValue).append("')");
				xmlSql.append("<no>").append(repXml(sInsert.toString()))
						.append("</no>")
			}
		}
	}
	var oArrGrid = window.document.all.tags("webgrid");
	for (var iGrid = 0;iGrid < oArrGrid.length; iGrid++) {
		if (oArrGrid[iGrid].readonly == "是")
			continue;
		var dssub1 = eval("window." + oArrGrid[iGrid].dataset);
		if (dssub1.pubpara == "是")
			continue;
		if (DsBeforeSave(dssub1, oArrGrid[iGrid]))
			return;
		if (IsSpace(dssub1.otherkey)) {
			billkeyfield = SKbillsheet.keyfield
		} else {
			billkeyfield = dssub1.otherkey
		}
		var tmpTable = dssub1.temptable;
		var saveasTable = dssub1.saveastable;
		if (iTag == 4)
			saveasTable = "";
		var sOtherSave = false;
		if (isSpace(saveasTable) == false && pubdjbh != ""
				&& SKbillsheet.OtherSave == "是") {
			xmlSql += SubTableEditSave(dssub1, billkeyfield);
			sOtherSave = true
		} else {
			dssub1.ReSum();
			var sErr = gridvalid(oArrGrid[iGrid]);
			if (sErr != "") {
				ShowWait("end");
				alert(sErr);
				return sErr
			}
			if (isSpace(saveasTable) == false && pubdjbh != "") {
				var sQuot = "'";
				if (dssub1.Fields.Field[billkeyfield].DataType == "整数"
						|| dssub1.Fields.Field[billkeyfield].DataType == "实数")
					sQuot = "";
				sInsert = new StringBuffer().append("delete from ")
						.append(saveasTable).append(" where ")
						.append(billkeyfield).append("=").append(sQuot)
						.append(pubdjbh).append(sQuot);
				xmlSql.append("<no>").append(repXml(sInsert.toString()))
						.append("</no>")
			}
			var sSubKeyFieldName = getSubKeyName(dssub1, billkeyfield);
			var xmlFields = dssub1.format;
			var oXmlField = SetDom(xmlFields);
			var arrField = Save_GetFieldArr(dssub1, oXmlField);
			if (arrField == null) {
				continue
			}
			var kk = arrField.length;
			var sF = Save_GetsF(arrField, oXmlField, "从");
			if ((isSpace(sProcName) == false && fcpubdata.databaseTypeName != "mysql")
					|| iTag == 4) {
				var tmp_sF = InsertTmpTableFields(dssub1)
			}
			var ll = dssub1.RecordCount;
			for (var ii = 0;ii < ll; ii++) {
				if (dssub1.oDom.documentElement.childNodes(ii)
						.getAttribute("rowstate") == "new")
					continue;
				var sV = "";
				for (var arri = 0;arri < kk; arri++) {
					i = arrField[arri];
					var arrRet = Save_GetsVsU(dssub1, ii, i, billkeyfield, sV,
							"", "从", sSubKeyFieldName);
					sV = arrRet.sV
				}
				if ((isSpace(sProcName) == false && fcpubdata.databaseTypeName != "mysql")
						|| iTag == 4) {
					sInsert = new StringBuffer().append("Insert into ")
							.append(tmpTable).append(" (").append(tmp_sF)
							.append("GZID) Values (").append(InsertTmpTableSql(
									dssub1, ii)).append("'").append(gzid)
							.append("')");
					xmlSql.append("<no>").append(repXml(sInsert.toString()))
							.append("</no>")
				}
				if (isSpace(saveasTable) == false) {
					if (sV.length > 0) {
						sV = sV.substring(0, sV.length - 1)
					}
					sInsert = new StringBuffer().append("Insert into ")
							.append(saveasTable).append(" (").append(sF)
							.append(") Values (").append(sV).append(")");
					xmlSql.append("<no>").append(repXml(sInsert.toString()))
							.append("</no>");
					if (iTag == 5) {
						sInsert = new StringBuffer().append("Insert into ")
								.append(draftsubTable).append(" (").append(sF)
								.append(") Values (").append(sV).append(")");
						xmlSql.append("<no>")
								.append(repXml(sInsert.toString()))
								.append("</no>")
					}
				}
			}
		}
	}
	if (typeof(creator_pt_grids) == 'undefined') {
		creator_pt_grids = new Array()
	}
	var oExtGrid = creator_pt_grids;
	for (var i = 0;i < oExtGrid.length; ++i) {
		var extGridObj = oExtGrid[i].obj;
		if (!eval(oExtGrid[i].isEdit))
			continue;
		var dssub1 = eval("window." + oExtGrid[i].dataset);
		if (dssub1.pubpara == "是")
			continue;
		if (IsSpace(dssub1.otherkey)) {
			billkeyfield = SKbillsheet.keyfield
		} else {
			billkeyfield = dssub1.otherkey
		}
		var tmpTable = dssub1.temptable;
		var saveasTable = dssub1.saveastable;
		var sOtherSave = false;
		dssub1.ReSum();
		var sSubKeyFieldName = getSubKeyName(dssub1, billkeyfield)
				.toLowerCase();
		var xmlFields = dssub1.format;
		var oXmlField = SetDom(xmlFields);
		var arrField = Save_GetFieldArr(dssub1, oXmlField);
		if (arrField == null) {
			continue
		}
		var kk = arrField.length;
		var sF = Save_GetsF(arrField, oXmlField, "从");
		var records = extGridObj.store.getModifiedRecords();
		var ll = records.length;
		for (var ii = 0;ii < ll; ii++) {
			var sV = "";
			var sU = "";
			for (var arri = 0;arri < kk; arri++) {
				i = arrField[arri];
				var arrRet = Save_GetsVsRecords(dssub1, ii, i, billkeyfield,
						sV, sU, "从", sSubKeyFieldName, records[ii]);
				sV = arrRet.sV;
				sU = arrRet.sU
			}
			if (isSpace(saveasTable) == false) {
				if (sV.length > 0) {
					sV = sV.substring(0, sV.length - 1)
				}
				if (sU.length > 0) {
					sU = sU.substring(0, sU.length - 1)
				}
				if (records[ii].get("opflag") == "del") {
					var sDelete = new StringBuffer().append("delete from ")
							.append(saveasTable).append(" where ")
							.append(sSubKeyFieldName).append("='")
							.append(records[ii].get(sSubKeyFieldName))
							.append("'");
					xmlSql.append("<no>").append(repXml(sDelete.toString()))
							.append("</no>")
				} else if (records[ii].get("opflag") == "add") {
					sInsert = new StringBuffer().append("Insert into ")
							.append(saveasTable).append(" (").append(sF)
							.append(") Values (").append(sV).append(")");
					xmlSql.append("<no>").append(repXml(sInsert.toString()))
							.append("</no>")
				} else {
					var sUpdate = new StringBuffer().append("update ")
							.append(saveasTable).append(" set ");
					sUpdate.append(sU).append(" where ");
					var sWhere1 = "";
					var sQuot = "'";
					if (dssub1.Fields.Field[sSubKeyFieldName].DataType == "整数"
							|| dssub1.Fields.Field[sSubKeyFieldName].DataType == "实数")
						sQuot = "";
					sWhere1 = new StringBuffer().append(sSubKeyFieldName)
							.append("=").append(sQuot).append(records[ii]
									.get(sSubKeyFieldName)).append(sQuot);
					sUpdate.append(sWhere1);
					xmlSql.append("<no>").append(repXml(sUpdate.toString()))
							.append("</no>")
				}
			}
		}
	}
	if (iTag != 4) {
		if (isSpace(sProcName) == false
				&& fcpubdata.databaseTypeName != "mysql") {
			xmlSql.append("<runsave>{ call ").append(repXml(trim(sProcName)))
					.append("(?,?) };").append(SKbillsheet.dj_sn).append(";")
					.append(gzid).append("</runsave>")
		}
		if (isSpace(sProc) == false) {
			xmlSql.append("<action>").append(repXml(sProc)).append("</action>")
		}
	} else {
		var sName = window
				.showModalDialog(fcpubdata.Path
						+ "/fceform/common/inputmsg.htm", "请输入挂帐说明:",
						"status:no;dialogHeight:105px;dialogWidth:470px;dialogTop:180;dialogLeft:250px");
		var s1 = new StringBuffer()
				.append("insert into billgz (gzid,sgzname,sgzdate,semployeeid,sbilltag) values ('")
				.append(gzid).append("','").append(sName).append("','")
				.append(curDateTime()).append("','").append(getuser())
				.append("','").append(SKbillsheet.codeheader).append("')");
		xmlSql.append("<no>").append(s1.toString()).append("</no>")
	}
	if (pubdjbh == "") {
		var sidtype = SKbillsheet.idtype;
		if (isSpace(sidtype))
			sidtype = "";
		if (sidtype == "4" || sidtype == "5") {
			var tmp1 = "";
			try {
				tmp1 = oDsMain.Fields.Field[SKbillsheet.keyfield].Value
			} catch (e) {
			}
			xmlSql = new StringBuffer().append("<fc").append(tmp1).append(">")
					.append(SKbillsheet.codeheader).append("</fc").append(tmp1)
					.append(">").append(xmlSql)
		} else {
			xmlSql = new StringBuffer().append("<add").append(sidtype)
					.append(">").append(SKbillsheet.codeheader).append("</add")
					.append(sidtype).append(">").append(xmlSql)
		}
	} else {
		xmlSql = new StringBuffer().append("<fc").append(pubdjbh).append(">")
				.append(SKbillsheet.codeheader).append("</fc").append(pubdjbh)
				.append(">").append(xmlSql)
	}
	var blnOk = "";
	var strReturn = "";
	var sRet = djupdate(xmlSql.toString());
	reloadExtGrid();
	if (sRet == fcpubdata.pub_sendhttp_errmsg)
		return fcpubdata.pub_sendhttp_errmsg;
	if (isSpace(sRet) == false) {
		strRet = sRet
	}
	if (iTag != 4 && isSpace(sProcName) == false
			&& isSpace(oDsMain.temptable) == false) {
		xmlSql = new StringBuffer().append("<no>").append("delete from ")
				.append(appUserName).append(oDsMain.temptable)
				.append(" where GZID='").append(gzid).append("'")
				.append("</no>");
		try {
			if (oArrGrid.length > 0 && isSpace(dssub1.temptable) == false)
				xmlSql.append("<no>").append("delete from ")
						.append(appUserName).append(dssub1.temptable)
						.append(" where GZID='").append(gzid).append("'")
						.append("</no>")
		} catch (e) {
		}
		var sRet1 = inserts(xmlSql.toString());
		if (isSpace(sRet1) == false) {
			alert(sRet1)
		}
	}
	if (sRet.indexOf('错误:') < 0) {
		if (arrImgValue != "" && arrImgChange == "变") {
			var stable = SKbillsheet.mastertable;
			if (IsSpace(stable))
				stable = oDsMain.saveastable;
			if (isSpace(stable)) {
				var stip1 = "请设置" + fcpubvar.DsMain + "的保存表名!";
				alert(stip1);
				return stip1
			}
			var serverUrl = new StringBuffer().append(location.protocol)
					.append("//").append(location.host)
					.append(fcpubdata.servletPath).append("/imagefield")
					.append(fcpubdata.dotnetVersion)
					.append("?key=writeimage&sTablename=").append(stable)
					.append("&sImgname=").append(arrImgName)
					.append("&sKeyname=").append(SKbillsheet.keyfield)
					.append("&sKeyvalue=").append(strRet).append("&sKeyname1=")
					.append(escape(fcpubdata.Path)).append("&sKeyvalue1=")
					.append(escape(arrImgValue).toString());
			var sRet11 = SendHttp(new StringBuffer().append(location.protocol)
					.append("//").append(location.host)
					.append(fcpubdata.servletPath).append("/imagefield")
					.append(fcpubdata.dotnetVersion)
					.append("?key=writeimage&sTablename=").append(stable)
					.append("&sImgname=").append(arrImgName)
					.append("&sKeyname=").append(SKbillsheet.keyfield)
					.append("&sKeyvalue=").append(strRet).append("&sKeyname1=")
					.append(escape(fcpubdata.Path)).append("&sKeyvalue1=")
					.append(escape(arrImgValue)).toString(), "");
			if (IsSpace(sRet11) == false) {
				alert(sRet11);
				return sRet11
			}
		}
		if (HaveUpload() == true)
			upload_save(strRet);
		blnOk = "ok";
		if (oDsMain.Empty != "null" && SKbillsheet.keyfield != "") {
			oDsMain.bEdit = true;
			oDsMain.Fields.Field[SKbillsheet.keyfield].Value = strRet;
			oDsMain.Update();
			oDsMain.fset_cont1()
		}
	} else {
		strReturn = strRet;
		alert(strRet);
		return strReturn
	}
	try {
		pubdjbh = oDsMain.Fields.Field[SKbillsheet.keyfield].Value
	} catch (e) {
	}
	oDsMain.bAdd = false;
	oDsMain.bEdit = false;
	ShowWait("end");
	pubEdit = false;
	if (iTag == 1) {
		CloseBill();
		return strReturn
	}
	if (iTag == 3) {
		AddBill();
		return strReturn
	}
	if (iTag == 2) {
		return strReturn
	}
	var d = new Date();
	var t1 = d.getTime();
	if (blnOk == "ok") {
		CloseBill()
	}
	return strReturn
}




function saveExtGrid() {
	var xmlSql = new StringBuffer();
	if (typeof(creator_pt_grids) == 'undefined') {
		creator_pt_grids = new Array()
	}
	var oExtGrid = creator_pt_grids;
	for (var i = 0;i < oExtGrid.length; ++i) {
		var extGridObj = oExtGrid[i].obj;
		if (!eval(oExtGrid[i].isEdit))
			continue;
		var dssub1 = eval("window." + oExtGrid[i].dataset);
		if (dssub1.pubpara == "是")
			continue;
		if (IsSpace(dssub1.otherkey)) {
			billkeyfield = SKbillsheet.keyfield
		} else {
			billkeyfield = dssub1.otherkey
		}
		var tmpTable = dssub1.temptable;
		var saveasTable = dssub1.saveastable;
		var sOtherSave = false;
		dssub1.ReSum();
		var sSubKeyFieldName = getSubKeyName(dssub1, billkeyfield)
				.toLowerCase();
		var xmlFields = dssub1.format;
		var oXmlField = SetDom(xmlFields);
		var arrField = Save_GetFieldArr(dssub1, oXmlField);
		if (arrField == null) {
			continue
		}
		var kk = arrField.length;
		var sF = Save_GetsF(arrField, oXmlField, "从");
		var records = extGridObj.store.getModifiedRecords();
		var ll = records.length;
		for (var ii = 0;ii < ll; ii++) {
			var sV = "";
			var sU = "";
			for (var arri = 0;arri < kk; arri++) {
				i = arrField[arri];
				var arrRet = Save_GetsVsRecords(dssub1, ii, i, billkeyfield,
						sV, sU, "从", sSubKeyFieldName, records[ii]);
				sV = arrRet.sV;
				sU = arrRet.sU
			}
			if (isSpace(saveasTable) == false) {
				if (sV.length > 0) {
					sV = sV.substring(0, sV.length - 1)
				}
				if (sU.length > 0) {
					sU = sU.substring(0, sU.length - 1)
				}
				if (records[ii].get("opflag") == "del") {
					var sDelete = new StringBuffer().append("delete from ")
							.append(saveasTable).append(" where ")
							.append(sSubKeyFieldName).append("='")
							.append(records[ii].get(sSubKeyFieldName))
							.append("'");
					xmlSql.append("<no>").append(repXml(sDelete.toString()))
							.append("</no>")
				} else if (records[ii].get("opflag") == "add") {
					sInsert = new StringBuffer().append("Insert into ")
							.append(saveasTable).append(" (").append(sF)
							.append(") Values (").append(sV).append(")");
					xmlSql.append("<no>").append(repXml(sInsert.toString()))
							.append("</no>")
				} else {
					var sUpdate = new StringBuffer().append("update ")
							.append(saveasTable).append(" set ");
					sUpdate.append(sU).append(" where ");
					var sWhere1 = new StringBuffer();
					var sQuot = "'";
					if (dssub1.Fields.Field[sSubKeyFieldName].DataType == "整数"
							|| dssub1.Fields.Field[sSubKeyFieldName].DataType == "实数")
						sQuot = "";
					sWhere1.append(sSubKeyFieldName).append("=").append(sQuot)
							.append(records[ii].get(sSubKeyFieldName))
							.append(sQuot);
					sUpdate.append(sWhere1);
					xmlSql.append("<no>").append(repXml(sUpdate.toString())).append("</no>")
				}
			}
		}
	}
	if (pubdjbh == "") {
		var sidtype = SKbillsheet.idtype;
		if (isSpace(sidtype))
			sidtype = "";
		if (sidtype == "4" || sidtype == "5") {
			var tmp1 = "";
			try {
				tmp1 = oDsMain.Fields.Field[SKbillsheet.keyfield].Value
			} catch (e) {
			}
			xmlSql = new StringBuffer().append("<fc").append(tmp1).append(">")
					.append(SKbillsheet.codeheader).append("</fc").append(tmp1)
					.append(">").append(xmlSql)
		} else {
			xmlSql = new StringBuffer().append("<add").append(sidtype)
					.append(">").append(SKbillsheet.codeheader).append("</add")
					.append(sidtype).append(">").append(xmlSql)
		}
	} else {
		xmlSql = new StringBuffer().append("<fc").append(pubdjbh).append(">")
				.append(SKbillsheet.codeheader).append("</fc").append(pubdjbh)
				.append(">").append(xmlSql)
	}
	var sRet = djupdate(xmlSql.toString());
	reloadExtGrid();
	return sRet
}
function reloadExtGrid() {
	if (typeof(creator_pt_grids) == 'undefined') {
		creator_pt_grids = new Array()
	}
	var oExtGrid = creator_pt_grids;
	for (var i = 0;i < oExtGrid.length; ++i) {
		oExtGrid[i].obj.store.reload()
	}
}
function getgzid() {
	return SendHttp(new StringBuffer().append(location.protocol).append("//")
			.append(location.host).append(fcpubdata.servletPath)
			.append("/WebBill").append(fcpubdata.dotnetVersion)
			.append("?getRecnum").toString(), "<no>LGZ</no>")
}
function djupdate(sSql) {
	var djid = fcpubdata.djid;
	var ret = SendHttp(new StringBuffer().append(location.protocol)
			.append("//").append(location.host).append(fcpubdata.servletPath)
			.append("/WebBill").append(fcpubdata.dotnetVersion)
			.append("?djupdate&key=djupdate&djid=").append(djid).toString(),sSql);
	ret = bindccid(ret);
	return ret
}
function savegrid(sSql) {
	var djid = fcpubdata.djid;
	var ret = SendHttp(new StringBuffer().append(location.protocol)
			.append("//").append(location.host).append(fcpubdata.servletPath)
			.append("/WebBill").append(fcpubdata.dotnetVersion)
			.append("?savegrid&key=savegrid&djid=").append(djid).toString(),sSql);
	ret = bindccid(ret);
	return ret
}
function message(maincaption, caption1, caption2, caption3) {
	var arr = new Array();
	arr[0] = maincaption;
	arr[1] = caption1;
	arr[2] = caption2;
	arr[3] = caption3;
	var sRet = window.showModalDialog(fcpubdata.Path
			+ "/fceform/common/message.htm", arr,
			"status:no;dialogHeight:40px;dialogWidth:425px;center:yes;");
	return sRet
}
function TmpTableAddField(tmpTable, sF, sV, gzid) {
	sF = sF + ",";
	var oDsMain = GetDsMainObj();
	var sInsert = new StringBuffer().append("Insert into ").append(tmpTable)
			.append(" (").append(sF).append("GZID) Values (").append(sV)
			.append("'").append(gzid).append("')").toString();
	var sFadd = new StringBuffer();
	var sVadd = new StringBuffer();
	var s11 = oDsMain.format;
	if (isSpace(s11) == false) {
		var oXml = new ActiveXObject("Microsoft.XMLDOM");
		oXml.async = false;
		oXml.loadXML(s11);
		var oList = oXml.documentElement
				.selectNodes("//field[fieldkind='临时计算项']");
		for (var iList = 0;iList < oList.length; iList++) {
			var sExp = oList.item(iList).childNodes(6).text;
			var sFieldName = oList.item(iList).childNodes(0).text;
			var vValue = eval(sExp);
			sFadd.append(sFieldName).append(",");
			sVadd.append("'").append(vValue).append("',")
		}
		sInsert = new StringBuffer().append("Insert into ").append(tmpTable)
				.append(" (").append(sF).append(sFadd).append("GZID) Values (")
				.append(sV).append(sVadd).append("'").append(gzid).append("')")
				.toString()
	}
	return sInsert
}
function DelBill() {
	if (NotCanSave())
		return;
	var ret = window.confirm("确定删除吗？");
	if (ret == false) {
		return
	}
	var oDsMain = GetDsMainObj();
	if (oDsMain == null) {
		alert("请在表单模版上增加一个主数据集控件(指没有绑定到表格控件的数据集控件)后再试此功能");
		return
	}
	var sTable = SKbillsheet.mastertable;
	if (isSpace(sTable))
		sTable = oDsMain.saveastable;
	if (isSpace(sTable)) {
		alert("请设置" + fcpubvar.DsMain + "的保存表名!");
		return
	}
	var sdjbh = oDsMain.Fields.Field[SKbillsheet.keyfield].Value;
	var sInsert = new StringBuffer().append("update ").append(sTable)
			.append(" set beactive='否'").append(" where ")
			.append(SKbillsheet.keyfield).append("='").append(sdjbh)
			.append("'").toString();
	var sRet = fc_insert(sInsert.toString());
	if (isSpace(sRet) == false) {
		alert(sRet)
	} else {
		oDsMain.Delete();
		AddBill()
	}
}
function DelRow(dsGrid) {
	if (NotCanSave())
		return;
	var ret = window.confirm("确定删除当前行吗？");
	if (ret == false) {
		return
	}
	if (arguments.length == 0)
		dsGrid = dssub1;
	var sTable = SKbillsheet.mastertable;
	if (isSpace(sTable)) {
		sTable = dsGrid.saveastable
	}
	if (isSpace(sTable)) {
		alert("请设置表格数据集的另存表名!");
		return
	}
	var arr = MultiKeyTmp(dsGrid);
	var sWhere = "";
	sWhere = MultiKeyWhere(arr, dsGrid.RecNo, dsGrid);
	if (isSpace(sWhere)) {
		var sdjbh = dsGrid.Fields.Field[SKbillsheet.keyfield].Value;
		sWhere = SKbillsheet.keyfield + "='" + sdjbh + "'"
	}
	var sInsert = new StringBuffer().append("update ").append(sTable)
			.append(" set beactive='否'").append(" where ").append(sWhere)
			.toString();
	var sRet = fc_insert(sInsert.toString());
	if (isSpace(sRet) == false) {
		alert(sRet)
	} else {
		dsGrid.Delete()
	}
}
function DelGridRow(dsGrid) {
	if (NotCanSave())
		return;
	var ret = window.confirm("确定删除当前行吗？");
	if (ret == false) {
		return
	}
	if (arguments.length == 0) {
		dsGrid = dssub1
	}
	var sTable = dsGrid.saveastable;
	var arr = MultiKeyTmp(dsGrid);
	var sWhere = "";
	sWhere = MultiKeyWhere(arr, dsGrid.RecNo, dsGrid);
	if (isSpace(sWhere)) {
		var sdjbh = dsGrid.Fields.Field[SKbillsheet.keyfield].Value;
		var sQuot = "'";
		if (dsGrid.Fields.Field[SKbillsheet.keyfield].DataType == "整数"
				|| dsGrid.Fields.Field[SKbillsheet.keyfield].DataType == "实数") {
			sQuot = ""
		}
		sWhere = SKbillsheet.keyfield + "=" + sQuot + sdjbh + sQuot
	}
	var sInsert = new StringBuffer().append("delete from ").append(sTable)
			.append(" where ").append(sWhere);
	var sRet = fc_insert(sInsert.toString());
	if (isSpace(sRet) == false) {
		alert(sRet)
	} else {
		dsGrid.Delete()
	}
}
function MultiDelGridRow(dsGrid, iMultiSelCol) {
	if (NotCanSave())
		return;
	var ret = window.confirm("确定删除吗？");
	if (ret == false) {
		return
	}
	if (arguments.length == 0) {
		dsGrid = dssub1
	}
	if (typeof iMultiSelCol == "undefined")
		iMultiSelCol = 0;
	var sTable = dsGrid.saveastable;
	var arr = MultiKeyTmp(dsGrid);
	var sWhere = "";
	var l = dsGrid.oDom.documentElement.childNodes.length - 1;
	for (var i = 0;i < l; i++) {
		if (dsGrid.oDom.documentElement.childNodes(i).childNodes(iMultiSelCol).text == "是") {
			var sWhere1 = MultiKeyWhere(arr, i, dsGrid);
			if (isSpace(sWhere1)) {
				var sdjbh = dsGrid.oDom.documentElement.childNodes(i)
						.childNodes(dsGrid.FieldNameToNo(SKbillsheet.keyfield)).text;
				var sQuot = "'";
				if (dsGrid.Fields.Field[SKbillsheet.keyfield].DataType == "整数"
						|| dsGrid.Fields.Field[SKbillsheet.keyfield].DataType == "实数") {
					sQuot = ""
				}
				sWhere1 = SKbillsheet.keyfield + "=" + sQuot + sdjbh + sQuot
			}
			if (IsSpace(sWhere1) == false) {
				sWhere += "(" + sWhere1 + ") or "
			}
		}
	}
	if (sWhere != "") {
		sWhere = sWhere.substring(0, sWhere.length - 3)
	}
	var sInsert = "delete from " + sTable + " where " + sWhere;
	var sRet = fc_insert(sInsert);
	if (isSpace(sRet) == false) {
		alert(sRet)
	} else {
		dsGrid.Open()
	}
}
function table_have_field1(tablename) {
	var sXml = dataset_select("select * from " + tablename + " where 1=2", 1, 1);
	if (sXml == fcpubdata.pub_sendhttp_errmsg)
		return fcpubdata.pub_sendhttp_errmsg;
	var oXml = new ActiveXObject("Microsoft.XMLDOM");
	oXml.async = false;
	oXml.loadXML(sXml);
	if (oXml.documentElement == null) {
		alert("很可能是数据库中无" + tablename + "表,或者是select * from " + tablename
				+ " where 1=2 执行出错!");
		return
	}
	var sFields = oXml.documentElement.childNodes(0).childNodes(1).xml;
	var oXml = new ActiveXObject("Microsoft.XMLDOM");
	oXml.async = false;
	oXml.loadXML(sFields);
	return oXml
}
function table_have_field2(oXml, fieldname) {
	var oNode = oXml.documentElement.selectSingleNode("field[fieldname='"
			+ fieldname.toLowerCase() + "']");
	if (oNode == null)
		return false;
	else
		return true
}
function SaveGrid(sTag, sExit) {
	if (NotCanSave())
		return;
	if (dssub1.Update() == 1)
		return;
	var billkeyfield = SKbillsheet.keyfield;
	var st1 = LoadUserData("hr", "gzt");
	if (isSpace(st1))
		st1 = "01";
	dssub1.dset_cont();
	var saveasTable = dssub1.saveastable;
	var tmpTable = dssub1.temptable;
	var gzid = getgzid();
	if (gzid == fcpubdata.pub_sendhttp_errmsg)
		return fcpubdata.pub_sendhttp_errmsg;
	var xmlFields = dssub1.format;
	var oXml = new ActiveXObject("Microsoft.XMLDOM");
	oXml.async = false;
	oXml.loadXML(xmlFields);
	if (isSpace(saveasTable) == false) {
		var ooXml = table_have_field1(saveasTable);
		if (typeof ooXml != "object")
			return fcpubdata.pub_sendhttp_errmsg
	}
	var sF = "";
	for (var i = 0;i < oXml.documentElement.childNodes.length; i++) {
		if (isSpace(saveasTable)
				|| ((isSpace(saveasTable) == false) && table_have_field2(ooXml,
						oXml.documentElement.childNodes(i).childNodes(0).text))) {
			sF += oXml.documentElement.childNodes(i).childNodes(0).text + ","
		}
	}
	var xmlSql = "";
	for (var ii = 0;ii < dssub1.RecordCount; ii++) {
		var keyvalue = "";
		if (dssub1.oDom.documentElement.childNodes(ii).getAttribute("rowstate") == "edit"
				|| ((sTag == "checkdj" || sTag == "uncheckdj") && ii == dssub1.RecNo)) {
			var sUpdate = "";
			for (var i = 0;i < dssub1.FieldCount; i++) {
				if (isSpace(saveasTable)
						|| ((isSpace(saveasTable) == false) && table_have_field2(
								ooXml, oXml.documentElement.childNodes(i)
										.childNodes(0).text))) {
					if (isSpace(dssub1.oDom.documentElement.childNodes(ii)
							.childNodes(i).text)) {
						s1 = ""
					} else {
						s1 = dssub1.oDom.documentElement.childNodes(ii)
								.childNodes(i).text
					}
					if (dssub1.Fields.Field[i].DataType == "整数"
							|| dssub1.Fields.Field[i].DataType == "实数") {
						if (isSpace(s1))
							s1 = "0"
					}
					sUpdate += dssub1.Fields.Field[i].FieldName + "='" + s1
							+ "',";
					var sname = dssub1.FieldNoToName(i);
					if (billkeyfield.toUpperCase() == sname.toUpperCase())
						keyvalue = s1
				}
			}
			if (sTag == "checkdj") {
				sUpdate += "ischeck='是',scheckdate='" + curDate()
						+ "',scheckman='" + getuser() + "',"
			}
			if (sTag == "uncheckdj") {
				sUpdate += "ischeck='否',scheckdate='',scheckman='',"
			}
			if (sTag == "check") {
				sUpdate += "shenhrq='" + curDate() + "',shenhr='" + getuser()
						+ "',"
			}
			if (sTag == "check1") {
				sUpdate += "fabrq='" + curDate() + "',fabr='" + getuser()
						+ "',"
			}
			sUpdate = "Update " + saveasTable + " Set " + sUpdate;
			sUpdate = sUpdate.substring(0, sUpdate.length - 1);
			sUpdate += " where " + billkeyfield + "='" + keyvalue + "'";
			if (sTag == "工资输入")
				sUpdate += " and gztid='" + st1 + "'";
			xmlSql += "<no>" + repXml(sUpdate) + "</no>"
		}
		if (dssub1.oDom.documentElement.childNodes(ii).getAttribute("rowstate") == "add"
				|| dssub1.oDom.documentElement.childNodes(ii)
						.getAttribute("rowstate") == "edit") {
			var sV = "";
			var s11111 = "";
			for (var i = 0;i < dssub1.FieldCount; i++) {
				if (isSpace(saveasTable)
						|| ((isSpace(saveasTable) == false) && table_have_field2(
								ooXml, oXml.documentElement.childNodes(i).childNodes(0).text))) {
					if (isSpace(dssub1.oDom.documentElement.childNodes(ii).childNodes(i).text))
						s1 = "";
					else
						s1 = dssub1.oDom.documentElement.childNodes(ii).childNodes(i).text;
					if (dssub1.Fields.Field[i].FieldName == billkeyfield) {
						s1 = ":get_keyfield";
						s11111 = dssub1.oDom.documentElement.childNodes(ii).childNodes(i).text;
						if (isSpace(s11111) == false)
							s1 = s11111
					}
					if (dssub1.Fields.Field[i].DataType == "整数"
							|| dssub1.Fields.Field[i].DataType == "实数") {
						if (dssub1.Fields.Field[i].FieldName == fcpubdata.gridno_fieldname) {
							sV += (ii + 1) + ","
						} else {
							if (isSpace(s1))
								sV += "0,";
							else
								sV += s1 + ","
						}
					} else {
						sV += "'" + s1 + "',"
					}
				}
			}
			if (isSpace(saveasTable) == false) {
				if (sF.length > 0) {
					sV = sV.substring(0, sV.length - 1)
				}
				var sV1 = repStr(sV, ":get_keyfield", s11111);
				var sInsert = "Insert into " + tmpTable + " (" + sF
						+ "GZID) Values (" + sV1 + ",'" + gzid + "')";
				if (fcpubdata.databaseTypeName != "mysql") {
					xmlSql += "<no>" + repXml(sInsert) + "</no>"
				}
				var st12 = "";
				var st13 = "";
				var st14 = "";
				if (sTag == "工资输入") {
					st12 = " and gztid='" + st1 + "'";
					st13 = ",gztid ";
					st14 = ",'" + st1 + "'"
				}
				var s11 = fc_select("select " + billkeyfield + " from "
						+ saveasTable + " where " + billkeyfield + "='"
						+ keyvalue + "'" + st12, 1, 1);
				var sHave = "存在";
				if (s11.length < 16)
					sHave = "不存在";
				if (dssub1.oDom.documentElement.childNodes(ii)
						.getAttribute("rowstate") == "add") {
					var sInsert = "Insert into " + saveasTable + " ("
							+ sF.substring(0, sF.length - 1) + ") Values ("
							+ sV + ")";
					xmlSql += "<" + SKbillsheet.codeheader + ">"
							+ repXml(sInsert) + "</" + SKbillsheet.codeheader
							+ ">"
				} else if (sHave == "不存在") {
					var sInsert = "Insert into " + saveasTable + " ("
							+ sF.substring(0, sF.length - 1) + st13
							+ ") Values (" + sV1 + st14 + ")";
					xmlSql += "<" + SKbillsheet.codeheader + ">"
							+ repXml(sInsert) + "</" + SKbillsheet.codeheader
							+ ">"
				}
			}
		}
	}
	if (isSpace(SKbillsheet.runsave) == false) {
		xmlSql += "<runsave>{ call " + repXml(trim(SKbillsheet.runsave))
				+ "(?,?) };" + SKbillsheet.dj_id + ";" + gzid + "</runsave>"
	}
	var sRet1 = savegrid(xmlSql);
	if (isSpace(sRet1) == false) {
		alert(sRet1)
	} else {
		pubEdit = false;
		alert("保存成功！")
	}
	if (fcpubdata.databaseTypeName != "mysql") {
		xmlSql = "<no>" + "delete from " + tmpTable + " where GZID='" + gzid
				+ "'" + "</no>"
	}
	var sRet1 = inserts(xmlSql);
	if (isSpace(sRet1) == false) {
		alert(sRet1)
	}
	if (sTag == "check" || sTag == "checkdj" || sTag == "uncheckdj") {
		dssub1.Open()
	}
	if (sExit == "exit") {
		parent.close()
	}
}

function SaveOneGrid(sExit, ogridDs) {
	if (NotCanSave())
		return;
	if (typeof ogridDs == "undefined") {
		var oDs = dssub1
	} else {
		var oDs = ogridDs
	}
	if (DsBeforeSave(oDs))
		return;
	var billkeyfield = SKbillsheet.keyfield;
	var sProcName = SKbillsheet.runsave;
	oDs.dset_cont();
	var saveasTable = oDs.saveastable;
	if (isSpace(saveasTable)) {
		alert("数据集" + oDs.id + "的保存表名不能为空!");
		return
	}
	var tmpTable = oDs.temptable;
	if (isSpace(sProcName) == false && fcpubdata.databaseTypeName != "mysql") {
		var gzid = getgzid();
		if (gzid == fcpubdata.pub_sendhttp_errmsg)
			return fcpubdata.pub_sendhttp_errmsg;
		var tmp_sF = InsertTmpTableFields(oDs)
	}
	var xmlFields = oDs.format;
	var oXmlField = SetDom(xmlFields);
	var arrField = Save_GetFieldArr(oDs, oXmlField);
	if (arrField == null) {
		return fcpubdata.pub_sendhttp_errmsg
	}
	var fieldLen = arrField.length;
	var sF = Save_GetsF(arrField, oXmlField);
	var arr = MultiKeyTmp(oDs);
	var xmlSql = "";
	var ll = oDs.RecordCount;
	for (var ii = 0;ii < ll; ii++) {
		if (oDs.oDom.documentElement.childNodes(ii).getAttribute("rowstate") == "add"
				|| oDs.oDom.documentElement.childNodes(ii)
						.getAttribute("rowstate") == "edit") {
			var sWhere = "";
			var sV = "";
			var sU = "";
			for (var arri = 0;arri < fieldLen; arri++) {
				i = arrField[arri];
				var arrRet = Save_GetsVsU(oDs, ii, i, billkeyfield, sV, sU);
				sV = arrRet.sV;
				sU = arrRet.sU
			}
			if (sV.length > 0)
				sV = sV.substring(0, sV.length - 1);
			if (sU.length > 0)
				sU = sU.substring(0, sU.length - 1);
			if (isSpace(saveasTable) == false) {
				sWhere = MultiKeyWhere(arr, ii, oDs);
				var s11111 = "";
				if (isSpace(sWhere)) {
					try {
						s11111 = oDs.oDom.documentElement.childNodes(ii)
								.childNodes(oDs.FieldNameToNo(billkeyfield)).text
					} catch (e) {
					};
					sWhere = billkeyfield + "='" + s11111 + "'"
				}
				if (isSpace(sProcName) == false
						&& fcpubdata.databaseTypeName != "mysql") {
					var sInsert = "Insert into " + tmpTable + " (" + tmp_sF
							+ "GZID) Values (" + InsertTmpTableSql(oDs, ii)
							+ "'" + gzid + "')";
					xmlSql += "<no>" + repXml(sInsert) + "</no>"
				}
				var s11 = fc_select("select * from " + saveasTable + " where "
						+ sWhere, 1, 1);
				var sHave = "存在";
				if (s11.length < 16)
					sHave = "不存在";
				if (sHave == "不存在"
						|| oDs.oDom.documentElement.childNodes(ii)
								.getAttribute("rowstate") == "add") {
					if (SKbillsheet.idtype == "3") {
						sV = RepStr(sV, ":get_keyfield", SKbillsheet.codeheader
								+ ".nextval")
					}
					var sInsert = "Insert into " + saveasTable + " (" + sF
							+ ") Values (" + sV + ")";
					var sstmp1 = SKbillsheet.codeheader;
					if (isSpace(sstmp1))
						sstmp1 = "no";
					xmlSql += "<" + sstmp1 + ">" + repXml(sInsert) + "</"
							+ sstmp1 + ">"
				} else {
					var sUpdate = "Update " + saveasTable + " Set " + sU
							+ " where " + sWhere;
					xmlSql += "<no>" + repXml(sUpdate) + "</no>"
				}
			}
		}
	}
	if (isSpace(sProcName) == false) {
		xmlSql += "<runsave>{ call " + repXml(trim(sProcName)) + "(?,?) };"
				+ SKbillsheet.dj_sn + ";" + gzid + "</runsave>"
	}
	if (isSpace(xmlSql))
		return;
	var sRet = "";
	var sRet1 = savegrid(xmlSql);
	if (isSpace(sRet1) == false) {
		alert(sRet1);
		sRet = sRet1
	} else {
		pubEdit = false;
		ClearEditTag(oDs);
		alert("保存成功！")
	}
	if (isSpace(sProcName) == false && fcpubdata.databaseTypeName != "mysql") {
		xmlSql = "<no>" + "delete from " + tmpTable + " where GZID='" + gzid
				+ "'" + "</no>";
		var sRet1 = inserts(xmlSql);
		if (isSpace(sRet1) == false) {
			alert(sRet1)
		}
	}
	if (sExit == "退出") {
		CloseBill()
	}
	oDs.Open();
	return sRet
}
function ClearEditTag(oDs) {
	for (var ii = 0;ii < oDs.RecordCount; ii++) {
		oDs.oDom.documentElement.childNodes(ii).setAttribute("rowstate", "")
	}
}
function MultiKeyTmp(dssub1) {
	var arr = new Array();
	var xmlFields = dssub1.format;
	var oXml = new ActiveXObject("Microsoft.XMLDOM");
	oXml.async = false;
	oXml.loadXML(xmlFields);
	var oList = oXml.documentElement.selectNodes("//field[primarykey='是']");
	for (var iList = 0;iList < oList.length; iList++) {
		var sFieldName = oList.item(iList).childNodes(0).text;
		var no = dssub1.FieldNameToNo(sFieldName);
		arr[iList] = no
	}
	return arr
}
function MultiKeyWhere(arr, curRecNo, dssub1) {
	var sWhere = "";
	for (var i = 0;i < arr.length; i++) {
		var sQuot = "'";
		if (dssub1.oDataField.childNodes(arr[i]).childNodes(1).text == "整数"
				|| dssub1.oDataField.childNodes(arr[i]).childNodes(1).text == "实数")
			sQuot = "";
		sWhere += dssub1.oDataField.childNodes(arr[i]).childNodes(0).text
				+ "="
				+ sQuot
				+ dssub1.oDom.documentElement.childNodes(curRecNo)
						.childNodes(arr[i]).text + sQuot + " and "
	}
	if (sWhere != "") {
		sWhere = sWhere.substring(0, sWhere.length - 4)
	}
	return sWhere
}
function CheckBill(sTag) {
	var billkeyfield = SKbillsheet.keyfield;
	var saveasTable = dssub1.saveastable;
	if (isSpace(saveasTable)) {
		alert("请设置表格数据集上的另存表名!");
		return
	}
	if (isSpace(billkeyfield)) {
		alert("请设置表单属性中的单据编号字段名!");
		return
	}
	var xmlSql = "";
	var keyvalue = dssub1.Fields.Field[billkeyfield].Value;
	var sFieldName = "scheckdesc";
	var keyno = dssub1.FieldNameToNo(billkeyfield);
	var oList = dssub1.oDom.documentElement.selectNodes("tr[@multisel='是']");
	var iList = 0;
	while (iList < oList.length || oList.length == 0) {
		if (oList.length > 0) {
			keyvalue = oList[iList].childNodes(keyno).text
		}
		var sUpdate = "";
		if (sTag == "checkdj") {
			sUpdate += "ischeck='是',scheckdate='" + curDate() + "',scheckman='"
					+ getuser() + "',";
			try {
				sUpdate += sFieldName + "='"
						+ dssub1.Fields.Field[sFieldName].Value + "',"
			} catch (E) {
			}
		}
		if (sTag == "uncheckdj") {
			sUpdate += "ischeck='否',scheckdate='',scheckman='',";
			try {
				sUpdate += sFieldName + "='" + dssub1.Fields.Field[sFieldName].Value + "',"
			} catch (E) {
			}
		}
		sUpdate = "Update " + saveasTable + " Set " + sUpdate;
		sUpdate = sUpdate.substring(0, sUpdate.length - 1);
		sUpdate += " where " + billkeyfield + "='" + keyvalue + "'";
		xmlSql += "<no>" + repXml(sUpdate) + "</no>";
		iList++;
		if (oList.length == 0)
			break
	}
	var sRet1 = inserts(xmlSql);
	if (isSpace(sRet1) == false) {
		alert(sRet1)
	} else {
		pubEdit = false;
		alert("操作成功！")
	}
}
function CheckAll(fieldname, fieldvalue) {
	var colno = dssub1.FieldNameToNo(fieldname);
	for (var ii = 0;ii < dssub1.RecordCount; ii++) {
		dssub1.oDom.documentElement.childNodes(ii).childNodes(colno).text = trim(fieldvalue);
		dssub1.oDom.documentElement.childNodes(ii).setAttribute("rowstate",
				"edit")
	}
	SaveOneGrid();
	return
}
function DelTmpTab() {
	var billtag = SKbillsheet.codeheader;
	var employeeid = getuser();
	var sql = "select gzid from billgz where sbilltag='" + billtag
			+ "' and semployeeid='" + employeeid + "'";
	var sRet = fc_select(sql, 1, -1);
	var xmlSql = "";
	if (sRet.length > 16) {
		var ssgzid = "";
		var oXml = new ActiveXObject("Microsoft.XMLDOM");
		oXml.async = false;
		oXml.loadXML(sRet);
		for (var i = 0;i < oXml.documentElement.childNodes.length - 1; i++) {
			ssgzid += "'"
					+ oXml.documentElement.childNodes(i).childNodes(0).text
					+ "',"
		}
		if (isSpace(ssgzid) == false) {
			ssgzid = ssgzid.substring(0, ssgzid.length - 1);
			var tabtmp = AllTmpTable();
			if (isSpace(tabtmp) == false) {
				var arr = tabtmp.split(",");
				for (var i = 0;i < arr.length; i++) {
					var sql = "delete from " + arr[i] + " where gzid in ("
							+ ssgzid + ")";
					xmlSql += "<no>" + sql + "</no>"
				}
			}
		}
	} else {
		return
	}
	var sql = "delete from billgz where sbilltag='" + billtag
			+ "' and semployeeid='" + employeeid + "'";
	xmlSql += "<no>" + sql + "</no>";
	var sRet = inserts(xmlSql);
	if (isSpace(sRet)) {
		alert("清除成功!")
	} else {
		alert(sRet)
	}
}
function AllTmpTable() {
	var sRet = "";
	var s1 = "";
	s1 = DsMain.temptable;
	if (typeof s1 != "undefined") {
		sRet += s1 + ","
	}
	try {
		s1 = dssub1.temptable;
		if (typeof s1 != "undefined") {
			sRet += s1 + ","
		}
	} catch (e) {
	}
	try {
		s1 = dssub2.temptable;
		if (typeof s1 != "undefined") {
			sRet += s1 + ","
		}
	} catch (e) {
	}
	try {
		s1 = dssub3.temptable;
		if (typeof s1 != "undefined") {
			sRet += s1 + ","
		}
	} catch (e) {
	}
	if (isSpace(sRet) == false) {
		sRet = sRet.substring(0, sRet.length - 1)
	}
	return sRet
}
function NotCanSave() {
	if (parent.piAction == 3) {
		alert("单据展现状态,不能保存!");
		return true
	}
	return false
}
function gridvalid(ogrid) {
	var d = new Date();
	var t = d.getTime();
	var oDs = eval(ogrid.dataset);
	var oldrow = oDs.RecNo;
	var sProc = "";
	var s1 = SKbillsheet.codeheader;
	var xml1 = "";
	var xml2 = "";
	var arr = arrFieldNo(oDs);
	if (arr != null) {
		for (var i = 0;i < arr.length; i++) {
			xml2 += "<no>" + "exec dj_sub_valid @ask_interface=1, @djtag='"
					+ SKbillsheet.codeheader + "',@fieldname='"
					+ oDs.Fields.Field[arr[i]].FieldName + "'" + "</no>"
		}
		for (var irow = 0;irow < oDs.RecordCount; irow++) {
			xml1 += xml2
		}
		var sXml = fc_gridvalid(xml1);
		var oProc = new ActiveXObject("Microsoft.XMLDOM");
		oProc.async = false;
		oProc.loadXML(sXml)
	}
	var ooList = oDs.oDataField.selectNodes("field[valid = '是']");
	for (var irow = 0;irow < oDs.RecordCount; irow++) {
		oDs.dset_fset(irow);
		oDs.RecNo = irow;
		for (var i = 0;i < ooList.length; i++) {
			var sRet = oDs.dataValid(oDs.Fields.Field[ooList.item(i)
					.childNodes(0).text], oDs.Fields.Field[ooList.item(i)
					.childNodes(0).text].Value, 5);
			if (sRet != "") {
				oDs.dset_fset(oldrow);
				oDs.RecNo = oldrow;
				return sRet
			}
		}
		if (arr != null) {
			for (var j = 0;j < arr.length; j++) {
				var newsql = oProc.documentElement.childNodes(irow * arr.length
						+ j).childNodes(0).text;
				if (newsql != "校验通过") {
					newsql = repfieldname(newsql, oDs,
							oDs.Fields.Field[arr[j]].FieldName);
					sProc += "<no>" + newsql + "</no>"
				}
			}
		}
	}
	if (sProc != "") {
		var sXml = fc_gridvalid(sProc);
		var oXml = new ActiveXObject("Microsoft.XMLDOM");
		oXml.async = false;
		oXml.loadXML(sXml);
		if (oXml.documentElement.nodeName == "err") {
			return oXml.documentElement.childNodes(1).text + ": "
					+ oXml.documentElement.childNodes(0).text
		} else {
		}
	}
	var d = new Date();
	var t1 = d.getTime();
	return ""
}
function arrFieldNo(oDs) {
	var arr = new Array();
	var oList = oDs.oDataField.selectNodes("field[procvalid = '是']");
	if (oList.length <= 0)
		return null;
	for (var i = 0;i < oList.length; i++) {
		var no = oDs.FieldNameToNo(oList.item(i).childNodes(0).text);
		arr[i] = no
	}
	return arr
}
function repfieldname(sql, oDs, curFieldName) {
	var arr = new Array();
	arr[0] = "fieldname";
	arr[1] = "spid";
	sql = repStr(sql, ":" + arr[0], "'" + curFieldName + "'");
	for (var i = 1;i < arr.length; i++) {
		sql = repStr(sql, ":" + arr[i], "'" + oDs.Fields.Field[arr[i]].Value
				+ "'")
	}
	return sql
}
function DjSave(sExit) {
	var sRet = "";
	if (sExit == "退出") {
		sRet = SaveBill(1)
	} else {
		sRet = SaveBill(2)
	}
	return sRet
}
function DjSaveShow() {
	var b = DjSave();
	if (IsSpace(b)) {
		alert('保存成功')
	} else {
		if (b != "主数据集不能通过数据校验")
			alert(b)
	}
}
function GridSaveShow(odsgrid) {
	var b = GridSave(odsgrid);
	if (IsSpace(b)) {
	} else {
		alert(b)
	}
}
function GridSave(odsgrid, sExit) {
	return SaveOneGrid(sExit, odsgrid)
}
function fc_gridvalid(sXml) {
	return SendHttp(new StringBuffer().append(location.protocol).append("//")
			.append(location.host).append(fcpubdata.servletPath)
			.append("/WebBill").append(fcpubdata.dotnetVersion)
			.append("?fc_gridvalid").toString(), sXml)
}
function RepUpdateSql(svalue) {
	var sRet = repStr(svalue, "'", "''");
	return sRet
}
function AddBill() {
	var oDsMain = GetDsMainObj();
	if (oDsMain == null) {
		alert("请在表单模版上增加一个主数据集控件(指没有绑定到表格控件的数据集控件)后再试此功能");
		return
	}
	var sErr = oDsMain.OpenEmpty();
	var o = window.document.all.tags("dataset");
	for (var ii = 0;ii < o.length; ii++) {
		if (o[ii].id != fcpubvar.DsMain) {
			o[ii].PageSize = -1;
			sErr = o[ii].OpenEmpty()
		}
	}
	pubdjbh = ""
}
function BeforeSaveFieldTrans(sXml, fieldname, fieldvalue, mRecNo) {
	if (isSpace(sXml))
		return fieldvalue;
	var oXml = SetDom(sXml);
	var l = oXml.documentElement.childNodes.length;
	for (var i = 0;i < l; i++) {
		if (oXml.documentElement.childNodes(i).childNodes(0).text == fieldname) {
			var ss = unescape(oXml.documentElement.childNodes(i).childNodes(1).text);
			ss = eval(ss);
			return ss
		}
	}
	return fieldvalue
}
function ReAllLineSum(dssub1) {
	var tmpNo = dssub1.RecNo;
	for (var i = 0;i < dssub1.RecordCount; i++) {
		dssub1.LineSum(null, i)
	}
	dssub1.RecNo = tmpNo
}
function getSubKeyName(dssub1, MainKey) {
	var xmlFields = dssub1.format;
	var oXml = new ActiveXObject("Microsoft.XMLDOM");
	oXml.async = false;
	oXml.loadXML(xmlFields);
	var oList = oXml.documentElement.selectNodes("//field[primarykey='是']");
	for (var iList = 0;iList < oList.length; iList++) {
		var sFieldName = oList.item(iList).childNodes(0).text;
		if (sFieldName.toUpperCase() != MainKey.toUpperCase()) {
			return sFieldName
		}
	}
	return ""
}
function Save_GetFieldArr(dssub1, oXml) {
	var arrField = new Array();
	var saveasTable = dssub1.saveastable;
	if (isSpace(saveasTable) == false) {
		var ooXml = table_have_field1(saveasTable);
		if (typeof ooXml != "object")
			return null;
		var arri = 0;
		for (var i = 0;i < dssub1.FieldCount; i++) {
			if (dssub1.Fields.Field[i].DataType == "图象")
				continue;
			if (table_have_field2(ooXml, oXml.documentElement.childNodes(i)
					.childNodes(0).text)) {
				arrField[arri] = i;
				arri++
			}
		}
	} else {
		var arri = 0;
		for (var i = 0;i < dssub1.FieldCount; i++) {
			if (dssub1.Fields.Field[i].DataType == "图象")
				continue;
			arrField[arri] = i;
			arri++
		}
	}
	return arrField
}

function Save_GetsF(arrField, oXml, bMainTab) {
	var sF = "";
	for (var arri = 0;arri < arrField.length; arri++) {
		i = arrField[arri];
		var curFieldName = oXml.documentElement.childNodes(i).childNodes(0).text;
		if (SKbillsheet.idtype == "2"
				&& curFieldName.toUpperCase() == SKbillsheet.keyfield
						.toUpperCase() && bMainTab != "从") {
		} else {
			sF += curFieldName + ","
		}
	}
	if (sF.length > 0) {
		sF = sF.substring(0, sF.length - 1)
	}
	return sF
}
function Save_GetsVsRecords(oDs, ii, i, billkeyfield, sV, sU, bMainTab,
		sSubKeyFieldName, record) {
	var bool = true;
	var s1 = "";
	var s11111 = "";
	billkeyfield = billkeyfield.toLowerCase();
	var curFieldName = oDs.Fields.Field[i].FieldName.toLowerCase();
	var curFieldValue = record.get(curFieldName);
	if (SKbillsheet.idtype == "2" && curFieldName == billkeyfield
			&& bMainTab != "从") {
	} else if (bMainTab == "从"
			&& curFieldName == sSubKeyFieldName.toLowerCase()) {
		sV += "':get_keyfield',"
	} else {
		s1 = BeforeSaveFieldTrans(oDs.fieldtrans,
				oDs.Fields.Field[i].FieldName, curFieldValue, i);
		if (curFieldName == billkeyfield) {
			if (typeof SKbillsheet.idtype == "undefined"
					|| SKbillsheet.idtype == "1" || SKbillsheet.idtype == "2"
					|| SKbillsheet.idtype == "3") {
				s1 = ":get_keyfield";
				if (bMainTab != "是") {
					s11111 = curFieldValue;
					if (isSpace(s11111) == false)
						s1 = s11111
				}
			} else {
				var oDsMain = GetDsMainObj();
				s1 = record.get(billkeyfield)
			}
		}
		if (oDs.Fields.Field[i].DataType == "整数"
				|| oDs.Fields.Field[i].DataType == "实数") {
			if (isSpace(s1)) {
				sV += "0,";
				s1 = "0"
			} else {
				sV += s1 + ","
			}
		} else if (oDs.Fields.Field[i].DataType == "自定") {
			sV += "" + s1 + ","
		} else if (oDs.Fields.Field[i].DataType == "日期"
				&& fcpubdata.databaseTypeName == "oracle") {
			sV += "" + "to_date('" + s1 + "','yyyy-mm-dd')" + ","
		} else {
			s1 = RepUpdateSql(s1);
			sV += "'" + s1 + "',"
		}
		var squot = "'";
		if (oDs.Fields.Field[i].DataType == "自定"
				|| oDs.Fields.Field[i].DataType == "整数"
				|| oDs.Fields.Field[i].DataType == "实数") {
			squot = ""
		}
		if (oDs.Fields.Field[i].DataType == "日期"
				&& fcpubdata.databaseTypeName == "oracle") {
			squot = "";
			s1 = "to_date('" + s1 + "','yyyy-mm-dd')"
		}
		if (curFieldName != billkeyfield) {
			sU += oDs.Fields.Field[i].FieldName + "=" + squot + s1 + squot
					+ ","
		}
	}
	var arrRet = {
		sV : "",
		sU : ""
	};
	arrRet.sV = sV;
	arrRet.sU = sU;
	return arrRet
}
function Save_GetsVsU(oDs, ii, i, billkeyfield, sV, sU, bMainTab,
		sSubKeyFieldName) {
	var bool = true;
	var s1 = "";
	var s11111 = "";
	billkeyfield = billkeyfield.toLowerCase();
	var curFieldName = oDs.Fields.Field[i].FieldName.toLowerCase();
	var curFieldValue = "";
	if (bMainTab == "是") {
		curFieldValue = oDs.Fields.Field[i].Value
	} else {
		curFieldValue = oDs.oDom.documentElement.childNodes(ii).childNodes(i).text
	}
	if (SKbillsheet.idtype == "2" && curFieldName == billkeyfield
			&& bMainTab != "从") {
	} else if (bMainTab == "从"
			&& curFieldName == sSubKeyFieldName.toLowerCase()) {
		sV += "'" + IGetSubTableKeyValue(ii, sSubKeyFieldName) + "',"
	} else {
		s1 = BeforeSaveFieldTrans(oDs.fieldtrans,
				oDs.Fields.Field[i].FieldName, curFieldValue, i);
		if (curFieldName == billkeyfield) {
			if (typeof SKbillsheet.idtype == "undefined"
					|| SKbillsheet.idtype == "1" || SKbillsheet.idtype == "2"
					|| SKbillsheet.idtype == "3") {
				s1 = ":get_keyfield";
				if (bMainTab != "是") {
					s11111 = curFieldValue;
					if (isSpace(s11111) == false)
						s1 = s11111
				}
			} else {
				var oDsMain = GetDsMainObj();
				s1 = oDsMain.Fields.Field[billkeyfield].Value
			}
		}
		if (oDs.Fields.Field[i].DataType == "整数"
				|| oDs.Fields.Field[i].DataType == "实数") {
			if (oDs.Fields.Field[i].FieldName == fcpubdata.gridno_fieldname) {
				sV += (ii + 1) + ","
			} else {
				if (isSpace(s1)) {
					sV += "0,";
					s1 = "0"
				} else {
					sV += s1 + ","
				}
			}
		} else if (oDs.Fields.Field[i].DataType == "自定") {
			sV += "" + s1 + ","
		} else if (oDs.Fields.Field[i].DataType == "日期"
				&& fcpubdata.databaseTypeName == "oracle") {
			sV += "" + "to_date('" + s1 + "','yyyy-mm-dd')" + ","
		} else {
			s1 = RepUpdateSql(s1);
			sV += "'" + s1 + "',"
		}
		var squot = "'";
		if (oDs.Fields.Field[i].DataType == "自定"
				|| oDs.Fields.Field[i].DataType == "整数"
				|| oDs.Fields.Field[i].DataType == "实数") {
			squot = ""
		}
		if (oDs.Fields.Field[i].DataType == "日期"
				&& fcpubdata.databaseTypeName == "oracle") {
			squot = "";
			s1 = "to_date('" + s1 + "','yyyy-mm-dd')"
		}
		if (curFieldName != billkeyfield) {
			sU += oDs.Fields.Field[i].FieldName + "=" + squot + s1 + squot
					+ ","
		}
	}
	var arrRet = {
		sV : "",
		sU : ""
	};
	arrRet.sV = sV;
	arrRet.sU = sU;
	return arrRet
}
function SubTableEditSave(oDs, billkeyfield) {
	var sWhere = "";
	var saveasTable = oDs.saveastable;
	var ll = oDs.RecordCount;
	var SubKeyName = getSubKeyName(oDs, billkeyfield);
	var iSubKeyNo = oDs.FieldNameToNo(SubKeyName);
	var xmlSql = new StringBuilder();
	var sList = new StringBuilder();
	for (var ii = 0;ii < ll; ii++) {
		var s1 = oDs.oDom.documentElement.childNodes(ii).childNodes(iSubKeyNo).text;
		if (isSpace(s1) == false) {
			sList.append("'" + s1 + "'")
		}
	}
	var s1 = sList.toString(",");
	s1 = "delete from " + saveasTable + " where " + billkeyfield + "='"
			+ pubdjbh + "' and " + SubKeyName + " not in (" + s1 + ")";
	xmlSql.append("<no>" + s1 + "</no>");
	var xmlFields = oDs.format;
	var oXmlField = SetDom(xmlFields);
	var arrField = Save_GetFieldArr(oDs, oXmlField);
	if (arrField == null) {
		return fcpubdata.pub_sendhttp_errmsg
	}
	var fieldLen = arrField.length;
	var sF = Save_GetsF(arrField, oXmlField, "从");
	var sInsert = "";
	var oldValue = "";
	var newValue = "";
	var sEditSql = new StringBuilder();
	var sAddSql = new StringBuilder();
	for (var ii = 0;ii < ll; ii++) {
		var sRowTag = oDs.oDom.documentElement.childNodes(ii)
				.getAttribute("rowstate");
		oldValue = oDs.oDom.documentElement.childNodes(ii)
				.childNodes(iSubKeyNo).text;
		newValue = IGetSubTableKeyValue(ii);
		sWhere = " where " + billkeyfield + "='" + pubdjbh + "' and "
				+ SubKeyName + "='" + oldValue + "'";
		if (sRowTag == "add" || sRowTag == "edit") {
			var sV = "";
			var sU = "";
			for (var arri = 0;arri < fieldLen; arri++) {
				i = arrField[arri];
				var arrRet = Save_GetsVsU(oDs, ii, i, billkeyfield, sV, sU,
						"从", SubKeyName);
				sV = arrRet.sV;
				sU = arrRet.sU
			}
			if (sV.length > 0)
				sV = sV.substring(0, sV.length - 1);
			if (sU.length > 0)
				sU = sU.substring(0, sU.length - 1);
			if (sRowTag == "add") {
				sInsert = "Insert into " + saveasTable + " (" + sF
						+ ") Values (" + sV + ")";
				sAddSql.append("<no>" + repXml(sInsert) + "</no>")
			} else {
				sInsert = "Update " + saveasTable + " set " + sU + " " + sWhere;
				sEditSql.append("<no>" + repXml(sInsert) + "</no>")
			}
		} else {
			sInsert = "update " + saveasTable + " set " + SubKeyName + "='"
					+ newValue + "' " + sWhere;
			sEditSql.append("<no>" + repXml(sInsert) + "</no>")
		}
	}
	xmlSql.append(sEditSql.toString());
	xmlSql.append(sAddSql.toString());
	return xmlSql.toString()
}
function InsertTmpTableFields(oDs) {
	var oF = oDs.oDom.documentElement
			.childNodes(oDs.oDom.documentElement.childNodes.length - 1)
			.childNodes(1);
	var l = oF.childNodes.length;
	var sFieldName = '';
	for (var i = 0;i < l; i++) {
		sFieldName += oF.childNodes(i).childNodes(0).text + ","
	}
	return sFieldName
}
function InsertTmpTableSql(oDs, curRow) {
	var oV = oDs.oDom.documentElement.childNodes(curRow);
	var l = oV.childNodes.length;
	var sV = '';
	for (var i = 0;i < l; i++) {
		var s1 = oV.childNodes(i).text;
		if (oDs.Fields.Field[i].DataType == "整数"
				|| oDs.Fields.Field[i].DataType == "实数") {
			if (oDs.Fields.Field[i].FieldName == fcpubdata.gridno_fieldname) {
				sV += (ii + 1) + ","
			} else {
				if (isSpace(s1)) {
					sV += "0,";
					s1 = "0"
				} else {
					sV += s1 + ","
				}
			}
		} else if (oDs.Fields.Field[i].DataType == "自定") {
			sV += "" + s1 + ","
		} else if (oDs.Fields.Field[i].DataType == "日期"
				&& fcpubdata.databaseTypeName == "oracle") {
			sV += "" + "to_date('" + s1 + "','yyyy-mm-dd')" + ","
		} else {
			s1 = RepUpdateSql(s1);
			sV += "'" + s1 + "',"
		}
	}
	return sV
}
function creator_djsave(opType, isSave, showAlert, jumpHref) {
	var oDsMain = GetDsMainObj();
	var retStr = "";
	var sql = "";
	if (isSave == null || isSave == undefined || isSave == "undefined") {
		isSave = false
	}
	if (showAlert == null || showAlert == undefined || showAlert == "undefined") {
		showAlert = true
	}
	if (jumpHref == null || jumpHref == undefined || jumpHref == "undefined") {
		jumpHref = ""
	}
	if (isSave) {
		if (opType == '是否选择后续活动' || opType == '是否显示选择下一步执行人'
				|| opType == '是否显示回退' || opType == '活动信息') {
		} else if (opType == 'isShowActSelectText'
				|| opType == 'isShowUserText' || opType == 'isShowBackButton'
				|| opType == 'getActObject') {
		} else {
			sql = getSaveBillSql(2);
			if (sql.indexOf(':与后台连接出错:') != -1) {//后台sql处理是否通过
				if (showAlert)
					alert("操作失败！");
				return sql
			}
		}
	}
	var retValue = "false";
	var djid = "";
	var workflowId = "";
	var sXml = "";
	var cc_form_instanceid = fcpubdata.cc_form_instanceid;
	if (!IsSpace(cc_form_instanceid)) {
		if (opType == '是否选择后续活动' || opType == '是否显示选择下一步执行人'
				|| opType == '是否显示回退' || opType == '活动信息') {
		} else if (opType == 'isShowActSelectText'
				|| opType == 'isShowUserText' || opType == 'isShowBackButton'
				|| opType == 'getActObject') {
		} else {
			djid = fcpubdata.djid;
			workflowId = fcpubdata.workflowId;
			sXml = getControlValue(djid, workflowId);
			sXml = sXml + creator_getWorkflowControlValue()
		}
		if (opType == '启动流程') {
			opType = 'start'
		} else if (opType == '完成活动') {
			opType = 'complete'
		} else if (opType == '回退') {
			opType = 'back'
		} else if (opType == '收回') {
			opType = 'recycle'
		} else if (opType == '终止流程') {
			opType = 'terminate'
		} else if (opType == '暂存') {
			opType = 'tempSaveForm'
		} else if (opType == '是否选择后续活动') {
			opType = 'isShowActSelectText'
		} else if (opType == '是否显示选择下一步执行人') {
			opType = 'isShowUserText'
		} else if (opType == '是否显示回退') {
			opType = 'isShowBackButton'
		} else if (opType == '活动信息') {
			opType = 'getActObject'
		} else if (opType == '挂起') {
			opType = 'suspend'
		} else if (opType == '恢复') {
			opType = 'resume'
		}
		if (typeof(workflowControl_selectUser) != "undefined"
				&& workflowControl_selectUser.style.display != "none"
				&& opType == 'start') {
			if (IsSpace(DYNAMICPERFORMER_NAME.value)) {
				if (!confirm("动态执行人为空，点击确定将发送给所有人!")) {
					return
				}
			}
		}
		if (opType == 'isShowActSelectText' || opType == 'isShowUserText'
				|| opType == 'isShowBackButton') {
			retValue = workflow_operation(opType, '', '', '',
					fcpubdata.wf_isReadOnly);
			if (retValue.indexOf('@') > 0) {
				retValue = retValue.split('@')[1]
			}
			return retValue
		} else if (opType == 'getActObject') {
			retValue = workflow_operation(opType, '', '', '');
			if (retValue.indexOf('@') > 0) {
				retValue = retValue.split('@')[1]
			}
			return retValue
		} else if (opType == 'isShowRecycle') {
			retValue = workflow_operation(opType, '', '', '',
					fcpubdata.wf_isReadOnly);
			if (retValue.indexOf('@') > 0) {
				retValue = retValue.split('@')[1]
			}
			return retValue
		} else if (opType == 'isShowCompleteWorkflow'
				|| opType == 'isShowTempSaveForm'
				|| opType == 'isShowTerminate' || opType == 'isShowSuspend'
				|| opType == 'isShowResume') {
			retValue = workflow_operation(opType, '', '', '',
					fcpubdata.wf_isReadOnly);
			if (retValue.indexOf('@') > 0) {
				retValue = retValue.split('@')[1]
			}
			return retValue
		} else if (opType == 'isShowBackToPrior') {
			if (fcpubdata.wf_isReadOnly == "readonly")
				return true;
			else
				return false
		} else {
			retStr = workflow_operation(opType, cc_form_instanceid, djid, sXml,
					'', sql);
			if (retStr.indexOf('@') > 0) {
				var sTmp = retStr.split('@')[0];
				var retValue = retStr.split('@')[1];
				if (sTmp.indexOf('错误:') < 0) {
					if (oDsMain != null) {
						if (oDsMain.Empty != "null"
								&& SKbillsheet.keyfield != "") {
							oDsMain.bEdit = true;
							oDsMain.Fields.Field[SKbillsheet.keyfield].Value = sTmp;
							oDsMain.Update();
							oDsMain.fset_cont1()
						}
					}
				} else {
					alert(sTmp);
					return sTmp
				}
				if (oDsMain != null) {
					try {
						pubdjbh = oDsMain.Fields.Field[SKbillsheet.keyfield].Value
					} catch (e) {
					}
					oDsMain.bAdd = false;
					oDsMain.bEdit = false;
					pubEdit = false
				}
			} else {
				retValue = retStr
			}
		}
		if (showAlert) {
			if (retValue == "false") {
				alert("操作失败！");
			} else if (retValue == -1) {
				alert("任务已被其它人完成！");
			} else {
				ShowWait("end");
				alert("操作成功！");
			}
		}
	} else if (showAlert) {
		alert('请在流程表单中执行此操作!')
	}
	var workflow_result = document.getElementById("workflowControl_result");
	if (!IsSpace(workflow_result)) {
		workflow_result.value = retValue;
	}
	if (jumpHref != "") {
		if (parent.parent.location.href.indexOf("common_workflow/start_form.jsp") != -1) {
			parent.parent.location.href = jumpHref
		} else if (parent.parent.parent.location.href.indexOf("common_workflow/main.jsp") != -1) {
			parent.parent.parent.location.reload()
		}
	} else {
		return retValue
	}
}
function creator_getActName() {
	var opType = "getActName";
	var retValue = "";
	var cc_form_instanceid = fcpubdata.cc_form_instanceid;
	if (cc_form_instanceid != "clear" && !IsSpace(cc_form_instanceid)) {
		var retValue = workflow_operation(opType);
		if (retValue == "false") {
			return ""
		}
	}
	return retValue
}
function getControlValue(djid, workflowId) {
	var sCtrlXml = "";
	var strsql = "select substr(t.ctrl_id,length(to_char(t.djid))+3) as text_id,t.ctrl_id from td_form_ctrlattr t where t.djid = "
			+ djid + " and oid = '" + workflowId + "'";
	var sXml = SelectSql(strsql, 1, 100, getAppDbName());
	if (sXml == "<root></root>") {
		return "<No></No>"
	} else {
		var oXml = SetDom(sXml);
		var len = oXml.documentElement.childNodes.length;
		for (var i = 0;i < len - 1; i++) {
			var textId = oXml.documentElement.childNodes[i].childNodes[0].text;
			var ctrlId = oXml.documentElement.childNodes[i].childNodes[1].text;
			var ctrlValue = document.getElementById(textId).value;
			sCtrlXml = sCtrlXml + "<No>" + ctrlId + "=" + ctrlValue + "</No>"
		}
		return sCtrlXml
	}
}
function creator_isShowActSelectText() {
	var ret = "failure";
	var next_acts_value = creator_getQueryString("next_acts");
	var ANDSPLITUSERS = creator_getQueryString("andsplitusers");
	var andsplitname = creator_getQueryString("andsplitname");
	var cc_form_instanceid = fcpubdata.cc_form_instanceid;
	if (arguments[0] != null) {
		ret = arguments[0]
	} else {
		ret = creator_djsave('是否选择后续活动', false, false)
	}
	if (ret != "failure" && ret != "false") {
		var arr = new Array();
		arr = ret.split(";");
		var isShowActSelectText = arr[0].split(":")[1];
		var isShowAndActSelectText = arr[1].split(":")[1];
		var selectValue = '';
		if (isShowActSelectText == "true") {
			for (var i = 2;i < arr.length; i++) {
				if (!IsSpace(next_acts_value)) {
					if (next_acts_value == arr[i].split(":")[0]) {
						selectValue = selectValue + '<option value="' + arr[i].split(":")[0] + '" selected>' + arr[i].split(":")[1] + '</option>'
					} else {
						selectValue = selectValue + '<option value="' + arr[i].split(":")[0] + '">' + arr[i].split(":")[1] + '</option>'
					}
				} else {
					if (i == 2) {
						selectValue = selectValue + '<option value="' + arr[i].split(":")[0] + '" selected>' + arr[i].split(":")[1] + '</option>'
					} else {
						selectValue = selectValue + '<option value="' + arr[i].split(":")[0] + '">' + arr[i].split(":")[1] + '</option>'
					}
				}
			}
			var workflowControl_selectAct = document
					.getElementById('workflowControl_selectAct');
			if (workflowControl_selectAct != null
					&& workflowControl_selectAct != "undefined"
					&& workflowControl_selectAct != "null") {
				workflowControl_selectAct.outerHTML = SelectAddOption(workflowControl_selectAct, selectValue)
			}
		} else {
			var workflowControl_selectAct = document
					.getElementById('workflowControl_selectAct');
			if (workflowControl_selectAct != null
					&& workflowControl_selectAct != "undefined"
					&& workflowControl_selectAct != "null") {
				workflowControl_selectAct.style.display = "none"
			}
		}
		if (isShowAndActSelectText == "false") {
			var workflowControl_selectAndUser = document
					.getElementById('workflowControl_selectAndUser');
			if (!IsSpace(workflowControl_selectAndUser)) {
				workflowControl_selectAndUser.style.display = "none"
			}
			var ANDSPLITUSERS_ACTNAME = document
					.getElementById('ANDSPLITUSERS_ACTNAME');
			if (!IsSpace(ANDSPLITUSERS_ACTNAME)) {
				ANDSPLITUSERS_ACTNAME.style.display = "none"
			}
		} else {
			if (!IsSpace(document.getElementById("ANDSPLITUSERS"))) {
				document.getElementById("ANDSPLITUSERS").value = ANDSPLITUSERS;
				var userRealName = SendHttp(location.protocol
						+ "//"
						+ location.host
						+ fcpubdata.servletPath
						+ "/DbTools?param=noUse&key=getAndSplitRealName&andSplitName="
						+ andsplitname + "&ANDSPLITUSERS=" + ANDSPLITUSERS);
				if (!IsSpace(userRealName))
					document.getElementById("ANDSPLITUSERS_ACTNAME").value = userRealName
			}
		}
	} else {
		var workflowControl_selectAct = document
				.getElementById('workflowControl_selectAct');
		if (workflowControl_selectAct != null
				&& workflowControl_selectAct != "undefined"
				&& workflowControl_selectAct != "null") {
			workflowControl_selectAct.style.display = "none"
		}
		var workflowControl_selectAndUser = document
				.getElementById('workflowControl_selectAndUser');
		if (!IsSpace(workflowControl_selectAndUser)) {
			workflowControl_selectAndUser.style.display = "none"
		}
		var ANDSPLITUSERS_ACTNAME = document
				.getElementById('ANDSPLITUSERS_ACTNAME');
		if (!IsSpace(ANDSPLITUSERS_ACTNAME)) {
			ANDSPLITUSERS_ACTNAME.style.display = "none"
		}
	}
	return ret
}
function creator_isShowUserText() {
	var DYNAMICPERFORMER = creator_getQueryString("DYNAMICPERFORMER");
	var ret = "";
	var cc_form_instanceid = fcpubdata.cc_form_instanceid;
	if (arguments[0] != null) {
		ret = arguments[0]
	} else {
		ret = creator_djsave('是否显示选择下一步执行人', false, false)
	}
	if (ret != "true") {
		var workflowControl_selectUser = document
				.getElementById('workflowControl_selectUser');
		if (!IsSpace(workflowControl_selectUser)) {
			workflowControl_selectUser.style.display = "none"
		}
	} else if (!IsSpace(DYNAMICPERFORMER)) {
		if (!IsSpace(document.getElementById("DYNAMICPERFORMER"))) {
			document.getElementById("DYNAMICPERFORMER").value = DYNAMICPERFORMER;
			var userRealName = SendHttp(location.protocol + "//"
					+ location.host + fcpubdata.servletPath
					+ "/DbTools?param=noUse&key=getUserRealName&userName="
					+ DYNAMICPERFORMER);
			if (!IsSpace(userRealName))
				document.getElementById("DYNAMICPERFORMER_NAME").value = userRealName
		}
	} else if (ret == "true") {
		changeSelectActor()
	}
	return ret
}
function creator_isShowBackButton() {
	var ret = "";
	var cc_form_instanceid = fcpubdata.cc_form_instanceid;
	if (!IsSpace(cc_form_instanceid) && cc_form_instanceid != 'clear') {
		if (arguments[0] != null) {
			ret = arguments[0]
		} else {
			ret = creator_djsave('是否显示回退', false, false)
		}
	}
	if (ret != "true") {
		var workflowControl_back = document.getElementById('workflowControl_back');
		if (!IsSpace(workflowControl_back)) {
			workflowControl_back.style.display = "none"
		}
	}
	return ret
}
function creator_isShowRecycle() {
	var ret = "";
	var workflowControl_recycle = document.getElementById('workflowControl_recycle');
	if (!IsSpace(workflowControl_recycle)) {
		var cc_form_instanceid = fcpubdata.cc_form_instanceid;
		if (!IsSpace(cc_form_instanceid) && cc_form_instanceid != 'clear') {
			if (arguments[0] != null) {
				ret = arguments[0]
			} else {
				ret = creator_djsave('isShowRecycle', false, false)
			}
		}
		if (ret != "true") {
			workflowControl_recycle.style.display = "none"
		}
	}
}
function creator_isShowCompleteWorkflow() {
	var ret = "";
	var workflowControl_recycle = document.getElementById('workflowControl_complete');
	if (!IsSpace(workflowControl_recycle)) {
		var cc_form_instanceid = fcpubdata.cc_form_instanceid;
		if (!IsSpace(cc_form_instanceid) && cc_form_instanceid != 'clear') {
			if (arguments[0] != null) {
				ret = arguments[0]
			} else {
				ret = creator_djsave('isShowCompleteWorkflow', false, false)
			}
		}
		if (ret != "true") {
			workflowControl_recycle.style.display = "none"
		}
	}
}
function creator_isShowTempSaveForm() {
	var ret = "";
	var workflowControl_recycle = document.getElementById('workflowControl_tempSaveForm');
	if (!IsSpace(workflowControl_recycle)) {
		var cc_form_instanceid = fcpubdata.cc_form_instanceid;
		if (!IsSpace(cc_form_instanceid) && cc_form_instanceid != 'clear') {
			if (arguments[0] != null) {
				ret = arguments[0]
			} else {
				ret = creator_djsave('isShowTempSaveForm', false, false)
			}
			if (ret != "true") {
				workflowControl_recycle.style.display = "none"
			}
		}
	}
}
function creator_isShowTerminate() {
	var ret = "";
	var workflowControl_recycle = document.getElementById('workflowControl_terminate');
	if (!IsSpace(workflowControl_recycle)) {
		var cc_form_instanceid = fcpubdata.cc_form_instanceid;
		if (!IsSpace(cc_form_instanceid) && cc_form_instanceid != 'clear') {
			if (arguments[0] != null) {
				ret = arguments[0]
			} else {
				ret = creator_djsave('isShowTerminate', false, false)
			}
		}
		if (ret != "true") {
			workflowControl_recycle.style.display = "none"
		}
	}
}
function creator_isShowBackToPrior() {
	var ret = "";
	var workflowControl_suspend = document.getElementById('workflowControl_backToPrior');
	if (!IsSpace(workflowControl_suspend)) {
		var cc_form_instanceid = fcpubdata.cc_form_instanceid;
		if (!IsSpace(cc_form_instanceid) && cc_form_instanceid != 'clear') {
			if (arguments[0] != null) {
				ret = arguments[0]
			} else {
				ret = creator_djsave('isShowBackToPrior', false, false)
			}
		}
		if (ret == false) {
			workflowControl_backToPrior.style.display = "none"
		}
	}
}
function creator_isShowSuspend() {
	var ret = "";
	var workflowControl_suspend = document.getElementById('workflowControl_suspend');
	if (!IsSpace(workflowControl_suspend)) {
		var cc_form_instanceid = fcpubdata.cc_form_instanceid;
		if (!IsSpace(cc_form_instanceid) && cc_form_instanceid != 'clear') {
			if (arguments[0] != null) {
				ret = arguments[0]
			} else {
				ret = creator_djsave('isShowSuspend', false, false)
			}
		}
		if (ret != "true") {
			workflowControl_suspend.style.display = "none"
		}
	}
}
function creator_isShowResume() {
	var ret = "";
	var workflowControl_resume = document.getElementById('workflowControl_resume');
	if (!IsSpace(workflowControl_resume)) {
		var cc_form_instanceid = fcpubdata.cc_form_instanceid;
		if (!IsSpace(cc_form_instanceid) && cc_form_instanceid != 'clear') {
			if (arguments[0] != null) {
				ret = arguments[0]
			} else {
				ret = creator_djsave('isShowResume', false, false)
			}
		}
		if (ret != "true") {
			workflowControl_resume.style.display = "none"
		}
	}
}
function creator_isShowOtherButton() {
	var cc_form_instanceid = fcpubdata.cc_form_instanceid;
	if (!IsSpace(cc_form_instanceid) && cc_form_instanceid == 'clear'
			|| fcpubdata.newccid) {
		var workflowControl_complete = document.getElementById('workflowControl_complete');
		if (!IsSpace(workflowControl_complete)) {
			workflowControl_complete.style.display = "none"
		}
		var workflowControl_terminate = document.getElementById('workflowControl_terminate');
		if (!IsSpace(workflowControl_terminate)) {
			workflowControl_terminate.style.display = "none"
		}
	} else {
		var workflowControl_start = document.getElementById('workflowControl_start');
		if (!IsSpace(workflowControl_start)) {
			workflowControl_start.style.display = "none"
		}
	}
}
function creator_getWorkflowControlValue() {
	var sXml = "";
	var workflowControl_selectAct = document
			.getElementById("workflowControl_selectAct");
	if (workflowControl_selectAct != null
			&& workflowControl_selectAct != "undefined") {
		sXml = sXml + "<No>" + "NEXT_ACT=" + workflowControl_selectAct.value
				+ "</No>"
	}
	var DYNAMICPERFORMER = document.getElementById("DYNAMICPERFORMER");
	if (!IsSpace(DYNAMICPERFORMER)) {
		sXml = sXml + "<No>" + "DYNAMICPERFORMER=" + DYNAMICPERFORMER.value
				+ "</No>"
	}
	var ANDSPLITUSERS = document.getElementById("ANDSPLITUSERS");
	if (!IsSpace(ANDSPLITUSERS)) {
		sXml = sXml + "<No>" + "ANDSPLITUSERS=" + ANDSPLITUSERS.value + "</No>"
	}
	var ANDSPLITUSERSSUBFLOW = document.getElementById("ANDSPLITUSERSSUBFLOW");
	if (!IsSpace(ANDSPLITUSERSSUBFLOW)) {
		sXml = sXml + "<No>" + "ANDSPLITUSERSSUBFLOW="
				+ ANDSPLITUSERSSUBFLOW.value + "</No>"
	}
	return sXml
}
function creator_showAllWorkflowButtonControl() {
	var SPLIT_CHAR = "@";
	var requestStr = "isShowActSelectText" + SPLIT_CHAR + "isShowUserText"
			+ SPLIT_CHAR + "isShowBackButton" + SPLIT_CHAR + "isShowRecycle"
			+ SPLIT_CHAR + "isShowCompleteWorkflow" + SPLIT_CHAR
			+ "isShowTempSaveForm" + SPLIT_CHAR + "isShowTerminate"
			+ SPLIT_CHAR + "isShowSuspend" + SPLIT_CHAR + "isShowResume";
	var ret = workflow_operation(requestStr, '', '', '',
			fcpubdata.wf_isReadOnly);
	if (ret.indexOf('@') > 0) {
		ret = ret.substring(ret.indexOf('@') + 1, ret.length)
	}
	var arr_ret = ret.split(SPLIT_CHAR);
	creator_isShowActSelectText(arr_ret[0]);
	creator_isShowUserText(arr_ret[1]);
	creator_isShowBackButton(arr_ret[2]);
	creator_isShowRecycle(arr_ret[3]);
	creator_isShowCompleteWorkflow(arr_ret[4]);
	creator_isShowTempSaveForm(arr_ret[5]);
	creator_isShowTerminate(arr_ret[6]);
	creator_isShowSuspend(arr_ret[7]);
	creator_isShowResume(arr_ret[8]);
	creator_isShowBackToPrior();
	creator_isShowOtherButton();
	changeWorkflowControlStatus()
}
function getSaveBillSql(iTag, sProc) {
	var currentSystemID = creator_getSession("subsystem_id_nouse");
	var appUserName = "";
	if (!IsSpace(currentSystemID) && currentSystemID != "module") {
		appUserName = "APP_" + currentSystemID.toUpperCase() + "."
	}
	var d = new Date();
	var t = d.getTime();
	if (NotCanSave())
		return "展现状态不能保存";
	var owin = ShowWait("正在保存......");
	var draftTable = "draft";
	var draftsubTable = "draftsub";
	var draftdescValue = "";
	if (iTag == 5) {
		draftdescValue = window
				.showModalDialog(fcpubdata.Path
						+ "/fceform/common/inputmsg.htm", "请输入草稿说明:",
						"status:no;dialogHeight:105px;dialogWidth:470px;dialogTop:180;dialogLeft:250px")
	}
	var oDsMain = GetDsMainObj();
	if (oDsMain == null)
		return "只有表单上含有主数据集控件(就是指没有绑定到表格的数据集控件)时才能保存!";
	var arrImgValue = "";
	var arrImgName = "";
	var arrImgChange = "";
	var sProcName = SKbillsheet.runsave;
	var billkeyfield = SKbillsheet.keyfield;
	var strRet = "";
	var xmlSql = "";
	var sInsert = "";
	var s1 = "";
	var gzid = "";
	if ((isSpace(sProcName) == false && fcpubdata.databaseTypeName != "mysql")
			|| iTag == 4) {
		gzid = getgzid();
		if (gzid == fcpubdata.pub_sendhttp_errmsg)
			return fcpubdata.pub_sendhttp_errmsg
	}
	if (oDsMain.Empty != "null") {
		oDsMain.cont1_fset();
		oDsMain.bEdit = true;
		if (oDsMain.Update() == 1) {
			ShowWait("end");
			return "主数据集不能通过数据校验"
		}
		var tmpTable = appUserName + oDsMain.temptable;
		var saveasTable = oDsMain.saveastable;
		if (iTag == 4)
			saveasTable = "";
		var xmlFields = oDsMain.format;
		var oXmlField = SetDom(xmlFields);
		var arrField = Save_GetFieldArr(oDsMain, oXmlField);
		if (arrField == null) {
			return fcpubdata.pub_sendhttp_errmsg
		}
		var kk = arrField.length;
		var sF = Save_GetsF(arrField, oXmlField, "主");
		var sV = "";
		var sU = "";
		var ltmp = oDsMain.FieldCount;
		for (var j = 0;j < ltmp; j++) {
			if (oDsMain.Fields.Field[j].DataType == "图象") {
				arrImgValue = oDsMain.Fields.Field[j].Value;
				arrImgName = oDsMain.Fields.Field[j].FieldName;
				arrImgChange = oDsMain.Fields.Field[j].valid;
				break
			}
		}
		for (var arri = 0;arri < kk; arri++) {
			i = arrField[arri];
			if (SKbillsheet.idtype == "3"
					&& pubdjbh == ""
					&& oDsMain.Fields.Field[i].FieldName.toUpperCase() == SKbillsheet.keyfield
							.toUpperCase()) {
				sV += SKbillsheet.codeheader + ".nextval,";
				continue
			}
			var arrRet = Save_GetsVsU(oDsMain, 0, i, billkeyfield, sV, sU, "是");
			sV = arrRet.sV;
			sU = arrRet.sU;
			sV = sV.replace("\r\n", "  ")
		}
		if ((isSpace(sProcName) == false && fcpubdata.databaseTypeName != "mysql")
				|| iTag == 4) {
			var tmp_sF = InsertTmpTableFields(oDsMain);
			sInsert = "Insert into " + tmpTable + " (" + tmp_sF
					+ "GZID) Values ("
					+ InsertTmpTableSql(oDsMain, oDsMain.RecNo) + "'" + gzid
					+ "')";
			xmlSql += "<no>" + repXml(sInsert) + "</no>";
			if (SKbillsheet.idtype == "3" && pubdjbh == "") {
				sV = RepStr(sV, SKbillsheet.codeheader + ".nextval",":get_keyfield")
			}
		}
		if (isSpace(saveasTable) == false) {
			if (sV.length > 0)
				sV = sV.substring(0, sV.length - 1);
			if (sU.length > 0)
				sU = sU.substring(0, sU.length - 1);
			if (pubdjbh == "") {
				sInsert = "Insert into " + saveasTable + " (" + sF
						+ ") Values (" + sV + ")"
			} else {
				var sWhere1 = "";
				if (SKbillsheet.idtype == "5") {
					sWhere1 = MultiKeyWhere(MultiKeyTmp(oDsMain),oDsMain.RecNo, oDsMain)
				} else {
					var sQuot = "'";
					if (oDsMain.Fields.Field[billkeyfield].DataType == "整数"
							|| oDsMain.Fields.Field[billkeyfield].DataType == "实数")
						sQuot = "";
					sWhere1 = billkeyfield + "=" + sQuot + pubdjbh + sQuot
				}
				sInsert = "Update " + saveasTable + " set " + sU + " where " + sWhere1
			}
			xmlSql += "<no>" + repXml(sInsert) + "</no>";
			if (iTag == 5) {
				sInsert = "Insert into " + draftTable + " (" + sF
						+ ",draftdesc) Values (" + sV + ",'" + draftdescValue
						+ "')";
				xmlSql += "<no>" + repXml(sInsert) + "</no>"
			}
		}
	}
	var oArrGrid = window.document.all.tags("webgrid");
	for (var iGrid = 0;iGrid < oArrGrid.length; iGrid++) {
		if (oArrGrid[iGrid].readonly == "是")
			continue;
		var dssub1 = eval("window." + oArrGrid[iGrid].dataset);
		if (dssub1.pubpara == "是")
			continue;
		if (DsBeforeSave(dssub1, oArrGrid[iGrid]))
			return;
		if (IsSpace(dssub1.otherkey)) {
			billkeyfield = SKbillsheet.keyfield
		} else {
			billkeyfield = dssub1.otherkey
		}
		var tmpTable = dssub1.temptable;
		var saveasTable = dssub1.saveastable;
		if (iTag == 4)
			saveasTable = "";
		var sOtherSave = false;
		if (isSpace(saveasTable) == false && pubdjbh != ""
				&& SKbillsheet.OtherSave == "是") {
			xmlSql += SubTableEditSave(dssub1, billkeyfield);
			sOtherSave = true
		} else {
			dssub1.ReSum();
			var sErr = gridvalid(oArrGrid[iGrid]);
			if (sErr != "") {
				ShowWait("end");
				alert(sErr);
				return sErr
			}
			if (isSpace(saveasTable) == false && pubdjbh != "") {
				var sQuot = "'";
				if (dssub1.Fields.Field[billkeyfield].DataType == "整数"
						|| dssub1.Fields.Field[billkeyfield].DataType == "实数")
					sQuot = "";
				sInsert = "delete from " + saveasTable + " where " + billkeyfield + "=" + sQuot + pubdjbh + sQuot;
				xmlSql += "<no>" + repXml(sInsert) + "</no>"
			}
			var sSubKeyFieldName = getSubKeyName(dssub1, billkeyfield);
			var xmlFields = dssub1.format;
			var oXmlField = SetDom(xmlFields);
			var arrField = Save_GetFieldArr(dssub1, oXmlField);
			if (arrField == null) {
				continue
			}
			var kk = arrField.length;
			var sF = Save_GetsF(arrField, oXmlField, "从");
			if ((isSpace(sProcName) == false && fcpubdata.databaseTypeName != "mysql")
					|| iTag == 4) {
				var tmp_sF = InsertTmpTableFields(dssub1)
			}
			var ll = dssub1.RecordCount;
			for (var ii = 0;ii < ll; ii++) {
				if (dssub1.oDom.documentElement.childNodes(ii).getAttribute("rowstate") == "new")
					continue;
				var sV = "";
				for (var arri = 0;arri < kk; arri++) {
					i = arrField[arri];
					var arrRet = Save_GetsVsU(dssub1, ii, i, billkeyfield, sV,
							"", "从", sSubKeyFieldName);
					sV = arrRet.sV
				}
				if ((isSpace(sProcName) == false && fcpubdata.databaseTypeName != "mysql")
						|| iTag == 4) {
					sInsert = "Insert into " + tmpTable + " (" + tmp_sF
							+ "GZID) Values (" + InsertTmpTableSql(dssub1, ii)
							+ "'" + gzid + "')";
					xmlSql += "<no>" + repXml(sInsert) + "</no>"
				}
				if (isSpace(saveasTable) == false) {
					if (sV.length > 0) {
						sV = sV.substring(0, sV.length - 1)
					}
					sInsert = "Insert into " + saveasTable + " (" + sF + ") Values (" + sV + ")";
					xmlSql += "<no>" + repXml(sInsert) + "</no>";
					if (iTag == 5) {
						sInsert = "Insert into " + draftsubTable + " (" + sF + ") Values (" + sV + ")";
						xmlSql += "<no>" + repXml(sInsert) + "</no>"
					}
				}
			}
		}
	}
	if (typeof(creator_pt_grids) == 'undefined') {
		creator_pt_grids = new Array()
	}
	var oExtGrid = creator_pt_grids;
	for (var i = 0;i < oExtGrid.length; ++i) {
		var extGridObj = oExtGrid[i].obj;
		if (!eval(oExtGrid[i].isEdit))
			continue;
		var dssub1 = eval("window." + oExtGrid[i].dataset);
		if (dssub1.pubpara == "是")
			continue;
		if (IsSpace(dssub1.otherkey)) {
			billkeyfield = SKbillsheet.keyfield
		} else {
			billkeyfield = dssub1.otherkey
		}
		var tmpTable = dssub1.temptable;
		var saveasTable = dssub1.saveastable;
		var sOtherSave = false;
		dssub1.ReSum();
		var sSubKeyFieldName = getSubKeyName(dssub1, billkeyfield)
				.toLowerCase();
		var xmlFields = dssub1.format;
		var oXmlField = SetDom(xmlFields);
		var arrField = Save_GetFieldArr(dssub1, oXmlField);
		if (arrField == null) {
			continue
		}
		var kk = arrField.length;
		var sF = Save_GetsF(arrField, oXmlField, "从");
		var records = extGridObj.store.getModifiedRecords();
		var ll = records.length;
		for (var ii = 0;ii < ll; ii++) {
			var sV = "";
			var sU = "";
			for (var arri = 0;arri < kk; arri++) {
				i = arrField[arri];
				var arrRet = Save_GetsVsRecords(dssub1, ii, i, billkeyfield,
						sV, sU, "从", sSubKeyFieldName, records[ii]);
				sV = arrRet.sV;
				sU = arrRet.sU
			}
			if (isSpace(saveasTable) == false) {
				if (sV.length > 0) {
					sV = sV.substring(0, sV.length - 1)
				}
				if (sU.length > 0) {
					sU = sU.substring(0, sU.length - 1)
				}
				if (records[ii].get("opflag") == "del") {
					var sDelete = "delete from " + saveasTable + " where "
							+ sSubKeyFieldName + "='"
							+ records[ii].get(sSubKeyFieldName) + "'";
					xmlSql += "<no>" + repXml(sDelete) + "</no>"
				} else if (records[ii].get("opflag") == "add") {
					sInsert = "Insert into " + saveasTable + " (" + sF
							+ ") Values (" + sV + ")";
					xmlSql += "<no>" + repXml(sInsert) + "</no>"
				} else {
					var sUpdate = "update " + saveasTable + " set ";
					sUpdate += sU + " where ";
					var sWhere1 = "";
					var sQuot = "'";
					if (dssub1.Fields.Field[sSubKeyFieldName].DataType == "整数"
							|| dssub1.Fields.Field[sSubKeyFieldName].DataType == "实数")
						sQuot = "";
					sWhere1 = sSubKeyFieldName + "=" + sQuot
							+ records[ii].get(sSubKeyFieldName) + sQuot;
					sUpdate += sWhere1;
					xmlSql += "<no>" + repXml(sUpdate) + "</no>"
				}
			}
		}
	}
	if (iTag != 4) {
		if (isSpace(sProcName) == false
				&& fcpubdata.databaseTypeName != "mysql") {
			xmlSql += "<runsave>{ call " + repXml(trim(sProcName)) + "(?,?) };"
					+ SKbillsheet.dj_sn + ";" + gzid + "</runsave>"
		}
		if (isSpace(sProc) == false) {
			xmlSql += "<action>" + repXml(sProc) + "</action>"
		}
	} else {
		var sName = window
				.showModalDialog(fcpubdata.Path
						+ "/fceform/common/inputmsg.htm", "请输入挂帐说明:",
						"status:no;dialogHeight:105px;dialogWidth:470px;dialogTop:180;dialogLeft:250px");
		var s1 = "insert into billgz (gzid,sgzname,sgzdate,semployeeid,sbilltag) values ('"
				+ gzid
				+ "','"
				+ sName
				+ "','"
				+ curDateTime()
				+ "','"
				+ getuser() + "','" + SKbillsheet.codeheader + "')";
		xmlSql += "<no>" + s1 + "</no>"
	}
	if (pubdjbh == "") {
		var sidtype = SKbillsheet.idtype;
		if (isSpace(sidtype))
			sidtype = "";
		if (sidtype == "4" || sidtype == "5") {
			var tmp1 = "";
			try {
				tmp1 = oDsMain.Fields.Field[SKbillsheet.keyfield].Value
			} catch (e) {
			}
			xmlSql = "<fc" + tmp1 + ">" + SKbillsheet.codeheader + "</fc" + tmp1 + ">" + xmlSql
		} else {
			xmlSql = "<add" + sidtype + ">" + SKbillsheet.codeheader + "</add" + sidtype + ">" + xmlSql
		}
	} else {
		xmlSql = "<fc" + pubdjbh + ">" + SKbillsheet.codeheader + "</fc"+ pubdjbh + ">" + xmlSql
	}
	if (iTag != 4 && isSpace(sProcName) == false
			&& isSpace(oDsMain.temptable) == false) {
		xmlSql += "<tmpTable>" + "delete from " + appUserName
				+ oDsMain.temptable + " where GZID='" + gzid + "'"
				+ "</tmpTable>";
		try {
			for (var iGrid = 0;iGrid < oArrGrid.length; iGrid++) {
				if (oArrGrid[iGrid].readonly == "是")
					continue;
				var dssub1 = eval("window." + oArrGrid[iGrid].dataset);
				if (dssub1.pubpara == "是")
					continue;
				if (DsBeforeSave(dssub1, oArrGrid[iGrid]))
					return;
				if (oArrGrid.length > 0 && isSpace(dssub1.temptable) == false)
					xmlSql += "<tmpTable>" + "delete from " + appUserName
							+ dssub1.temptable + " where GZID='" + gzid + "'"
							+ "</tmpTable>"
			}
		} catch (e) {
		}
	}
	if (arrImgValue != "" && arrImgChange == "变") {
		if (isSpace(saveasTable) == false) {
			var sql = "";
			if (pubdjbh == "") {
				sql = "update " + saveasTable + " set " + arrImgName
						+ " =(select attachcontent from " + appUserName
						+ "fc_attach where filepos = '" + arrImgValue + "')"
						+ " where id = ':get_keyfield'"
			} else {
				var sWhere1 = "";
				if (SKbillsheet.idtype == "5") {
					sWhere1 = MultiKeyWhere(MultiKeyTmp(oDsMain),
							oDsMain.RecNo, oDsMain)
				} else {
					var sQuot = "'";
					if (oDsMain.Fields.Field[billkeyfield].DataType == "整数"
							|| oDsMain.Fields.Field[billkeyfield].DataType == "实数")
						sQuot = "";
					sWhere1 = billkeyfield + "=" + sQuot + pubdjbh + sQuot
				}
				sql = "update " + saveasTable + " set " + arrImgName
						+ " =(select attachcontent from " + appUserName
						+ "fc_attach where filepos = '" + arrImgValue + "')"
						+ " where " + sWhere1
			}
			sql = sql + "@delete from " + appUserName
					+ "fc_attach where filepos = '" + arrImgValue + "'";
			xmlSql += "<dbImg>" + repXml(sql) + "</dbImg>"
		}
	}
	return xmlSql
}