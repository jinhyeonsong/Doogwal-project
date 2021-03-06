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


@WebServlet("/ajax/updateAddress.json")
public class UpdateAddress extends HttpServlet {
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		
		//응답 content type을 지정
		resp.setContentType("application/json; charset=UTF-8");
		
		String updatedAddress = req.getParameter("updatedAddress");
		User loginUser = (User)req.getSession().getAttribute("loginUser");
		int userNo = loginUser.getNo();
		
		
		User user= new User();
		user.setAddress(updatedAddress);
		user.setNo(userNo);
		loginUser.setAddress(updatedAddress);//세션 값도 업데이트!
		
		int result = UsersDAO.updateUserAddress(user);
		//응답
		PrintWriter out = resp.getWriter();
		System.out.println("됐다!");
		
		
		out.print("{\"result\":"+(result==1)+"}");
		
	}//doPost() end

}

