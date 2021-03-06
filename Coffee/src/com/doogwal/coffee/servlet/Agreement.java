package com.doogwal.coffee.servlet;


import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;



@WebServlet("/agreement.do")
public class Agreement extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
				
		//우선 세션 얻고
		HttpSession session = req.getSession();
		//agreement 서블릿에 왔다는 것은 체크박스 다 체크하고 나서 확인 버튼 눌렀다는 것.
		session.setAttribute("agreement", "true");
		resp.sendRedirect("/signUpForm.jsp");
		
	}
	
}
