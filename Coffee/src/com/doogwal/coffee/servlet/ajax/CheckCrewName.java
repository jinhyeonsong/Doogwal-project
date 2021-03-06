package com.doogwal.coffee.servlet.ajax;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.doogwal.coffee.dao.CrewsDAO;



@WebServlet(value="/ajax/checkCrewname.json")
public class CheckCrewName extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.setContentType("application/json; charset=UTF-8");
		
		PrintWriter out = response.getWriter();
		
		String name = request.getParameter("name");

		//3초후에 응답
		//Thread.sleep(3000);
		
		int cnt = CrewsDAO.selectCheckCrewname(name);
		System.out.println("이름: " +name+  " / " + cnt);
		out.print("{\"count\":"+cnt+"}");
		
	}

}
