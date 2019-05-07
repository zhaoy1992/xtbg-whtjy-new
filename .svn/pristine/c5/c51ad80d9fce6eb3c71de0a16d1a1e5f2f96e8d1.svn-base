/**
 * 沈联成 2012-8-15 added
 */
/**
 * 树:
 */
(function($) {
	$.z_tree_old = function() {
		this.treetypestr = "checkbox"
		this.treeID = "z_tree";
		this.zTreeObject;
		var THIS = this;
		function beforeClick(treeId, treeNode) {

		}

		var log, className = "dark";
		// 用于捕获异步加载之前的事件回调函数，zTree 根据返回值确定是否允许进行异步加载
		function beforeAsync(treeId, treeNode) {

		}
		/*
		 * 用于捕获异步加载出现异常错误的事件回调函数 如果设置了 setting.callback.beforeAsync 方法，且返回
		 * false，将无法触发 onAsyncSuccess / onAsyncError 事件回调函数。
		 */
		function onAsyncError(event, treeId, treeNode, XMLHttpRequest,
				textStatus, errorThrown) {

		}
		/*
		 * 用于捕获异步加载正常结束的事件回调函数 如果设置了 setting.callback.beforeAsync 方法，且返回
		 * false，将无法触发 onAsyncSuccess / onAsyncError 事件回调函数。
		 */
		function onAsyncSuccess(event, treeId, treeNode, msg) {
			if(msg == ""){
				THIS.NODES=[];
			}else{
				THIS.NODES = eval(msg);
				for(var i = 0;i<THIS.NODES.length;i++ ){
					THIS.NODES[i].open=true;
				}
			}
			
	   }

		this.returnFunction = function() {
		}
		this.initTree = function() {
			var setting = {
				view : {
					selectedMulti : false
				/*
				 * 1、设置为 true时，按下 Ctrl 键可以选中多个节点 2、设置为 true / false 都不影响按下 Ctrl
				 * 键可以让已选中的节点取消选中状态（ 取消选中状态可以参考 setting.view.autoCancelSelected ）
				 */
				},
				data : {
					simpleData : { // 简单json类型
						enable : true,
						idKey : this.item_id,
						pIdKey : this.parent_id,
						rootPId : 0
					}
				},
				check : {
					enable : true,
					chkStyle : this.treetypestr,
					chkboxType : {
						"Y" : "s",
						"N" : "s"
					},
					radioType : "all"
				/*
				 * 规则说明： Y 属性定义 CheckBox 被勾选后的情况； N 属性定义 CheckBox 取消勾选后的情况； "p"
				 * 表示操作会影响父级节点； "s" 表明操作会影响子级节点。
				 */
				},
				async : {
					enable : true,
					url : this.url,
					autoParam : this.autoParam,
					otherParam : this.otherParam
				},
				callback : {
					onAsyncSuccess : onAsyncSuccess,
					onClick: window.top.zTreeOnClick
				}
			};
			var wid = window.top;
			if (wid != null) {
				this.zTreeObject =window.top.$.fn.zTree.init(window.top.$("#"+"treeDemo" + THIS.treeID),setting);
			} else {
				this.zTreeObject = $.fn.zTree.init($("treeDemo" + this.treeID),
						setting);
			}
		}
		this.init = function() {
			var lock = new window.top.$.lockDiv();
			lock.init();
			this.item_id = this.item_id?this.item_id:'item_id';
			this.parent_id = this.parent_id?this.parent_id:'parent_id';
			// 树布局
			var root = createDiv("_z_tree_root" + this.treeID, "_z_tree_root");
			body = $("body");
			wid = window.top;
			if (null != wid) {
				body = window.top.document.body;
			}
			if (!this.treeID) {
				alert("this docmunt is null!!")
			} else {
				$(body).append($(root));
			}
			var title = createDiv("_z_tree_title" + this.treeID,
					"_z_tree_title");
			$(root).append($(title));

			var titleImg = createDiv("_z_tree_title_img" + this.treeID,
					"_z_tree_title_img");
			var titleText = createDiv("_z_tree_title_text" + this.treeID,
					"_z_tree_title_text");
			var close = createDiv("_tree_div_title_close" + this.treeID,
					"_tree_div_title_close");
			$(title).append($(close));
			$(title).append($(titleImg));
			$(title).append($(titleText));
			$(titleText).html(this.treeName);
			var isSeachFirst = true;
			var setting = {
					view : {
						selectedMulti : false
					},
					data : {
						simpleData : { // 简单json类型
							enable : true,
							idKey : THIS.item_id,
							pIdKey : THIS.parent_id,
							rootPId : 0
						}
					},
					check : {
						enable : true,
						chkStyle : THIS.treetypestr,
						chkboxType : {
							"Y" : "s",
							"N" : "s"
						},
						radioType : "all"
					}
				};
			var seachterInput = window.top.document.createElement("input");
			var seachterValue = "";
			if (this.isShowSeacher) {
				var seacher = createDiv("_z_tree_seacher_box" + this.treeID,
						"_z_tree_seacher_box");
				$(root).append($(seacher));
				var dds = this;
				$(seachterInput).addClass("_z_tree_seachter_input");
				$(seacher).append($(seachterInput));
				var butseacht = window.top.document.createElement("input");
				$(butseacht).attr("type", "button");
				$(butseacht).val('搜索');
				$(seacher).append($(butseacht));
				$(butseacht).addClass("_z_tree_seachter_input_but");
				$(seachterInput).addClass("tree_box_mid_in");
				$(seachterInput).hover(function(){
					if(""==$(seachterInput).val()){
						$(seachterInput).removeClass();
						$(seachterInput).addClass("tree_box_mid_in");
					}
					else{
						$(seachterInput).removeClass();
					}
					$(seachterInput).addClass("_z_tree_seachter_input");
				});
				$(seachterInput).click(function(){
					if(""==$(seachterInput).val()){
						$(seachterInput).removeClass();
						$(seachterInput).addClass("tree_box_mid_over");
					}
					else{
						$(seachterInput).removeClass();
					}
					$(seachterInput).addClass("_z_tree_seachter_input");
				});
				$(seachterInput).keyup(function(event){
					if(""==$(seachterInput).val()){
						$(seachterInput).removeClass();
						$(seachterInput).addClass("tree_box_mid_over");
					}
					else{
						$(seachterInput).removeClass();
					}
					$(seachterInput).addClass("_z_tree_seachter_input");
					   if (event.keyCode=="13"){
						   $(butseacht).click()
					   }
				});
				$(butseacht).click(
						function() {
							$(seachterInput).removeClass();
							$(seachterInput).addClass("_z_tree_seachter_input");
							seachterValue = $(seachterInput).val();
							if(isSeachFirst){
								dds.zTreeObject = window.top.$.fn.zTree.init(window.top.$("#"+"treeDemo" + dds.treeID),setting,THIS.NODES);
								isSeachFirst = false;
							}
							z_tree_searchTree(dds.zTreeObject, $(seachterInput)
									.val(), "treeDemo" + dds.treeID)
						});

			}
			var header = createDiv("_z_tree_header" + this.treeID,
					"_z_tree_header");
			$(root).append($(header));
			$(header).html(this.headerName);
			var treeBody = createDiv("_z_tree_body" + this.treeID,
					"_z_tree_body");
			$(root).append($(treeBody));
			$(treeBody).append(
					"<ul id='treeDemo" + this.treeID + "' class='ztree'></ul>");
			if (!this.isShowButton) {
				var edit = createDiv("_z_tree_edit" + this.treeID,
						"_z_tree_edit");
				$(root).append($(edit));
				var butOk = window.top.document.createElement("input");
				$(butOk).attr("type", "button");
				$(butOk).val('确定');
				$(edit).append($(butOk));
				$(butOk).addClass("_z_tree_edit_ok");
				var butClear = window.top.document.createElement("input");
				$(butClear).attr("type", "button");
				$(butClear).val('取消');
				$(edit).append($(butClear));
				$(butClear).addClass("_z_tree_edit_clear");

				$(butClear).click(function() {
					$(root).remove();
					lock.remove();
				});
				var rrut = this;
				$(butOk).click(
						function() {
							OK(rrut.zTreeObject, rrut, rrut.returnFunction,
									rrut.isType ? rrut.isType : 'person',seachterValue);
							$(root).remove();
							lock.remove();
						});
				this.initTree();
				$(close).click(function() {
					$(root).remove();
					lock.remove();
				});
			}

		}
	};
	$.extend($.z_tree_old, {
		treeID : "z_tree"/* 树ID */
	});
})(jQuery);


