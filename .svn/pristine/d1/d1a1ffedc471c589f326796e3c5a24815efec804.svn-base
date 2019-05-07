package com.chinacreator.xtbg.core.archive.service.impl;

import java.io.File;
import java.sql.Connection;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.log4j.Logger;

import com.chinacreator.xtbg.core.archive.common.SplitExcel;
import com.chinacreator.xtbg.core.archive.common.SplitExcelForSZ;
import com.chinacreator.xtbg.core.archive.common.SplitExcelForSZQ;
import com.chinacreator.xtbg.core.archive.dao.BudgetDetailDao;
import com.chinacreator.xtbg.core.archive.dao.BudgetFileDao;
import com.chinacreator.xtbg.core.archive.dao.impl.BudgetDetailDaoImpl;
import com.chinacreator.xtbg.core.archive.dao.impl.BudgetFileDaoImpl;
import com.chinacreator.xtbg.core.archive.entity.BudgetAttachBean;
import com.chinacreator.xtbg.core.archive.entity.BudgetDetailBean;
import com.chinacreator.xtbg.core.archive.entity.BudgetFileBean;
import com.chinacreator.xtbg.core.archive.entity.ExcelBean;
import com.chinacreator.xtbg.core.archive.service.BudgetAttachService;
import com.chinacreator.xtbg.core.archive.service.BudgetDetailInfoService;
import com.chinacreator.xtbg.core.archive.service.BudgetDetailService;
import com.chinacreator.xtbg.core.archive.service.BudgetFileService;
import com.chinacreator.xtbg.core.common.cache.OASystemCache;
import com.chinacreator.xtbg.core.common.util.DaoUtil;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.ResultCode;
import com.chinacreator.xtbg.core.common.util.ResultMap;

/**
 * 
 * <p>
 * Title:SplitLogServiceImpl.java
 * </p>
 * <p>
 * Description:指标文拆分服务层实现
 * </p>
 * <p>
 * Copyright:Copyright (c) 2013
 * </p>
 * <p>
 * Company:湖南科创
 * </p>
 * 
 * @author 陈建华
 * @version 1.0 Sep 16, 2013
 */
public class BudgetFileServiceImpl implements BudgetFileService {
	private static final Logger LOG = Logger
			.getLogger(BudgetFileServiceImpl.class);

	/**
	 * 
	 * <b>Summary: </b> 复写方法 insert
	 * 
	 * @param bean
	 * @return
	 * @see com.chinacreator.xtbg.caizhengting.split.service.SplitLogService#insert(com.chinacreator.xtbg.caizhengting.split.entity.SplitLogBean)
	 */
	@Override
	public ResultMap<ResultCode, BudgetFileBean> save(BudgetFileBean bean) {
		ResultMap<ResultCode, BudgetFileBean> result = new ResultMap<ResultCode, BudgetFileBean>();
		result.setCode(ResultCode.FAIL);
		if (bean != null) {
			if (bean.getBus_id() == null || "".equals(bean.getBus_id())) {
				result.setCode(ResultCode.MISS_ID);
			} else {
				BudgetFileDao dao = new BudgetFileDaoImpl();
				Connection con = null;
				try {
					con = DbManager.getInstance().getConnection();
					BudgetFileBean queryBean = dao.selectByBussid(bean, con);
					if (queryBean != null) {
						bean.setId(queryBean.getId());
						dao.update(bean, con);
						result.setCode(ResultCode.OK);
						result.setResult(bean);
					} else {
						if (bean.getId() == null || "".equals(bean.getId())) {
							bean.setId(DaoUtil.getUUID());
						}
						dao.insert(bean, con);
						result.setCode(ResultCode.OK);
						result.setResult(bean);
					}
				} catch (Exception e) {
					LOG.error(e.getMessage(), e);
				} finally {
					DbManager.closeConnection(con);
				}
			}
		}
		return result;
	}

	@Override
	public ResultMap<ResultCode, BudgetFileBean> save(String id,
			String file_code, String bus_id, String file_name, String amount,
			String branch_id, String user_id, String op_date, String status,String annual) {
		BudgetFileBean bean = new BudgetFileBean();
		bean.setAmount(amount);
		bean.setBranch_id(branch_id);
		bean.setBus_id(bus_id);
		bean.setFile_code(file_code);
		bean.setFile_name(file_name);
		bean.setId(id);
		bean.setOp_date(op_date);
		bean.setStatus(status);
		bean.setUser_id(user_id);
		bean.setAnnual(annual);
		return save(bean);
	}

