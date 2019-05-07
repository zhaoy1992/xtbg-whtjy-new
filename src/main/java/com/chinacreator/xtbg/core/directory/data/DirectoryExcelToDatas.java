package com.chinacreator.xtbg.core.directory.data;

import java.io.File;
import java.sql.Connection;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;

import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.directory.constant.DirectoryConstant;
import com.chinacreator.xtbg.core.directory.dao.DirectoryDao;
import com.chinacreator.xtbg.core.directory.entity.DirectoryBean;
import com.chinacreator.xtbg.core.directory.entity.HeTongBean;
import com.chinacreator.xtbg.core.directory.entity.UserinfoBean;
import com.chinacreator.xtbg.pub.excel.POIExcelUtil;
import com.chinacreator.xtbg.pub.excel.ifc.BusiExcelToData;

/**
 * 
 *<p>Title:DirectoryExcelToData.java</p>
 *<p>Description:名录excel导入导出</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *@author 夏天
 *@version 1.0
 *2014-3-9
 */
public class DirectoryExcelToDatas extends BusiExcelToData{
	public static final Logger LOG = Logger
			.getLogger(DirectoryExcelToDatas.class.getName());
	@Autowired
	private DirectoryDao directoryDao = null;
	
	public DirectoryExcelToDatas(){
		
	}
	
	/**
	 * 
	*<b>Summary: </b>
	* exportExcelToData(根据传入的用户id数组，查询相应的人员信息并生成excel到指定路径，最后成功返回该路径)
	* @param useridArry 用户id数组
	* @return
	 */
	public String exportExcelToData(Map<String,String> params){
		try{
			String[] useridArry = (params.get("userids")).split(",");
			tempExportFilePath += System.currentTimeMillis()+".xls";

			poiExcelUtil = new POIExcelUtil(exportTemplateFilePath);
			
			for(int i=0 ; i < useridArry.length; i++){
				String userid = useridArry[i];
				DirectoryBean directoryBean = directoryDao.getTypeBeanById(userid,"view");
				HeTongBean hetongBean = directoryDao.getHeTongBeanById(userid);

				if(!StringUtil.nullOrBlank(directoryBean.getDirectoryname())){
					String[] values = new String[58];
					values[0] = userid;
					values[1] = DirectoryConstant.parsePersonType(directoryBean.getNew_user_type(), true);
					values[2] = DirectoryConstant.parseJobState(directoryBean.getNew_job_state(), true);
					values[3] = directoryBean.getNew_job_no();
					values[4] = directoryBean.getDirectoryname();
					
					values[5] = directoryBean.getDepartment();
					values[6] = DirectoryConstant.parsePost(directoryBean.getPost(), true);
					values[7] = DirectoryConstant.parsePost(directoryBean.getDirectorylevel(), true);
					values[8] = directoryBean.getDirectorysex();
					values[9] = directoryBean.getNation();
					
					values[10] = directoryBean.getNatives();
					values[11] = DirectoryConstant.parseJobSet(directoryBean.getNew_job_set(), true);
					values[12] = DirectoryConstant.parsePolitics(directoryBean.getPolitics(), true);
					values[13] = directoryBean.getNew_join_zzdate();
					values[14] = directoryBean.getDirectoryyear();
					
					values[15] = directoryBean.getWorktime();
					values[16] = directoryBean.getNew_in_hosb();
					values[17] = directoryBean.getNew_toother_date();
					values[18] = directoryBean.getIdnumber();
					values[19] = "";
					
					values[20] = directoryBean.getSchool();
					values[21] = DirectoryConstant.parseEducation(directoryBean.getEducation(), true);
					values[22] = DirectoryConstant.parseDegree(directoryBean.getDegree(), true);
					values[23] = directoryBean.getNew_first_xingshi();
					values[24] = directoryBean.getNew_first_zy();
					
					values[25] = directoryBean.getNew_first_bydate();
					values[26] = directoryBean.getNew_zg_byyx();
					values[27] = DirectoryConstant.parseEducation(directoryBean.getNew_zg_xl(), true);
					values[28] = DirectoryConstant.parseDegree(directoryBean.getNew_zg_xw(), true);
					values[29] = directoryBean.getNew_zg_xingshi();
					
					values[30] = directoryBean.getNew_zg_zy();
					values[31] = directoryBean.getNew_zg_bydate();
					values[32] = DirectoryConstant.parseNewjszc(directoryBean.getNew_jszc(), true);
					values[33] = directoryBean.getNew_zc_getdate();
					values[34] = directoryBean.getNew_zc_pydate();
					
					values[35] = DirectoryConstant.parseBoolean(hetongBean.getHetong_isold(), true);
					values[36] = DirectoryConstant.parseBoolean(hetongBean.getHetong_isyl(), true);
					values[37] = DirectoryConstant.parseBoolean(hetongBean.getHetong_issy(), true);
					values[38] = DirectoryConstant.parseBoolean(hetongBean.getHetong_isgs(), true);
					values[39] = DirectoryConstant.parseBoolean(hetongBean.getHetong_issy(), true);

					values[40] = "";
					values[41] = DirectoryConstant.parseHetongtype(hetongBean.getHetong_type(),true);
					values[42] = hetongBean.getHetong_number();
					values[43] = hetongBean.getHetong_first_date();
					values[44] = hetongBean.getHetong_nowstart_date();
					
					values[45] = hetongBean.getHetong_nowsend_date();
					values[46] = hetongBean.getHetong_trystart_date();
					values[47] = hetongBean.getHetong_tryend_date();
					values[48] = directoryBean.getNew_xc_gwgz();
					values[49] = directoryBean.getNew_xc_xjgz();
					
					values[50] = "";
					values[51] = directoryBean.getNew_xc_yb();
					values[52] = directoryBean.getNew_xc_ylbx();
					values[53] = directoryBean.getNew_xc_sybx();
					values[54] = directoryBean.getNew_xc_gjj();
					values[55] = directoryBean.getNew_xc_cb();
					
					values[56] = "";
					values[57] = "";
					poiExcelUtil.writeLine(2+i, values);//从模版的第二行开始 写入
				}
				poiExcelUtil.writeExcelToPath(tempExportFilePath);
			}
		}catch(Exception e){
			LOG.error(e.getMessage());
		}
		return tempExportFilePath;
	}
	
