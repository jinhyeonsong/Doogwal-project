package com.doogwal.coffee.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.doogwal.coffee.util.SqlSessionUtil;
import com.doogwal.coffee.vo.Board;

public class BoardsDAO {
	//박형우 start -----------------------------------------------------------------------
	//20210114 start

		//크루 게시판을 가져오는
		public static List<Board> selectBoards(int no){
			
			SqlSession session = null;
			
			try {
				session = SqlSessionUtil.getSession();
				
				return session.selectList("boards.selectBoards",no);
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				session.close();
			}
			
			return null;
		}

	//20210114 end
	//20210115 start

		//새 크루 게시판을 만드는
		public static int insertPlusBoard(Board board){
			
			SqlSession session = null;
			
			try {
				session = SqlSessionUtil.getSession();
				
				return session.insert("boards.insertPlusBoard", board);
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				session.close();
			}
			
			return 0;
		}
		
	//20210115 start
	//박형우 end -----------------------------------------------------------------------
		
	// 주성호 start	
	public static int insertBoard(Board board) {
		SqlSession session = null;
		try {
			session = SqlSessionUtil.getSession();
			return session.insert("boards.insertBoard", board);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			session.close();
		}
		
		return -1;
	}
	// 주성호 end

}
