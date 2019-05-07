package com.chinacreator.xtbg.core.archive.dao.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeSet;

import com.chinacreator.xtbg.core.archive.dao.WorkCountDao;
import com.chinacreator.xtbg.core.archive.entity.SearchBean;
import com.chinacreator.xtbg.core.archive.entity.SfwColumnBean;
import com.chinacreator.xtbg.core.archive.entity.SfwdjUserListConfBean;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.core.common.util.DaoUtil;
import com.chinacreator.xtbg.core.common.util.StringUtil;

public class WorkCountDaoImpl extends XtDbBaseDao implements WorkCountDao {

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 workcount
	  * @param SearchBean
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.fagaiwei.worklistcount.dao.WorkCountDao#workcount(com.chinacreator.xtbg.fagaiwei.worklistcount.entity.SearchBean, java.lang.String, java.lang.String, long, int)
	 */
	public PagingBean workcount(SearchBean searchBean, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception {
		StringBuffer sql =new StringBuffer();
		SfwdjUserListConfBean sfwdjUserListConfBean = getUserListConfigInfo(searchBean.getCount_type(),searchBean.getUser_id());
		String tablepk = 
				queryToSingleMap("select table_pk from oa_md_table t where t.table_code = ?", (null != sfwdjUserListConfBean)?sfwdjUserListConfBean.getExtable():"" ).get("table_pk");
		
		List<String> values = new ArrayList<String>();
		PagingBean pb= new PagingBean();
		sql.append("       select ");
		sql.append("       v.ins_name as title,");
		sql.append("       to_char(v.accept_time,'yyyy-mm-dd hh24:mi') accept_time ,");
		sql.append("       org.org_name , ");
		sql.append("       v.ins_id,");
		sql.append("       v.busi_id,");
		sql.append("       v.busitype_code ,");
		sql.append("       v.action_form, ");
		sql.append("       n.number_title, ");
		sql.append("       v.accepter, ");
		sql.append("       v.template_id ");
		if(!StringUtil.isBlank((null != sfwdjUserListConfBean)?sfwdjUserListConfBean.getColumn_list():"" )){
			String[] columnListstr = sfwdjUserListConfBean.getColumn_list().split("#")[0].split(",");
			for(int i = 0 ; i < columnListstr.length ; i++){
				sql.append("       ,x."+columnListstr[i]+" as "+sfwdjUserListConfBean.getExtable()+"_"+columnListstr[i]);
			}
			
		}
		sql.append("  from oa_fw_v_vworklist v");
		sql.append("  left join td_sm_organization org  on v.org_id=org.org_id");
		sql.append("  left join oa_word_number n on v.busi_id=n.busi_id ");
		sql.append("  left join OA_FLOW_BUSITYPE_TYPE t on t.busitype_type_code=v.busitype_type_code ");
		if(!StringUtil.isBlank((null != sfwdjUserListConfBean)?sfwdjUserListConfBean.getExtable():"" )){//如果扩展业务表不为空
			sql.append("  left join "+sfwdjUserListConfBean.getExtable()+" x on x."+tablepk+"=v.busi_id ");
		}
		sql.append(" where t.count_type='"+searchBean.getCount_type()+"'");
		//特检验OA 2014-06-09 start 只查询发文数据
		sql.append("    and v.STATUS_CODE='02' ");
		if(!StringUtil.isBlank(searchBean.getBusitype_type_code())){
			sql.append(" and  t.busitype_type_code ='"+searchBean.getBusitype_type_code()+"'");
		}
		//特检验OA 2014-06-09 end
		if(!StringUtil.isBlank(searchBean.getStartTime())){
			sql.append(" and v.accept_time>=to_date('"+searchBean.getStartTime()+"','yyyy-mm-dd')");
		}
		if(!StringUtil.isBlank(searchBean.getEndTime())){
			sql.append(" and v.accept_time<=to_date('"+searchBean.getEndTime()+"','yyyy-mm-dd')");
		}
		if(!StringUtil.isBlank(searchBean.getWorkTitle())){
			sql.append(" and v.ins_name like '%"+searchBean.getWorkTitle()+"%'");
		}
		if(!StringUtil.isBlank(searchBean.getZsorg())){
			sql.append(" and org_name like '%"+searchBean.getZsorg()+"%'");
		}	
		if(!StringUtil.isBlank(searchBean.getFwnumber())){
			sql.append(" and n.number_title like '%"+searchBean.getFwnumber()+"%'");
		}
		if(!StringUtil.isBlank(searchBean.getNgorg())){
			sql.append(" and v.accepter like '%"+searchBean.getNgorg()+"%'");
		}
		sql.append(" order by v.accept_time desc ");
		pb= queryToPagingBean(sql.toString(), offset, maxPagesize, null, values);
		return pb;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getAllGWTableByListType
	  * @param listtype
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.archive.dao.WorkCountDao#getAllGWTableByListType(java.lang.String)
	 */
	public List<Map<String, String>> getAllGWTableByListType(String listtype)
			throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append("select distinct  o.table_id ,o.table_code,o.table_name from oa_md_table o ");
		sql.append("left join oa_md_table_business_mapping o1 on o1.table_id = o.table_id ");
		sql.append("left join oa_flow_busitype bt on bt.busitype_code = o1.busitype_code ");
		sql.append("left join oa_flow_busitype_type btt on btt.busitype_type_code = bt.busitype_type_code ");
		sql.append("where btt.count_type = ? ");
		
		List<Map<String, String>> resultMap = queryToListMap(sql.toString(), listtype);
		
		return resultMap;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getColumnsByTableId
	  * @param tableid
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.archive.dao.WorkCountDao#getColumnsByTableId(java.lang.String)
	 */
	public List<Map<String, String>> getColumnsByTableId(String tableid)
			throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append("select * from oa_md_columns c where c.table_id = ?");

		return queryToListMap(sql.toString(), tableid);
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 saveUserListConfig
	  * @param sfwdjUserListConfBean
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.archive.dao.WorkCountDao#saveUserListConfig(com.chinacreator.xtbg.core.archive.entity.SfwdjUserListConfBean)
	 */
	public void saveUserListConfig(SfwdjUserListConfBean sfwdjUserListConfBean)
			throws Exception {
		Map<String,String> result = queryToSingleMap(sfwdjUserListConfBean);
		if(StringUtil.isBlank(result.get("id"))){
			sfwdjUserListConfBean.setId(DaoUtil.getUUID());
			insert(sfwdjUserListConfBean);
		}else{
			update(sfwdjUserListConfBean);
		}
	}

	@Override
	public SfwdjUserListConfBean getUserListConfigInfo(String listtype,
			String userid) throws Exception {
		SfwdjUserListConfBean sfwdjUserListConfBean = new SfwdjUserListConfBean();
		sfwdjUserListConfBean.setList_type(listtype);
		sfwdjUserListConfBean.setUser_id(userid);
		return (SfwdjUserListConfBean)queryToBean(sfwdjUserListConfBean);
	}

	@Override
	public Map<String, String> getListExtendFields(String list_type,
			String user_id) throws Exception {
		String ex_columnNames = "";//列表扩展字段名称
		String ex_columns = "";//列表扩展字段结构
		Map<String,String> exFieldMap = new HashMap<String,String>();
		SfwdjUserListConfBean sfwdjUserListConfBean = getUserListConfigInfo(list_type,user_id);
		
		if(null != sfwdjUserListConfBean){
			String tablename = sfwdjUserListConfBean.getExtable();
			String column_list = sfwdjUserListConfBean.getColumn_list();
			
			
			if(!StringUtil.isBlank(column_list)){
				String[] columnIndexstr = null;//字段排序数组
				if(column_list.split("#").length > 2){
					columnIndexstr = column_list.split("#")[2].split(",");
				}
				String[] columnNames = column_list.split("#")[1].split(",");
				String[] columnFields = column_list.split("#")[0].split(",");
				Set<SfwColumnBean> extendColumnSet = new TreeSet<SfwColumnBean>();
				for(int i = 0 ; i < columnNames.length ; i++){//通过treeSet对字段进行排序
					SfwColumnBean sfwColumnBean = new SfwColumnBean();
					if(null != columnIndexstr && !StringUtil.isBlank(columnIndexstr[i])){
						sfwColumnBean.setColumn_index(Integer.parseInt(columnIndexstr[i]));
					}
					sfwColumnBean.setColumn_name(columnNames[i]);
					sfwColumnBean.setColumn_field(columnFields[i]);
					extendColumnSet.add(sfwColumnBean);
				}
				Iterator<SfwColumnBean> it = extendColumnSet.iterator();
				while (it.hasNext()) {//排序完成，对字符串进行拼接
					SfwColumnBean tem_Sfwcb = it.next();
					ex_columnNames += ",'"+tem_Sfwcb.getColumn_name()+"'";
					String grid_filed = (tablename+"_"+tem_Sfwcb.getColumn_name()).toLowerCase();
					ex_columns += ",{name: '"+grid_filed+"',index: '"+grid_filed+"',width: '60',sortable: false}";
				}
				
				
			}
		}
		exFieldMap.put("ex_columnNames", ex_columnNames);
		exFieldMap.put("ex_columns", ex_columns);
		
		return exFieldMap;
	}
	
}
