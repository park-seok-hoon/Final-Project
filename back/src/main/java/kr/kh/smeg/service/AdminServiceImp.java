package kr.kh.smeg.service;

import java.util.ArrayList;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.kh.smeg.dao.AdminDAO;
import kr.kh.smeg.model.vo.CategoryVO;
import kr.kh.smeg.model.vo.GroupVO;
import kr.kh.smeg.model.vo.MemberVO;
import kr.kh.smeg.model.vo.OrderStateVO;
import kr.kh.smeg.model.vo.OrderVO;
import kr.kh.smeg.model.vo.ProductVO;
import kr.kh.smeg.model.vo.Slide_picsVO;
import kr.kh.smeg.pagination.Criteria;
import kr.kh.smeg.utils.UploadFileUtils;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class AdminServiceImp implements AdminService {
	@Autowired
	AdminDAO adminDao;
	@Resource
	String uploadPath;

	@Override
	public ArrayList<GroupVO> getGroupList() {
		return adminDao.selectGroupList();	//그룹 리스트 가져옴;
	}

	@Override
	public ArrayList<CategoryVO> getCategoriesByGroupNum(String gr_num) {
		return adminDao.selectCategoriesByGroupNum(gr_num);
	}

	@Override
	public boolean codeCheck(String code) {
		ProductVO product = adminDao.selectProduct(code);
		
		//member에 있는 아이디와 비교했을 떄 아이디가 null인 것 
		//즉 중복 검사를 했을때 쓸 수 있는 아이디
		return product == null;
	}
	
	//슬라이드 파일 여러개라 업로드 처리해줄 메서드
	private void uploadFile(String sp_pr_code, MultipartFile file) {
		
		try {
			String originalFileName = file.getOriginalFilename();
			//파일명이 없으면
			if(originalFileName.length() == 0) {
				return;
			}
			//서버에 업로드 후 업로드한 파일명을 가져옴
			String fileName = 
				UploadFileUtils.uploadFile(uploadPath, originalFileName,file.getBytes());
			//Slide_picsVO 개체를 생성
			Slide_picsVO slideVo = new Slide_picsVO(sp_pr_code, fileName, originalFileName);
			//DB에 추가
			adminDao.insertSlidePictures(slideVo);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	//서버에서 삭제 - 파일 여러개라 메서드 따로 처리 : 추후 상품삭제에서 쓸것
	private void deleteFile(Slide_picsVO slide) {
		if(slide == null) {
			return;
		}
		//서버에서 삭제
		UploadFileUtils.deleteFile(uploadPath, slide.getSp_name());
		//DB에서 삭제
		adminDao.deleteSlidePictures(slide.getSp_num());
	}
	//수정할 때 삭제하기 - 해당 번호 알아야 함
	private void deleteFile2(Slide_picsVO slide, int sp_num) {
		if(slide == null) {
			return;
		}
		//서버에서 삭제
		UploadFileUtils.deleteFile(uploadPath, slide.getSp_name());
		//DB에서 삭제
		adminDao.deleteSlidePicture(slide.getSp_pr_code(), sp_num);
	}

	@Override
	public boolean insertProduct(ProductVO product, MultipartFile[] slide_pictures, MultipartFile file_detail) {
		if(product == null)
			return false;
		
		//상품 코드가 중복된다면 null처리
		ProductVO productDupCheck = adminDao.selectProduct(product.getPr_code());
		
		if(productDupCheck!=null)
			return false;
		
		//file_detail 서버에 업로드 후 파일명 가져오기
		String pr_pic;
		try {
			pr_pic = UploadFileUtils.uploadFile(uploadPath, file_detail.getOriginalFilename(), file_detail.getBytes());		
			product.setPr_pic(pr_pic);
			
			//원래 파일명 추가
			product.setPr_pic_ori_name(file_detail.getOriginalFilename());
		} catch (Exception e) {
			System.out.println("제품 상세 이미지 업로드 실패");
			e.printStackTrace();
		}
		
		//가져온 파일명을 product의 상세이미지에 추가
		boolean res= adminDao.insertProduct(product);

		if(!res)
			return false;
		
		
		if(slide_pictures == null || slide_pictures.length == 0)
			return false;
		
		//slide_pics을 서버에 업로드하고, slide_pics테이블에 추가하도록 작업 배열로 저장해야 됨.
		for(MultipartFile file : slide_pictures) {
			uploadFile(product.getPr_code(), file);
		
		}
		
		return res;
	}

	@Override
	public ArrayList<ProductVO> getProductList(Criteria cri) {
		if(cri == null) {
			cri = new Criteria(1,5);
		}
		return adminDao.selectProductList(cri);
	}

	@Override
	public int getProductTotalCount(Criteria cri) {
		if(cri == null) {
			cri = new Criteria(1,5);
		}
		return adminDao.selectProductTotalCount(cri);
	}

	@Override
	public ProductVO getProductByPrCode(String pr_code) {
		if(pr_code == null) {
			return null;
		}
		return adminDao.selectProductByPrCode(pr_code);
	}

	@Override
	public boolean updateProduct(ProductVO product, MultipartFile[] slide_pictures, MultipartFile file_detail, String[] slide_pictures_value, String file_detail_value) {
		//기존 DB의 이미지 정보 불러오기
		ProductVO dbProduct = adminDao.selectProductByPrCode(product.getPr_code());
		
		//상품 수정전에 기존 상품 이미지의 이미지명과 file_detail_value가 같지 않으면 디테일이미지도 삭제 후 업데이트
		String dbname = dbProduct.getPr_pic_ori_name();
		if(!dbname.equals(file_detail_value)) {
			//서버에서 삭제
			UploadFileUtils.deleteFile(uploadPath, dbProduct.getPr_pic());
			//이미지관련 데이터를 변경할 것을 처리
			String pr_pic;
			try {
				//새로운 디테일 사진 추가
				pr_pic = UploadFileUtils.uploadFile(uploadPath, file_detail.getOriginalFilename(), file_detail.getBytes());
				product.setPr_pic(pr_pic);
				product.setPr_pic_ori_name(file_detail.getOriginalFilename());
			}catch (Exception e) {
				e.printStackTrace();
			}	
		}else { //바뀌지 않았다는 것은 기존 이미지 값이 비어 있다는 것이라 기존 DB정보로 처리해줘야 함
			product.setPr_pic(dbProduct.getPr_pic());
			product.setPr_pic_ori_name(dbProduct.getPr_pic_ori_name());
		}
		
		//상품 수정
		boolean res = adminDao.updateProduct(product);
		
		if(!res) {
			return false;
		}

		//기존 첨부파일 삭제 및 새로운 파일 추가
		ArrayList<Slide_picsVO> slideList = adminDao.selectSlideList(product.getPr_code());
		//첨부파일 리스트가 있고, 기존 값과 변경이 있다면 반복문으로 명령실행
		if(slideList != null) {
			for(int i = 0; i < slideList.size(); i++) {
			    String dbSpOriName = slideList.get(i).getSp_ori_name();
			    if(!dbSpOriName.equals(slide_pictures_value[i])) {
			    	deleteFile2(slideList.get(i),slideList.get(i).getSp_num());
			    	uploadFile(product.getPr_code(), slide_pictures[i]);
			    }
			}
		}
		
		

		return true;
	}
	
	//상품삭제
	@Override
	public boolean deleteProduct(ArrayList<String> arr) {
	    if (arr == null) {
	        return false;
	    }
	    
	    boolean res = true;
	    
	    for (String pr_code : arr) {
	        // 해당 슬라이드 삭제
	        ArrayList<Slide_picsVO> slideList = adminDao.selectSlidesByProductCode(pr_code);
	        if (slideList != null) {
	            for (Slide_picsVO slide : slideList) {
	                deleteFile(slide);
	            }
	        }

	        // 기존 product 불러옴
	        ProductVO product = adminDao.selectProductByPrCode(pr_code);

	        if (product != null) {
	            // 카테고리와 맞는 첨부파일 삭제
	            UploadFileUtils.deleteFile(uploadPath, product.getPr_pic());

	            // 상품 삭제
	            if (!adminDao.deleteProduct(pr_code)) {
	                // 삭제에 실패하면 res를 false로 설정
	                res = false;
	            }
	        }
	    }
	    return res;
	}
	

	// 카테고리 설명에서 한 줄바꿈을 <br> 태그로 변경하는 메서드
	private String convertLineBreaksTohtml(String text) {
	    // \r\n은 Windows 스타일의 줄바꿈을 나타냄
	    // 따라서 먼저 \r\n을 \n으로 변경하여 통일시킴
	    text = text.replace("\r\n", "\n");
	    // 한 줄바꿈을 <br> 태그로 변경
	    text = text.replace("\n", "<br>");
	    return text;
	}

	//카테고리 등록
	@Override
	public boolean insertCategory(CategoryVO category, MultipartFile category_file_insert) {
		if(category == null)
			return false;
		
		// 카테고리 설명에서 줄바꿈을 <br> 태그로 변경
	    category.setCa_explain(convertLineBreaksTohtml(category.getCa_explain()));

		
		//file_detail 서버에 업로드 후 파일명 가져오기
		String ca_pic_name;
		try {
			ca_pic_name = UploadFileUtils.uploadFile(uploadPath, category_file_insert.getOriginalFilename(), category_file_insert.getBytes());		
			category.setCa_pic_name(ca_pic_name);
			
			//원래 파일명 추가
			category.setCa_pic_ori_name(category_file_insert.getOriginalFilename());
		} catch (Exception e) {
			System.out.println("카테고리 이미지 업로드 실패");
			e.printStackTrace();
		}
		
		//가져온 파일명을 product의 상세이미지에 추가
		boolean res= adminDao.insertCategory(category);
		
		return res;
	}

	//카테고리 업데이트
	@Override
	public boolean updateCategory(CategoryVO category, MultipartFile category_file_update, String past_ca_pic_ori_name) {
		//기존 DB의 카테고리 정보 불러오기
		CategoryVO dbCategory = adminDao.selectCategoryByCaNum(category.getCa_num());
		
		//상품 수정전에 기존 상품 이미지의 이미지명과 file_detail_value가 같지 않으면 디테일이미지도 삭제 후 업데이트
		String dbname = dbCategory.getCa_pic_ori_name();
		
		//카테고리 설명에서 줄바꿈을 <br> 태그로 변경
	    category.setCa_explain(convertLineBreaksTohtml(category.getCa_explain()));
		if( dbname == null || !dbname.equals(past_ca_pic_ori_name)) {
			if(dbname != null && !dbname.equals(past_ca_pic_ori_name)) {
				//서버에서 삭제
				UploadFileUtils.deleteFile(uploadPath, dbCategory.getCa_pic_name());
			}
			//이미지관련 데이터를 변경할 것을 처리
			String pr_pic;
			try {
				//새로운 디테일 사진 추가
				pr_pic = UploadFileUtils.uploadFile(uploadPath, category_file_update.getOriginalFilename(), category_file_update.getBytes());
				category.setCa_pic_name(pr_pic);
				category.setCa_pic_ori_name(category_file_update.getOriginalFilename());
			}catch (Exception e) {
				e.printStackTrace();
			}	
		}else { //바뀌지 않았다는 것은 기존 이미지 값이 비어 있다는 것이라 기존 DB정보로 처리해줘야 함
			category.setCa_pic_name(dbCategory.getCa_pic_name());
			category.setCa_pic_ori_name(dbCategory.getCa_pic_ori_name());
		}
		
		//상품 수정
		boolean res = adminDao.updateCategory(category);
		
		if(!res) {
			return false;
		}
		
		
		return true;
	}

	//카테고리 삭제
	@Override
	public boolean deleteCategory(int caNum) {
		//기존 DB의 카테고리 불러오기
		CategoryVO category = adminDao.selectCategoryByCaNum(caNum);
		
		if(category == null) {
			return false;
		}
		//카테고리와 맞는 첨부파일 삭제
		UploadFileUtils.deleteFile(uploadPath, category.getCa_pic_name());
		
		//삭제시 DB는 모두 삭제되지만(CASCADE때문에) DB상품이지는 삭제가 안됨
		//카테고리에 해당되는 모든 제품리스트를 불러옴
		ArrayList<ProductVO> productlist = adminDao.selectProductByCaNum(caNum);
		
		//해당 슬라이드 리스트 불러오기
		ArrayList<Slide_picsVO> slideList = null;
		
		for(ProductVO product : productlist) {
			slideList = adminDao.selectSlideList(product.getPr_code());
			
			//상세디테일이미지 지워야 함
			//서버에서 삭제
			UploadFileUtils.deleteFile(uploadPath, product.getPr_pic());
			
			//슬라이드 이미지 지우기
			for(Slide_picsVO slide : slideList) {
				deleteFile2(slide,slide.getSp_num());
			}
		}
		
		
		
		//카테고리 삭제
		boolean res = adminDao.deleteCategory(caNum);
		
		if(!res) {
			return false;
		}
		
		
		return true;
	}

	@Override
	public int getOrderCount(Criteria cri) {
		return adminDao.selectOrderCount(cri);
	}

	@Override
	public ArrayList<OrderVO> getOrder(Criteria cri) {
		return adminDao.selectOrder(cri);
	}

	@Override
	public ArrayList<OrderStateVO> getOrderState() {
		return adminDao.selectOrderState();
	}

	@Override
	public boolean orderStateUpdate(ArrayList<String> os_states, ArrayList<Integer> or_nums) {
		if(os_states == null || or_nums == null) {
			return false;
		}
		boolean res = true;
		for(int i=0;i<or_nums.size();i++) {
			if(!adminDao.orderStateUpdate(or_nums.get(i), os_states.get(i))) {
				res = false;
			}
		}
		return res;
	}

	//회원리스트 가져오기 - ADMIN빼고
	@Override
	public ArrayList<MemberVO> getMemberList(Criteria cri) {
		return adminDao.selectMemberList(cri);
	}

	@Override
	public int getMemberTotalCount(Criteria cri) {
		return adminDao.selectMemberTotalCount(cri);
	}

	@Override
	public boolean deleteMemberByChk(ArrayList<String> arr) {
		if(arr == null) {
			return false;
		}
		boolean res = true;
		for(String me_id : arr) {
			//삭제가 실패하면, 브라우저 두 개 faq 2개...
			//나중에 이 기능은 adminInterceptor 추가해서 관리자만 가능하게 수정할 예정
			if(!adminDao.deleteMemberByChk(me_id)) {
				res = false;
			}
		}
		return res;
	}
}
