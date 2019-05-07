/** 
* @class Ext.tree.TreeCheckNodeUI 
* @extends Ext.tree.TreeNodeUI 
* 
* 寄1�7 Ext.tree.TreeNodeUI 进行checkbox功能的扩屄1�7,后台返回的结点信息不用非要包含checked属�1�7�1�7 
* 
* 扩展的功能点有： 
* 丄1�7、支持只对树的叶子进行�1�7�择 
* 只有当返回的树结点属性leaf = true 时，结点才有checkbox可�1�7�1�7 
* 使用时，只需在声明树时，加上属�1�7�1�7 onlyLeafCheckable: true 既可，默认是false 
* 
* 二�1�7�支持对树的单�1�7�1�7 
* 只允许�1�7�择丄1�7个结炄1�7 
* 使用时，只需在声明树时，加上属�1�7�1�7 checkModel: "single" 既可 
* 
* 二�1�7�支持对树的级联多�1�7�1�7 
* 当�1�7�择结点时，自动选择该结点下的所有子结点，以及该结点的所有父结点（根结点除外），特别是支持异步，当子结点还没显示时，会从后台取得子结点，然后将其选中/取消选中 
* 使用时，只需在声明树时，加上属�1�7�1�7 checkModel: "cascade" 既可 
* 
* 三�1�7�添劄1�7"check"事件 
* 该事件会在树结点的checkbox发生改变时触叄1�7 
* 使用时，只需给树注册事件,如： 
* tree.on("check",function(node,checked){...}); 
* 
* 默认情况下，checkModel丄1�7'multiple'，也就是多�1�7�，onlyLeafCheckable为false，所有结点都可�1�7�1�7 
* 
* 使用方法：在loader里加丄1�7 baseAttrs:{uiProvider:Ext.tree.TreeCheckNodeUI} 既可. 
* 例如＄1�7 
* var tree = new Ext.tree.TreePanel({ 
* el:'tree-ct', 
* width:568, 
* height:300, 
* checkModel: 'cascade', //对树的级联多逄1�7 
* onlyLeafCheckable: false,//对树扄1�7有结点都可�1�7�1�7 
* animate: false, 
* rootVisible: false, 
* autoScroll:true, 
* loader: new Ext.tree.DWRTreeLoader({ 
* dwrCall:Tmplt.getTmpltTree, 
* baseAttrs: { uiProvider: Ext.tree.TreeCheckNodeUI } //添加 uiProvider 属�1�7�1�7 
* }), 
* root: new Ext.tree.AsyncTreeNode({ id:'0' }) 
* }); 
* tree.on("check",function(node,checked){alert(node.text+" = "+checked)}); //注册"check"事件 
* tree.render(); 
* modify auther minghua.guo 2009.3
*/ 

Ext.tree.TreeCheckNodeUI = function() {
	// 'multiple':多�1�7�1�7, 默认倄1�7
	// 'single':单�1�7�1�7,
	// 'cascade':级联多�1�7�1�7
	// 'parentCascade':级联多�1�7�父节点
	// 'childCascade':级联多�1�7�子节点
	this.checkModel = 'multiple'; 

	//only leaf can checked 
	this.onlyLeafCheckable = false; 
	//如果是checkbox，双击时是否触发check事件   
    this.checkedOnDblClick = false;   
	
	Ext.tree.TreeCheckNodeUI.superclass.constructor.apply(this, arguments); 
};

