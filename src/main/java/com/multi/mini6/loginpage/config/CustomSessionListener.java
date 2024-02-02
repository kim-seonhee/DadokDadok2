package com.multi.mini6.loginpage.config;

import lombok.extern.log4j.Log4j2;

import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionIdListener;
import javax.servlet.http.HttpSessionListener;
import java.time.LocalDateTime;

@Log4j2
public class CustomSessionListener implements HttpSessionListener, HttpSessionIdListener {


    @Override
    public void sessionCreated(HttpSessionEvent httpSessionEvent) {
        log.info("===> [" + LocalDateTime.now() + "] 세션 생성됨 " + httpSessionEvent.getSession().getId());
    }

    @Override
    public void sessionDestroyed(HttpSessionEvent httpSessionEvent) {
        log.info("===> [" + LocalDateTime.now() + "] 세션 만료됨 " + httpSessionEvent.getSession().getId());
    }

    @Override
    public void sessionIdChanged(HttpSessionEvent httpSessionEvent, String oldSessionId) {
        log.info("===> [" + LocalDateTime.now() + "] 세션 ID 변경됨 " + oldSessionId + " -> " + httpSessionEvent.getSession().getId());
    }
}
