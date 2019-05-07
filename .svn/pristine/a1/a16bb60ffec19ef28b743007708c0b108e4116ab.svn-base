package com.chinacreator.xtbg.caizhengting.press.service.impl;

import java.sql.Connection;

import org.apache.log4j.Logger;

import com.chinacreator.xtbg.caizhengting.press.dao.PressDao;
import com.chinacreator.xtbg.caizhengting.press.dao.imploracle.PressDaoImpl;
import com.chinacreator.xtbg.caizhengting.press.entity.PressBean;
import com.chinacreator.xtbg.caizhengting.press.service.PressService;
import com.chinacreator.xtbg.pub.util.DaoUtil;
import com.chinacreator.xtbg.pub.util.DbconnManager;
import com.chinacreator.xtbg.pub.util.StringUtil;

public class PressServiceImpl implements PressService {
	private PressDao dao = null;
	private static final Logger LOG = Logger.getLogger(PressServiceImpl.class);
	
	public PressServiceImpl(){
			dao = new PressDaoImpl();
	}
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 save
	  * @param bean
	  * @return 
	  * @see com.chinacreator.xtbg.caizhengting.press.service.PressService#save(com.chinacreator.xtbg.caizhengting.press.entity.PressBean, java.lang.String)
	 */
	@Override
	public String save(PressBean bean) {
		String flag = "";
		Connection conn = null;
		PressBean pressBean = null;
		try {
			conn = DbconnManager.getInstance().getTransactionConnection();
			if(!StringUtil.isBlank(bean.getPress_name())){
				pressBean = dao.findPressBeanByName(bean.getPress_name(), conn);
			}
			//如果查询出来的出版社实体不为null并且id也不为null值
			if(pressBean == null || StringUtil.isBlank(StringUtil.deNull(pressBean.getPress_id()))){
				if(!StringUtil.isBlank(bean.getPress_name())){
					String uuid = DaoUtil.getUUID();
					bean.setPress_id(uuid);
					flag = dao.insert(bean, conn);
				} else{
					flag = "操作成功";
				}
			} else {
				flag = "操作成功";
			}
			DbconnManager.closeTransactionConnection(conn, true);
		} catch (Exception e) {
			LOG.error("出版社保存错误："+e.getMessage(), e);
			DbconnManager.closeTransactionConnection(conn, false);
			flag = "操作失败";
		}
		return flag;
	}

}
