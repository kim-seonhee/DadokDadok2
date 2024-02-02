package com.multi.mini6.adminpage.dao;

import lombok.extern.log4j.Log4j2;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.MockitoJUnitRunner;
import org.mybatis.spring.SqlSessionTemplate;

import java.util.Arrays;
import java.util.Collections;
import java.util.List;

import static org.junit.Assert.assertEquals;
import static org.mockito.Mockito.*;


@RunWith(MockitoJUnitRunner.class)
@Log4j2
public class BookUploadDAOTest {
    @Mock
    private SqlSessionTemplate sqlSession;

    @InjectMocks
    private BookUploadDAO bookUploadDAO;

    @Test
    public void shouldFindDuplicatedIsbns() {
        // 가짜 ISBN 리스트 준비
        List<String> givenIsbns = Arrays.asList("9788964361658", "9788984887909", "9788960777332");
        // 예상되는 결과 설정
        List<String> expectedDuplicatedIsbns = Arrays.asList("9788964361658", "9788960777332");
        // Mock 객체 동작 설정
        when(sqlSession.selectList("findDuplicatedIsbns", givenIsbns)).thenReturn(Collections.singletonList(expectedDuplicatedIsbns));
        // 메소드 실행
        List<String> actualDuplicatedIsbns = bookUploadDAO.findDuplicatedIsbns(givenIsbns);

        // 결과 검증
        assertEquals(expectedDuplicatedIsbns, actualDuplicatedIsbns);
        verify(sqlSession, times(1)).selectList("findDuplicatedIsbns", givenIsbns);

    }

}
