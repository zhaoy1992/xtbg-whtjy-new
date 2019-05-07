package com.chinacreator.xtbg.core.archive.service.impl;

import java.sql.Connection;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import org.apache.log4j.Logger;

import com.chinacreator.xtbg.core.archive.dao.BudgetDetailInfoDao;
import com.chinacreator.xtbg.core.archive.dao.impl.BudgetDetailInfoDaoImpl;
import com.chinacreator.xtbg.core.archive.entity.BudgetDetailInfoBean;
import com.chinacreator.xtbg.core.archive.entity.ExcelBean;
import com.chinacreator.xtbg.core.archive.entity.ExcelDetailBean;
import com.chinacreator.xtbg.core.archive.service.BudgetDetailInfoService;
import com.chinacreator.xtbg.core.common.util.DaoUtil;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.ResultCode;
import com.chinacreator.xtbg.core.common.util.ResultMap;

/**
 *<p>Title:BudgetDetailInfoServiceImpl.java</p>
 *<p>Description:拆分文件详细数据Service实现</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 陈建华
 *@version 1.0
 *2014-4-17
 */
public class BudgetDetailInfoServiceImpl implements BudgetDetailInfoService {
	private static final Logger LOG = Logger.getLogger(BudgetDetailInfoServiceImpl.class);
	@Override
	public ResultMap<ResultCode, BudgetDetailInfoBean> insert(ExcelBean bean,String detail_id) {
		ResultMap<ResultCode, BudgetDetailInfoBean> result = new ResultMap<ResultCode, BudgetDetailInfoBean>();
		result.setCode(ResultCode.FAIL);
		
		if (bean != null) {
			BudgetDetailInfoDao dao = new BudgetDetailInfoDaoImpl();
			Connection con = null;
			try {
				BudgetDetailInfoBean detailBean ;
				con = DbManager.getInstance().getTransactionConnection();
				//保存数据前 先删除这个detail_id的数据
				dao.deleteByDetailId(detail_id, con);
				if(bean.isAllItemSame() || bean.getList().size() == 1){
					detailBean = new BudgetDetailInfoBean();
					ExcelDetailBean excelDetailBean = bean.getList().get(0); 
					detailBean.setBudget_detail_info_id(DaoUtil.getUUID());
					detailBean.setDetail_id(detail_id);
					detailBean.setProject_name(excelDetailBean.getProjectName());
					detailBean.setAmount(excelDetailBean.getAmount()+"");
					detailBean.setRemark(excelDetailBean.getRemark());
					detailBean.setFun_type_name(excelDetailBean.getFunctionItem());
					detailBean.setE_type_name(excelDetailBean.getEconomyItem());
					dao.insert(detailBean, con);
				} else {
					Map<String,BudgetDetailInfoBean> map = new HashMap<String, BudgetDetailInfoBean>();
					for(int i = 1;i<bean.getList().size();i++){
						ExcelDetailBean b = bean.getList().get(i);
						//把经济分类 功能分类作为map的key与循环比较，如果相同的就累加项目，金额，备注
						if(!map.containsKey(b.getFunctionItem()+"##"+b.getEconomyItem())){
							BudgetDetailInfoBean dBean = new BudgetDetailInfoBean();
							dBean.setProject_name(b.getProjectName());
							dBean.setAmount(b.getAmount()+"");
							dBean.setRemark(b.getRemark());
							dBean.setFun_type_name(b.getFunctionItem());
							dBean.setE_type_name(b.getEconomyItem());
							map.put(b.getFunctionItem()+"##"+b.getEconomyItem(), dBean);
						} else {
							BudgetDetailInfoBean dBean = map.get(b.getFunctionItem()+"##"+b.getEconomyItem());
							dBean.setProject_name(dBean.getProject_name()+"。"+b.getProjectName());
							dBean.setAmount(Double.parseDouble(dBean.getAmount())+b.getAmount()+"");
							if(b.getRemark() == null || "".equals(b.getRemark())){
								dBean.setRemark(dBean.getRemark());
							} else {
								dBean.setRemark(dBean.getRemark()+"。"+b.getRemark());
							}
							dBean.setFun_type_name(b.getFunctionItem());
							dBean.setE_type_name(b.getEconomyItem());
						}
					}
					Iterator<String> iter = map.keySet().iterator();
					while(iter.hasNext()){
						BudgetDetailInfoBean dBean = map.get(iter.next());
						dBean.setDetail_id(detail_id);
						dBean.setBudget_detail_info_id(DaoUtil.getUUID());
						dao.insert(dBean, con);
					}
				}
				result.setCode(ResultCode.OK);
				DbManager.closeTransactionConnection(con, true);
			} catch (Exception e) {
				DbManager.closeTransactionConnection(con, false);
				LOG.error(e.getMessage(), e);
			}
		}
		return result;
	}
}