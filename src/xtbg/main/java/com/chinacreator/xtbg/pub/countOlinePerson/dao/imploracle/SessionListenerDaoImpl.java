package com.chinacreator.xtbg.pub.countOlinePerson.dao.imploracle;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import com.chinacreator.xtbg.pub.common.PagingBean;
import com.chinacreator.xtbg.pub.countOlinePerson.dao.SessionListenerDao;
import com.chinacreator.xtbg.pub.countOlinePerson.entity.CountOnlineBean;
import com.chinacreator.xtbg.pub.countOlinePerson.entity.LoginUserbean;
import com.frameworkset.common.poolman.PreparedDBUtil;

public class SessionListenerDaoImpl implements SessionListenerDao {

	//保存和更新登录信息
		@Override
		public void saveLoginInfo(CountOnlineBean cOnlineBean, String state)throws Exception{
			PreparedDBUtil pdb=new PreparedDBUtil();
			StringBuffer sql=new StringBuffer();
			//state为0表示保存，state为1表示更新
			if("0".equals(state)){
				sql.append(" insert into ta_oa_countolineperson");
				sql.append(" (id, username, userid, login_time, out_time, login_ip ,sessionid)");
				sql.append(" values");
				sql.append(" (seq_countolineperson.nextval,");
				sql.append(" ?,");
				sql.append(" ?,");
				sql.append(" to_date('"+cOnlineBean.getLogin_time()+"','yyyy-MM-dd HH24:mi:ss') ,");
				sql.append(" ?, ");
				sql.append(" ?,");
				sql.append(" ?)");
				pdb.preparedInsert(sql.toString());
				int i=1;
				pdb.setString(i++, cOnlineBean.getUsername());
				pdb.setString(i++, cOnlineBean.getUserid());
				//pdb.setString(i++, cOnlineBean.getLogin_time());
				pdb.setString(i++, cOnlineBean.getOut_time());
				pdb.setString(i++, cOnlineBean.getLogin_ip());
				pdb.setString(i++, cOnlineBean.getSessionid());
			}else if("1".equals(state)){
				sql.append(" update ta_oa_countolineperson c");
				sql.append(" set out_time = to_date('"+cOnlineBean.getOut_time()+"','yyyy-MM-dd HH24:mi:ss') ");
				sql.append(" where c.sessionid = ? ");
				sql.append(" and c.out_time is null ");
				int i=1;
				pdb.preparedUpdate(sql.toString());
				pdb.setString(i++, cOnlineBean.getSessionid());
			}
			pdb.executePrepared();
			
		}

		//保存最高人数
		@Override
		public void saveTopInfo(String num)throws Exception {
			PreparedDBUtil pdb=new PreparedDBUtil();
			StringBuffer sql=new StringBuffer();
			sql.append(" insert into ta_oa_onlinetop");
			sql.append(" (id, personnum, time)");
			sql.append(" values");
			sql.append(" (seq_onlinetop.nextval, ?, sysdate)");
			pdb.preparedInsert(sql.toString());
			int i=1;
			pdb.setString(i++, num);
			pdb.executePrepared();
		}

		//查询最高人数
		@Override
		public String queryTop()throws Exception {
			PreparedDBUtil pdb=new PreparedDBUtil();
			StringBuffer sql=new StringBuffer();
			String top="";
			sql.append("select max(to_number(p.personnum)) personnum  from ta_oa_onlinetop p ");
			pdb.preparedSelect(sql.toString());
			pdb.executePrepared();
			for (int i = 0; i < pdb.size(); i++) {
				top=pdb.getString(i, "personnum");
			}
			return top;
		}
		
		//查询人员登录信息
		@Override
		public String queryPsersonInfo(String username) throws Exception{
			PreparedDBUtil pdb=new PreparedDBUtil();
			StringBuffer sql=new StringBuffer();
			sql.append(" select to_char(i.lastlogin,'yyyy-mm-dd hh24:mi:ss') lastlogin,i.loginnumber,i.lastloginip from TA_OA_USERLOGININFO i ");
			sql.append(" where username='"+username+"'");
			String info="2013-04-02 17:30,1,127.0.0.1";
			pdb.preparedSelect(sql.toString());
			pdb.executePrepared();
			for (int i = 0; i < pdb.size(); i++) {
				String date=pdb.getString(i, "lastlogin");
				String logins=pdb.getString(i, "loginnumber");
				String ip=pdb.getString(i, "lastloginip");
				info= date+","+logins+","+ip;
			}
			return info;
		}

