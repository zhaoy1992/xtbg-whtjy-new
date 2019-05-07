	
	var btnListAdd={	//要注册的按钮的列表
		mytest1: ["这是我新加的工具栏上的按钮", "../images/ef_design_test.gif", false, "mytest1_onclick()"]
	}
	
	//fcpubdata.toolbar = "newnull,opendj,mytest1,|,opendjfile,billtype,djpreview,save,saveas,copy,paste,undo,redo,align,focus,front,behind,form,userfunction,userfunction1,addhtml,execute,showlist,eformhelp,designmenu,cbozoom,br,button,label,image,fcdiv,shape,pagecontrol,treeview,dblike,numedit,divcheckbox,divradio,dataset,webgrid,htmltable,formattab,dbedit,dbcheckbox,dbradiogroup,dblistbox,fccode,dbcombobox,dbmemo,dbimage,dbchart,file,excel,imgsetposition",

function mytest1_onclick() {
	alert("这是我新加的工具栏上的按钮!");
}

//将用户的业务函数注册到函数的选择窗口中.下面是两个简单的示例.用户可以根据需要增加

var arrRegFuncList=[
 	["业务函数","取当前用户名","getuser()","输出参数：<br/> 当前用户名. "],
 	["业务函数","取当前日期","getdate()","输出参数：<br/> 当前日期. "],
 	["业务函数","打开系统管理对象","openTree('type',id,name)","输入参数：<br/>type:org,user,role,group,job<br/>id:接收返回的id<br/>name:接收返回的name<br/>输出参数：<br/> 系统管理对象的id和name."]
];
