package com.javaex.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.javaex.vo.ScheduleVo;
import com.javaex.vo.SummaryVo;

@Repository
public class ScheduleDao {

    @Autowired
    SqlSession sqlSession;

    public boolean insert(ScheduleVo scheduleVo) {
        return sqlSession.insert("schedule.insert", scheduleVo) == 1;
    }

    public List<ScheduleVo> getScheduleList(int trainerNo) {
    	
    	List<ScheduleVo> list = sqlSession.selectList("schedule.selectList", trainerNo);

        return list;
    }

    public ScheduleVo getSchedule(ScheduleVo scheduleVo) {
        return sqlSession.selectOne("schedule.selectByVo", scheduleVo);
    }

    public boolean modifySchedule(ScheduleVo scheduleVo) {
        return sqlSession.update("schedule.update", scheduleVo) == 1;
    }

    public boolean changeScheduleState(ScheduleVo scheduleVo) {
        return sqlSession.update("schedule.changeScheduleState", scheduleVo) == 1;
    }


    public boolean deleteSchedule(ScheduleVo scheduleVo) {
        return sqlSession.delete("schedule.delete", scheduleVo) == 1;
    }

    public SummaryVo getReviewCount(int trainerNo) {
    	return sqlSession.selectOne("schedule.getReviewCount", trainerNo);
    }

    public int countAll(int trainerNo) {
		return sqlSession.selectOne("schedule.countAll", trainerNo);
	}

	public int countCurrent(int trainerNo) {
		return sqlSession.selectOne("schedule.countCurrent", trainerNo);
	}

	public List<ScheduleVo> getTodaySchedule(int trainerNo) {
		return sqlSession.selectList("schedule.getTodaySchedule", trainerNo);
	}

}