		@Override
		public PagingBean findloginsList(Set<Object> listset,LoginUserbean params,
				String sortName, String sortOrder, long offset, int maxPagesize)throws Exception{
			PagingBean pb = new PagingBean();
			PreparedDBUtil pdb=new PreparedDBUtil();
			StringBuffer sql=new StringBuffer();
			List<LoginUserbean> ulist=new ArrayList<LoginUserbean>();
			String usernames=",";
			for (Iterator iterator = listset.iterator(); iterator.hasNext();) {
				usernames+=(String)iterator.next()+",";
			}
			//查询当前用户单位中的所有人
			sql.append(" select u.user_id,u.user_realname,u.user_name,ou.org_id,orgg.org_name ");
			sql.append(" ,to_char(lo.lastlogin,'yyyy-mm-dd hh24:mi') login_time ");
			sql.append(" from td_sm_user u inner join td_sm_orguser ou");
			sql.append(" on to_char(u.user_id)=ou.user_id");
			sql.append(" left join td_sm_organization orgg");
			sql.append(" on ou.org_id=orgg.org_id");
			sql.append(" left join ta_oa_userlogininfo lo on u.user_id=lo.userid ");
			sql.append(" where instr(',"+usernames+",',','||u.user_name||',')>0 ");
			sql.append(" order by orgg.org_sn asc,u.user_sn asc  ");
			try {
					pdb.preparedSelect(sql.toString());
					pdb.executePrepared();
					for (int i = 0; i < pdb.size(); i++) {
						if(usernames.indexOf(","+pdb.getString(i, "user_name")+",")>-1){
							LoginUserbean loginUserbean=new LoginUserbean();
							loginUserbean.setUserid(pdb.getString(i,"user_id"));
							loginUserbean.setUsername(pdb.getString(i,"user_name"));
							loginUserbean.setUserRealName(pdb.getString(i,"user_realname"));
							loginUserbean.setOrgid(pdb.getString(i,"org_id"));
							loginUserbean.setOrg(pdb.getString(i, "org_name"));
							loginUserbean.setLoginTime(pdb.getString(i, "login_time"));
							ulist.add(loginUserbean);
						}
					}
			} catch (SQLException e) {
				e.printStackTrace();
			}
			pb.setList(ulist);
			pb.setRecords((long) ulist.size());
			return pb;
		}
		//按用户保存登录次数和最后登录时间及退出时间
		@Override
		public void saveUserLoginInfo(CountOnlineBean cOnlineBean)
				throws Exception {
			PreparedDBUtil pdb=new PreparedDBUtil();
			StringBuffer sql=new StringBuffer();
			sql.append(" insert into TA_OA_USERLOGININFO");
			sql.append(" values('"+cOnlineBean.getUsername()+"',");
			sql.append(" (select user_id from td_sm_user where user_name = '"+cOnlineBean.getUsername()+"'),");
			sql.append(" ('1'),sysdate,'','"+cOnlineBean.getLogin_ip()+"','')");
			try {
				pdb.preparedInsert(sql.toString());
				pdb.executePrepared();
			} catch (Exception e) {
				e.printStackTrace();
				throw e;
			}
			
		}

		//更新用户登录时间和ip地址及登录次数
		@Override
		public void updateLoginInfo(CountOnlineBean cOnlineBean,String state)
				throws Exception {
			PreparedDBUtil pdb=new PreparedDBUtil();
			StringBuffer sql=new StringBuffer();
			//0表示登录时候的更新,1表示退出时的更新
			if("0"==state){
				sql.append(" update TA_OA_USERLOGININFO i");
				sql.append(" set i.loginnumber = (select loginnumber+1 ");
				sql.append("              from TA_OA_USERLOGININFO");
				sql.append("             where username = '"+cOnlineBean.getUsername()+"'),");
				sql.append(" i.lastlogin   = sysdate,");
				sql.append(" i.lastloginip = '"+cOnlineBean.getLogin_ip()+"'");
				sql.append(" where i.username='"+cOnlineBean.getUsername()+"'");
			}else{
				sql.append("  update TA_OA_USERLOGININFO i");
				sql.append("  set i.lastout=sysdate   "); 
			}
			try {
				pdb.preparedUpdate(sql.toString());
				pdb.executePrepared();
			} catch (Exception e) {
				e.printStackTrace();
				throw e;
			}
		}
		////查询用户是否已有记录
		@Override
		public boolean queryUser(CountOnlineBean cOnlineBean) throws Exception {
			PreparedDBUtil pdb=new PreparedDBUtil();
			StringBuffer sql=new StringBuffer();
			boolean flag=true;
			sql.append(" select * from TA_OA_USERLOGININFO");
			sql.append(" where username='"+cOnlineBean.getUsername()+"'");
			try {
				pdb.preparedSelect(sql.toString());
				pdb.executePrepared();
				if(pdb.size()>0){
					flag=false;
				}
			} catch (Exception e) {
				e.printStackTrace();
				throw e;
			}
			return flag;
		}


	}