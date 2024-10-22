<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
<link rel="stylesheet" href="<c:url value="/resources/css/detail.css"/>">
<script src="<c:url value="/resources/js/sub.js"/>"></script>
<script src="<c:url value="/resources/js/detail.js"/>"></script>
</head>
<body>
	 <!-- header스타일 달라서 스크립트 header_view.jsp에 처리 -->
	 <div class="main-contents">
	 	 <div class="product-top">
	 	 	<div class="slide-wrap">
                <div class="swiper">
                    <div class="swiper-wrapper">
                    	<!-- 이미지 크기때문에 CSS 수정 -->
                    	<c:forEach items="${product.slidelist}" var="slide">
                    		<div class="swiper-slide"><img src="<c:url value="/download${slide.sp_name}"/>" alt="제품슬라이드이미지" width='285'></div>
                    	</c:forEach>
                    </div>
                    <div class="swiper-pagination"></div>
                </div>
            </div>
            <div class="text-wrap">
                <h2>${product.pr_name}</h2>
                <p class="product-code">${product.pr_code}</p>
                <div class="count-box">
                    <p class="title-text">수량</p>
                    <div class="btn-wrap">
                        <button type="button" class="plus-btn">+</button>
                        <span class="count">1</span>
                        <button type="button" class="minus-btn">-</button>
                    </div>
                </div>
                <div class="delivery-box">
                    <p class="title-text">배송</p>
                    <p class="content-text">무료</p>
                </div>
                <p class="price">${product.pr_price}</p>
                <ul class="btn">
                    <!--주소는 jsp에서 처리할것-->
                    <li>
                    	<a href="#" class="btn-hover btn-purchase">바로구매</a>
                    </li>
                    <li>
                    	<a href="#" class="btn-hover btn-basket">장바구니담기</a>
                    </li>
                </ul>
            </div>
	 	 </div>
	 	 <div class="detail-nav">
            <div class="inner-wrap">
                <h4>제품보기 메뉴</h4>
                <ul>
                    <li><a href="#">제품상세</a></li>
                    <li><a href="#">상품정보 고시</a></li>
                    <li><a href="#">배송안내</a></li>
                    <li><a href="#">교환/반품/취소 안내</a></li>
                    <li><a href="#">A/S 안내</a></li>
                </ul>
            </div>
        </div>
        <div class="detail-info">
            <div class="product-detail">
                <div class="text-wrap">
                    <h2>${product.pr_name}</h2>
                    <p>
                    	${product.pr_explain}
                    </p>
                </div>
                <div class="img-wrap">
                    <img src="<c:url value="/download${product.pr_pic}"/>" alt="디테일이미지">
                </div>
            </div>
            <div class="product-notification">
                <h3>상품 정보 고시</h3>
                <ul class="list">
                    <li>
                        <h4>품명 및 모델명</h4>
                        <p>${product.pr_code}</p>
                    </li>
                    <li>
                        <h4>KC 인증 필 유무</h4>
                        <p>${product.pr_kc}</p>
                    </li>
                    <li>
                        <h4>정격전압, 소비전력</h4>
                        <p>${product.pr_elec}</p>
                    </li>
                    <li>
                        <h4>에너지소비효율등급</h4>
                        <p>해당없음</p>
                    </li>
                    <li>
                        <h4>동일모델의 출시년월</h4>
                        <p>${product.pr_date}</p>
                    </li>
                    <li>
                        <h4>제조자, 수입품의 경우 수입자를 함께 표기</h4>
                        <p>${product.pr_maker}</p>
                    </li>
                    <li>
                        <h4>제조국</h4>
                        <p>${product.pr_nation}</p>
                    </li>
                    <li>
                        <h4>크기, 용량, 형태</h4>
                        <p>${product.pr_size}</p>
                    </li>
                    <li>
                        <h4>품질보증기준</h4>
                        <p>${product.pr_guarantee}</p>
                    </li>
                    <li>
                        <h4>A/S 책임자와 전화번호</h4>
                        <p>${product.pr_AS}</p>
                    </li>
                    <li>
                        <h4>추가설치비용</h4>
                        <p>${product.pr_extraprice}</p>
                    </li>
                </ul>
            </div>
            <div class="product-delivery">
                <h3>배송안내</h3>
                <ul>
                    <li>주문 제작/예약 상품의 배송은 (온라인) 상품페이지, (오프라인) 구매 계약서에 안내된 내용을 참고해 주시기 바랍니다.</li>
                    <li>예약/주문 상품이 아닌 일반 상품은 구매일로부터 6개월이내 제품 수령이 진행되며 고객 사정에 의해 수령 연장이 필요한 경우 해당 주문을 취소하시고 신규 주문으로 진행하셔야 합니다.</li>
                    <li>온라인 구매의 경우 당사 임의 취소 처리 될수 있으며 신규 주문시 이전 구매 조건은 적용되지 않습니다.</li>
                    <li>상업용 오븐, 냉장고, 식기세척기등 직접 배송 상품과 함께 동시 주문하는 소형가전, 액세서리 상품은 택배 배송 상품으로 먼저 택배 출고됩니다.</li>
                </ul>
                <ol>
                    <li>
                        직접 배송 상품
                        <ul>
                            <li>결제 완료일로부터 영업일 기준 2~15일 이내에 배송됩니다. 단, 주말/공휴일/도서산간지역은 배송 불가하며 제주/강원 영동 월 1~2회 지정일에 배송됩니다.</li>
                            <li>배송일은 배송 날짜가 정해진 후 담당 부서에서 해피 콜로 안내해 드리며 가상 전화번호로 주문 시 연락이 안 될 수 있으니 실제 전화번호로 주문해 주시기 바랍니다.</li>
                            <li>고객의 귀책사유(배송지/수령자 오기재, 연락 두절, 설치환경 미흡)로 재배송 시 배송비가 발생할 수 있습니다.</li>
                            <li>배송 일정을 미리 확인하고 싶으신 경우, 결제일로부터 2일 이후에 고객센터로 1:1문의하시면 안내받으실 수 있습니다.</li>
                            <li>배송시간은 월~금(10:00~16:30) 사이 고객님 댁내에 도착함을 원칙으로 하며 배송 당일 기후 및 교통상황에 따라 배송이 지연될 수 있습니다.</li>
                            <li>엘리베이터가 없는 2층 이상의 고층 또는 배송, 설치 현장의 특수 상황에 따라 사다리차를 사용하며 사다리차 비용은 당사가 부담합니다.</li>
                            <li>이사 및 인테리어 등으로 인한 제품 이전, 제품 이동은 당사에서 진행하지 않습니다. 단, 당사의 이전 서비스 가능한 상품 및 지역은 유상 서비스로 진행합니다.</li>
                            <li>기존에 사용하던 폐가전은 별도로 수거하지 않으며, 타제품의 이동 및 재설치를 진행하지 않습니다. (일부 상품 제외)</li>
                            <li>폐가전 배출 문의: 한국 전자제품 자원순환 공제조합(tel. 1599-0903)</li>
                            <li>빌트인/업소용/세척, 세탁 제품의 경우 설치 환경에 따라 추가 비용이 발생할 수 있으며, 설치 상품은 설치할 공간이 확보되고 인테리어 작업이 모두 완료된 상태에서 배송이 진행됩니다.</li>
                            <li>포장 박스 상태로 설치 위치까지 진입이 불가한 경우 진입로에서 제품 박스를 개봉하고 이동할 수 있습니다.</li>
                            <li>안전사고 발생 가능성이 있거나 제품이 정상 작동할 수 없는 곳은 설치가 불가합니다. (ex. 제품 설치 장소의 주/야간 온도가 10도 이하인 경우 설치 불가)</li>
                            <li>비정상적인 공간에 고객이 임의로 설치하거나 제품을 이동하여 발생하는 제품 오작동, 고장, 파손은 고객 귀책사유에 해당됩니다.</li>
                            <li>당사 배송 상황에 따라 협력사인 로지스올(주), 라운INT에서 배송 됩니다.</li>
                        </ul>
                    </li>
                    <li>
                        택배배송 상품
                        <ul>
                            <li>결제 완료일로부터 영업일 기준 2~7일(결제 후 순차 출고, 공휴일 및 주말 제외) 이내 배송됩니다. 정확한 배송일자는 택배사의 사정에 따라 변동될 수 있습니다.</li>
                            <li>고객의 귀책사유(배송지/수령자 오기재, 연락 두절, 설치환경 미흡)로 재배송 시 배송비가 발생할 수 있습니다.</li>
                            <li>주문 시 연락받으실 전화번호를 정확히 기재해 주셔야 택배사의 배송 안내 메시지를 받으실 수 있습니다. (가상 전화번호 불가)</li>
                        </ul>
                    </li>
                </ol>
            </div>
            <div class="product-cancel">
                <h3>교환/반품/취소 안내</h3>
                <h4>교환/반품/취소</h4>
                <ol>
                    <li>
                        직접 배송 상품
                        <ul>
                            <li>단순 변심에 의한 교환/반품은 설치 후 미사용 제품에 한 해 배송 직원이 떠나기 전에 가능하며 배송비, 사다리차 비용 등을 포함한 반품/교환 비용은 고객 부담이며 설치 환경 원상 복구는 불가합니다.</li>
                            <li>대리 수령 또는 고객의 현장 부재로 인해 전화 및 문자 등을 이용해 제품 설치를 진행한 경우 제품 인수를 완료한 것으로 합니다.</li>
                        </ul>
                    </li>
                    <li>
                        택배 상품
                        <ul>
                            <li>단순 변심에 의한 교환/반품은 택배 도착 10일 내에 미사용 제품에 한 해 가능합니다.</li>
                        </ul>
                    </li>
                    <li>
                        매장 현장 수령 상품
                        <ul>
                            <li>매장에서 제품 확인 후 수령한 경우 단순 변심에 의한 교환/반품은 불가합니다.</li>
                            <li>매장에서 제품 확인을 하지 않고 단순 수령한 경우 수령일로부터 10일 내에 미사용 제품에 한 해 가능합니다.</li>
                        </ul>
                    </li>
                    <li>
                        공통
                        <ul>
                            <li>단순 변심 기준 외의 교환/반품은 상품의 하자 시에만 가능합니다.</li>
                            <li>단, 구매한 제품이 불량 등으로 재고가 품절되어 대체 재고가 없는 경우 배송이 지연되거나 환불 처리 될 수 있으며 이러한 경우 별도의 보상은 불가합니다.</li>
                            <li>교환/반품 시 설치 환경 원상 복구는 불가합니다.</li>
                            <li>반품/교환 시 고객의 귀책사유로 인해 수거가 지연될 경우에는 반품/교환이 제한될 수 있습니다.</li>
                            <li>제품의 제작 과정에서 스웰 마크, 홀로그램 현상, 작은 점, 미세 스크래치, 비닐 자국, 찍힘, 이격, 단차 등이 발생할 수 있으며 이로 인한 교환, 환불은 불가합니다.</li>
                            <li>가격 변동으로 인한 반품 및 가격 보상은 불가합니다.</li>
                            <li>제품의 수입/제작 과정 중에 발생할 수 있는 입고 지연, 배송일정 변경 등으로 인한 보상은 불가합니다.</li>
                            <li>사은품의 경우도 제품과 동일한 기준이 적용됩니다.</li>
                            <li>구매처에 따라 2개 이상 동시구매 할인등 프로모션 혜택이 적용된 경우 교환/반품/취소 규정에 해당되어 일부 상품만 반품이 필요할 경우 구매처별 단품 판매 가격으로 먼저 재결제해주셔야 하며 재결제 이후 전체 환불로 진행됩니다.<br>※당사 교환/반품/취소 규정에 해당 되지 않을 경우 반품은 불가합니다</li>
                            <li>교환의 경우, 교환/반품비 결제 및 교환 상품이 당사에 입고된 후 교환된 상품으로 재배송해 드립니다.</li>
                            <li>반품의 경우, 교환/반품비 결제 및 반품 상품이 당사에 입고되면 결제가 취소됩니다.</li>
                            <li>신용카드로 결제한 경우 결제 취소가 승인되면 PG사 및 카드사 정책에 따라 환불까지 영업일 기준 3~7일 정도 소요될 수 있습니다.</li>
                            <li>무통장 결제의 경우 환불 승인 후 반품 신청 시 남겨주신 계좌를 통해 당사 영업일 기준 3~5일 내에 환불이 진행되며 환불 계좌 정보가 구매자 정보와 상이한 경우 지연될 수 있습니다.</li>
                            <li>교환/반품비 안내</li>
                        </ul>
                    </li>
                </ol>
                <table class="table01">
                    <thead>
                        <tr>
                            <th>구분</th>
                            <th>교환/반품비</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>택배(일반) : 중형 제외 소형가전 및 쿡웨어</td>
                            <td>10,000원</td>
                        </tr>
                        <tr>
                            <td>택배(중형) : 반죽기, 반자동커피머신, 전자동커피머신, 4구 토스터</td>
                            <td>13,000원</td>
                        </tr>
                        <tr>
                            <td>택배(소형) : 원두, 액세서리, 기프트</td>
                            <td>9,000원</td>
                        </tr>
                        <tr>
                            <td>택배(대형) : 오븐랙, 스텐랙</td>
                            <td>
                                60,000원/30,000원<br>
                                (당사 화물배송으로 처리할 경우 100,000원)
                            </td>
                        </tr>
                        <tr>
                            <td>직접 배송</td>
                            <td>
                                200,000원 (설치환경 원상복구 불가)<br>
                                사다리차 등 부대 비용 별도 청구
                            </td>
                        </tr>
                    </tbody>
                </table>
                <h4>교환/반품 불가 사유 (상품 하자 시 제외)</h4>
                <ul>
                    <li>택배 상품 : 택배 도착 10일이 지났거나 제품을 사용한 경우</li>
                    <li>직접 배송 상품 : 제품 설치 후 배송 직원이 떠나기 전 교환/반품 의사를 밝히지 않은 경우</li>
                    <li>재판매가 불가할 정도로 상품의 가치가 감소한 경우 (전원 인가 등의 제품 사용, 포장 누락/훼손 등)</li>
                    <li>제품 회수 시 구성품 및 사은품이 누락된 경우</li>
                    <li>고객의 과실로 제품이 멸실 또는 파손 및 훼손된 경우</li>
                    <li>예약 주문 된 상품인 경우</li>
                    <li>할인이 적용된 전시/리퍼브 제품의 내/외관에 생긴 이색, 흠집 등으로 인한 경우</li>
                    <li>제품 설치 후, 혹은 사용 중 파손되거나 흠집 및 기타 외형상의 문제가 발생한 경우 (깨짐, 스크래치, 얼룩, 색상 침전, 패임 등)</li>
                    <li>상품 사용 시 사용 설명에 기재된 주의사항을 지키지 않은 경우</li>
                    <li>그 밖에 제품 구매 시 사전 안내되거나 동의한 사항일 경우</li>
                    <li>기타 ‘전자상거래 등에서의 소비자 보호에 관한 법률’ 소비자 기본법에 따른 ‘소비자 분쟁 해결 기준’이 정하는 소비자 청약철회 제한에 해당되는 경우</li>
                </ul>
            </div>
            <div class="product-as">
                <h3>A/S 안내</h3>
                <ul>
                    <li>정상적인 사용 중에 발생한 성능/기능상 하자 상품에 의한 반품, 교환, A/S, 환불, 품질보증 및 피해 보상 등에 관한 사항은 소비자 분쟁 해결기준에 따라 진행됩니다.</li>
                    <li>무상 품질보증기간 : 1년</li>
                    <li>제품별 무상 A/S기간<br>
                        - 업소용 가전(푸드서비스 오븐 및 식기세척기), 와인셀러 : 2년<br>
                        - 상기 제품 외 모든 제품 : 1년
                    </li>
                </ul>
                <table class="table02">
                    <tbody>
                        <tr>
                            <td>수령 후 10일 이내</td>
                            <td colspan="2">교환 또는 반품</td>
                        </tr>
                        <tr>
                            <td>수령 후 1개월 이내</td>
                            <td colspan="2">교환 또는 무상수리</td>
                        </tr>
                        <tr>
                            <td rowspan="6">수령 후 1개월 이내</td>
                            <td>하자 발생시</td>
                            <td>무상 수리</td>
                        </tr>
                        <tr>
                            <td>수리 불가능시</td>
                            <td>교환 또는 반품</td>
                        </tr>
                        <tr>
                            <td>교환 불가능시</td>
                            <td>반품</td>
                        </tr>
                        <tr>
                            <td>교환된 제품이 1개월 내에 중대한 수리를 요할 때</td>
                            <td>반품</td>
                        </tr>
                        <tr>
                            <td>동일하자에 대해 2회까지 수리하였으나 동일 증상이 재발생시</td>
                            <td>교환 또는 반품</td>
                        </tr>
                        <tr>
                            <td>여러 부위에 대해 4회까지 수리하였으나 동일 증상이 재발생시</td>
                            <td>교환 또는 반품</td>
                        </tr>
                        <tr>
                            <td>수령 후 1년~2년 이내 (무상 AS 2년 해당 제품)</td>
                            <td>하자 발생시</td>
                            <td>무상 수리</td>
                        </tr>
                        <tr>
                            <td rowspan="2">무상 AS기간 이후</td>
                            <td>하자 발생시</td>
                            <td>유상 수리</td>
                        </tr>
                        <tr>
                            <td>유상 수리하였으나 1개월 이내 동일 부위 재고장시</td>
                            <td>무상 수리</td>
                        </tr>
                    </tbody>
                </table>
                <ul>
                    <li>고객의 과실로 인한 A/S는 1년 이내일 경우에도 유상 수리됩니다.</li>
                    <li>무상 A/S 2년 제품 중 무상 품질보증기간 1년 경과 시 출장비 부과됩니다.</li>
                    <li>푸드서비스 오븐 및 식기세척기 외의 제품은 일반 가정용으로 제작되었기에 영업용, 상업용으로 사용할 경우 무상 품질 보증 기간이 적용되지 않을 수 있습니다. (중요 부품 포함)</li>
                    <li>유상 수리의 경우, 상품과 수리 종류에 따라 출장비/공임비/부품비가 발생합니다.</li>
                    <li>A/S 신청은 스메그 코리아 공식몰에서 온라인으로 가능하며 신청 시 제품의 S/N 와 구매 이력을 확인하고 있습니다. 수리 제품에 S/N 스티커가 없거나 접수된 SN 번호와 다른 제품인 경우 수리를 진행하지 않고 출장비가 발생됩니다. (공식 판매점 제품이 아닌 경우 A/S 불가)</li>
                    <li>A/S 신청이 진행되면 직영 또는 협력사 센터 통해 수리가 진행됩니다. 단, 공휴일은 제외되며 부품이 품절인 경우 해당 부품 수급이 될 때까지 수리가 불가할 수 있습니다.</li>
                </ul>

                <ol class="as">
                    <li>
                        소형가전, 홈카페 상품 AS 진행 안내<br>
                        가. 스메그코리아 공식몰 온라인으로 AS 신청 후 센터 방문으로 진행됩니다.<br>
                        나. 제품 수령 날짜, 모델명, 시리얼 번호, 고장 증상 확인 후 스메그코리아 공식몰 A/S 신청 → 센터 방문 안내 알림톡 수령 → AS 신청 제품 가지고 센터 방문 진행
                    </li>
                    <li>
                        대형가전, 빌트인, 푸드서비스(전문가용) , 후드, 와인셀러 상품 진행 안내<br>
                        가. 스메그코리아 공식몰 온라인으로 AS 신청 후 기사 방문으로 진행됩니다.<br>
                        나. 제품 수령 날짜, 모델명, 시리얼 번호, 고장 증상을 확인하시고 공식몰 A/S 신청 → A/S 센터에서 접수 내용 확인 → 우선 상담 및 방문 일정 안내
                    </li>
                    <li>AS 신청 페이지에서 상세 내용을 확인하실 수 있습니다.
                    </li>
                </ol>
            </div>
        </div>
	 </div>
	 
	 <!-- 로그인 정보에 따라 경고창 처리 -->
	 <script type="text/javascript">
	 	//장바구니버튼
	 	$('.btn-basket').click(function(e){
	 		//기본이벤트제거 - 주소 이동안되게 처리
	 		e.preventDefault();
	 		
	 		let loginUrl = '<c:url value="/topnav/login" />';
	 		
	 		//로그인이 안되면 로그인 페이지로 이동
	 		if(${user == null}){
	 			let q = confirm('로그인을 해야 가능합니다. 로그인하시겠습니까?');
	 			if(q){
	 				location.href = loginUrl;
	 			}
	 		}
	 		
	 		//로그인은 했으나 ADMIN이면
	 		if(${user != null} && ${user.me_authority == "ADMIN"}){
	 			alert('관리자는 구매할 수 없습니다.');
	 			return false;
	 		}
	 		
	 		//제품의 상태가 품절인 경우
	 		if(${product.pr_ps_state == "품절"}){
	 			alert('죄송합니다. 현재 상품은 품절입니다.');
	 			return false;
	 		}
	 		
	 		//로그인은 했으나 USER이면
	 		if(${user != null} && ${user.me_authority == "USER"}){
	 			let prCode = '${product.pr_code}';
	 			let baAmount = $('.count-box .count').text();
	 			let url = `<c:url value="/product/basket?pr_code=\${prCode}&ba_amount=\${baAmount}" />`;
	 			
	
	 			//해당 주소로 넘김
	 			location.href = url;
	 		}
	 	});
	 	
	 	//바로구매버튼
	 	$('.btn-purchase').click(function(e){
	 		//기본이벤트제거 - 주소 이동안되게 처리
	 		e.preventDefault();
	 		
	 		let loginUrl = '<c:url value="/topnav/login" />';
	 		
	 		//로그인이 안되면 로그인 페이지로 이동
	 		if(${user == null}){
	 			let q = confirm('로그인을 해야 가능합니다. 로그인하시겠습니까?');
	 			if(q){
	 				location.href = loginUrl;
	 			}
	 		}
	 		
	 		//로그인은 했으나 ADMIN이면
	 		if(${user != null} && ${user.me_authority == "ADMIN"}){
	 			alert('관리자는 구매할 수 없습니다.');
	 			return false;
	 		}
	 		
	 		
	 		//제품의 상태가 품절인 경우
	 		if(${product.pr_ps_state == "품절"}){
	 			alert('죄송합니다. 현재 상품은 품절입니다.');
	 			return false;
	 		}
	 		
	 		//카카오로 로그인한 경우 개인정보 수정페이지로 보냄
	 		if(${user != null} && ${user.me_email == null}){
	 			let q = confirm('카카오로그인한 경우 구매를 할수 없습니다. 개인정보 페이지로 이동하시겠습니까?');
	 			
	 			let url = `<c:url value="/mypage/personal_info" />`;
	 			if(q){
	 				//해당 주소로 넘김
		 			location.href = url;
	 			}
	 			return false;
	 		}
	 		
	 		//로그인은 했으나 USER이면
	 		if(${user != null} && ${user.me_authority == "USER"}){
	 			let prCode = '${product.pr_code}';
	 			let baAmount = $('.count-box .count').text();
	 			let url = `<c:url value="/product/purchase?pr_code=\${prCode}&ba_amount=\${baAmount}" />`;
	 			
	
	 			//해당 주소로 넘김
	 			location.href = url;
	 		}
	 	});
	 </script>
</body>
</html>