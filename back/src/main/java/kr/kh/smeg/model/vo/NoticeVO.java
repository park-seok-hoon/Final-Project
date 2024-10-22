package kr.kh.smeg.model.vo;

import java.util.ArrayList;
import java.util.Date;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class NoticeVO {
	private int no_num;
	private String no_title;
	private String no_content;
	private Date no_date;
	private int no_view;
	private String no_me_id;
	private int no_nc_num;
	private String no_nc_name; //매퍼로 조인하면서 만들었기 때문에 VO에 추가해야 함
	
	private ArrayList<FileVO> filelist; //rusultmap으로 조인하기 위해 생성 - 메인페이지용
	
	//썸머노트 가져오는코드
	public String getNo_content_html() {
		if(no_content == null || no_content == "") {
			return null;
		}
		Document content = Jsoup.parse(no_content);
		String noticeContent = content.text();

		if(noticeContent.length() > 200) {
			//substring은 string의 문자열을 반환하는 메서드라 0글자부터 200글자로 제한함을 의미.
			return noticeContent.substring(0,200);
		}
		return noticeContent;
	}
	
	//문자열만 가져오는 코드라 이미지를 가져오지 못해서 추가로 이미지 가져오는 코드 
	public String getContentImg() {
		Document content = Jsoup.parse(no_content); //jsoup으로 파싱한 content
		Elements elements = content.getElementsByTag("img"); //img
		
		if(!elements.isEmpty()) { //이미지가 하나 이상 있으면
			Element el = elements.get(0); //첫 번째 이미지 가져오기
			//메인 화면 너비가 285이고 높이는 어떻게 할지 몰라서 비율에 맞춰서 출력되도록 작업
			el.attr("style", "width: 285px; height : auto;");
			return el.toString();
		}
		//이미지가 없는 경우
		return "<img src='/smeg/resources/images/admin/noimage.png'>";
	} 
}
