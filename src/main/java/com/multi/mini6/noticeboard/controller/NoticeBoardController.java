package com.multi.mini6.noticeboard.controller;

import com.multi.mini6.noticeboard.service.NoticeBoardService;
import com.multi.mini6.noticeboard.vo.NoticeBoardPageVO;
import com.multi.mini6.noticeboard.vo.NoticeBoardVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;


import javax.inject.Inject;
import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.UUID;
import java.util.List;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("noticeboard")
public class NoticeBoardController {

    @Autowired
    @Inject
    NoticeBoardService noticeBoardService;

    @RequestMapping("/noticeboard")
    public void getNotices(Model model,
                             NoticeBoardPageVO noticeBoardPageVO,
                             @RequestParam(defaultValue = "1") int page,
                             @RequestParam(defaultValue = "10") int pageSize) throws Exception {
        int totalItemCount = noticeBoardService.getNoticeBoardCount();
        noticeBoardPageVO = new NoticeBoardPageVO(page, pageSize, totalItemCount);

        List<NoticeBoardVO> pinnedNotices = noticeBoardService.getPinnedNotices();

        List<NoticeBoardVO> remainingNotices = noticeBoardService.getRemainingNotices(noticeBoardPageVO);

        List<NoticeBoardVO> combinedNotices = new ArrayList<>();
        combinedNotices.addAll(pinnedNotices);
        combinedNotices.addAll(remainingNotices);

        int totalPages = noticeBoardPageVO.getTotalPages();
        int count = noticeBoardService.getNoticeBoardCount();
        log.info("noticeboard: " + combinedNotices);

        model.addAttribute("pinnedNotices", pinnedNotices);
        model.addAttribute("noticeboard", combinedNotices);
        model.addAttribute("noticeBoardPageVO", noticeBoardPageVO);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("count", count);

    }

    @RequestMapping(value = "/noticeboard_write")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public String writeNotice() throws Exception {
        return "noticeboard/noticeboard_write";
    }

    @PostMapping("/noticeboard_insert")
    @PreAuthorize("hasAnyRole('ROLE_ADMIN')")
    public String insertNotice(@RequestParam(value = "file", required = false) MultipartFile file,
                               @RequestParam("notc_title") String notc_title,
                               @RequestParam("notc_content") String notc_content,
                               @RequestParam(value = "pinnedCheckbox", defaultValue = "false") boolean pinned,
                               RedirectAttributes redirectAttributes) {
        try {
            NoticeBoardVO noticeBoardVO = new NoticeBoardVO();
            noticeBoardVO.setNotc_title(notc_title);
            noticeBoardVO.setNotc_content(notc_content);
            noticeBoardVO.setPinned(pinned);

            if (file != null && !file.isEmpty()) {
                String uuid = UUID.randomUUID().toString();

                String filePath = "C:" + File.separator + "upload_data" + File.separator + "temp" + File.separator + uuid + "_" + file.getOriginalFilename();

                Path path = Paths.get(filePath);
                Files.write(path, file.getBytes());

                noticeBoardVO.setNotice_uuid(uuid);
                noticeBoardVO.setNotice_file_name(file.getOriginalFilename());
            }

            noticeBoardService.insertNotice(noticeBoardVO);

            redirectAttributes.addFlashAttribute("successMessage", "Notice inserted successfully");
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("errorMessage", "Failed to insert notice");
        }

        return "redirect:/noticeboard/noticeboard";
    }

    @GetMapping("/noticeboard_update/{notc_id}")
    @PreAuthorize("hasAnyRole('ROLE_ADMIN')")
    public String showUpdateForm(@PathVariable("notc_id") int notc_id, Model model) {
        NoticeBoardVO existingNotice = noticeBoardService.getNoticeBoardById(notc_id);

        model.addAttribute("existingNotice", existingNotice);

        return "noticeboard/noticeboard_update";
    }

