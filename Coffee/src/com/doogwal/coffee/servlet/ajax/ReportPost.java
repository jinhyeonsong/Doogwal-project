package com.doogwal.coffee.servlet.ajax;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.doogwal.coffee.dao.CrewMembersDAO;
import com.doogwal.coffee.dao.CrewsDAO;
import com.doogwal.coffee.dao.ReportsDAO;
import com.doogwal.coffee.vo.Report;

@WebServlet("/ajax/insertReport.json")
public class ReportPost extends HttpServlet {
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String postNoStr = req.getParameter("postNo");
		String reporterNoStr = req.getParameter("reporterNo");
		String writerNoStr = req.getParameter("writerNo");
		String typeStr = req.getParameter("type");
		
		int postNo = Integer.parseInt(postNoStr);
		int reporterNo = Integer.parseInt(reporterNoStr);
		int writerNo = Integer.parseInt(writerNoStr);
		System.out.println("postNo:" + postNo + "reporterNo: "+ reporterNo + "writerNo: " + writerNo);
		System.out.println(typeStr);
		char type = typeStr.charAt(0);
		
		Report report = new Report(postNo, writerNo, reporterNo, type);
		
		int Reportresult = ReportsDAO.insertReport(report);
		
		int updateResult = CrewMembersDAO.updateReportCrewMember(writerNo);
		
		System.out.println("Report result: "+ Reportresult);
		
		resp.setContentType("application/json; charset=UTF-8");
		
		PrintWriter out = resp.getWriter();
		
		out.print("{\"result\":"+Reportresult+"}");
		
		
	}
	
}
