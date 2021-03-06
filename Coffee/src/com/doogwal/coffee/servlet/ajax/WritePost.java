package com.doogwal.coffee.servlet.ajax;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.doogwal.coffee.vo.Post;
import com.doogwal.coffee.vo.User;

@WebServlet("/ajax/writePost.json")
public class WritePost extends HttpServlet {
	
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//title, contents 파라미터가 넘어옴
		
		String contents = req.getParameter("contents");
		String postTop = req.getParameter("post_top");
		String boardNoStr = req.getParameter("boardNo");
		String memberNoStr = req.getParameter("memberNo");

		int boardNo = Integer.parseInt(boardNoStr);
		int memberNo = Integer.parseInt(memberNoStr);
		
		System.out.println("boardNo:" + boardNo+"memberNo: " + memberNo+"postTop" +postTop);
		
		
		HttpSession session = req.getSession();
		User loginMember = (User)session.getAttribute(User.LOGIN);
		
		
//		int memberNo = loginMember.getNo();
//		Post article = new Post(no, memberNo, likeCnt, boardNo, imageApplicable, contents)
//				
//		int result = BoardDAO.insert(article);
//		
//		if(result==1) {
//			System.out.println("입력 했다~!");
//		}
//		else {
//			System.out.println("실패했다");
//		}
//		
		resp.sendRedirect("/index.jsp");
	}
}