    @PostMapping("/noticeboard_update/{notc_id}")
    @PreAuthorize("hasAnyRole('ROLE_ADMIN')")
    public String handleUpdateForm(@PathVariable("notc_id") int notc_id,
                                   @ModelAttribute("existingNotice") NoticeBoardVO existingNotice,
                                   @RequestParam(value = "file", required = false) MultipartFile file,
                                   @RequestParam(value = "pinnedCheckbox", defaultValue = "false") boolean pinned,
                                   RedirectAttributes redirectAttributes) {
        try {
            if (file != null && !file.isEmpty()) {
                String uuid = UUID.randomUUID().toString();

                String filePath = "C:" + File.separator + "upload_data" + File.separator + "temp" + File.separator + uuid + "_" + file.getOriginalFilename();

                Path path = Paths.get(filePath);
                Files.write(path, file.getBytes());

                existingNotice.setNotice_uuid(uuid);
                existingNotice.setNotice_file_name(file.getOriginalFilename());
            }

            existingNotice.setPinned(pinned);

            noticeBoardService.updateNotice(existingNotice, file);

            return "redirect:/noticeboard/noticeboard_one?notc_id=" + notc_id;
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("errorMessage", "Failed to update notice");
            return "redirect:/noticeboard/noticeboard_one?notc_id=" + notc_id;
        }
    }

    @DeleteMapping("/noticeboard_delete/{notc_id}")
    @PreAuthorize("hasAnyRole('ROLE_ADMIN')")
    public String deleteNotice(@PathVariable("notc_id") int notc_id, RedirectAttributes redirectAttributes) {
        try {
            noticeBoardService.deleteNotice(notc_id);
            redirectAttributes.addFlashAttribute("successMessage", "Notice deleted successfully");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Failed to delete notice");
        }
        return "redirect:/noticeboard";
    }

    @RequestMapping(value = "/noticeboard_one", method = RequestMethod.GET)
    public String viewNotice(@RequestParam("notc_id") int notc_id, Model model) {
        try {
            NoticeBoardVO noticeBoardVO = noticeBoardService.getNoticeBoardById(notc_id);

            if (noticeBoardVO != null) {
                model.addAttribute("noticeBoardVO", noticeBoardVO);

                noticeBoardService.updateViewCountNotice(notc_id);

                NoticeBoardVO move = noticeBoardService.moveNoticeBoardPage(notc_id);
                System.out.println(move.getNext());
                model.addAttribute("move", move);

                return "noticeboard/noticeboard_one";
            } else {
                return "noticeboard/notice_not_found";
            }
        } catch (Exception e) {
            model.addAttribute("error", "An error occurred while processing your request.");
            return "error";
        }
    }

    @GetMapping("/noticeboard_search")
    public String searchNotice(@RequestParam(value = "searchType", required = false) String searchType,
                               @RequestParam(value = "keyword", required = false) String keyword,
                               @RequestParam(value = "page", defaultValue = "1") int page,
                               @RequestParam(value = "pageSize", defaultValue = "10") int pageSize,
                               Model model) {

        if (searchType == null || keyword == null || searchType.isEmpty() || keyword.isEmpty()) {
            model.addAttribute("error", "Search type and keyword are required.");
            return "noticeboard/search_error";
        }

        try {
            NoticeBoardPageVO pageVO = new NoticeBoardPageVO(page, pageSize, 0);
            pageVO.setSearchType(searchType);
            pageVO.setKeyword(keyword);

            int totalItemCount = noticeBoardService.getNoticeBoardCountBySearch(pageVO);
            pageVO.setTotalItemCount(totalItemCount);

            int searchCount = noticeBoardService.getNoticeBoardCountBySearch(pageVO);
            model.addAttribute("searchCount", searchCount);

            pageVO.calculateOffset();
            pageVO.setStartEnd();

            List<NoticeBoardVO> searchResults = noticeBoardService.searchNoticeBoard(pageVO);
            model.addAttribute("searchResults", searchResults);
            model.addAttribute("noticeBoardPageVO", pageVO);
            model.addAttribute("searchType", searchType);
            model.addAttribute("keyword", keyword);

            return "noticeboard/noticeboard_search";
        } catch (Exception e) {
            System.out.println("Received Parameters - searchType: " + searchType + ", keyword: " + keyword + ", page: " + page + ", pageSize: " + pageSize);
            e.printStackTrace();

            model.addAttribute("error", "An error occurred while processing your search.");
            return "noticeboard/search_error";
        }
    }

}
