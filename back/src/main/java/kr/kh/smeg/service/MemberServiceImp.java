package kr.kh.smeg.service;

import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import kr.kh.smeg.dao.MemberDAO;
import kr.kh.smeg.model.dto.FindIdDTO;
import kr.kh.smeg.model.dto.LoginDTO;
import kr.kh.smeg.model.vo.MemberVO;

@Service
public class MemberServiceImp implements MemberService {
	@Autowired
	MemberDAO memberDao;
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	
	@Autowired
	private JavaMailSender mailSender;
	
	//String null 체크와 길이가 0인지 체크
	public boolean checkString(String str) {
		return str!=null && str.length() !=0;
	}

	@Override
	public boolean signup(MemberVO member) {
		member.merge_date();
		member.merge_email();
		
		if(	!checkString(member.getMe_address()) 			||
			!checkString(member.getMe_gender()) 			||
			!checkString(member.getMe_id()) 				||
			!checkString(member.getMe_name()) 				||
			!checkString(member.getMe_phone()) 				||
			!checkString(member.getMe_pw()) 				||
			!checkString(member.getMe_address()) 			||
			!checkString(member.getYear()) 					||
			!checkString(member.getMonth()) 				||
			!checkString(member.getDay()) 					||
			!checkString(member.getMe_birth())				||
			!checkString(member.getMe_calendar()) 			||
			!checkString(member.getMe_detail_address()) 	||
			!checkString(member.getMe_email()) 				||
			!checkString(member.getFirst_email()) 			||
			!checkString(member.getSecond_email()) 			||
			member.getMe_postcode()==0) {
					
			return false;	
		}	
		
		//중복 체크
		MemberVO user = memberDao.selectMember(member.getMe_id());
		
		if(user!=null) {
			return false;
		}
		
		if(member.getMe_pw() == null || member.getMe_pw().length() == 0) {
			return false;
		}
		
		String encodePw = passwordEncoder.encode(member.getMe_pw());
		
		member.setMe_pw(encodePw);
		
		return memberDao.insertMember(member);
	}

	@Override
	public boolean idCheck(String id) {
		MemberVO member = memberDao.selectMember(id);
		
		//member에 있는 아이디와 비교했을 떄 아이디가 null인 것 
		//즉 중복 검사를 했을때 쓸 수 있는 아이디
		return member == null;
	}

	@Override
	public MemberVO login(LoginDTO loginDTO) {
		//로그인 dto: id와 pw를 가져온 상태
		
		//비교해야 될 부분-> id가 null인지 체크
		if(loginDTO.getMe_id() == null) {
			return null;
		}
		
		//id가 null이 아닌 경우 MemberVO 객체에서 memberService에서 select문으로 가져온 것으로 ->mapper에서 select문으로 가져온 id와 일치하는지 체크
		MemberVO user = memberDao.selectMember(loginDTO.getMe_id());
			
		//user가 null
		if(user == null) {
			return null;
		}
		
		//일치한다면 loginDTO에서 가져온 비밀번호와 MemberVO 객체가 일치하는지 체크하고 
		if(passwordEncoder.matches(loginDTO.getMe_pw(), user.getMe_pw())) {
			return user;
		}
			
		//일치하면 이 값을 return memberService에게 보내준다.
		return null;
	}

	@Override
	public MemberVO findID(FindIdDTO findid) {
		if(findid.getMe_name() == null || findid.getMe_email() == null) {
			return null;
		}
		
		MemberVO member = memberDao.findID(findid);
		
		// 데이터베이스에서 조회한 결과가 null인지 검사
	    if (member == null || member.getMe_name() == null || member.getMe_email() == null) {
	        return null;
	    }

		return member;
	}

	@Override
	public boolean findPw(String id, String email) {
		//회원의 정보를 가져옴
			MemberVO member = memberDao.selectMember(id);
			if(member == null) {
				return false;
			}
			
			//이메일도 맞게 처리가 되어야 함
			if(!member.getMe_email().equals(email)) {
				return false;
			}
			//임시 새 비밀번호를 생성 - 8자리로 설정
			String newPw = randomPassword(8);
			
			//이메일을 전송
			String title = "새 비밀번호입니다.";
			String content = "새 비밀번호는 <b>"+ newPw +"</b> 입니다.";
			boolean res = mailSend(member.getMe_email(), title, content);
			
			//임시 새 비밀번호를 암호화해서 DB에 저장
			String encPw = passwordEncoder.encode(newPw);
			memberDao.updatePassword(id, encPw);
			return res;
	}

