package com.chinacreator.xtbg.core.dssave.dao.impl;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import com.chinacreator.eform.util.Escape;
import com.chinacreator.xtbg.core.archive.entity.FlowDocmentFileBean;
import com.chinacreator.xtbg.core.archive.tag.ColumnDisplayBean;
import com.chinacreator.xtbg.core.common.commonlist.Constant;
import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.core.common.util.DataControlUtil;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.dssave.dao.DsCRUDDao;
import com.chinacreator.xtbg.core.dssave.entity.MdColumnBean;
import com.chinacreator.xtbg.core.dssave.entity.MdTableBean;
import com.chinacreator.xtbg.core.dssave.entity.ViewListBean;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 * 
 *<p>Title:OperArchiveDaoImpl.java</p>
 *<p>Description:通用保存核心实现类。</p>
 *<p>Copyright:Copyright (c) 2010</p>
 *<p>Company:湖南科创</p>
 *@author shuqi.liu
 *@version 1.0
 *2013-4-7
 */
public class DsCRUDDaoImpl extends XtDbBaseDao implements DsCRUDDao {
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     save(保存方法)
	  * @param datalist
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.dssave.dao.DsCRUDDao#save(java.util.List, java.sql.Connection)
	 */
	@Override
	public boolean save(List<Map<String,List<Map<String, String>>>> datalist, Map<String, String> datemap, Connection conn) throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();
		int i = 0;
		for(Map<String,List<Map<String, String>>> tableMap : datalist){//信息块循环
			Set<String> tableSet = tableMap.keySet();
			for(String tableName : tableSet){//信息块中表循环
				List<Map<String, String>> columnList = tableMap.get(tableName);
				for(Map<String, String> columnMap : columnList){//表中的数据循环
					String insertSql = creatInsertSql(columnMap,tableName,datemap);
					//System.out.println(insertSql);
					pdb.preparedInsert(insertSql.toString());
					pdb.addPreparedBatch();
					i++;//为了防止没有记录保存报错
				}
			}
		}
		//批处理执行
		if(i > 0){
			pdb.executePreparedBatch(conn);
		}
		return true;
	}
	
	/**
	 * 
	*<b>Summary: </b>
	* creatInsertSql(拼装插入SQL)
	* @param cmap
	* @param tableName
	* @return
	 */
	private String creatInsertSql(Map<String, String> columnMap , String tableName, Map<String, String> datemap){
		StringBuffer insertSql = new StringBuffer();
		insertSql.append("insert into ").append(tableName).append("(");
		StringBuffer columnNameSb = new StringBuffer();//字段
		StringBuffer columnValueSb = new StringBuffer();//字段值
		Set<String> columnSet = columnMap.keySet();
		for(String key : columnSet){
			columnNameSb.append(key).append(",");
			if(!StringUtil.isBlank(datemap.get(tableName+key))){//这里对数据元里定义为日期型的字段进行日期转义
				if(columnMap.get(key).length()>datemap.get(tableName+key).length()){
					String keyValue=columnMap.get(key).substring(0,datemap.get(tableName+key).length());
					columnValueSb.append("to_date('").append(keyValue).append("','")
					.append(datemap.get(tableName+key).replace("hh", "hh24").replace("HH", "HH24").replace("mm", "mi")).append("'),");	
				}else{
					columnValueSb.append("to_date('").append(columnMap.get(key)).append("','")
					.append(datemap.get(tableName+key).replace("hh", "hh24").replace("HH", "HH24").replace("mm", "mi")).append("'),");
				}
			}else{
			       columnValueSb.append("'").append(columnMap.get(key)).append("',");
			}
		}
		
		insertSql.append(columnNameSb.substring(0, columnNameSb.length()-1)).append(") values (")
				.append(columnValueSb.substring(0, columnValueSb.length()-1)).append(")");
		
		return insertSql.toString();
	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  *  update(更新方法)
	  * @param datalist
	  * @param conn
	  * @param businessType
	  * 
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.dssave.dao.DsCRUDDao#update(java.util.List, java.sql.Connection, java.lang.String)
	 */
	@Override
	public boolean update(List<Map<String,List<Map<String, String>>>> datalist,Connection conn,String businessType,Map<String,String> datemap) throws Exception {
		//String businessType = "测试1";
		List<MdTableBean> tablelist = getMdTableInfo(businessType);
		Map<String,MdTableBean> tmap = new HashMap<String,MdTableBean>();
		for(MdTableBean archiveMdTableBean:tablelist){//将定义的数据放入MAP中
			tmap.put(archiveMdTableBean.getTable_code(), archiveMdTableBean);
			List<MdTableBean> sonarchiveMdTableBeanList = archiveMdTableBean.getSonlist();
			if(sonarchiveMdTableBeanList.size()>0){
				for(MdTableBean sonarchiveMdTableBean:sonarchiveMdTableBeanList){
					tmap.put(sonarchiveMdTableBean.getTable_code(), sonarchiveMdTableBean);	
				}
			}
		}
		
		PreparedDBUtil pdb = new PreparedDBUtil();
		int i = 0;
		for(Map<String,List<Map<String, String>>> tableMap : datalist){//信息块循环
			Set<String> tableSet = tableMap.keySet();
			for(String tableName : tableSet){//信息块中表循环
				List<Map<String, String>> columnList = tableMap.get(tableName);
				//获取表的类型，主表，或者子表；
				MdTableBean archiveMdTableBean =  tmap.get(tableName);
				if(columnList!=null && columnList.size()>0){
					if(!StringUtil.isBlank(archiveMdTableBean.getParent_table_id())){//如果不为空，代表是子表,
						//因为子表可能增减记录，所有采取先删，再添加的方式
						String parent_id = archiveMdTableBean.getParent_table_id();
						String fkey = "";//找到子表的外键
						for(MdTableBean archiveMdBean:tablelist){
							if(archiveMdBean.getTable_id().equals(parent_id)){
								fkey = archiveMdBean.getTable_pk(); 
								break;
							}
						}
						StringBuffer delstr = new StringBuffer();
						delstr.append("delete from ").append(tableName).append(" where ").append(fkey).append("='").append(columnList.get(0).get(fkey)).append("'");
						//System.out.println(delstr);
						pdb.preparedDelete(delstr.toString());
						pdb.addPreparedBatch();
						
						for(Map<String, String> columnMap : columnList){//表中的数据循环
							String insertSql = creatInsertSql(columnMap,tableName,datemap);
							//System.out.println(insertSql);
							pdb.preparedInsert(insertSql.toString());
							pdb.addPreparedBatch();
							i++;//为了防止没有记录保存报错
						}
					}else{
						for(Map<String, String> columnMap : columnList){//表中的数据循环
							String updateSql = creatUpdateSql(columnMap,tableName,tmap.get(tableName).getTable_pk(),datemap);
							//System.out.println(updateSql);
							pdb.preparedUpdate(updateSql.toString());
							pdb.addPreparedBatch();
							i++;//为了防止没有记录保存报错
						}
					}
				
				}
			}
		}
		//批处理执行
		if(i > 0){
			pdb.executePreparedBatch(conn);
		}
		return true;
	}
	
	/**
	 * 
	*<b>Summary: </b>
	* creatUpdateSql(拼装更新SQL)
	* @param columnMap
	* @param tableName
	* @return
	 */
	private String creatUpdateSql(Map<String, String> columnMap , String tableName,String pkName, Map<String, String> datemap){
		StringBuffer updateSql = new StringBuffer();
		updateSql.append("update ").append(tableName).append(" set ");
		Set<String> columnSet = columnMap.keySet();
		for(String key : columnSet){
			updateSql.append(key).append(" = ");
			if(!StringUtil.isBlank(datemap.get(tableName+key))){//这里对数据元里定义为日期型的字段进行日期转义
				if(columnMap.get(key).length()>datemap.get(tableName+key).length()){
					String keyValue=columnMap.get(key).substring(0,datemap.get(tableName+key).length());
					updateSql.append("to_date('").append(keyValue).append("','")
					.append(datemap.get(tableName+key).replace("hh", "hh24").replace("HH", "HH24").replace("mm", "mi")).append("'),");	
				}else{
					updateSql.append("to_date('").append(columnMap.get(key)).append("','")
					.append(datemap.get(tableName+key).replace("hh", "hh24").replace("HH", "HH24").replace("mm", "mi")).append("'),");
				}
			}else{
				updateSql.append("'").append(columnMap.get(key)).append("',");
			}
		}
		updateSql.deleteCharAt(updateSql.length()-1);
		updateSql.append(" where ").append(pkName).append(" = '").append(columnMap.get(pkName)).append("'");
		return updateSql.toString();
	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     根据request 获取业务封装数据
	  * @param request
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.dssave.dao.DsCRUDDao#getDateList(javax.servlet.http.HttpServletRequest)
	 */
	@Override
	public List<Map<String, List<Map<String, String>>>> getDateList(HttpServletRequest request) throws Exception {
		String businessType = request.getParameter("busiTypeCode");
		String busi_id = request.getParameter("busi_id");
		//String action_id = (String) request.getAttribute("action_id");//环节ID
		List<Map<String,List<Map<String, String>>>>  dataList = new ArrayList<Map<String,List<Map<String,String>>>>();
		//根据业务ID查询出oa_md_table 中定义的逻辑表。
		List<MdTableBean> tablelist = getMdTableInfo(businessType);
		for(MdTableBean tableBean:tablelist){//循环遍历配置表
			Map<String, List<Map<String, String>>> tmap = new HashMap<String, List<Map<String, String>>>();
			String table_name = tableBean.getTable_code();//表名
			String table_key_name = tableBean.getTable_pk();//主键名
			String keyId = busi_id;//从requst获取主键ID，如果为空，则NEW一个UUID
			if(StringUtil.isBlank(keyId)){
				throw new Exception("获取业务ID的时候出现异常！");
			}
			//String keyId = request.getParameter(table_name+Constant.SEPARATOR+table_key_name);//从requst获取主键ID，如果为空，则NEW一个UUID
			//if(StringUtil.isBlank(keyId)){
			//	keyId = StringUtil.getUUID();
			//}
			//遍历主表字段
			List<MdColumnBean> clist = tableBean.getMdList();
			List<Map<String, String>> dlist = new ArrayList<Map<String, String>>();
			Map<String, String> cMap = new HashMap<String, String>();
			cMap.put(table_key_name, keyId);
			//Map<String,ColumnDisplayBean> stautsmap = this.getActColStauts(action_id,tableBean.getTable_id());
			for(MdColumnBean cbean:clist){//在这里拼装
				if(!table_key_name.equalsIgnoreCase(cbean.getColumn_code()) && !Constant.IS_VIEW.equals(cbean.getIsview())){//主键不重复PUT && 意见字段不封装。
					//ColumnDisplayBean sbean = stautsmap.get(cbean.getColumn_code());
					//if(sbean!=null && !sbean.isHide()&&!sbean.isDisable()&& !sbean.isReadonly()){//此处将页面上的 隐藏，不可用，只读的数据过滤掉
						String value =  request.getParameter(table_name+Constant.SEPARATOR+cbean.getColumn_code());						
						if(null != value){//如果取值不为NULL则不取该字段,考虑到更新如果为空值的话要取。
							  //解码
							value =DataControlUtil.replaceStr(value);
							value = Escape.unescape(value);
							cMap.put(cbean.getColumn_code(),value);
						}
				//	}
				}
			}
			dlist.add(cMap);
			tmap.put(table_name, dlist);
			//遍历子表
			List<MdTableBean> tlist = tableBean.getSonlist();
			for(MdTableBean tbean:tlist){//在这里拼装
				 List<Map<String, String>> sondataInfoList = new ArrayList<Map<String,String>>();
				
				 String son_table_name = tbean.getTable_code();
				 String son_table_key_name = tbean.getTable_pk();
				 //Map<String,ColumnDisplayBean> sonstautsmap = this.getActColStauts(action_id,tbean.getTable_id());
				//遍历主表字段
				 List<MdColumnBean> sonMdList = tbean.getMdList();
				 String[] strs = null  ;
				 int sonMaxLength = 0;
				 for(int i=0;i<sonMdList.size();i++){//在这里遍历所有字段，取到非主键，或者外键的字段获取行数
					 MdColumnBean archiveBean = sonMdList.get(i);
					 if(!archiveBean.getColumn_code().equalsIgnoreCase(son_table_key_name) && !archiveBean.getColumn_code().equalsIgnoreCase(table_key_name)){
						 strs = request.getParameterValues(son_table_name+Constant.SEPARATOR+archiveBean.getColumn_code());//获取子表的行数 
						 //TODO 如果子表不是成对出现，这里会出现无法正确匹配的问题。
						 if(strs !=null && strs.length > sonMaxLength){
							 sonMaxLength = strs.length;
						 }
					 }
				 }
			 if(sonMaxLength > 0 ){
				 for(int i=0; i<sonMaxLength; i++){
					 Map<String, String> sMap = new HashMap<String, String>();
					 String sonKeyId = "";//request.getParameter(son_table_name+"_"+son_table_key_name);//从requst获取主键ID，如果为空，则NEW一个UUID
				     if(StringUtil.isBlank(sonKeyId)){ //考虑在子表有增减，每次获取数据的时候为子表NEW一个新的UUID。
				    	 sonKeyId = StringUtil.getUUID();
					 }
					 sMap.put(son_table_key_name, sonKeyId);//子表KEY
					 sMap.put(table_key_name, keyId);//主表外键
					 
					 for(MdColumnBean archiveMdColumnBean:sonMdList){
						 if(!archiveMdColumnBean.getColumn_code().equalsIgnoreCase(son_table_key_name) && !archiveMdColumnBean.getColumn_code().equalsIgnoreCase(table_key_name)  && !archiveMdColumnBean.getIsview().equals("1")){//主键外键，不重复PUT&& 意见字段不封装。
							 //ColumnDisplayBean sbean = sonstautsmap.get(archiveMdColumnBean.getColumn_code());
							 //if(sbean!=null && !sbean.isHide()&&!sbean.isDisable()&& !sbean.isReadonly()){//此处将页面上的 隐藏，不可用，只读的数据过滤掉
							 		 //modify by shuqi.liu 2013-08-14 如果子表页面没有该字段，那么不做处理
							 		 String[] sonValues = request.getParameterValues(son_table_name+Constant.SEPARATOR+archiveMdColumnBean.getColumn_code());
							 		 if(null!=sonValues){
							 			 String sonValue = sonValues[i];
							 			 if(null!=sonValue){
							 				sonValue =DataControlUtil.replaceStr(sonValue);
							 				sonValue = Escape.unescape(sonValue);
											 sMap.put(archiveMdColumnBean.getColumn_code(), sonValue);
										 }
							 		 }
									
									
							// }
						 }
					 }
					 //这里加入一行子表
					 sondataInfoList.add(sMap);
				 }
			 }
				 tmap.put(son_table_name, sondataInfoList);
			}
			dataList.add(tmap);
		}
		return dataList;
	}
	
	/**
	 * 
	*<b>Summary: </b>
	* getMdTableInfo(获取业务类型的配置信息)
	* @param businessType
	* @return
	 */
	public List<MdTableBean> getMdTableInfo(String businessType) throws Exception{
		StringBuffer sql = new StringBuffer();
		sql.append("select t.table_id,t.table_code,t.table_name,t.table_pk,t.parent_table_id, v.busitype_code,t.table_sn from oa_md_table t ");
		sql.append("left join v_oa_bcode_table_map v on v.table_id = t.table_id");
		sql.append(" where v.busitype_code = ? and t.parent_table_id is null order by t.table_sn ");
		List<MdTableBean> list = new ArrayList<MdTableBean>();
		PreparedDBUtil db = new PreparedDBUtil();
		db.preparedSelect(sql.toString());
		db.setString(1, businessType);
		db.executePrepared();
		if(db.size()<1){
			throw new Exception("根据业务类型查询数据元表名时未找到相关记录！");
		}
		for(int i=0;i<db.size();i++){
			MdTableBean bean = new MdTableBean();
			String table_id = db.getString(i, "table_id");
			bean.setTable_id(table_id);
			bean.setTable_code(db.getString(i, "table_code"));
			bean.setTable_name(db.getString(i, "table_name"));
			bean.setTable_pk(db.getString(i, "table_pk"));
			bean.setParent_table_id(db.getString(i, "parent_table_id"));
			bean.setBusiness_type(db.getString(i, "business_id"));
			bean.setTable_sn(db.getString(i, "table_sn"));
			
			bean.setSonlist(querySonTable(table_id));//子表
			bean.setMdList(queryMdColumn(table_id));//字段信息
			list.add(bean);
		}
		return list;
	}
	
	/**
	 * 
	*<b>Summary: </b>
	* queryMdColumn(根据table_id查询字段信息)
	* @param table_id
	* @return
	* @throws Exception
	 */
	private List<MdColumnBean> queryMdColumn(String table_id)  throws Exception{
		StringBuffer sql = new StringBuffer();
		sql.append("select t.column_id,t.table_id,t.column_code,t.column_name,t.column_sn, t.isview  from oa_md_columns t where t.table_id = ? order by t.column_sn ");
		List<MdColumnBean> list = new ArrayList<MdColumnBean>();
		PreparedDBUtil db = new PreparedDBUtil();
		db.preparedSelect(sql.toString());
		db.setString(1, table_id);
		db.executePrepared();
		if(db.size()<1){
			throw new Exception("根据表ID查询数据元字段时未找到相关记录！");
		}
		for(int i=0;i<db.size();i++){
			MdColumnBean bean = new MdColumnBean();
			bean.setColumn_id(db.getString(i, "column_id"));
			bean.setTable_id(db.getString(i, "son_table_id"));
			bean.setColumn_code(db.getString(i, "column_code"));
			bean.setColumn_name(db.getString(i, "column_name"));
			bean.setColumn_sn(db.getString(i, "column_sn"));
			bean.setIsview(db.getString(i, "isview"));
			list.add(bean);
		}
		return list;
	}
	/**
	 * 
	*<b>Summary: </b>
	* querySonTable(获取子表信息)
	* @param table_id
	* @return
	 */
	private List<MdTableBean> querySonTable(String table_id)  throws Exception{
		StringBuffer sql = new StringBuffer();
		sql.append("select t.table_id,t.table_code,t.table_name,t.table_pk,t.parent_table_id, t.table_sn from oa_md_table t ");
		sql.append("where t.parent_table_id = ? order by t.table_sn");
		List<MdTableBean> list = new ArrayList<MdTableBean>();
		PreparedDBUtil db = new PreparedDBUtil();
		db.preparedSelect(sql.toString());
		db.setString(1, table_id);
		db.executePrepared();
		for(int i=0;i<db.size();i++){
			MdTableBean bean = new MdTableBean();
			String son_table_id = db.getString(i, "table_id");
			bean.setTable_id(table_id);
			bean.setTable_code(db.getString(i, "table_code"));
			bean.setTable_name(db.getString(i, "table_name"));
			bean.setTable_pk(db.getString(i, "table_pk"));
			bean.setParent_table_id(db.getString(i, "parent_table_id"));
			//bean.setBusiness_type(db.getString(i, "business_type"));
			bean.setTable_sn(db.getString(i, "table_sn"));
			
			//bean.setSonlist(querySonTable(son_table_id));//子表
			bean.setMdList(queryMdColumn(son_table_id));//主表
			list.add(bean);
		}
		return list;
	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  *    根据表名，主键名，主键值查询出业务数据
	  * @param archiveMdTableBean
	  * @param tablePk
	  * @param businessid
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.dssave.dao.DsCRUDDao#getBusinessDada(com.chinacreator.xtbg.core.archive.entity.MdTableBean, java.lang.String, java.lang.String)
	 */
	@Override
	public List<Map<String, String>> getBusinessDada(MdTableBean archiveMdTableBean,String tablePk, String businessid) throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append("select ");
		for(MdColumnBean cbean:archiveMdTableBean.getMdList()){
			sql.append(cbean.getColumn_code()).append(", ");
		}
		sql.delete( sql.length()-2,sql.length());
		sql.append(" from ").append(archiveMdTableBean.getTable_code()).append("  where ").append(tablePk).append("= ? ");
		List<Map<String, String>> list = new ArrayList<Map<String, String>>();
		PreparedDBUtil db = new PreparedDBUtil();
		db.preparedSelect(sql.toString());
		db.setString(1, businessid);
		db.executePrepared();
		for(int i=0;i<db.size();i++){
			Map<String, String> dataMap = new HashMap<String, String>();
			for(MdColumnBean cbean:archiveMdTableBean.getMdList()){
				//TODO 这里需要加入日期处理，如果是日期类型，进行TO_CHAR后再查询，否则无法根据getString 去取值。
				dataMap.put(cbean.getColumn_code(), db.getString(i, cbean.getColumn_code()));
			}
			list.add(dataMap);
		}
		return list;
	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  *   (获取页面控制配置信息 流程活动表单元素状态表(环节字段状态表))
	  * @param nodeid
	  * @param tableId
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.dssave.dao.DsCRUDDao#getActColStauts(java.lang.String, java.lang.String)
	 */
	@Override
	public Map<String, ColumnDisplayBean> getActColStauts(String action_id, String tableId) throws Exception {
		Map<String, ColumnDisplayBean> map = new HashMap<String, ColumnDisplayBean>();
		StringBuffer sql = new StringBuffer();
		sql.append("select id, action_id, table_id, table_code, column_id, column_code, readonly, hidden, disable, required from oa_act_col_stauts where action_id =? and table_id = ?");
		PreparedDBUtil db = new PreparedDBUtil();
		db.preparedSelect(sql.toString());
		db.setString(1, action_id);
		db.setString(2, tableId);
		db.executePrepared();
		/*if(db.size()<1){
			throw new Exception("根据环节ID，表ID获取oa_act_col_stauts表配置信息时出错");
		}*/
		for(int i=0;i<db.size();i++){
			ColumnDisplayBean bean = new ColumnDisplayBean();
			bean.setHide(db.getString(i, "hidden").equals("1"));
			bean.setReadonly(db.getString(i, "readonly").equals("1"));
			bean.setDisable(db.getString(i, "disable").equals("1"));
			bean.setRequired(db.getString(i, "required").equals("1"));
			map.put(db.getString(i,"column_code"), bean);
		}
		return map;
	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getView
	  * @param insID
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.dssave.dao.DsCRUDDao#getView(java.lang.String)
	 */
	@Override
	public List<ViewListBean> getView(String insID) throws Exception {
		List<ViewListBean> list = new ArrayList<ViewListBean>();
		StringBuffer sql = new StringBuffer();
		sql.append("select viewlist_id, ins_id, action_id, action_name, action_handeridea, hander_time, is_valid, remark1, remark2,org_id,org_name,user_id,user_name,table_name,column_name from oa_flow_insviewlist where ins_id = ? order by hander_time desc");
		PreparedDBUtil db = new PreparedDBUtil();
		db.preparedSelect(sql.toString());
		db.setString(1, insID);
		db.executePrepared();
		for(int i=0;i<db.size();i++){
			ViewListBean bean = new ViewListBean();
			bean.setViewlist_id(db.getString(i,"viewlist_id"));
			bean.setIns_id(db.getString(i,"ins_id"));
			bean.setAction_id(db.getString(i,"action_id"));
			bean.setAction_name(db.getString(i,"action_name"));
			bean.setAction_handeridea(db.getString(i,"action_handeridea"));
			bean.setHander_time(db.getString(i,"hander_time"));
			bean.setIs_valid(db.getString(i,"is_valid"));
			bean.setRemark1(db.getString(i,"remark1"));
			bean.setRemark2(db.getString(i,"remark2"));
			bean.setOrg_id(db.getString(i,"org_id"));
			bean.setOrg_name(db.getString(i,"org_name"));
			bean.setUser_id(db.getString(i,"user_id"));
			bean.setUser_name(db.getString(i,"user_name"));
			bean.setTable_name(db.getString(i,"table_name"));
			bean.setColumn_name(db.getString(i,"column_name"));
			list.add(bean);
		}
		return list;
	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getTextContorlInfo
	  * @param action_id
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.dssave.dao.DsCRUDDao#getTextContorlInfo(java.lang.String, java.sql.Connection)
	 */
	@Override
	public Map<String, String> getTextContorlInfo(String action_id, Connection conn) throws Exception {
		Map<String,String> map = new HashMap<String,String>();
		StringBuffer sql = new StringBuffer();
		sql.append("select t.id, t.action_id, t.is_trace, t.is_red, t.is_readonly, t.extend_attribute,t.extend_methods,t.msg_txt,t.is_msg,t.is_sign,t.is_keeptrace,t.is_attachment,t.is_serialnumber, ");
		sql.append(" t.is_gwzl, t.is_ckcg, t.is_ckzw, t.is_ckmq, t.is_singname, t.is_affix, t.remark1, is_xd, is_gwff, is_cd, is_cklc, is_newflow, is_gk ,is_print,is_split,is_infotype,is_nbfs,is_doback,is_chief,is_ckls,is_sm ");
		sql.append(" from oa_act_text_stauts t where t.action_id = ?");
		PreparedDBUtil db = new PreparedDBUtil();
		db.preparedSelect(sql.toString());
		db.setString(1, action_id);
		db.executePrepared();
		if(db.size() > 0){
			map.put("is_trace", db.getString(0,"is_trace"));
			map.put("is_red", db.getString(0,"is_red"));
			map.put("is_readonly", db.getString(0,"is_readonly"));
			map.put("extend_attribute", db.getString(0,"extend_attribute"));
			map.put("extend_methods", db.getString(0,"extend_methods"));
			map.put("msg_txt", db.getString(0,"msg_txt"));
			map.put("is_msg", db.getString(0,"is_msg"));
			map.put("is_sign", db.getString(0,"is_sign"));
			map.put("is_keeptrace", db.getString(0,"is_keeptrace"));
			map.put("is_attachment", db.getString(0,"is_attachment"));
			map.put("is_serialnumber", db.getString(0,"is_serialnumber"));
			map.put("is_gwzl", db.getString(0,"is_gwzl"));
			map.put("is_ckcg", db.getString(0,"is_ckcg"));
			map.put("is_ckzw", db.getString(0,"is_ckzw"));
			map.put("is_ckmq", db.getString(0,"is_ckmq"));
			map.put("is_singname", db.getString(0,"is_singname"));
			map.put("is_affix", db.getString(0,"is_affix"));
			map.put("remark1", db.getString(0,"remark1"));
			map.put("is_xd", db.getString(0,"is_xd"));
			map.put("is_gwff", db.getString(0,"is_gwff"));
			map.put("is_cd", db.getString(0,"is_cd"));
			map.put("is_cklc", db.getString(0,"is_cklc"));
			map.put("is_newflow", db.getString(0,"is_newflow"));
			map.put("is_gk", db.getString(0,"is_gk"));
			map.put("is_print", db.getString(0,"is_print"));
			map.put("is_split", db.getString(0,"is_split"));
			map.put("is_infotype", db.getString(0,"is_infotype"));
			map.put("is_nbfs", db.getString(0,"is_nbfs"));
			map.put("is_doback", db.getString(0,"is_doback"));
			map.put("is_chief", db.getString(0,"is_chief"));
			map.put("is_ckls", db.getString(0,"is_ckls"));
			map.put("is_sm", db.getString(0,"is_sm"));
		}/*else{
			throw new Exception("根据环节ID查询正文配置信息时没有查到相关记录，请正确配置环节正文配置关系！");
		}*/
		return map;
	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getDefaultActColStauts
	  * @param tableId
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.dssave.dao.DsCRUDDao#getDefaultActColStauts(java.lang.String, java.sql.Connection)
	 */
	@Override
	public Map<String, ColumnDisplayBean> getDefaultActColStauts(String tableId, Connection conn) throws Exception {
		Map<String, ColumnDisplayBean> map = new HashMap<String, ColumnDisplayBean>();
		StringBuffer sql = new StringBuffer();
		sql.append("select t.table_id,t.column_code,t.column_name from oa_md_columns t  where t.table_id = ?");
		PreparedDBUtil db = new PreparedDBUtil();
		db.preparedSelect(sql.toString());
		db.setString(1, tableId);
		db.executePrepared();
		/*if(db.size()<1){
			throw new Exception("根据环节ID，表ID获取oa_act_col_stauts表配置信息时出错");
		}*/
		for(int i=0;i<db.size();i++){
			ColumnDisplayBean bean = new ColumnDisplayBean();
			//bean.setReadonly(true);
			map.put(db.getString(i,"column_code"), bean);
		}
		return map;
	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 del
	  * @param conn
	  * @param businessType
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.dssave.dao.DsCRUDDao#del(java.sql.Connection, java.lang.String)
	 */
	@Override
	public boolean del(Connection conn, String businessType,String busi_id) throws Exception {// 获取表结构关系
		boolean flag = true;
		StringBuffer sql = null;
		int i=0;
		PreparedDBUtil preDBUtil = new PreparedDBUtil();
		String table_pk = ""; //主键ID
		List<MdTableBean> mdList = this.getMdTableInfo(businessType);
		for(MdTableBean mdTableBean:mdList){
			table_pk = mdTableBean.getTable_pk();
			List<MdTableBean> sonList = mdTableBean.getSonlist();
			for(MdTableBean sonMdTableBean:sonList){//删除子表
				sql = new StringBuffer();
				sql.append("DELETE FROM ").append(sonMdTableBean.getTable_code().toUpperCase())
						.append(" WHERE ").append(table_pk).append(" = ?");
				preDBUtil.preparedDelete(sql.toString());
				preDBUtil.setString(1, busi_id);
				preDBUtil.addPreparedBatch();
				i++;
			}
			sql = new StringBuffer();
			sql.append("DELETE FROM ").append(mdTableBean.getTable_code().toUpperCase())
					.append(" WHERE ").append(table_pk).append(" = ?");
			preDBUtil.preparedDelete(sql.toString());
			preDBUtil.setString(1, busi_id);
			preDBUtil.addPreparedBatch();
			i++;
		}
		if(i > 0){
			preDBUtil.executePreparedBatch(conn);
		}
		return flag;
	}

	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 hasText
	  * @param mRecordID
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.dssave.dao.DsCRUDDao#hasText(java.lang.String) 
	  */
	@Override
	public boolean hasText(String mRecordID) throws Exception {
		boolean flag = false;
		StringBuffer sql = new StringBuffer();
		sql.append("select count(1) as count1 from oa_document_File  where recordid = ? and text_type = 'text' ");
		PreparedDBUtil db = new PreparedDBUtil();
		db.preparedSelect(sql.toString());
		db.setString(1, mRecordID);
		db.executePrepared();
		if(db.size()>0){
			if(db.getInt(0, "count1")>0){
				flag = true;
			}
		}
		return flag;
	}
	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 getPublicConfig
	  * @param ins_id
	  * @return 
	  * @see com.chinacreator.xtbg.core.dssave.dao.DsCRUDDao#getPublicConfig(java.lang.String) 
	  */
	@Override
	public String getPublicConfig(String ins_id) throws Exception {
		String isPublic = "";
		StringBuffer sql = new StringBuffer();
		sql.append("select is_open from OA_FLOW_INSTANCE  where ins_id = ?");
		PreparedDBUtil db = new PreparedDBUtil();
		db.preparedSelect(sql.toString());
		db.setString(1, ins_id);
		db.executePrepared();
		if(db.size()>0){
			isPublic = db.getString(0, "is_open");
		}
		return isPublic;
	}

	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 updatePublicConfig
	  * @param is_open
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.dssave.dao.DsCRUDDao#updatePublicConfig(java.lang.String) 
	  */
	@Override
	public boolean updatePublicConfig(String is_open,String ins_id ,Connection conn) throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append("update OA_FLOW_INSTANCE  set is_open = ? where ins_id = ?");
		PreparedDBUtil db = new PreparedDBUtil();
		db.preparedUpdate(sql.toString());
		db.setString(1, is_open);
		db.setString(2, ins_id);
		db.executePrepared(conn);
		return true;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getInfoTypeConfig
	  * @param ins_id
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.dssave.dao.DsCRUDDao#getInfoTypeConfig(java.lang.String)
	 */
	public String getInfoTypeConfig(String ins_id) throws Exception {
		String is_infotype = "";
		StringBuffer sql = new StringBuffer();
		sql.append("select info_type from OA_FLOW_INSTANCE  where ins_id = ?");
		PreparedDBUtil db = new PreparedDBUtil();
		db.preparedSelect(sql.toString());
		db.setString(1, ins_id);
		db.executePrepared();
		if(db.size()>0){
			is_infotype = db.getString(0, "info_type");
		}
		return is_infotype;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 updateInfoTypeConfig
	  * @param is_infotype
	  * @param ins_id
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.dssave.dao.DsCRUDDao#updateInfoTypeConfig(java.lang.String, java.lang.String, java.sql.Connection)
	 */
	public boolean updateInfoTypeConfig(String is_infotype, String ins_id,
			Connection conn) throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append("update OA_FLOW_INSTANCE  set info_type = ? where ins_id = ?");
		PreparedDBUtil db = new PreparedDBUtil();
		db.preparedUpdate(sql.toString());
		db.setString(1, is_infotype);
		db.setString(2, ins_id);
		db.executePrepared(conn);
		return true;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 updateChiefConfig
	  * @param chief_endtime
	  * @param ins_id
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.dssave.dao.DsCRUDDao#updateChiefConfig(java.lang.String, java.lang.String, java.sql.Connection)
	 */
	public boolean updateChiefConfig(String chief_endtime, String ins_id,
			Connection conn) throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append("update OA_FLOW_INSTANCE  set chief_endtime = to_date(?,'yyyy-MM-dd HH24:mi:ss') where ins_id = ?");
		PreparedDBUtil db = new PreparedDBUtil();
		db.preparedUpdate(sql.toString());
		db.setString(1, chief_endtime);
		db.setString(2, ins_id);
		db.executePrepared(conn);
		return true;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getChiefConfig
	  * @param ins_id
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.dssave.dao.DsCRUDDao#getChiefConfig(java.lang.String)
	 */
	public String getChiefConfig(String ins_id) throws Exception {
		String chief_endtime = "";
		StringBuffer sql = new StringBuffer();
		sql.append("select chief_endtime from OA_FLOW_INSTANCE  where ins_id = ?");
		PreparedDBUtil db = new PreparedDBUtil();
		db.preparedSelect(sql.toString());
		db.setString(1, ins_id);
		db.executePrepared();
		if(db.size()>0){
			chief_endtime = db.getString(0, "chief_endtime");
		}
		return chief_endtime;
	}

	@Override
	public Boolean[] hasTextSign(String mRecordID) throws Exception {
		
		Boolean[] b = new Boolean[3];
		
		StringBuffer sql = new StringBuffer();
	
		sql.append("select count(1) as count1 from oa_document_File  where recordid = '"+mRecordID+"' and text_type = 'text'");
		sql.append(" union all select count(1) from oa_document_File  where recordid = '"+mRecordID+"' and text_type = 'singn'");
		sql.append(" union all select count(1) from oa_document_File  where recordid = '"+mRecordID+"' and text_type = 'zb_'");
		
		PreparedDBUtil db = new PreparedDBUtil();
		db.preparedSelect(sql.toString());
		
		db.executePrepared();
		for (int i = 0; i < db.size(); i++) {
			b[i] = ("1".equals(db.getString(i, "count1")))?true:false;
		}
		return b;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 findTable
	  * @param ins_id
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.dssave.dao.DsCRUDDao#findTable(java.lang.String)
	 */
	public Map<String, String> findTable(String ins_id) throws Exception {
		String sql="select table_id,column_id from oa_word_textinput where template_id =(select template_id from OA_FLOW_INSTANCE where ins_id=?) and textinput_value_type='2'";
		Map<String, String> map=queryToSingleMap(sql, ins_id);
		
		return map;
	}
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 findRecordIDs
	  * @param table_id
	  * @param column_id
	  * @param busi_id
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.dssave.dao.DsCRUDDao#findRecordIDs(java.lang.String, java.lang.String, java.lang.String)
	 */
	public String findRecordIDs(String table_id,String column_id,String busi_id) throws Exception{
		String sql="select "+column_id+" from  "+table_id +" where "+findIdByTable(table_id)+"=?";
		Map<String, String> map=queryToSingleMap(sql, busi_id);
		String recordid=map.get(column_id.toLowerCase());
		return recordid;
	}
	
	/**
	 * 
	*<b>Summary: </b>
	* findIdByTable(查找主键ID)
	* @param table_id
	* @return
	* @throws Exception
	 */
	public String findIdByTable(String table_id) throws Exception{
		String sql="SELECT COL.COLUMN_NAME FROM USER_CONSTRAINTS CON, USER_CONS_COLUMNS COL WHERE CON.CONSTRAINT_NAME = COL.CONSTRAINT_NAME AND CON.CONSTRAINT_TYPE = 'P'"
			+"AND COL.TABLE_NAME = ?";
		String id=queryToSingleMap(sql, table_id).get("column_name");
		return id;
	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 saveAsText
	  * @param recordid
	  * @param flowDocmentFileBean
	  * @param conn
	  * @return 
	 * @throws SQLException 
	  * @see com.chinacreator.xtbg.core.dssave.dao.DsCRUDDao#saveAsText(java.lang.String, com.chinacreator.xtbg.core.archive.entity.FlowDocmentFileBean, java.sql.Connection)
	 */
	@Override
	public boolean saveAsText(String recordid,FlowDocmentFileBean flowDocmentFileBean, Connection conn) throws SQLException {
		String sql = "insert into oa_flow_document_file(id,ins_id,action_id,flow_act_id,filetype,filesize,filedate,filebody,filepath,username,descript,recordid)  (select ?,?,?,?,filetype,filesize,filedate,filebody,filepath,username,descript,recordid from oa_document_file where recordid=? )";
		PreparedDBUtil db = new PreparedDBUtil();
		db.preparedInsert(sql);
		db.setString(1, flowDocmentFileBean.getId());
		db.setString(2, flowDocmentFileBean.getIns_id());
		db.setString(3, flowDocmentFileBean.getAction_id());
		db.setString(4, flowDocmentFileBean.getFlow_act_id());
		db.setString(5, recordid);
		db.executePrepared(conn);
		return true;
	}

	@Override
	public String getFlowActId(String ins_id, String action_id, Connection conn) throws Exception{
		String flowActId = "";
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT FLOW_ACTION_ID  FROM OA_FLOW_INSWFACTION tt where tt.ins_id = ? and tt.action_id = ? and tt.ACTION_HANDERNAME is not null order by tt.insert_order desc");
		PreparedDBUtil db = new PreparedDBUtil();
		db.preparedSelect(sql.toString());
		db.setString(1, ins_id);
		db.setString(2, action_id);
		db.executePrepared(conn);
		if(db.size()>0){
			flowActId = db.getString(0, "FLOW_ACTION_ID");
		}/*else{
			throw new Exception("无法获取流程环节实例ID。");
		}*/
		return flowActId;
	}

	@Override
	public boolean updateFile(FlowDocmentFileBean flowDocmentFileBean,
			Connection conn) throws SQLException {
		String sql = "update OA_DOCUMENT_FILE  set FILEBODY = (select FILEBODY from oa_flow_document_file f where  f.flow_act_id=?)  where recordid = ?";
		PreparedDBUtil db = new PreparedDBUtil();
		db.preparedInsert(sql);
		db.setString(1, flowDocmentFileBean.getFlow_act_id());
		db.setString(2, flowDocmentFileBean.getRecordid());
		db.executePrepared(conn);
		return true;
	}
}
