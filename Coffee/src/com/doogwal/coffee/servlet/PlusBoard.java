package com.doogwal.coffee.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.doogwal.coffee.dao.BoardsDAO;
import com.doogwal.coffee.vo.Board;

//보드 추가하는 servlet
@WebServlet("/plusBoard.doo")
public class PlusBoard extends HttpServlet{
	 
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	
		//한글 안 깨지게 세션 받아오고
		req.setCharacterEncoding("UTF-8");
		HttpSession session = req.getSession();
		
		//크루 번호와 새로 생길 게시판 이름 받아오기
		int crewNo = Integer.parseInt(req.getParameter("crewNo"));
		String boardName = req.getParameter("boardName");
		
		//DAO에 보낼 Board객체 생성
		Board board = new Board();
		board.setName(boardName);
		board.setCrewNo(crewNo);
		
		int result = BoardsDAO.insertPlusBoard(board);
		
		resp.sendRedirect("/");
	}
}
