package com.doogwal.coffee.servlet;

import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.doogwal.coffee.dao.BoardsDAO;
import com.doogwal.coffee.dao.CrewMembersDAO;
import com.doogwal.coffee.dao.CrewsDAO;
import com.doogwal.coffee.dao.MtpQuestsDAO;
import com.doogwal.coffee.dao.QuestionsDAO;
import com.doogwal.coffee.dao.UsersDAO;
import com.doogwal.coffee.vo.Board;
import com.doogwal.coffee.vo.Crew;
import com.doogwal.coffee.vo.CrewMember;
import com.doogwal.coffee.vo.MtpQuest;
import com.doogwal.coffee.vo.Question;
import com.doogwal.coffee.vo.User;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

@WebServlet("/createCrew.do")
public class CreateCrew extends HttpServlet{

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String name = req.getParameter("name");
		String coverImg = req.getParameter("cover_img");
		String intro = req.getParameter("intro");
		String categoryNoStr = req.getParameter("category_no");
		String olderYearStr = req.getParameter("olderYear");
		String youngerYearStr = req.getParameter("youngerYear");
		String maxPopStr = req.getParameter("max_pop");
		
		HttpSession session = req.getSession();
		User user = (User)session.getAttribute(User.LOGIN);
		
		int userNo = user.getNo();
		int categoryNo = Integer.parseInt(categoryNoStr);
		int minAge = Integer.parseInt(olderYearStr);
		int maxAge = Integer.parseInt(youngerYearStr);
		int maxPop = Integer.parseInt(maxPopStr);
		
		
		Date d=new Date();  
        int year=d.getYear();  
        // 크루장 나이 얻기
        int age=year+1900-user.getBirthYear();
        // 크루장 성별 얻기
		char gender = user.getGender();
		int no=1;
		Crew crew;
		// 남녀 성별 구분하여 성비를 바꿈
		if(gender=='F') {
			crew = new Crew(minAge, maxAge, maxPop,1, categoryNo, 30000, age, 0, name, coverImg, intro);
		}else {
			crew = new Crew(minAge, maxAge, maxPop,1, categoryNo, 30000, age, 1, name, coverImg, intro);
		}
		
		// 크루 삽입과 동시에 크루 번호 얻기
		int crewNo = CrewsDAO.insertCrew(crew);

		
		// 질문들 얻기
		String[] mtpQuests = req.getParameterValues("mtp_quest");
		String[] mtpAnswers = req.getParameterValues("mtp_answer");
		
		int mtpNumIndex=0;
		int ansLen=0;
		Question q;
		MtpQuest mtpQ;
		// 질문 타입을 알아내기 위함
		String[] types = req.getParameterValues("type");
		// 보기 몇번까지 존재하는지 알아냄
		String[] mtpNums = req.getParameterValues("mtp_num");
		if(types!=null) {
			for(int i=0;i<types.length;i++) {
				if(types[i].equals("M")) {
					// insert Questoin
					q = new Question(crewNo, 'M', mtpQuests[i]);
					int qNo = QuestionsDAO.insertQuestion(q);
					int mtpNum = Integer.parseInt(mtpNums[mtpNumIndex++]);
					// 보기 질문이 있을때
					if(mtpQuests.length>0) {
						for(int j=ansLen;j<ansLen+mtpNum;j++) {
							System.out.println(mtpAnswers[j]);
							mtpQ = new MtpQuest(crewNo, qNo, mtpAnswers[j]);
							int mtpQResult = MtpQuestsDAO.insertMtpQuests(mtpQ);
							if(mtpQResult==1) {
								System.out.println("mtpQresult 입력 완료");
							}else {
								System.out.println("mtpQresult 입력 실패");
							}
						}
					}
					ansLen += mtpNum;
				}
				// 주관식 질문 얻기
				else if(types[i].equals("S")) {
					// insert Questoin
					q = new Question(crewNo, 'S', mtpQuests[i]);
					int qResult = QuestionsDAO.insertQuestion(q);
				}
				// 파일 질문 얻기
				else if(types[i].equals("F")) {
					// insert Questoin
					q = new Question(crewNo, 'F', mtpQuests[i]);
					int qResult = QuestionsDAO.insertQuestion(q);
				}
			}
		}
		// 크루 삽입
		CrewMember crewMember = new CrewMember(crewNo, userNo, 0, 'C', 'A', "default.jpg",null);
		int crewMemberResult = CrewMembersDAO.insertCrewMember(crewMember);
		// 질문과 정답 얻기
		System.out.println("크루 insert:" + crewMemberResult);
		
		Board board = new Board();
		board.setCrewNo(crewNo);
		// 전체글 삽입
		board.setName("전체글");
		int boardResult = BoardsDAO.insertBoard(board);
		// 일정 삽입
		board.setName("일정");
		boardResult = BoardsDAO.insertBoard(board);
		
		
		// header.jsp를 위해 session을 추가해서 넣어줌
		List<CrewMember> ownCrewList = CrewMembersDAO.selectOwnList(user.getNo());
		System.out.println("onwCrewList 사이즈:" + ownCrewList.size());
		int crewIdx = ownCrewList.size();
		session.setAttribute("userCrewList"+ (--crewIdx), crewMember);
		
		// index로 redirect
		resp.sendRedirect("/index.jsp");
		
	}
	
}
