package kr.kh.smeg.model.vo;

import java.util.Date;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class MemberVO {
    private String me_id;
    private String me_pw;
    private String me_gender;
    private String me_birth;
    private String me_email;
    private String me_authority;
    private String me_address;
    private String me_phone;
    private String me_name;
    private int me_postcode;
    private String me_cookie;        // 자동 로그인을 위한 DB에 변수 추가
    private Date me_cookie_limit;    // 자동 로그인을 위한 DB에 변수 추가
    private boolean autoLogin;    // 자동 로그인

    // 년,월,일 name 일치시키는 변수 ->me_birth에 합침
    private String year;
    private String month;
    private String day;

    // 양력인지 음력인지 받는 변수
    private String me_calendar;

    // 상세 주소
    private String me_detail_address;

    // 이메일 처음 부분, 뒷 부분
    private String first_email;
    private String second_email;

    // 생년월일 부분 따로 가져오기 : 개인정보 수정위해서
    private String useryear;
    private String usermonth;
    private String userday;

    public void merge_date() {
        me_birth = year + "-" + month + "-" + day;
        // 개인정보 수정 시 사용하기 위해 다시 설정
        useryear = year;
        usermonth = month;
        userday = day;
    }

    // 개인정보 수정시 사용되는 메서드
    public void merge_date_for_update() {
        me_birth = year + "-" + month + "-" + day;
    }

    // 개인정보 수정시 따로 설정하는 메서드 추가
    public void setBirthDateForUpdate() {
        this.year = getUseryear();
        this.month = getUsermonth();
        this.day = getUserday();
    }

    public void merge_email() {
        me_email = first_email + "@" + second_email;
    }

    // 개인정보 수정시 추가해야 얻어올 수 있음
    public String getFirst_email() {
        if (me_email == null || !me_email.contains("@")) {
            return "";
        }
        int index = me_email.indexOf("@");
        return me_email.substring(0, index);
    }

    public String getSecond_email() {
        if (me_email == null || !me_email.contains("@")) {
            return "";
        }
        int index = me_email.indexOf("@");
        return me_email.substring(index + 1);
    }

    public String getUseryear() {
        if (me_birth != null && me_birth.length() >= 10) {
            return me_birth.substring(0, 4);
        }
        return null;
    }

    public String getUsermonth() {
        if (me_birth != null && me_birth.length() >= 10) {
            String month = me_birth.substring(5, 7);
            if (month.startsWith("0")) {
                month = month.substring(1);
            }
            return month;
        }
        return null;
    }

    public String getUserday() {
        if (me_birth != null && me_birth.length() >= 10) {
            String day = me_birth.substring(8, 10);
            if (day.startsWith("0")) {
                day = day.substring(1);
            }
            return day;
        }
        return null;
    }

    public MemberVO(String id, String pw) {
        this.me_id = id;
        this.me_pw = pw;
    }
}
