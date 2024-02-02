package com.multi.mini6.bookpage.vo;

import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

import java.util.Date;

@Data
public class BooksHistoryVO {
    private Long id;
    private String file_name;
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date upload_date;
    private String file_type;
    private String file_size;

    public void setFileSizeFormatted(MultipartFile file) {
        double sizeInMB = (double) file.getSize() / (1024 * 1024);
        String formattedSize = String.format("%.2f MB", sizeInMB);
        this.file_size = formattedSize;
    }


}

