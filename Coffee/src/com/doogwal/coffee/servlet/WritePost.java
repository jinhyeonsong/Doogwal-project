package com.doogwal.coffee.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.doogwal.coffee.dao.PostImgsDAO;
import com.doogwal.coffee.dao.PostsDAO;
import com.doogwal.coffee.util.PostStringParserUtil;
import com.doogwal.coffee.vo.Post;
import com.doogwal.coffee.vo.PostImg;
import com.doogwal.coffee.vo.User;

@WebServlet("/writePost.do")
public class WritePost extends HttpServlet {
	
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//title, contents 파라미터가 넘어옴
		
		String contents = req.getParameter("contents");
		String postTop = req.getParameter("post_top");
		String boardNoStr = req.getParameter("boardNo");
		String memberNoStr = req.getParameter("memberNo");
		String imageApplicableStr = req.getParameter("imageApplicable");
		
		char imageApplicable = imageApplicableStr.charAt(0);
		int boardNo = Integer.parseInt(boardNoStr);
		int memberNo = Integer.parseInt(memberNoStr);
		
		System.out.println("boardNo:" + boardNo+"memberNo: " + memberNo+"postTop" +postTop);
		System.out.println("contents: " + contents);
		
		//파일이면 ("<file src="  ,"\">")
		List<String> postImage = PostStringParserUtil.PostImagesParserUtil(contents, "<img src=", "\">");
		String textContents = PostStringParserUtil.contenetsOriginParserUtil(contents,"<img src=", "\">");
		Post post;
		if(postTop!=null) {
			post = new Post(memberNo, 0, boardNo, imageApplicable, contents,'Y',textContents);
		}else {
			post = new Post(memberNo, 0, boardNo, imageApplicable, contents,'N',textContents);
		}
		int result= PostsDAO.insertPost(post);
		
		int postNo = PostsDAO.selectpostNo();
		
		System.out.println("postNo: "+ postNo);
		PostImg postImg; 
		for(String postImageStr: postImage) {
			postImg = new PostImg(postNo, postImageStr);
			int postImgResult = PostImgsDAO.insertPostImages(postImg);
			System.out.println("postImageResult: "+ postImgResult + " postImageStr: " + postImageStr);
		}
		
		
		System.out.println("result:" + result);
		String referer = 
				req.getHeader("referer");
		resp.sendRedirect(referer);
	}
}
