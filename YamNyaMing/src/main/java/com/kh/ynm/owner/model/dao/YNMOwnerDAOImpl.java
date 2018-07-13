package com.kh.ynm.owner.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.ynm.owner.model.vo.YNMOwner;

@Repository("ynmOwnerDAO")
public class YNMOwnerDAOImpl implements YNMOwnerDAO{

	@Override
	public int ynmOwnerSignUp(SqlSessionTemplate sqlSession, YNMOwner owner) {	
		return sqlSession.insert("owners.ownerSignUp", owner);
	}

}
