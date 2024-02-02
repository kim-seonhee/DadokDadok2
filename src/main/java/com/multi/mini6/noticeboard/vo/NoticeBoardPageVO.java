package com.multi.mini6.noticeboard.vo;

import lombok.*;

@Data
@AllArgsConstructor
@Builder
@Getter
@Setter
@ToString
public class NoticeBoardPageVO {
    private int page; // Current page number
    private int pageSize; // Number of items per page
    private int totalItemCount; // Total number of items
    private int totalPages; // Total number of pages
    private int offset; // Offset for pagination
    private int start; // Start index for current page
    private int end; // End index for current page
    private String keyword; // 검색 키워드
    private String type; // 검색 타입
    private String[] typeArr;
    private String searchType; // search type ( title , content , titleContent )

    public NoticeBoardPageVO() {
        // Default constructor with no arguments
    }

    public NoticeBoardPageVO(int page, int pageSize, int totalItemCount) {
        this.page = page;
        this.pageSize = pageSize > 0 ? pageSize : 10; // Set a default page size of 10 if pageSize is less than or equal to 0
        this.totalItemCount = totalItemCount;
        this.totalPages = calculateTotalPages(); // Calculate the total number of pages
        calculateOffset(); // Calculate the offset based on the current page and page size
        setStartEnd(); // Set the start and end indices for the current page
    }

    private int calculateTotalPages() {
        return (int) Math.ceil((double) totalItemCount / pageSize); // Calculate the total number of pages
    }

    public void calculateOffset() {
        // Calculate the offset based on the current page and page size
        this.offset = Math.max((this.page - 1) * this.pageSize, 0);
    }

    public void setStartEnd() {
        // Set the start and end indices for the current page
        if (this.page < 1) {
            this.page = 1; // Ensure that the page number is always positive
        }
        if (this.pageSize < 1) {
            this.pageSize = 10; // Ensure that the page size is always positive
        }
        int offset = (this.page - 1) * this.pageSize; // Calculate the offset
        this.start = offset + 1; // Set the start index
        this.end = Math.min(offset + this.pageSize, this.totalItemCount); // Set the end index
    }

    public int getTotalPages() {
        // Calculate the total number of pages based on the total item count and page size
        return (int) Math.ceil((double) totalItemCount / pageSize);
    }

    public int getStartPage() {
        int totalPages = getTotalPages();
        int startPage = Math.max(page - 2, 1); // Start from current page - 2
        return Math.min(startPage, totalPages - 4); // Ensure start page is within valid range
    }

    public int getEndPage() {
        int totalPages = getTotalPages();
        int startPage = getStartPage();
        return Math.min(startPage + 4, totalPages); // End at startPage + 4 or totalPages, whichever is smaller
    }

    public int getLimit() {
        return pageSize;
    }
}