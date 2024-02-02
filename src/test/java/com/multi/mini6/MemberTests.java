package com.multi.mini6;

import com.multi.mini6.loginpage.dao.MemberDAO;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringRunner;

@RunWith(SpringRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class MemberTests {

    @Setter(onMethod_ = @Autowired)
    private PasswordEncoder passwordEncoder;

    @Autowired
    private MemberDAO memberDAO;



}