Ext.extend(Ext.tree.TreeCheckNodeUI, Ext.tree.TreeNodeUI, {
	renderElements : function(n, a, targetNode, bulkRender){
		var tree = n.getOwnerTree(); 
		this.checkModel = tree.checkModel || this.checkModel; 
		this.onlyLeafCheckable = tree.onlyLeafCheckable || false; 
		
		//add by minghua.guo [2010-12-09] add radio
		var checkboxOrRadio = "checkbox";
		if(this.checkModel=="single"){
			checkboxOrRadio = "radio";
		}
		// add some indent caching, this helps performance when rendering a large tree 
		this.indentMarkup = n.parentNode ? n.parentNode.ui.getChildIndent() : ''; 
		
		var cb = (!this.onlyLeafCheckable || a.leaf); 
		var href = a.href ? a.href : Ext.isGecko ? "" : "#"; 
		var buf = ['<li class="x-tree-node"><div ext:tree-node-id="',n.id,'" class="x-tree-node-el x-tree-node-leaf x-unselectable ', a.cls,'" unselectable="on">', 
		'<span class="x-tree-node-indent">',this.indentMarkup,"</span>", 
		'<img src="', this.emptyIcon, '" class="x-tree-ec-icon x-tree-elbow" />', 
		'<img src="', a.icon || this.emptyIcon, '" class="x-tree-node-icon',(a.icon ? " x-tree-node-inline-icon" : ""),(a.iconCls ? " "+a.iconCls : ""),'" unselectable="on" />', 
		cb ? ('<input class="x-tree-node-cb" type="'+checkboxOrRadio+'" ' + (a.checked ? 'checked="checked" />' : '/>')) : '', 
		'<a hidefocus="on" class="x-tree-node-anchor" href="',href,'" tabIndex="1" ', 
		a.hrefTarget ? ' target="'+a.hrefTarget+'"' : "", '><span unselectable="on">',n.text,"</span></a></div>", 
		'<ul class="x-tree-node-ct" style="display:none;"></ul>', 
		"</li>"].join(''); 
		
		var nel; 
		if(bulkRender !== true && n.nextSibling && (nel = n.nextSibling.ui.getEl())){ 
			this.wrap = Ext.DomHelper.insertHtml("beforeBegin", nel, buf); 
		}else{ 
			this.wrap = Ext.DomHelper.insertHtml("beforeEnd", targetNode, buf); 
		} 
		
		this.elNode = this.wrap.childNodes[0]; 
		this.ctNode = this.wrap.childNodes[1]; 
		var cs = this.elNode.childNodes; 
		this.indentNode = cs[0]; 
		this.ecNode = cs[1]; 
		this.iconNode = cs[2]; 
		var index = 3; 
		if(cb){ 
			this.checkbox = cs[3]; 
			Ext.fly(this.checkbox).on('click', this.check.createDelegate(this,[null])); 
			index++; 
		}
		this.anchor = cs[index]; 
		this.textNode = cs[index].firstChild; 
	}, 

	// private 
	check : function(checked){
		var n = this.node; 
		var tree = n.getOwnerTree(); 
		this.checkModel = tree.checkModel || this.checkModel; 
		
		if( checked === null ) { 
			checked = this.checkbox.checked; 
		} else { 
			this.checkbox.checked = checked; 
		} 
		
		n.attributes.checked = checked; 
		tree.fireEvent('check', n, checked); 
		
		if(!this.onlyLeafCheckable && this.checkModel == 'cascade'){ 
			var parentNode = n.parentNode; 
			if(parentNode !== null) { // 改变父节点�1�7�中状�1�7�1�7
				this.parentCheck(parentNode,checked); 
			} 
			if( !n.expanded && !n.childrenRendered ) { 
			   
				n.expand(false,false,this.childCheck); 

				
				
			} else { 
				this.childCheck(n); 
			}
		}else if(!this.onlyLeafCheckable && this.checkModel == 'parentCascade'){ //2009.3.27劄1�7
			var parentNode = n.parentNode; 
			if(parentNode !== null) { // 改变父节点�1�7�中状�1�7�1�7
				this.parentCheck(parentNode,checked); 
			}
		}else if(!this.onlyLeafCheckable && this.checkModel == 'childCascade'){ //2009.3.27劄1�7
			if( !n.expanded && !n.childrenRendered ) { 
				n.expand(false,false,this.childCheck); 
			} else { 
				this.childCheck(n); 
			}
		}else if(this.checkModel == 'single'){ 
			var checkedNodes = tree.getChecked(); 
			for(var i=0;i<checkedNodes.length;i++){ 
				var node = checkedNodes[i]; 
				if(node.id != n.id){ 
					node.getUI().checkbox.checked = false; 
					node.attributes.checked = false; 
					tree.fireEvent('check', node, false); 
				}
			}
		}
	}, 
	
	// private 
	childCheck : function(node){ 
		var a = node.attributes; 
		if(!a.leaf) { 
			var cs = node.childNodes; 
			var csui; 
			for(var i = 0; i < cs.length; i++) { 
				csui = cs[i].getUI(); 
				if(csui.checkbox.checked ^ a.checked) 
				csui.check(a.checked); 
			} 
		} 
	}, 
	
	// private 
	parentCheck : function(node ,checked){ 
		var checkbox = node.getUI().checkbox; 
		if(typeof checkbox == 'undefined')return ; 
		if(!(checked ^ checkbox.checked))return; 
		if(!checked && this.childHasChecked(node))return; 
		checkbox.checked = checked; 
		node.attributes.checked = checked; 
		node.getOwnerTree().fireEvent('check', node, checked); 
		
		var parentNode = node.parentNode; 
		if( parentNode !== null){ 
			this.parentCheck(parentNode,checked); 
		} 
	}, 
	
	// private 
	childHasChecked : function(node){ 
		var childNodes = node.childNodes; 
		if(childNodes || childNodes.length>0){ 
			for(var i=0;i<childNodes.length;i++){ 
				if(childNodes[i].getUI().checkbox.checked) 
				return true;
			} 
		} 
		return false; 
	}, 
	//重写
	toggleCheck : function(value){
		var cb = this.checkbox; 
		if(cb){ 
			var checked = (value === undefined ? !cb.checked : value); 
			if(this.checkedOnDblClick)//双击是否选中?
				this.check(checked); 
		} 
	},
	//重写
	onCheckChange : function(e){
		if(e.getTarget('input[type=checkbox]', 1)){//checkbox check
	        var checked = this.checkbox.checked;
			
			this.checkbox.defaultChecked = checked;
	        this.node.attributes.checked = checked;
	        this.fireEvent('checkchange', this.node, checked);
        }else if(e.getTarget('input[type=radio]', 1)){//radio check
			var value;
			var cb = this.checkbox; 
			if(cb){ 
				var checked = (value === undefined ? !cb.checked : value); 
					this.check(checked); 
			} 
        }
    }
}); 
