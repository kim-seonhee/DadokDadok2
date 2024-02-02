package com.multi.mini6.noticeboard.vo;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.*;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Component;

import java.util.Date;

@Component
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Getter
@Setter
@ToString
public class NoticeBoardVO {

    private int notc_id; // 글번호
    private int notc_views; // 조회수
    private String notc_title; // 글제목
    private String notc_content; // 글내용

    private String notice_uuid; // 첨부파일uuid
    private String notice_file_name; // 첨부파일명

    private int next; // 다음글
    private int last; // 이전글
    private String nexttitle; // 다음글제목
    private String lasttitle; // 이전글제목

    private boolean pinned; // 고정글여부

    public String getImageUrl() {
        if (notice_uuid != null && !notice_uuid.isEmpty()) {
            return "/upload_data/temp/" + notice_uuid + "_" + notice_file_name;
        } else {
            return null;
        }
    }

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd HH:mm")
    private Date notc_createdAt = new Date(); // 작성일

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd HH:mm")
    private Date notc_updatedAt = new Date(); // 수정일

}
