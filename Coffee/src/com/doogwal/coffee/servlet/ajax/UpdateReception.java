package com.doogwal.coffee.servlet.ajax;


import java.io.IOException;
import java.io.PrintWriter;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import com.doogwal.coffee.dao.UsersDAO;

import com.doogwal.coffee.vo.User;


@WebServlet("/ajax/updateReception.json")
public class UpdateReception extends HttpServlet {
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		
		//응답 content type을 지정
		resp.setContentType("application/json; charset=UTF-8");
		
		char reception = 'Y';
		String receptionName = req.getParameter("receptionName");
		String updatedReception = req.getParameter("updatedReception");
		User loginUser = (User)req.getSession().getAttribute("loginUser");
		int userNo = loginUser.getNo();
		
		
		if(updatedReception.equals("true")) {
			reception = 'Y';
		}else {
			reception = 'N';
		}
		
		User user= new User();//db 업데이트용
		int result = 0;
		//emailCheck,smsCheck; 멤버필드명
		if(receptionName.equals("smsCheck")) {
			user.setSmsCheck(reception);
			user.setNo(userNo);
			result = UsersDAO.updateUserSmsReception(user);
			
			loginUser.setSmsCheck(reception);//세션에 있는 것
			
		}else {
			user.setEmailCheck(reception);
			user.setNo(userNo);
			result = UsersDAO.updateUserEmailReception(user);
			loginUser.setEmailCheck(reception);
		}
		System.out.println("업데이트 됨~!");
		
		
		
		
		
		//응답
		PrintWriter out = resp.getWriter();
		
		out.print("{\"result\":"+(result==1)+"}");
	}//doPost() end

}