(function($) {

	$.z_tree_leftRigth_old = function() {
		this.selectNode = new Array();
		var rrut = this;
		this.treeID = "z_tree";
		this.zTreeObject = new Array();
		this.deleteNode = new Array();
		var THIS = this;
		THIS.NODES = new Object();
		function beforeClick(treeId, treeNode) {

		}

		var log, className = "dark";
		// 用于捕获异步加载之前的事件回调函数，zTree 根据返回值确定是否允许进行异步加载
		function beforeAsync(treeId, treeNode) {

		}
		/*
		 * 用于捕获异步加载出现异常错误的事件回调函数 如果设置了 setting.callback.beforeAsync 方法，且返回
		 * false，将无法触发 onAsyncSuccess / onAsyncError 事件回调函数。
		 */
		function onAsyncError(event, treeId, treeNode, XMLHttpRequest,
				textStatus, errorThrown) {

		}
		/*
		 * 用于捕获异步加载正常结束的事件回调函数 如果设置了 setting.callback.beforeAsync 方法，且返回
		 * false，将无法触发 onAsyncSuccess / onAsyncError 事件回调函数。
		 */
		function onAsyncSuccess(event, treeId, treeNode, msg) {
			if (msg == "") {
				THIS.NODES[treeId] = [];
			} else {
				THIS.NODES[treeId] = eval(msg);
				for ( var i = 0; i < THIS.NODES[treeId].length; i++) {
					THIS.NODES[treeId][i].open = true;
				}
				window.top.$("#tree_mid_but_right").click();
			}
		}

		this.returnFunction = function() {
		}
		this.initTree = function(p) {
			p.item_id = p.item_id?p.item_id:'item_id';
			p.parent_id = p.parent_id?p.parent_id:'parent_id';
			p.treetypestr = p.treetypestr ? p.treetypestr : "checkbox";
			var setting = {
				view : {
					selectedMulti : false
				/*
				 * 1、设置为 true时，按下 Ctrl 键可以选中多个节点 2、设置为 true / false 都不影响按下 Ctrl
				 * 键可以让已选中的节点取消选中状态（ 取消选中状态可以参考 setting.view.autoCancelSelected ）
				 */
				},
				data : {
					simpleData : { // 简单json类型
						enable : true,
						idKey : p.item_id,
						pIdKey : p.parent_id,
						rootPId : 0
					}
				},
				check : {
					enable : true,
					chkStyle : p.treetypestr,
					chkboxType : {
						"Y" : "s",
						"N" : "s"
					},
					radioType : "all"
				/*
				 * 规则说明： Y 属性定义 CheckBox 被勾选后的情况； N 属性定义 CheckBox 取消勾选后的情况； "p"
				 * 表示操作会影响父级节点； "s" 表明操作会影响子级节点。
				 */
				},
				async : {
					enable : true,
					url : p.url,
					autoParam : p.autoParam,
					otherParam : p.otherParam
				},
				callback : {
					onAsyncSuccess : onAsyncSuccess,
					onClick: window.top.zTreeOnClick
				}
			};
			var wid = window.top;
			if (wid != null) {
				var oo =window.top.$.fn.zTree.init(window.top.$("#"+"treeDemo" +p.treeID),setting);
				oo.leftHeaderText = p.leftHeaderText;
				oo.valueKey = p.valueKey;
				oo.isType = p.isType ? p.isType : 'person';
				oo.item_id = p.item_id;
				oo.parent_id = p.parent_id;
				oo.treetypestr = p.treetypestr;
				oo.autoParam =  p.autoParam,
				oo.otherParam = p.otherParam
				this.zTreeObject.push(oo);
			} else {
				var oo = $.fn.zTree.init($("treeDemo" + p.treeID), setting);
				oo.leftHeaderText = p.leftHeaderText;
				oo.valueKey = p.valueKey;
				oo.isType = p.isType;
				oo.item_id = p.item_id;
				oo.parent_id = p.parent_id;
				oo.treetypestr = p.treetypestr;
				oo.autoParam =  p.autoParam,
				oo.otherParam = p.otherParam
				this.zTreeObject.push(oo);
			}
		}
		this.init = function() {
			var lock = new $.lockDiv();
			lock.init();
			// 树布局
			var root = createDiv("tree_box_opt" + this.treeID, "tree_box_opt");
			var body = $("body");
			wid = window.top;
			if (null != wid) {
				body = window.top.document.body;
			}
			if (!this.treeID) {
				alert("this docmunt is null!!")
			} else {
				$(body).append($(root));
			}
			var title = createDiv("tree_box_opt_title" + this.treeID,
					"tree_box_opt_title");
			$(root).append($(title));
			var titleImg = createDiv("tree_box_opt_left_img" + this.treeID,
					"tree_box_opt_left_img");
			$(title).append($(titleImg));
			var titelText = createDiv("tree_box_opt_left_text" + this.treeID,
					"tree_box_opt_left_text");
			$(title).append($(titelText));
			$(titelText).html(this.titelText)
			var close = createDiv("_tree_div_title_close" + this.treeID,
					"_tree_div_title_close");
			$(title).append($(close));
			var left = createDiv("tree_box_left" + this.treeID, "tree_box_left");
			$(root).append($(left));
			var treeBox = createDiv("tree_box" + this.treeID, "tree_box");
			$(left).append($(treeBox));

			if (this.isShowSeacher) {
				var seacher = createDiv("seacher_box" + this.treeID,
						"seacher_box");
				$(treeBox).append($(seacher));
				var seachterInput =window.top.document.createElement("input");
				$(seachterInput).addClass("_z_tree_seachter_input")
				$(seacher).append($(seachterInput));
				var butseacht = window.top.document.createElement("input");
				$(butseacht).attr("type", "button");
				$(butseacht).val('搜索');
				$(seacher).append($(butseacht));
				$(butseacht).addClass("_z_tree_seachter_input_but");
				var dds = this;
				$(seachterInput).addClass("tree_box_mid_in");
				$(seachterInput).hover(function(){
					if(""==$(seachterInput).val()){
						$(seachterInput).removeClass();
						$(seachterInput).addClass("tree_box_mid_in");
					}
					else{
						$(seachterInput).removeClass();
					}
					$(seachterInput).addClass("_z_tree_seachter_input")
				});
				$(seachterInput).click(function(){
					if(""==$(seachterInput).val()){
						$(seachterInput).removeClass();
						$(seachterInput).addClass("tree_box_mid_over");
					}
					else{
						$(seachterInput).removeClass();
					}
					$(seachterInput).addClass("_z_tree_seachter_input")
				});
				$(seachterInput).keyup(function(event){
					if(""==$(seachterInput).val()){
						$(seachterInput).removeClass();
						$(seachterInput).addClass("tree_box_mid_over");
					}
					else{
						$(seachterInput).removeClass();
					}
					$(seachterInput).addClass("_z_tree_seachter_input");
					   if (event.keyCode=="13"){
						   $(butseacht).click()
					   }
				});
				var sechterFalg = true;
				$(butseacht).click(
						function() {
							$(seachterInput).removeClass();
							$(seachterInput).addClass("_z_tree_seachter_input")
							var dd = window.top.$(".tree_left_body:visible");
							var TETREEOBJ = new Array();
							$.each(thisObject.zTreeObject, function(key, val) {
								
								if(sechterFalg){
									var setting = {
											view : {
												selectedMulti : false
											},
											data : {
												simpleData : { // 简单json类型
													enable : true,
													idKey : val.item_id,
													pIdKey : val.parent_id,
													rootPId : 0
												}
											},
											check : {
												enable : true,
												chkStyle : val.treetypestr,
												chkboxType : {
													"Y" : "s",
													"N" : "s"
												},
												radioType : "all"
											}
									};
									var tt = val;
									 val  = window.top.$.fn.zTree.init(window.top.$("#"+"treeDemo" + dds.treeID + key),setting,THIS.NODES["treeDemo" + dds.treeID + key]);
									 val.leftHeaderText = tt.leftHeaderText;
									 val.valueKey = tt.valueKey;
									 val.isType = tt.isType;
									 val.item_id = tt.item_id;
									 val.parent_id = tt.parent_id;
									 val.treetypestr =tt.treetypestr;
									 val.autoParam =  tt.autoParam,
									 val.otherParam = tt.otherParam
									
									TETREEOBJ.push(val);
								}
								z_tree_searchTree(val, $(seachterInput).val(),
										"treeDemo" + dds.treeID + key);
							});
							if(sechterFalg){
								thisObject.zTreeObject = TETREEOBJ;
							}
							sechterFalg =false;
							window.top.$(".tree_left_body").hide();
							dd.show();
						});

			}
			$.each(this.treeList, function(key, val) {
				var leftHeader = createDiv("tree_left_title" + this.treeID
						+ key, "tree_left_title");
				$(leftHeader).html(val.leftHeaderText)
				$(treeBox).append($(leftHeader))
				$(treeBox).click(function() {
					// 自动反选
				});
				var leftbody = createDiv("tree_left_body" + dds.treeID + key,
						"tree_left_body");
				$(leftbody).append(
						"<ul id='treeDemo" + dds.treeID + key
								+ "' class='ztree'></ul>")
				$(treeBox).append($(leftbody));
				val.treeID = dds.treeID + key;
				dds.initTree(val);
				if (key != 0) {
					$(leftbody).hide();
				}
				;
				$(leftHeader).click(function() {
					window.top.$(".tree_left_body").hide();
					$(leftbody).show();
				});
			});

			var midBox = createDiv("tree_box_mid" + this.treeID, "tree_box_mid");

			var butR = window.top.document.createElement("input");
			$(butR).attr("type", "button");
			$(butR).val('添加 >>');
			$(butR).addClass("tree_mid_but");
			$(butR).attr("id","tree_mid_but_right")
			$(midBox).append($(butR));
			var butL = window.top.document.createElement("input");
			$(butL).attr("type", "button");
			$(butL).val('<< 取消');
			$(midBox).append($(butL));
			$(butL).addClass("tree_mid_but");
			$(root).append($(midBox));

			// !-- right -->
			var right = createDiv("tree_box_right" + this.treeID,
					"tree_box_right");
			var rightHeader = createDiv("tree_box_right_text" + this.treeID,
					"tree_box_right_text");
			$(rightHeader).append(this.rightHeaderText);
			var rightBody = createDiv("tree_box_right_body" + this.treeID,
					"tree_box_right_body");
			$(root).append($(right));
			$(right).append($(rightHeader));
			$(right).append($(rightBody));

			var thisObject = this;
			$(butR)
					.click(
							function() {
								thisObject.deleteNode = new Array();
								$(rightBody).html("");
								var oldSelect = thisObject.selectNode;
								thisObject.selectNode = new Array();
								$
										.each(
												thisObject.zTreeObject,
												function(key, val) {
													var nodes = val
															.getCheckedNodes(true);
													nodes.valueKey = val.valueKey;
													nodes.isType = val.isType;
													var nodesSelect = new Array();
													nodesSelect.isType = val.isType;
													nodesSelect.valueKey = val.valueKey;
													for ( var i = 0, l = nodes.length; i < l; i++) {
														
														if (!IsSpace(nodes[i].user_id) && val.isType === "person"
																|| !IsSpace(nodes[i].org_id) && val.isType === "dept") {
															var deletenodes = true;
															
															if(null != oldSelect[key]){
																for(var s =0;s<oldSelect[key].length;s++){
																	if(oldSelect[key][s].item_code == nodes[i].item_code){
																		deletenodes = false;
																		break;
																	}
																}
															}
															if(nodes[i].name.indexOf($(seachterInput).val())<0&&deletenodes){
																nodes[i].checked = false;
																val.updateNode(nodes[i]);
																continue;
															}
															nodesSelect.push(nodes[i]);
															var li = createDiv(
																	"tree_box_right_body_li"
																			+ thisObject.treeID
																			+ i
																			+ val.valueKey,
																	"tree_box_right_body_li");
															var str = '';
															if (null != nodes[i]
																	.getParentNode()) {
																str = nodes[i]
																		.getParentNode().name
																		+ "-";
															}
															$(li)
																	.append(
																			str
																					+ nodes[i].name
																					+ "("
																					+ val.leftHeaderText
																					+ ")");
															$(li).attr("bb", i)
															$(rightBody)
																	.append(
																			$(li));

															$(li)
																	.click(
																			function() {
																				if ($(
																						this)
																						.attr(
																								"class")
																						.indexOf(
																								"tree_box_right_body_li_click") > -1) {
																					$(
																							this)
																							.removeClass(
																									"tree_box_right_body_li_click");
																				} else {
																					$(
																							this)
																							.addClass(
																									"tree_box_right_body_li_click");
																				}
																				thisObject.deleteNode = new Array();
																				var deleteNode = window.top
																						.$(".tree_box_right_body_li_click");
																				if (null != deleteNode)
																					for (j = 0; j < deleteNode.length; j++) {
																						thisObject.deleteNode
																								.push(nodes[$(
																										deleteNode[j])
																										.attr(
																												"bb")]);
																					}
																			});
														}
													}
													thisObject.selectNode.push(nodesSelect);
												});

							});

			$(butL)
					.click(
							function() {
								// 取消选中
                                var temp = null;
								$.each(thisObject.deleteNode,
										function(key, val) {
											val.checked = false;
											$.each(thisObject.zTreeObject,function(key2, val2) {
												val2.updateNode(val);
											});
											$.each(thisObject.selectNode, function(key3, val3){
												temp = new Array();
												temp.isType = val3.isType;
												temp.valueKey = val3.valueKey;
												for(var i = 0, l = val3.length; i < l; i++){
													if(val.item_code!=val3[i].item_code){
														temp.push(val3[i]);
													}
												}
												thisObject.selectNode[key3]=temp;
											});
										});
								window.top.$(".tree_box_right_body_li_click").remove();
								thisObject.deleteNode = new Array();
								
							});
			var foot = createDiv("tree_box_foot" + this.treeID, "tree_box_foot");
			$(root).append($(foot));
			var butOk = window.top.document.createElement("input");
			$(butOk).attr("type", "button");
			$(butOk).val('确定');
			$(foot).append($(butOk));
			$(butOk).addClass("_z_tree_edit_ok");
			var butClear = window.top.document.createElement("input");
			$(butClear).attr("type", "button");
			$(butClear).val('取消');
			$(foot).append($(butClear));
			$(butClear).addClass("_z_tree_edit_clear");

			$(butClear).click(function() {
				$(root).remove();
				lock.remove();
			});
			$(butOk).click(function() {
				OKRL(thisObject.selectNode, rrut, rrut.returnFunction);
				$(root).remove();
				lock.remove();
			});
			$(close).click(function() {
				$(root).remove();
				lock.remove();
			});
		}
	};
	$.extend($.z_tree_leftRigth_old, {
		treeID : "z_tree"/* 树ID */
	});
})(jQuery);

