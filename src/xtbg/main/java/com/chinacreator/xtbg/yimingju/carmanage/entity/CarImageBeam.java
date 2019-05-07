package com.chinacreator.xtbg.yimingju.carmanage.entity;
/**
 * 车辆照片附件表
 * @author haiyun
 *
 */
public class CarImageBeam {
	private String image_id; //主键
	private String image_parth; //路径
	private String image_yewu_id; //附件ID
	public String getImage_id() {
		return image_id;
	}
	public void setImage_id(String image_id) {
		this.image_id = image_id;
	}
	public String getImage_parth() {
		return image_parth;
	}
	public void setImage_parth(String image_parth) {
		this.image_parth = image_parth;
	}
	public String getImage_yewu_id() {
		return image_yewu_id;
	}
	public void setImage_yewu_id(String image_yewu_id) {
		this.image_yewu_id = image_yewu_id;
	}
	
}
