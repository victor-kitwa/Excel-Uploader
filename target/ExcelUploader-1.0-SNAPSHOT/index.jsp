<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Upload</title>
    <meta property="og:title" content="Upload">
    <!-- Add any necessary CSS stylesheets -->
    <link rel="stylesheet" type="text/css" href="./upload.css">
</head>
<body>
<h1>Excel Upload Example</h1>
<form action="Upload.jsp" method="post" enctype="multipart/form-data">
    <input type="file" name="file" accept=".xlsx">
    <input type="submit" value="Upload">
</form>



<div class="upload-container">
    <div class="upload-upload-container">
        <img
                alt="DropBox63"
                src="/external/dropbox63-llfc.svg"
                class="upload-drop-box"
        />
        <img
                alt="UploadtoCloud1033"
                src="/external/uploadtocloud1033-jhdh-200h.png"
                class="upload-uploadto-cloud"
        />
        <div class="upload-group2">
            <span class="upload-text">Drag &amp; Drop</span>
            <span class="upload-text1">
                    <span class="upload-text2">
                        or select files from your computer
                    </span>
                    <br>
                </span>
            <span class="upload-text4">Max 50mb</span>
        </div>
    </div>
    <div class="upload-container1">
        <!-- Include the necessary JSP or HTML code here to render the Group6 component -->

    </div>
    <div class="upload-notification"></div>
</div>

<!-- Add any necessary JavaScript scripts here -->
<!-- For example, <script src="/path/to/your/script.js"></script> -->
</body>
</html>
