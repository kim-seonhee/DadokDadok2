<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>File Upload Form</title>
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <script>
        $(document).ready(function() {
            $("#uploadForm").submit(function(event) {
                event.preventDefault();
                ajaxSubmitForm();
            });

            function ajaxSubmitForm() {
                var formData = new FormData($("#uploadForm")[0]);

                $.ajax({
                    type: "POST",
                    url: "/uploadAjaxFormAction",
                    enctype: 'multipart/form-data',
                    processData: false,
                    contentType: false,
                    cache: false,
                    data: formData,
                    success: function(data) {
                        // 업로드 결과를 처리하는 코드
                        console.log(data);
                    },
                    error: function(e) {
                        console.log("Error: ", e);
                    }
                });
            }
        });
    </script>
</head>
<body>
    <h2>File Upload Form</h2>
    <form id="uploadForm">
        <input type="file" name="files" multiple>
        <input type="submit" value="Upload">
    </form>
</body>
</html>