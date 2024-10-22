package kr.kh.smeg.model.vo;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class FileVO {
	private int fi_num; 
	private int fi_no_num; 
	private String fi_name; 
	private String fi_ori_name;
	
	public FileVO(int fi_no_num, String fi_name, String fi_ori_name) {
		this.fi_no_num = fi_no_num;
		this.fi_name = fi_name;
		this.fi_ori_name = fi_ori_name;
	}
}
