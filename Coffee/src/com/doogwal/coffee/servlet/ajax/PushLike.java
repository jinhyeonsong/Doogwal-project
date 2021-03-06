package com.doogwal.coffee.servlet.ajax;

import java.io.IOException;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.doogwal.coffee.dao.LikesDAO;
import com.doogwal.coffee.dao.PostsDAO;

@WebServlet("/ajax/pushLike.json")
public class PushLike extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String postNoStr = req.getParameter("postNo");
		String likerNoStr = req.getParameter("likerNo");
		int postNo = Integer.parseInt(postNoStr);
		int likerNo = Integer.parseInt(likerNoStr);
		
		
		Map<String,Object> map = new ConcurrentHashMap<String, Object>();
		map.put("postNo",postNo);
		map.put("likerNo",likerNo);
		int insertResult = LikesDAO.pushLike(map);

		int updateResult = PostsDAO.postPushLike(postNo);
		System.out.println(insertResult + " : " + updateResult);
		
	}
	
}
