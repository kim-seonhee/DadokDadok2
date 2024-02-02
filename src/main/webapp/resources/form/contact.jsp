<%--<%@ page import="javax.mail.*, javax.mail.internet.*, javax.activation.*" %>--%>
<%@ page import="java.util.*"%>
<%@ page import="com.mysql.cj.Session" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    // 이메일을 받을 주소 설정
    String receivingEmail = "contact@example.com";

    // 요청으로부터 파라미터를 받음
    String name = request.getParameter("name");
    String fromEmail = request.getParameter("email");
    String subject = request.getParameter("subject");
    String message = request.getParameter("message");

    // 메일을 보내는 데 사용할 세션 생성
    String host = "smtp.example.com";
    final String username = "username@example.com"; // SMTP 서버에 로그인할 계정 이름
    final String password = "password"; // SMTP 서버에 로그인할 계정 비밀번호
    int port = 587; // SMTP 서버 포트

    // SMTP 서버 정보 설정
    Properties props = new Properties();
    props.put("mail.smtp.host", host);
    props.put("mail.smtp.port", port);
    props.put("mail.smtp.auth", "true");

//    Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
//        protected PasswordAuthentication getPasswordAuthentication() {
//            return new PasswordAuthentication(username, password);
//        }
//    });

    try {
        // MimeMessage 객체 생성
//        MimeMessage msg = new MimeMessage(session);
//        msg.setFrom(new InternetAddress(fromEmail, name));
//        msg.addRecipient(Message.RecipientType.TO, new InternetAddress(receivingEmail));
//        msg.setSubject(subject);
//        msg.setText(message);
//
//        // 메일 전송
//        Transport.send(msg);

        // 성공 응답
        out.println("The email has been sent successfully.");
    } catch (Exception e) {
        // 에러 처리
        e.printStackTrace();
        out.println("There was an error sending the email.");
    }
%>