function OKRL(nodes, obj, returnFunction) {
	var returnObj = '';
	var returnjson = new Object();
	$.each(nodes, function(key, val) {
		var returnValName = "";// 用户姓名
		var returnValId = "";// 用户登录id
		var returnCode = "";// 用户登录名
		var returnparentNode = "";
		var returnValDeptAndUserName = "";// 用户姓名
		var userObj = new Object();
		for ( var i = 0, l = val.length; i < l; i++) {
			
			if (!IsSpace(val[i].user_id) && val.isType === "person") {
				returnValId += val[i].user_id + ",";
				returnValName += val[i].name + ",";
				returnCode += val[i].item_code + ",";
				
				if (null != val[i].getParentNode() && null != val[i].getParentNode().getParentNode()) {
					//returnparentNode += val[i].getParentNode().name + ",";
					//alert(val[i].getParentNode().deptType+"sdaf")
					var paraentNode = val[i].getParentNode();
					var deptType = val[i].getParentNode().deptType;
					var deptName = val[i].getParentNode().name;
					while((deptType.indexOf("A")>-1&&deptType=="A4")||(deptType.indexOf("A")==-1 && deptType.substr(1,1)=='3')){
						paraentNode = paraentNode.getParentNode();
						deptName = paraentNode.name;
						deptType = paraentNode.deptType;
					}
					returnparentNode +=deptName+",";
					returnValDeptAndUserName+=val[i].name +"("+val[i].getParentNode().getParentNode().name+"),";
				}
			}

			if (!IsSpace(val[i].org_id) && val.isType === "dept") {
				returnValId += val[i].org_id + ",";
				returnValName += val[i].name + ",";
				returnCode += val[i].item_code + ",";
				if (null != val[i].getParentNode()) {
					returnparentNode += val[i].getParentNode().name + ",";
				}
			}
		}
		if (returnValId.length > 0)
			returnValId = returnValId.substring(0, returnValId.length - 1);
		if (returnValName.length > 0)
			returnValName = returnValName
					.substring(0, returnValName.length - 1);
		if (returnCode.length > 0)
			returnCode = returnCode.substring(0, returnCode.length - 1);
		if (returnparentNode.length > 0)
			returnparentNode = returnparentNode.substring(0,
					returnparentNode.length - 1);

		userObj.name = returnValName;
		userObj.id = returnValId;
		userObj.user_name = returnCode;
		userObj.returnparentNode = returnparentNode;
		userObj.returnValDeptAndUserName = returnValDeptAndUserName;
		returnjson[val.valueKey] = userObj;
	});
	returnFunction(returnjson, nodes);
}
