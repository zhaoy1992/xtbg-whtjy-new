/*
函数:  chooseOrg
说明:  选择单位
参数：   orgId（回填父页面的控件id）,orgName（回填父页面的控件id）
*/
var chooseOrg = function(orgId,orgName) {
	var s = new jQuery.z_tree();
	s.treeID = 'mian';
	s.treetypestr='radio';
	s.isShowSeacher = true;
	s.treeName = "选取单位";
	s.isType = 'dept';
	s.headerName = "选取单位";
	s.item_id = 'p_template_unitid';
	s.selectedIds = jQuery('#p_template_unitid').val();
	s.type = 'AORG';
	s.returnFunction = function(orgObj) {
		if (!IsSpace(orgObj)) {
			jQuery('#'+orgId).val(orgObj.id);
			jQuery('#'+orgName).val(orgObj.name);
		} else {
			jQuery('#'+orgId).val("");
			jQuery('#'+orgName).val("");
		}
	}
	s.init();
}
