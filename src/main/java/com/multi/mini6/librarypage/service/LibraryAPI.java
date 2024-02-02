package com.multi.mini6.librarypage.service;

import com.multi.mini6.librarypage.vo.LibraryVO;

import org.json.JSONArray;
import org.json.JSONObject;
import org.json.XML;

import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;

import java.util.ArrayList;


@Component
public class LibraryAPI {

    public ArrayList<LibraryVO> parse() {
        //url + parameter
        String url = "https://data4library.kr/api/libSrch";
        String authKey = "66bc011815c930ce9aea4fd77457d0b260cf3f15d673ae40221351dc126bc127";
        int pageSize = 1000;

        //http 요청 --> 응답(json)
        RestTemplate rest = new RestTemplate();
        String response = rest.getForObject(url + "?authKey=" + authKey + "&pageNo=1&pageSize=" + pageSize, String.class);
        //String response = rest.getForObject(url + parameter, String.class);
        //System.out.println("respose >> " + response);

        //xml --> json변경
        JSONObject json = XML.toJSONObject(response);
        System.out.println("json 출력 >> " + json);

        //전체 데이터 숫자 가져오기
        int totalDataCount = json.getJSONObject("response").getInt("numFound");
        int totalPages = (totalDataCount / pageSize) + 1;

        ArrayList<LibraryVO> list = new ArrayList<LibraryVO>();

        for (int pageNo = 1; pageNo <= totalPages; pageNo++) {
            String pageUrl = url + "?authKey=" + authKey + "&pageNo=" + pageNo + "&pageSize=" + pageSize;
            String pageResponse = rest.getForObject(pageUrl, String.class);
            JSONObject pageJson = XML.toJSONObject(pageResponse);

            JSONArray libsArray = pageJson.getJSONObject("response").getJSONObject("libs").getJSONArray("lib");

            for (int i = 0; i < libsArray.length(); i++) {
                LibraryVO libraryVO = new LibraryVO();
                libraryVO.setLib_code(libsArray.getJSONObject(i).getInt("libCode"));
                libraryVO.setLib_name(libsArray.getJSONObject(i).getString("libName"));
                libraryVO.setLib_address(libsArray.getJSONObject(i).getString("address"));
                libraryVO.setLib_tel(libsArray.getJSONObject(i).getString("tel"));
                if (libsArray.getJSONObject(i).has("fax")) {
                    libraryVO.setLib_fax(libsArray.getJSONObject(i).getString("fax"));
                } else {
                    // "fax" 필드가 없을 경우에 대한 처리
                    libraryVO.setLib_fax(""); // 또는 다른 기본값으로 설정할 수 있음
                }
                //libraryVO.setLib_fax(libsArray.getJSONObject(i).getString("fax"));
                libraryVO.setLib_latitude(libsArray.getJSONObject(i).getDouble("latitude"));
                libraryVO.setLib_longitude(libsArray.getJSONObject(i).getDouble("longitude"));
                libraryVO.setLib_homepage(libsArray.getJSONObject(i).getString("homepage"));
                if (libsArray.getJSONObject(i).has("closed")) {
                    libraryVO.setLib_closed(libsArray.getJSONObject(i).getString("closed"));
                } else {
                    // "closed" 필드가 없을 경우에 대한 처리
                    libraryVO.setLib_closed(""); // 또는 다른 기본값으로 설정할 수 있음
                }
                //libraryVO.setLib_closed(libsArray.getJSONObject(i).getString("closed"));
                if (libsArray.getJSONObject(i).has("operatingTime")) {
                    libraryVO.setLib_operating_time(libsArray.getJSONObject(i).getString("operatingTime"));
                } else {
                    // "operatingTime" 필드가 없을 경우에 대한 처리
                    libraryVO.setLib_operating_time(""); // 또는 다른 기본값으로 설정할 수 있음
                }
                //libraryVO.setLib_operating_time(libsArray.getJSONObject(i).getString("operatingTime"));
                String bookCountString = String.valueOf(libsArray.getJSONObject(i).get("BookCount"));
                libraryVO.setLib_bookcount("-".equals(bookCountString) ? "" : bookCountString);
                //libraryVO.setLib_bookcount(libsArray.getJSONObject(i).getString("BookCount"));

                list.add(libraryVO);
            }
        }
        //{vo, vo, vo, ...}


        System.out.println("DB 삽입 성공");
        return list;
    }
}
