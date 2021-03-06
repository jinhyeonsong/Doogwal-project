package com.doogwal.coffee.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebFilter(value= {
		"/signUpEmailAuthorization.jsp"
		})
public class SignUpFormCheckFilter 
implements Filter {

	@Override
	public void destroy() {
		
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		//회원약관 동의 안할시 로그인 폼으로 넘어가지 못하게 하기 위해 만듦.
		System.out.println("SignUpFormCheckFilter 필터작동!!");
		
		HttpSession session = ((HttpServletRequest)request).getSession();
		System.out.println("request:"+request);
		System.out.println("request:"+session);
		
		String signUp = (String)session.getAttribute("signUp");
		System.out.println(signUp);
		
		if(signUp==null) {
			((HttpServletResponse)response).sendRedirect("/signUpForm.jsp");
		}else {
			chain.doFilter(request, response);
		}//if~else end
		
	}

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		
	}
	

}
