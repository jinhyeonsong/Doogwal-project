package com.doogwal.coffee.util;

public class PaginateUtil {
	
	public static String getPaginate(int pageNo,
			                         int total,
			                         int numPage,
			                         int numBlock,
			                         String url,
			                         String param) {
		//현재 페이지 : pageNo
		//전체 게시물수 : total 
		//한 페이지당 게시물수 : numPage
		//한 페이지당 보여질 블록수 : numBlock
		//주소 : url
		//파라미터 : param
		
		//전체 페이지수
		int totalPage = (int)Math.ceil((double)total/numPage);
		
		//System.out.println(totalPage);
		
		//현재 블록
		int nowBlock = (int)Math.ceil((double)pageNo/numBlock);
		
		
		String paginate = 
				"<div class='paginate'>";
		
		if(total!=0) {
			
			//이전버튼
			if(pageNo<=1) {
				//비활성화
				paginate += "<span title=\"이전 페이지 없음\"><i class=\"fa fa-chevron-left\"></i></span>";
			}else {
				//활성화
				paginate += "<a href='"+url+"?"+param+(pageNo-1)+"' title='이전 페이지로'><i class='fa fa-chevron-left'></i><span class='screen_out'>이전 페이지</span></a>";
						
			}//if end
			
			
			for(int i = 1 ; i <= numBlock ; i++) {
				
				//실제 출력 페이지
				int realPage = ((nowBlock-1)*numBlock)+i;
				
				//현재 페이지냐? 아니냐?
				if(realPage==pageNo) {
					//현재 페이지
					paginate += "<strong title='현재 "+pageNo+"페이지'>"+pageNo+"</strong>";
					
				}else {
					//현재 페이지가 아님
					paginate += "<a href='"+url+"?"+param+realPage+"' title='"+realPage+"'>"+realPage+"</a>";
					
					
				}//if ~ else end
				
				if(realPage==totalPage) {
					break;
				}//if end
				
			}//for end(블록 만들기)
			
			//다음버튼
			if(pageNo >= totalPage) {
				//비활성화
				paginate+="<span title='다음 페이지 없음'><i class='fa fa-chevron-right'></i></span>";
			}else {
				//활성화
				paginate+="<a href='"+url+"?"+param+(pageNo+1)+"' title='다음 페이지로'><i class='fa fa-chevron-right'></i><span class='screen_out'>다음 페이지</span></a>";
			}//if end
			
		}//if end
		
		paginate+= "</div>";
		
		return paginate;
	}
	
	public String getPaginate(int pageNo, int total, int numPage, int numBlock, String url) {
		//현재 페이지 : pageNo
		//전체 게시물수 : total 
		//한 페이지당 게시물수 : numPage
		//한 페이지당 보여질 블록수 : numBlock
		//주소 : url

		//전체 페이지수
				int totalPage = (int) Math.ceil((double) total / numPage);

		//System.out.println(totalPage);

		//현재 블록
				int nowBlock = (int) Math.ceil((double) pageNo / numBlock);

				String paginate = "<div class='paginate'>";

				if (total != 0) {

		//이전버튼
					if (pageNo <= 1) {
		//비활성화
						paginate += "<span title=\"이전 페이지 없음\"><i class=\"fa fa-chevron-left\"></i></span>";
					} else {
		//활성화
						paginate += "<a href='" + url + "/page/" + (pageNo - 1) + "' data-no='" + (pageNo - 1)
								+ "' title='이전 페이지로'><i class='fa fa-chevron-left'></i><span class='screen_out'>이전 페이지</span></a>";

					} // if end

					for (int i = 1; i <= numBlock; i++) {

		//실제 출력 페이지
						int realPage = ((nowBlock - 1) * numBlock) + i;

		//현재 페이지냐? 아니냐?
						if (realPage == pageNo) {
		//현재 페이지
							paginate += "<strong title='현재 " + pageNo + "페이지'>" + pageNo + "</strong>";

						} else {
		//현재 페이지가 아님
							paginate += "<a data-no='" + realPage + "' href='" + url + "/page/" + realPage + "' title='"
									+ realPage + "'>" + realPage + "</a>";

						} // if ~ else end

						if (realPage == totalPage) {
							break;
						} // if end

					} // for end(블록 만들기)

		//다음버튼
					if (pageNo >= totalPage) {
		//비활성화
						paginate += "<span title='다음 페이지 없음'><i class='fa fa-chevron-right'></i></span>";
					} else {
		//활성화
						paginate += "<a href='" + url + "/page/" + (pageNo + 1) + "' data-no='" + (pageNo + 1)
								+ "' title='다음 페이지로'><i class='fa fa-chevron-right'></i><span class='screen_out'>다음 페이지</span></a>";
					} // if end

				} // if end

				paginate += "</div>";

				return paginate;
			}

}