	/**
	 * 
	*<b>Summary: </b>
	* importExcelToData(导入excel数据，user_id为空的不导入)
	 */
	public String importExcelToData(String filepath){
		Connection conn = null;
		try {
		    poiExcelUtil = new POIExcelUtil(filepath);

			conn = DbManager.getInstance().getTransactionConnection();
			String[][] datas = poiExcelUtil.readSheet();//将excel中的数据全部获取出来放置在二维数组中
			for(int i = 2 ; i < datas.length; i++){//从第二行开始读取
				String[] data = datas[i];
				if(StringUtil.nullOrBlank(data[0])){
					break;
				}
				UserinfoBean userinfoBean = new UserinfoBean();
				HeTongBean heTongBean = new HeTongBean();
				
				userinfoBean.setUserid(data[0]);//用户id
				heTongBean.setHetong_userands_id(data[0]);
				
				userinfoBean.setNew_user_type(DirectoryConstant.parsePersonType(data[1],false));//人员类别
				userinfoBean.setNew_job_state(DirectoryConstant.parseJobState(data[2], false));//在岗状态
				userinfoBean.setNew_job_no(data[3]);//职工工号
				userinfoBean.setUserRealname(data[4]);//姓名
				
				//data[5]工作部门 字段不存
				userinfoBean.setDuties(DirectoryConstant.parsePost(data[6], false));
				userinfoBean.setDirectorylevel(DirectoryConstant.parseJobState(data[7], false));//职务级别
				userinfoBean.setUserSex(DirectoryConstant.parsePersonSex(data[8],false));//性别
				userinfoBean.setNation(data[9]);//民族
				userinfoBean.setNatives(data[10]);//籍贯
				userinfoBean.setNew_job_set(DirectoryConstant.parseJobSet(data[11], false));//岗位设置
				
				userinfoBean.setPolitics(DirectoryConstant.parsePolitics(data[12], false));//政治面貌
				userinfoBean.setNew_join_zzdate(data[13]);//参加组织日期
				userinfoBean.setUserBirthday(data[14]);//出生日期
				userinfoBean.setWorktime(data[15]);//参加工作时间
				userinfoBean.setNew_in_hosb(data[16]);//入院时间
				
				userinfoBean.setNew_toother_date(data[17]);//借调时间
				userinfoBean.setUserIdcard(data[18]);//身份证
				
				//data[19]备注不存
				userinfoBean.setSchool(data[20]);//毕业院校(第一学历)
				userinfoBean.setEducation(DirectoryConstant.parseEducation(data[21], false));//学历(第一学历)
				userinfoBean.setDegree(DirectoryConstant.parseDegree(data[22], false));//学位(第一学历)
				userinfoBean.setNew_first_xingshi(data[23]);//学习形式(第一学历)
				userinfoBean.setNew_first_zy(data[24]);//专业(第一学历)
				userinfoBean.setNew_first_bydate(data[25]);//毕业时间(第一学历)
				
				userinfoBean.setNew_zg_byyx(data[26]);//毕业院校(最高学历)
				userinfoBean.setNew_zg_xl(DirectoryConstant.parseEducation(data[27], false));//学历(最高学历)
				userinfoBean.setNew_zg_xw(DirectoryConstant.parseDegree(data[28], false));//学位(最高学历)
				userinfoBean.setNew_zg_xingshi(data[29]);//学习形式(最高学历)
				userinfoBean.setNew_zg_zy(data[30]);//专业(最高学历)
				userinfoBean.setNew_zg_bydate(data[31]);//毕业时间(最高学历)
				
				userinfoBean.setNew_jszc(DirectoryConstant.parseNewjszc(data[32], false));//技术职称
				userinfoBean.setNew_zc_getdate(data[33]);//职称获取时间
				userinfoBean.setNew_zc_pydate(data[34]);//职称聘任时间
				
				heTongBean.setHetong_isold(DirectoryConstant.parseBoolean((data[35]), false));//养老保险
				heTongBean.setHetong_isyl(DirectoryConstant.parseBoolean((data[36]), false));//医疗保险
				heTongBean.setHetong_issy(DirectoryConstant.parseBoolean((data[37]), false));//生育保险
				heTongBean.setHetong_isgs(DirectoryConstant.parseBoolean((data[38]), false));//工伤保险
				heTongBean.setHetong_isshiye(DirectoryConstant.parseBoolean((data[39]), false));//失业保险
				
				//data[40]合同编号不存
				heTongBean.setHetong_type(DirectoryConstant.parseHetongtype(data[41], false));//合同类别
				heTongBean.setHetong_number(data[42]);//08年后劳动合同签订次数
				heTongBean.setHetong_first_date(data[43]);//首次合同签订日期
				heTongBean.setHetong_nowstart_date(data[44]);//现合同起始期
				heTongBean.setHetong_nowsend_date(data[45]);//现合同终止期
				heTongBean.setHetong_trystart_date(data[46]);//合同试用起始期
				heTongBean.setHetong_tryend_date(data[47]);//合同试用终止期
				
				userinfoBean.setNew_xc_gwgz(data[48]);//岗位工资
				userinfoBean.setNew_xc_xjgz(data[49]);//薪级工资
				//data[50]应发合计不存
				userinfoBean.setNew_xc_yb(data[51]);//医保
				userinfoBean.setNew_xc_ylbx(data[52]);//养老保险
				userinfoBean.setNew_xc_sybx(data[53]);//失业保险
				userinfoBean.setNew_xc_gjj(data[54]);//公积金
				userinfoBean.setNew_xc_cb(data[55]);//补扣
				//data[56]扣款合计不存
				//data[57]实发合计不存
				
				directoryDao.updateUserinfo(userinfoBean, heTongBean, conn);
				cggxNumber ++;
			}
			DbManager.closeTransactionConnection(conn, true);
		} catch (Exception e) {
			LOG.error(e.getMessage());
			DbManager.closeTransactionConnection(conn, false);
		}
		outStr = outStr + "成功更新" + cggxNumber + "条记录<br>";
		return outStr;
	}
	
	
	public static void main(String[] args) throws Exception{
		//new DirectoryExcelToData().importExcelToData("D:\\WorkSpace\\xtbg-tjy\\creatorepp\\ccapp\\oa\\directory\\excel\\tmp\\1394358420265.xlsx");
		//new DirectoryExcelToData().exportExcelToData("3,4".split(","));
		File testFile = new File("D:/WorkSpace/xtbg-tjy/creatorepp/ccapp/oa/directory/excel/tmp/1394419886765.xls");
		testFile.delete();
	}
}