	//임시 새 비밀번호를 생성
	private String randomPassword(int size) {
		int min = 0, max = 26 + 26 + 10 + 3 - 1;
		String newPw = "";
		while(newPw.length() < size) {
			int r = (int)(Math.random() * (max-min + 1) + min);
			//r:0~9 => 숫자 0~9
			if(r < 10) {
				newPw += r;
			}
			//r:10~35 => a~z
			else if(r < 36) {
				newPw += (char)('a' + r - 10);
			}
			//r:36~61 => A-Z
			else if(r < 62) {
				newPw += (char)('A' + r - 36);
			}
			//r:62 => !
			else if(r == 62) {
				newPw += '!';
			}
			//r:63 => @
			else if(r == 63) {
				newPw += '@';
			}
			//r:64 => #
			else if(r == 64) {
				newPw += '#';
			}
		}
		return newPw;
	}
	
	//이메일 보내는 메서드
	public boolean mailSend(String to, String title, String content) {

		String setfrom = "sgj00700@gmail.com";
		   try{
		        MimeMessage message = mailSender.createMimeMessage();
		        MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
		
				messageHelper.setFrom(setfrom);// 보내는사람 생략하거나 하면 정상작동을 안함
				messageHelper.setTo(to);// 받는사람 이메일
				messageHelper.setSubject(title);// 메일제목은 생략이 가능하다
				messageHelper.setText(content, true);// 메일 내용
		
		    mailSender.send(message);
		    return true;
		} catch(Exception e){
		    e.printStackTrace();
		    return false;
		}
	}

	@Override
	public void updateMemberCookie(MemberVO user) {
		if(user == null)
			return;
		memberDao.updateMemberCookie(user);
	}

	@Override
	public MemberVO getMemberByCookie(String sessionId) {
		return memberDao.selectMemberByCookie(sessionId);
	}

	//마이페이지 개인정보 수정관련
	//개인정보수정 시 유저 비밀번호 체크
	@Override
	public MemberVO getuserinfo(MemberVO member,String me_pw) {
		if(	member == null || 
			member.getMe_id() == null || 
			member.getMe_pw() == null)
			return null;
		MemberVO user = memberDao.selectMember(member.getMe_id()); 
		// 228 가져온 MemberVO member는 세션에서 아이디 값을 넣은 객체
		// 233 MemberVO user는 아이디가 있는지 확인하는 작업을 거치고 user에 넣어준 것
		if(user == null)
				return null;
		//비번확인
		//String encPw = passwordEncoder.encode(me_pw); 이거는 암호화된 비밀번호를 또 암호화하는 코드라 필요없음.
		
		if(passwordEncoder.matches(me_pw,user.getMe_pw())) {
			return user;
		}
		return null;
	}

	//회원정보 수정
	@Override
	public boolean updateMember(MemberVO member, MemberVO user) {
		if(member == null || user == null) {
			return false;
		}
		member.merge_date();
		member.merge_email();
		if(!checkString(member.getMe_email())) {
			return false;
		}
		
		//비번을 변경하는 경우
		if(checkString(member.getMe_pw())) {
			String encPw = passwordEncoder.encode(member.getMe_pw());
			member.setMe_pw(encPw);
		}else {
			//비번을 변경하지 않는 경우
			member.setMe_pw(user.getMe_pw());
			
		}
		
		//로그인한 회원 아이디로 아이디를 설정
		member.setMe_id(user.getMe_id());
		boolean res = memberDao.updateMember(member);
		if(!res) {
			return false;
		}
		//세션에 회원 정보를 업데이트하기 위해 작업
		user.setMe_pw(member.getMe_pw());
		user.setMe_phone(member.getMe_phone());
		return true;
	}

	/* 카카오 로그인관련 */
	@Override
	public boolean idCheck(String sns, String id) {
		try {
			int num = Integer.parseInt(id);
			num = num * 2;
			id = sns + "!" + num;
		}catch(Exception e) {
			id = sns + "!" + id;
		}
		MemberVO user = memberDao.selectMember(id);
		System.out.println(id);
		return user != null;
	}

	@Override
	public boolean signupSns(String sns, String id, String pw) {
		try {
			int num = Integer.parseInt(id);
			num = num * 2;
			id = sns + "!" + num;
		}catch(Exception e) {
			id = sns + "!" + id;
		}
		
		//비번 0000인코딩처리
		String encPw = passwordEncoder.encode(pw);
		
		MemberVO memberVO = new MemberVO(id, encPw);
		return memberDao.insertMember(memberVO);
	}

	@Override
	public MemberVO loginSns(String sns, String id) {
		try {
			int num = Integer.parseInt(id);
			num = num * 2;
			id = sns + "!" + num;
		}catch(Exception e) {
			id = sns + "!" + id;
		}
		return memberDao.selectMember(id);
	}

	
}
