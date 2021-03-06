package com.doogwal.coffee.dao;

import org.apache.ibatis.session.SqlSession;

import com.doogwal.coffee.util.SqlSessionUtil;
import com.doogwal.coffee.vo.SubjAns;
import com.doogwal.coffee.vo.UserAns;

public class SubjAnsDAO {
	
	// 주성호 2021 01 25 start----------------------------------------------
	// 주관식 답변 넣기
	public static int insertSubjAns(SubjAns subjAns) {
		int result = 0;
		SqlSession session = null;
		try {
			session = SqlSessionUtil.getSession();
			return session.insert("subjAns.insertSubjAns",subjAns);
		}catch(Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}//try~catch~finally end
		return -1;
	}
	// 주성호 2021 01 25 end----------------------------------------------
}
