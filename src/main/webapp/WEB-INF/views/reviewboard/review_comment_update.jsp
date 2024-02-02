<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
int result = (int)request.getAttribute("result");

if(result==1){

%>
- ${reviewCommentVO.cm_id}, ${reviewCommentVO.cm_content},${reviewCommentVO.member_id}
<%
}
%>
