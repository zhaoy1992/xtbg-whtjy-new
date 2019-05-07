package com.chinacreator.sysmgrcore.manager.db;

import java.sql.SQLException;

import com.chinacreator.sysmgrcore.entity.UserAndSn;
import com.frameworkset.common.poolman.PreparedDBUtil;

public class UserAndSnImpl {
	
	//添加
	public void addUserAndSn(UserAndSn userAndSn) throws SQLException{
		try {
			if(null!=userAndSn){
				if(!"是".equals(userAndSn.getNumberOne())){
				userAndSn.setNumberOne("否");
				}
			}
		PreparedDBUtil db = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		int i = 1;
			sql.append("  insert into ta_oa_userandsn ");
			sql.append("  (id, userid, mobile_sn , ");
			sql.append("  directorystate, education, degree, politics, ");
			sql.append("  school,nation,seniority,natives,specialty, ");
			sql.append("  homeadress,joinparttime,worktime,duties,directorylevel ,");
			sql.append("  duty,resume , numberone) ");
			
			sql.append(" values(seq_oa_userandsn.nextval,?,?,?,?, ");
			//sql.append(" ?,?,?,to_date(?,'yyyy-mm-dd hh24:mi:ss'),?, ");
			sql.append(" ?,?,?,?,? ,");
			sql.append(" ?,?,?,to_date(?,'yyyy-mm-dd'),to_date(?,'yyyy-mm-dd'), ");
			sql.append(" ?,?,?,?,? ) ");
			db.preparedInsert(sql.toString());
			db.setString(i++, userAndSn.getUserid());
			db.setString(i++, userAndSn.getMobile_sn());
			db.setString(i++, userAndSn.getDirectorystate());
			db.setString(i++, userAndSn.getEducation());
			db.setString(i++, userAndSn.getDegree());
			db.setString(i++, userAndSn.getPolitics());
			db.setString(i++, userAndSn.getSchool());
			db.setString(i++, userAndSn.getNation());
			db.setString(i++, userAndSn.getSeniority());
			db.setString(i++, userAndSn.getNatives());
			db.setString(i++, userAndSn.getSpecialty());
			db.setString(i++, userAndSn.getHomeadress());
			db.setString(i++, userAndSn.getJoinparttime());
			db.setString(i++, userAndSn.getWorktime());
			db.setString(i++, userAndSn.getDuties());
			db.setString(i++, userAndSn.getDirectorylevel());
			db.setString(i++, userAndSn.getDuty());
			db.setString(i++, userAndSn.getResume());
			db.setString(i++, userAndSn.getNumberOne());
			db.executePrepared();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	//修改
	public void updateUserAndSn(UserAndSn userAndSn) throws SQLException{
		if(null!=userAndSn){
			if(!"是".equals(userAndSn.getNumberOne())){
			userAndSn.setNumberOne("否");
			}
		}
		PreparedDBUtil db = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		int i = 1;
			sql.append("  update ta_oa_userandsn set ");
			sql.append("  mobile_sn =? , ");
			sql.append("  directorystate = ?, education = ?, degree = ?, politics = ?, ");
			sql.append("  school = ?,nation = ?,seniority = ?,natives = ?,specialty = ? , ");
			sql.append("  homeadress = ?,joinparttime = to_date(?,'yyyy-mm-dd'),worktime = to_date(?,'yyyy-mm-dd'),duties = ?,directorylevel = ? ,");
			sql.append("  duty = ?,resume= ?,numberone=?  ");
			sql.append("  where userid= ?  ");
			db.preparedUpdate(sql.toString());
			db.setString(i++, userAndSn.getMobile_sn());
			db.setString(i++, userAndSn.getDirectorystate());
			db.setString(i++, userAndSn.getEducation());
			db.setString(i++, userAndSn.getDegree());
			db.setString(i++, userAndSn.getPolitics());
			db.setString(i++, userAndSn.getSchool());
			db.setString(i++, userAndSn.getNation());
			db.setString(i++, userAndSn.getSeniority());
			db.setString(i++, userAndSn.getNatives());
			db.setString(i++, userAndSn.getSpecialty());
			db.setString(i++, userAndSn.getHomeadress());
			db.setString(i++, userAndSn.getJoinparttime());
			db.setString(i++, userAndSn.getWorktime());
			db.setString(i++, userAndSn.getDuties());
			db.setString(i++, userAndSn.getDirectorylevel());
			db.setString(i++, userAndSn.getDuty());
			db.setString(i++, userAndSn.getResume());
			db.setString(i++, userAndSn.getNumberOne());
			db.setString(i++, userAndSn.getUserid());
			db.executePrepared();
	}
	//根据id查询
	public UserAndSn getUserAndSnById(String userId) throws Exception{
		PreparedDBUtil db = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		UserAndSn userAndSn =  new UserAndSn();;
			sql.append("  select  ");
			sql.append("  id, userid, mobile_sn , ");
			sql.append("  directorystate, education, degree, politics, ");
			sql.append("  school,nation,seniority,natives,specialty, ");
			sql.append("  homeadress,to_char(joinparttime, 'yyyy-mm-dd') as joinparttime,to_char(worktime, 'yyyy-mm-dd') as worktime ,duties,directorylevel ,");
			sql.append("  duty,resume ,numberone");
			sql.append(" from ta_oa_userandsn ");
			sql.append("  where userid = ? ");
			db.preparedSelect(sql.toString());
			db.setString(1, userId);
			db.executePrepared();
			if (db.size()>0){
				
				userAndSn.setId(db.getString(0,"id"));
				userAndSn.setUserid(db.getString(0,"userid"));
				userAndSn.setMobile_sn(db.getString(0,"mobile_sn"));
				userAndSn.setDirectorystate(db.getString(0,"directorystate"));
				userAndSn.setEducation(db.getString(0,"education"));
				userAndSn.setDegree(db.getString(0,"degree"));
				userAndSn.setPolitics(db.getString(0,"politics"));
				userAndSn.setSchool(db.getString(0,"school"));
				userAndSn.setNation(db.getString(0,"nation"));
				userAndSn.setSeniority(db.getString(0,"seniority"));
				userAndSn.setNatives(db.getString(0,"natives"));
				userAndSn.setSpecialty(db.getString(0,"specialty"));
				userAndSn.setHomeadress(db.getString(0,"homeadress"));
				userAndSn.setJoinparttime(db.getString(0,"joinparttime"));
				userAndSn.setWorktime(db.getString(0,"worktime"));
				userAndSn.setDuties(db.getString(0,"duties"));
				userAndSn.setDirectorylevel(db.getString(0,"directorylevel"));
				userAndSn.setDuty(db.getString(0,"duty"));
				userAndSn.setResume(db.getString(0,"resume"));
				userAndSn.setNumberOne(db.getString(0,"numberone"));
			}
			
		return userAndSn;
	}
	
}
