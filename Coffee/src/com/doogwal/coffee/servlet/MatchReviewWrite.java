package com.doogwal.coffee.servlet;

import java.io.IOException;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.doogwal.coffee.dao.MannersDAO;
import com.doogwal.coffee.dao.RecordsDAO;
import com.doogwal.coffee.vo.Manner;

@WebServlet("/matchReviewWrite.do")
public class MatchReviewWrite extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		// 평가 받는 크루번호
		int rateeNo = Integer.parseInt(req.getParameter("rateecrewNo"));
		
		// 평가 하는 크루 번호
		int raterNo = Integer.parseInt(req.getParameter("ratercrewNo"));
		
		// 밋팅 번호
		int meetingNo = Integer.parseInt(req.getParameter("meetingNo"));
		
		// 승 무 패
		char matchResult = req.getParameter("match_result").charAt(0);
		
		String[] reviews = req.getParameterValues("review");
		char[] arr = {'F','F','F','F','F'};
		for(String s:reviews) {
			int num = Integer.parseInt(s);
			arr[num-1] = 'T';
		}
		Manner manner = new Manner(raterNo, rateeNo, meetingNo, arr[0],arr[1],arr[2],arr[3],arr[4]);
		
		int mannerResult = MannersDAO.insert(manner);
		
		Map<String,Object> map = new ConcurrentHashMap<String, Object>();
		map.put("crewNo",raterNo);
		map.put("meetingNo",meetingNo);
		map.put("type", matchResult);
		
		int recordResult = RecordsDAO.update(map);
		
		System.out.println("manner: "+mannerResult + " record: " + recordResult);
		
		String referer = 
				req.getHeader("referer");
		
		resp.sendRedirect(referer);
		
	}
}
