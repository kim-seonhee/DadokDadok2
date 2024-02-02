package com.multi.mini6.bookpage.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor // 기본 생성자 자동 생성
@AllArgsConstructor // 모든 필드를 매개변수로 받는 생성자 자동 생성
@Builder
public class PageVO {

    private int start;
    private int end;
    private int page; // 현재 페이지 번호
    private int pageSize = 3; // 페이지당 보여줄 아이템 수
    private int totalItemCount; // 전체 아이템 수
    private int totalPages; // 전체 페이지 수
    private int offset; // 쿼리에서 건너뛸 행의 수

    public PageVO(int page, int pageSize, int totalItemCount){
        this.page = page;
        this.pageSize = pageSize > 0 ? pageSize : 3; // pageSize가 0보다 크면 pageSize, 아니면 3
        this.totalItemCount = totalItemCount;
        this.totalPages = (int) Math.ceil((double) totalItemCount / pageSize);
        calculateOffset();
        setStartEnd();

    }

    public void calculateOffset() {
        this.offset = Math.max((this.page - 1) * this.pageSize, 0); // 음수 값 방지
    }
    public void setStartEnd() {
        if (page < 1) {
            page = 1;
        }
        if (pageSize < 1) {
            pageSize = 3;
        }
        start = 1 + (page - 1) * pageSize;
        end = page * pageSize;
    }

}
