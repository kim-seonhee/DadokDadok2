package com.multi.mini6.bookpage.service;//package com.multi.mini6.bookpage.service;
//
//import com.multi.mini6.bookpage.vo.bookAPI.ResponseDTO;
//import lombok.RequiredArgsConstructor;
//import lombok.extern.log4j.Log4j2;
//import org.springframework.core.ParameterizedTypeReference;
//import org.springframework.http.*;
//import org.springframework.stereotype.Service;
//import org.springframework.web.client.RestTemplate;
//import org.springframework.web.util.UriComponentsBuilder;
//
//import java.util.Arrays;
//
//@Service
//@RequiredArgsConstructor
//@Log4j2
//public class BookAPIService {
//
//    private final RestTemplate restTemplate = new RestTemplate();
//
//    public ResponseDTO getBookDetails(String isbn) {
//        log.info("getBookDetails() called");
//
//        String url = "http://data4library.kr/api/srchDtlList";
//        String authKey = "c500550c260a842b762bc86dc21ee159406d97cfdc35d10d71726d7a7d998b6b";
//
//        HttpHeaders headers = new HttpHeaders();
//        headers.setAccept(Arrays.asList(MediaType.APPLICATION_JSON)); // JSON 응답을 기대함을 나타냅니다.
//        HttpEntity<String> entity = new HttpEntity<>("parameters", headers);
//
//        UriComponentsBuilder builder = UriComponentsBuilder.fromHttpUrl(url)
//                .queryParam("authKey", authKey)
//                .queryParam("isbn13", isbn)
//                .queryParam("loaninfoYN", "Y")
//                .queryParam("displayInfo", "age")
//                .queryParam("format", "json");
//
//        ResponseEntity<ResponseDTO> response = restTemplate.exchange(
//                builder.toUriString(),
//                HttpMethod.GET,
//                entity,
//                new ParameterizedTypeReference<ResponseDTO>() {}
//        );
//
//        log.info("Response: {}", response.toString());
//
//        if (response.getStatusCode().is2xxSuccessful()) {
//            log.info("Successfully fetched book details for ISBN: {}", isbn);
//            return response.getBody();
//        } else {
//            log.error("Failed to fetch book details for ISBN: {}. Status code: {}", isbn, response.getStatusCode());
//            return null; // or throw an exception as per your error handling policy
//        }
//    }
//
//
//}
