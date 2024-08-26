package kr.ac.kopo.com;

import java.util.ArrayList;
import java.util.List;

import lombok.Getter;
import lombok.Setter;

public class Pagination {
	
	
	//처음에 설정해주어야 하는 값
	//내가 현재 보고 있는 페이지 번호
	private int currentPage = 1;		
	
	//내가 보고 있는 한 페이지 당 출력될 게시물의 갯수
	private int recordPerPage = 5; 	
	
	//전체 게시물이 몇 개가 있는지
	private float total;		
	
	//페이지 리스트에 게시되는 페이지 건수, 
	//페이지를 나눠서 출력할 건데 몇개를 출력할건지 (1~5 6~10 같은거) 
	private int pageSize = 5;
	
	//검색
	private int searchKey;
	private String searchValue;
	
	public String getQuery() {
		String query="";
		
		if(searchKey > 0) {
			query += "&searchKey=" + searchKey + "&searchValue=" + searchValue;
		}
		
		return query;
	}

	
	public int getSearchKey() {
		return searchKey;
	}
	public void setSearchKey(int searchKey) {
		this.searchKey = searchKey;
	}


	public String getSearchValue() {
		return searchValue;
	}
	public void setSearchValue(String searchValue) {
		this.searchValue = searchValue;
	}





	public int getCurrentPage() {
		return currentPage;
	}
	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}

	public int getRecordPerPage() {
		return recordPerPage;
	}
	public void setRecordPerPage(int recordPerPage) {
		this.recordPerPage = recordPerPage;
	}

	public float getTotal() {
		return total;
	}
	public void setTotal(float total) {
		this.total = total;
	}

	public int getPageSize() {
		return pageSize;
	}
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}



	//마지막 페이지
	//전체 게시글과 페이지당 출력 게시글의 수가 있으면 계산할 수 있다 = 페이지의 개수 
	//반올림 하면 해결
	public int getLastPage() {
		return (int) Math.ceil(total / recordPerPage);
	}
	
	public int getOffset() {
		return (getCurrentPage() - 1) * getRecordPerPage();
	}

		
	// 페이지 그룹의 가장 첫 번호 (이전 페이지)
	// 1~5, 6~10, 11~15 라면 1, 6, 11과 같이 나눈 페이지 쪽수의 첫번호를 계산 
	// 현재 3페이지를 보고 있고, 페이지 건수로 나눈 몫은 확정적으로 페이지가 확보됨 , (ex 3 / 5 = (int) 0)
	// 0, 1, 2, 3.. 과 같은 몫에 따라서 페이지 건수를 곱해주면, (1~5 = 1, 6~10 = 2 ...) 
	// 해당 값에 따라서 1~5, 6~10, 11~15...  5, 10, 15가 되고 그에 따른 첫 번호니까 +1을 해주는거 
	// 보고 있는 페이지가 페이지 건수와 똑같을 경우 나누면 1이 나오니까 -1을 해줌 (5페이지까지면 1~5페이지만 나와야하니까..) 
	public int getPrev() {
		//현재 페이지에서 -1을 해서 몫이 정확하게 1, 2, 3으로 떨어지는 경우를 방지 
		//페이지 그룹 단위로 나누어서 몫을 구하고, 이전 페이지라서 -1을 진행
		int prev = (((getCurrentPage() - 1 ) / getPageSize()) - 1)  * pageSize + 1;
		int first = 1; //가장 첫페이지
		
		return currentPage <= pageSize ? first : prev;
	}

	
	//다음 페이지
	//1~5, 6~10, 11~15 라면 각각 현재 페이지 그룹 다음의 6, 11, 16 등을 계산
	//현재 페이지에서 -1을 해서 몫이 정확하게 1, 2, 3으로 떨어지는 경우를 방지 
	//페이지 그룹 단위로 나누어서 몫을 구하고, 다음 페이지라서 +1을 진행
	public int getNext() {
		int next = (((getCurrentPage() - 1 ) / getPageSize()) + 1)  * pageSize + 1; 
		int last = getLastPage(); //가장 마지막 페이지 
	return next < last ? next : last;
	}

	
	// 화면에 표시할 페이지 번호의 리스트 
	public List<Integer> getList() {
		List<Integer> list = new ArrayList<Integer>();
			
		int startPage = (((currentPage - 1 ) / pageSize) + 0)  * pageSize + 1; //현재그룹의 첫번째 페이지값
			
		for (int i = startPage ; i < (startPage + pageSize) && i <= getLastPage(); i++) {
			list.add(i);
		}
		return list;
	}	
}


