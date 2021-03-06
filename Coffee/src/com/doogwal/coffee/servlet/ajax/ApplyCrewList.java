package com.doogwal.coffee.servlet.ajax;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.doogwal.coffee.dao.ApplyCrewsDAO;
import com.doogwal.coffee.vo.ApplyCrew;
import com.fasterxml.jackson.databind.ObjectMapper;

@WebServlet(value="/ajax/applyCrewList.json")
public class ApplyCrewList extends HttpServlet{

	
	private static final long serialVersionUID = 1L;
	
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	
		resp.setContentType("application/json; charset=UTF-8");
		PrintWriter out = resp.getWriter();
	
		
		String noStr = req.getParameter("no");
		int no = Integer.valueOf(noStr);
		
		List<ApplyCrew> applycrews = ApplyCrewsDAO.selectList(no);
		
		ObjectMapper om =new ObjectMapper();
		String json = om.writeValueAsString(applycrews);
		out.println(json);	
	}	
}






