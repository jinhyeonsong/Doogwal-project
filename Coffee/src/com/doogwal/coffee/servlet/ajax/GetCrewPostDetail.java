package com.doogwal.coffee.servlet.ajax;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.doogwal.coffee.dao.CrewMembersDAO;
import com.doogwal.coffee.dao.CrewPostsDAO;
import com.doogwal.coffee.dao.LikesDAO;
import com.doogwal.coffee.dao.PostImgsDAO;
import com.doogwal.coffee.dao.RepliesDAO;
import com.doogwal.coffee.vo.CrewPost;
import com.fasterxml.jackson.databind.ObjectMapper;

@WebServlet("/ajax/getCrewPostDetail.json")
public class GetCrewPostDetail extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		resp.setContentType("application/json; charset=UTF-8");

		PrintWriter out = resp.getWriter();
		
    	
    	String postNoStr = req.getParameter("postNo");
    	String crewNoStr = req.getParameter("crewNo");
		String crewMemberNoStr = req.getParameter("memberNo");
		int postNo = Integer.parseInt(postNoStr);
		int crewNo = Integer.parseInt(crewNoStr);
		int myMemberNo = Integer.parseInt(crewMemberNoStr);
		System.out.println("myMemberNo:" + myMemberNo);
		CrewPost cp = CrewPostsDAO.selectPostDetailOne(postNo);

		System.out.println("글쓴이MemberNo:" + cp.getNo());
		System.out.println("글쓴이MemberNo:" + cp.getMemberNo());
		cp.setUserMember(CrewMembersDAO.selectCrewMemberOneByNo(cp.getMemberNo()));
		Map<String,Object> map = new ConcurrentHashMap<String, Object>();
		map.put("postNo",cp.getNo());
		map.put("crewMemberNo",cp.getMemberNo());
		cp.setReplies(RepliesDAO.selectReplyList(map));
		cp.setPostImgs(PostImgsDAO.selectImageList(cp.getNo()));
		
		cp.setLikeMembers(LikesDAO.selectLikesList(map));
		map.put("myMemberNo",myMemberNo);
		cp.setMyLikeCount(LikesDAO.selectWhetherLike(map));
		
		ObjectMapper om = new ObjectMapper();
		
		String json = om.writeValueAsString(cp);
		out.print(json);
		
	}
	
	
}
