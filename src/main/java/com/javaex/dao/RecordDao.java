package com.javaex.dao;

import com.javaex.vo.RecordVo;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class RecordDao {
    @Autowired
    private SqlSession sqlSession;

    public int insertRecordList(List<RecordVo> recordList) {
        return sqlSession.insert("record.insertRecordList",recordList);
    }

    public List<RecordVo> getRecordList(int ptNo) {
        return sqlSession.selectList("record.getList", ptNo);
    }
}
