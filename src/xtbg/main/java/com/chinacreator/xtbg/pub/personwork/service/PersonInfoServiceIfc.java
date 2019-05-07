package com.chinacreator.xtbg.pub.personwork.service;

public interface PersonInfoServiceIfc {
	
	/**
	 * 保存人员信息
	 * @param baseinfoJson
	 * @param phoneVOList
	 * @param foxVOList
	 * @param emailVOList
	 * @param qqVOList
	 * @param birthVOList
	 * @param companyVOList
	 * @param positionVOList
	 * @param addressVOList
	 * @param websiteVOList
	 * @return 人员主键
	 * @throws Exception
	 */
	public String savePersonInfo(String baseinfoJson,String phoneVOList,
			String foxVOList,String emailVOList,String qqVOList,String birthVOList,
			String companyVOList,String positionVOList,String addressVOList,String websiteVOList)throws Exception;
	
	/**
	 * 删除人员信息
	 * @param personids
	 * @throws Exception
	 */
	public void deletePersonInfo(String personids,String userid,String directoryids) throws Exception;
	
	/**
	 * 保存人员分组信息
	 * @param personids
	 * @param groupids
	 * @throws Exception
	 */
	public void savePersonGroupInfo(String personids,String groupids) throws Exception;
}
