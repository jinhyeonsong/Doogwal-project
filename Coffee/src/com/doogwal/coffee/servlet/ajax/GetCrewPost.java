package com.doogwal.coffee.servlet.ajax;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.doogwal.coffee.dao.CrewMembersDAO;
import com.doogwal.coffee.dao.CrewPostsDAO;
import com.doogwal.coffee.dao.LikesDAO;
import com.doogwal.coffee.dao.PostImgsDAO;
import com.doogwal.coffee.dao.RepliesDAO;
import com.doogwal.coffee.vo.CrewMember;
import com.doogwal.coffee.vo.CrewPost;
import com.doogwal.coffee.vo.Like;
import com.doogwal.coffee.vo.PageVO;
import com.doogwal.coffee.vo.PostImg;
import com.doogwal.coffee.vo.Reply;
import com.fasterxml.jackson.databind.ObjectMapper;

@WebServlet("/ajax/getCrewPost.json")
public class GetCrewPost extends HttpServlet{
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		resp.setContentType("application/json; charset=UTF-8");

		PrintWriter out = resp.getWriter();
		
		String crewNoStr = req.getParameter("crewNo");
		String crewMemberNoStr = req.getParameter("crewMemberNo");
		String startStr = req.getParameter("start");
		String endStr = req.getParameter("end");
		String boardNoStr = req.getParameter("boardNo");
		//String userCrewsStr = req.getParameter("userCrews");
		
		int crewNo = Integer.parseInt(crewNoStr);
		int myMemberNo = Integer.parseInt(crewMemberNoStr);
		int start = Integer.parseInt(startStr);
		int end = Integer.parseInt(endStr);
		int boardNo = Integer.parseInt(boardNoStr);
		//int userCrews = Integer.parseInt(userCrewsStr);
		
		PageVO page = new PageVO(start, end, crewNo);	
		Map<String, Object> pageVO = new HashMap<String, Object>();
		pageVO.put("boardNo", boardNo);
		pageVO.put("start", page.getStart());
		pageVO.put("end", page.getEnd());
		pageVO.put("crewNo", crewNo);
		
		List<CrewPost> list = CrewPostsDAO.selectPostDetailList(pageVO);
		
		
		for(CrewPost cp : list) {
			cp.setUserMember(CrewMembersDAO.selectCrewMemberOneByNo(cp.getMemberNo()));
			Map<String,Object> map = new ConcurrentHashMap<String, Object>();
			map.put("postNo",cp.getNo());
			map.put("crewMemberNo",cp.getMemberNo());
			
			cp.setReplies(RepliesDAO.selectReplyList(map));
			
			cp.setPostImgs(PostImgsDAO.selectImageList(cp.getNo()));
			
			cp.setLikeMembers(LikesDAO.selectLikesList(map));
			map.put("myMemberNo",myMemberNo);
			cp.setMyLikeCount(LikesDAO.selectWhetherLike(map));
		}// for end
		ObjectMapper om = new ObjectMapper();
		
		String json = om.writeValueAsString(list);
		out.print(json);
	} 
		

}
