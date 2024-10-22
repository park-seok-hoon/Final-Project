# 제품 그룹 데이터 처리 - SPECIAL, BIG PRODUCT, SMALL PRODUCT 
insert into `group`(gr_name) values("SPECIAL");
insert into `group`(gr_name) values("BIG PRODUCT");
insert into `group`(gr_name) values("SMALL PRODUCT");

# 제품 그룹 - SPECIAL = 1, BIG PRODUCT = 2, SMALL PRODUCT = 3
insert into category(ca_gr_num, ca_name, ca_explain) values(1, "D&G", "이탈리아의 대표적인 두 브랜드 스메그(SMEG)와 돌체앤가바나(D&G)가 만들어낸 콜라보레이션은<br>서로의 철학과 예술적인 감성을 결합하여 가전 그 이상의 가치를 선사합니다.");
insert into category(ca_gr_num, ca_name, ca_explain) values(1, "FIAT", "이탈리아 자동차 브랜드 피아트(FIAT)와 콜라보레이션 프로젝트를 통해 탄생한 제품으로<br>피아트의 대표 소형차 친퀘첸토(FIAT500)를 냉장고로 디자인한 모델입니다.");
insert into category(ca_gr_num, ca_name, ca_explain) values(1, "DISNEY", "전 세계 많은 사람들이 사랑하는 디즈니 대표 캐릭터, 미키마우스.<br>미키마우스 탄생 90주년을 기념하여 제작된 한정판 드로잉 FAB28이 성능 개선된 리뉴얼 버전으로 새롭게 선보입니다");
insert into category(ca_gr_num, ca_name, ca_explain) values(1, "COCACOLA", "시간이 흘러도 변함 없이 사랑받는 클래식, 아이코닉한 아이템으로 대표되는 두 브랜드의 만남.<br>스메그의 50’S RETRO 스타일 디자인과 코카콜라를 상징하는 레드 컬러로 CLASSIC & ICONINC을 보여줍니다.");
insert into category(ca_gr_num, ca_name, ca_explain) values(2, "냉장고", "스메그의 냉장고는 주방의 따뜻함과 친밀함을 스메그만의 감각으로 재현한 디자인입니다.<br>시대를 초월한 디자인으로 고전적이고 우아한 주방을 완성하는 스메그의 냉장고를 만나보세요.");
insert into category(ca_gr_num, ca_name, ca_explain) values(2, "와인셀러", "115병의 와인을 보관할 수 있으며, 수납 방법에 따라 최대 198병까지 보관 가능합니다.<br>넉넉한 용량으로 다양한 종류의 와인을 이상적인 환경에 오래도록 보관할 수 있습니다.");
insert into category(ca_gr_num, ca_name, ca_explain) values(2, "식기세척기", "플라네타리움(PLANETARIUM)은 원형 지지대와 세척 날개의 혁신적인 역방향 더블 모션,<br>회전 속도 65RPM의 회전력을 바탕으로 전작 대비 60% 증가된 소비 효율과 세척력을 보여줍니다.");
insert into category(ca_gr_num, ca_name, ca_explain) values(2, "오븐/인덕션", "세계적인 건축가 구이도 카날리(Guido Canali)와의 협업으로 탄생한 스메그 클래식 라인은 스틸 소재를 활용한 세련된 디자인이 특징입니다.<br>스틸 소재와 블랙 글라스로 완성된 오븐 전면과 인덕션은 어떤 주방 가구와도 잘 어우러지며 깔끔하고 세련된 공간 분위기를 연출합니다.");
insert into category(ca_gr_num, ca_name, ca_explain) values(3, "전기포트", "스메그 온도조절 전기포트는 공간 인테리어의 가치를 높이고 멋을 더해 주기 위해 설계되었습니다.<br>부드러운 곡선의 레트로 라인 FAB 냉장고를 모티브로 디자인되어 제품의 컬러와 소재가 다양합니다.");
insert into category(ca_gr_num, ca_name, ca_explain) values(3, "토스트기", "스메그 온도조절 전기포트는 공간 인테리어의 가치를 높이고 멋을 더해 주기 위해 설계되었습니다.<br>부드러운 곡선의 레트로 라인 FAB 냉장고를 모티브로 디자인되어 제품의 컬러와 소재가 다양합니다. ");
insert into category(ca_gr_num, ca_name, ca_explain) values(3, "믹서기", "800W 모터의 강력한 블렌딩, 원터치 프로그램과 자동세척 모드로 더 편리해진 기능,<br>100% Tritan 소재 컨테이너로 안전성과 독보적인 스타일리시함. 스메그 프리미엄 블렌더 BLF03를 경험해보세요.");

# 제품 상태 - 판매중, 품절
insert into product_state value("판매중");
insert into product_state value("품절");

# 공지사항 카테고리 - 신제품, 안내, 매장, 이슈
insert into noticecategory(nc_name) value("신제품");
insert into noticecategory(nc_name) value("안내");
insert into noticecategory(nc_name) value("매장");
insert into noticecategory(nc_name) value("이슈");