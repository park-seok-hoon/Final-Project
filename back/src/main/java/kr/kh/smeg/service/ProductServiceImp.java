package kr.kh.smeg.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kh.smeg.dao.ProductDAO;
import kr.kh.smeg.model.vo.CategoryVO;
import kr.kh.smeg.model.vo.GroupVO;
import kr.kh.smeg.model.vo.OrderVO;
import kr.kh.smeg.model.vo.OrderlistVO;
import kr.kh.smeg.model.vo.ProductVO;
import kr.kh.smeg.pagination.Criteria;
import kr.kh.smeg.pagination.ProductCriteria;

@Service
public class ProductServiceImp implements ProductService {
	@Autowired
	ProductDAO productDao;
	
	//문자열 체크
	private boolean checkString(String str) {
		return str != null && str.length() != 0;
	}

	@Override
	public CategoryVO getCategoryByCaNum(int ca_num) {
		return productDao.selectCategoryByCaNum(ca_num);
	}

	@Override
	public GroupVO getGroupByCaGrNum(int ca_gr_num) {
		return productDao.selectGroupByCaGrNum(ca_gr_num);
	}

	@Override
	public CategoryVO getCategoryByGroupMin(int ca_gr_num) {
		return productDao.selectCategoryByGroupMin(ca_gr_num);
	}

	@Override
	public ArrayList<GroupVO> getGrouplist() {
		return productDao.selectGrouplist();
	}

	@Override
	public ArrayList<CategoryVO> getCategoriesByGroupNum(String gr_num) {
		return productDao.selectCategoriesByGroupNum(gr_num);
	}

	@Override
	public ArrayList<ProductVO> getproductList(ProductCriteria cri) {
		if(cri == null)
			cri = new ProductCriteria();
		return productDao.selectProductList(cri);
	}

	@Override
	public int getTotalCount(ProductCriteria cri) {
		return productDao.selectProductTotalCount(cri);
	}

	@Override
	public ProductVO getProductCode(String pr_code) {
		return productDao.selectProductCode(pr_code);
	}

	//장바구니 담기
	@Override
	public boolean insertBasket(String ba_amount, String me_id, String pr_code) {
		if(!checkString(ba_amount) || !checkString(me_id) || !checkString(pr_code)) {
			return false;
		}
		
		return productDao.insertBasket(ba_amount, me_id, pr_code);
	}
	

	@Override
	public boolean insertOrder(String me_id, int or_total_price) {
		if(!checkString(me_id)) {
			return false;
		}
		return productDao.insertOrder(me_id, or_total_price);
	}

	@Override
	public OrderVO getOrderById(String me_id) {
		return productDao.selectOrderById(me_id);
	}

	@Override
	public boolean insertOrderlist(int or_num, String pr_code, String ba_amount) {
		if(!checkString(ba_amount) || !checkString(pr_code)) {
			return false;
		}
		return productDao.insertOrderlist(or_num, pr_code, ba_amount);
	}

	@Override
	public ArrayList<ProductVO> getproductListByName(ProductCriteria cri) {
		if(cri == null)
			cri = new ProductCriteria();
		
		return productDao.selectproductListByName(cri);
	}

	@Override
	public int getTotalCountByName(ProductCriteria cri) {
		return productDao.selectTotalCountByName(cri);
	}

	

	
}
