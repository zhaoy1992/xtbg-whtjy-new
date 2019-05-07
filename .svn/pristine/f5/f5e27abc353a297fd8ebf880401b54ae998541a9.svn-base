/*
函数:  chooseFileType
说明:  选择分类
参数：   name 赋值框的id
treetypestr 单选框或者多选框
*/
var chooseFileType = function (typeid,typename,typeno,treetypestr,f){
	var s = new jQuery.z_tree();
	s.treeID = 'mianType';
	s.treetypestr = treetypestr;
	s.isShowSeacher = true;
	s.treeName = "选择分类";
	s.headerName = "选择分类";
	s.type = "PSDATA_TYPE";
	s.isType="dept"; //要设置默认选中值，则需要此类型
	s.selectedIds = jQuery("#"+typeid).val(),
	s.f_org_id = p_unit;//所属单位id 全局的js变量 引用时注意
	s.user_id = user_id;//当前用户ID 全局的js变量 引用时注意
	s.returnFunction = function(nothing,object){    
	    try{
	    	jQuery("#"+typeid).val(object[0].id);
	    	jQuery("#"+typename).val(object[0].name);
	    }catch(e){
	    }
	}
	s.init();
}