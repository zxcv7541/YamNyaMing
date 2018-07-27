package com.kh.ynm.owner.model.vo;

import java.util.ArrayList;

public class CouponPageData {
	private int startPage;
	private int endPage;
	private ArrayList<CouponEnroll> couponList  = new ArrayList<CouponEnroll>();
	private String pageNavi;
	private int startNavi;
	private int endNavi;
	private int currentPage;
	private int pageTotalCount;
	private int recordTotalCount;
	private int owEntirePk;
	private int storeEntireFk;
	
	public CouponPageData() {}
	public CouponPageData(int startPage, int endPage, ArrayList<CouponEnroll> couponList, String pageNavi,
			int startNavi, int endNavi, int currentPage, int pageTotalCount, int recordTotalCount, int owEntirePk,
			int storeEntireFk) {
		super();
		this.startPage = startPage;
		this.endPage = endPage;
		this.couponList = couponList;
		this.pageNavi = pageNavi;
		this.startNavi = startNavi;
		this.endNavi = endNavi;
		this.currentPage = currentPage;
		this.pageTotalCount = pageTotalCount;
		this.recordTotalCount = recordTotalCount;
		this.owEntirePk = owEntirePk;
		this.storeEntireFk = storeEntireFk;
	}


	public int getOwEntirePk() {
		return owEntirePk;
	}
	public void setOwEntirePk(int owEntirePk) {
		this.owEntirePk = owEntirePk;
	}
	public int getStoreEntireFk() {
		return storeEntireFk;
	}
	public void setStoreEntireFk(int storeEntireFk) {
		this.storeEntireFk = storeEntireFk;
	}
	public int getStartPage() {
		return startPage;
	}

	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}


	public int getEndPage() {
		return endPage;
	}


	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}


	public int getStartNavi() {
		return startNavi;
	}


	public void setStartNavi(int startNavi) {
		this.startNavi = startNavi;
	}


	public int getEndNavi() {
		return endNavi;
	}


	public void setEndNavi(int endNavi) {
		this.endNavi = endNavi;
	}


	public int getCurrentPage() {
		return currentPage;
	}


	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}


	public int getPageTotalCount() {
		return pageTotalCount;
	}


	public void setPageTotalCount(int pageTotalCount) {
		this.pageTotalCount = pageTotalCount;
	}


	public int getRecordTotalCount() {
		return recordTotalCount;
	}


	public void setRecordTotalCount(int recordTotalCount) {
		this.recordTotalCount = recordTotalCount;
	}


	public ArrayList<CouponEnroll> getCouponList() {
		return couponList;
	}
	public void setCouponList(ArrayList<CouponEnroll> noticeList) {
		this.couponList = couponList;
	}
	public String getPageNavi() {
		return pageNavi;
	}
	public void setPageNavi(String pageNavi) {
		this.pageNavi = pageNavi;
	}

//	public CouponPageData pagingList(int currentPage, ManagerSellSearch mss) {
//		Connection conn = JDBCTemplate.getConnection(); //커넥션 객체 생성
//		//Service에서는 2가지 값을 정해야 함
//		//1.한 페이지당 보이는 리스트의 갯수(게시물의 개수) ->10
//		//2.현재 위치를 중심으로 시작 navi에서부터 끝 navi개수-> 5
//		int recordCountPerPage = 10; //1. 1페이지에10개씩보이게
//		int naviCountPerPage = 5; //2.
//
//		//service에서는 DAO에 2가지 요청을 진행해야 함
//		//1.현재 페이지 리스트
//		//2.현재 중심으로 만들어지는 navi리스트 
//		
//		ArrayList<CouponEnroll> list = new ManagerProductDao().getCurrentPage(conn,currentPage,recordCountPerPage);
//		String pageNavi = new ManagerProductDao().getPageNavi(conn,currentPage,recordCountPerPage,naviCountPerPage,mss);
//		
//		CouponPageData cpd = null;
//		if(!list.isEmpty() && !pageNavi.isEmpty())
//		{
//			cpd = new CouponPageData();
//			cpd.setCouponList(list);
//			cpd.setPageNavi(pageNavi);
//		}
//		JDBCTemplate.close(conn);
//		return pd;
//	}
}