	@Override
	public String splitFile(String relative_path, String fileName,
			String file_code, int header_row, String user_id, String dept_id,
			String bus_id,String annual,String template_type) {
		String file_url = OASystemCache.getContextProperty("oa_split_file_save_path");
		SplitExcel split = null;
		if("1".equals(template_type)){	//注入市州解析模板
			split = new SplitExcelForSZ();
		} else if("2".equals(template_type)){
			split = new SplitExcelForSZQ(); //注入市州区县解析模板
		}
		StringBuffer outStr = new StringBuffer();
		BudgetAttachService attachService = new BudgetAttachServiceImpl();
		BudgetDetailService detailService = new BudgetDetailServiceImpl();
		
		Connection con = null;
		String filePath = file_url + relative_path + File.separator + fileName;
		File file = new File(filePath);
		SimpleDateFormat format = new SimpleDateFormat("HH:mm:ss sss");
		SimpleDateFormat format1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		if (!file.exists()) {
			outStr.append("<p>[" + format.format(new Date()) + "]:被拆分文件不存在...</p>");
		} else if(split == null){
			outStr.append("<p>[" + format.format(new Date()) + "]:请选择拆分模板...</p>");
		} else {
			try {
				con = DbManager.getInstance().getConnection();

				outStr.append("<p>[" + format.format(new Date())+ "]: 开始拆分文件...</p>");
				List<ExcelBean> list = split.split(header_row, filePath);
				outStr.append("<p>[" + format.format(new Date())+ "]: 文件拆分完成，正在保存数据...</p>");
				
				if (list != null && list.size() > 0) {
					// 保存主文件
					ResultMap<ResultCode, BudgetFileBean> result1 = this.save(
							"", file_code, bus_id, fileName,
							"0", dept_id, user_id, format1.format(new Date()),
							"0",annual);
					if(result1.getCode().equals(ResultCode.OK)){
						//主信息保存成功,保存附件信息
						String id = result1.getResult().getId();
						ResultMap<ResultCode, BudgetAttachBean> result2 = attachService.save(
															id, "",fileName, relative_path + File.separator + fileName,
															file.length()+"");
						if(result2.getCode().equals(ResultCode.OK)){
							outStr.append("<p>[" + format.format(new Date()) + "]: " + fileName + " 数据保存成功！</p>");
							
							//这个文件夹这样命名是规定好的，如果要改，必须在解析类（--拆分后）中也要改这个文件夹名，因为两边保持了一致，两个地方约束好的（BudgetFileServiceImpl--拆分后）
							String tmpfileName = fileName.substring(0, fileName.lastIndexOf(".")) + "拆分后";
							BudgetDetailInfoService detailInfoBean = new BudgetDetailInfoServiceImpl();
							for (ExcelBean bean : list) {
								//保存详细数据
								ResultMap<ResultCode, BudgetDetailBean> result3 = detailService.save(DaoUtil.getUUID(), id, bean.getUnit_id(), bean.getTitle(), 
										relative_path+ File.separator + tmpfileName + File.separator+ bean.getTitle(), 
										bean.getFile_size()+"", bean.getRemark());
								if(result3.getCode().equals(ResultCode.OK)){
									outStr.append("<p>["+format.format(new Date())+"]: "+bean.getTitle()+" 数据保存成功！</p>");
									detailInfoBean.insert(bean, result3.getResult().getDetail_id());
								} else {
									outStr.append("<p>[" + format.format(new Date())+ "]: 保存指标文详细数据【"+bean.getTitle()+"】出错，错误代码【"+result3.getCode().getIndex()+"】...</p>");
								}
							}
							outStr.append("<p>[" + format.format(new Date())+ "]: 文件拆分成功！共拆分文件：" + (list.size())+ "个，如果拆分不完全，请检查拆分单位及正确的标题行数！</p>");
						} else {
							outStr.append("<p>[" + format.format(new Date())+ "]: 保存指标文附件出错，错误代码【"+result2.getCode().getIndex()+"】...</p>");
						}
					} else {
						outStr.append("<p>[" + format.format(new Date())+ "]: 保存指标文总信息出错，错误代码【"+result1.getCode().getIndex()+"】...</p>");
					}
				} else {
					outStr.append("<p>[" + format.format(new Date())+ "]: 拆分内容为空或拆分单位未完全维护到数据库中，退出保存！</p>");
				}
			} catch (Exception e) {
				LOG.error(e.getMessage(), e);
				outStr.append("<p>[" + format.format(new Date())+ "]: 拆分异常，拆分结束！</p>");
			} finally {
				DbManager.closeConnection(con);
			}
		}
		return outStr.toString();
	}

	@Override
	public ResultMap<ResultCode, List<BudgetDetailBean>> getGwcsOrg(String bus_id) {
		ResultMap<ResultCode, List<BudgetDetailBean>> result = new ResultMap<ResultCode, List<BudgetDetailBean>>();
		result.setCode(ResultCode.FAIL);
		if (bus_id == null || "".equals(bus_id)) {
			result.setCode(ResultCode.MISS_ID);
		} else {
			BudgetDetailDao detailDao = new BudgetDetailDaoImpl();
			BudgetFileDao fileDao = new BudgetFileDaoImpl();
			Connection con = null;
			try {
				con = DbManager.getInstance().getConnection();
				BudgetFileBean fileBean = new BudgetFileBean();
				BudgetDetailBean detailBean = new BudgetDetailBean();
				List<BudgetDetailBean> list = new ArrayList<BudgetDetailBean>();
				//根据流程实例id查询指标文总信息
				fileBean.setBus_id(bus_id);
				fileBean = fileDao.selectByBussid(fileBean, con);
				
				if(fileBean != null){
					
					detailBean.setBudget_file_id(fileBean.getId());
					list = detailDao.getByFileId(detailBean, con);
					if(list != null && list.size() > 0){
						result.setCode(ResultCode.OK);
						result.setResult(list);
					} else {
						result.setCode(ResultCode.UNEXIST);
					}
				} else {
					result.setCode(ResultCode.UNEXIST);
				}
			} catch (Exception e) {
				LOG.error(e.getMessage(), e);
			} finally {
				DbManager.closeConnection(con);
			}
		}
		return result;
	}
}
