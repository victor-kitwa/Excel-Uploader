<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>


        <style>
            .upload-container {
                width: 100%;
                display: flex;
                overflow: auto;
                min-height: 100vh;
                align-items: center;
                flex-direction: column;
                justify-content: center;
            }
            .upload-upload-container {
                top: 100px;
                left: 0px;
                right: 0px;
                width: 780px;
                height: 440px;
                margin: auto;
                display: flex;
                position: absolute;
                align-items: flex-start;
                flex-shrink: 1;
                justify-content: center;
            }
            .upload-drop-box {
                top: 0px;
                left: 0px;
                right: 0px;
                width: 780px;
                height: 440px;
                margin: auto;
                position: absolute;
                box-shadow: 50px 50px 40px 0px rgba(0, 0, 0, 0.57);
                border-radius: 24px;
            }
            .upload-uploadto-cloud {
                width: 228px;
                height: 146px;
                margin: 20px;
                z-index: 100;
            }
            .upload-group2 {
                top: 234px;
                left: 234px;
                width: 293px;
                height: 136px;
                display: flex;
                position: absolute;
                align-items: flex-start;
                flex-shrink: 1;
                justify-content: center;
            }
            .upload-text {
                top: 0px;
                left: 0px;
                color: #ffffff;
                right: 0px;
                margin: auto;
                position: absolute;
                font-size: 24px;
                text-align: center;
            }
            .upload-text1 {
                top: 51px;
                left: 0px;
                color: #ffffff;
                right: 0px;
                margin: auto;
                position: absolute;
                text-align: center;
            }
            .upload-text4 {
                top: 90px;
                left: 0px;
                color: #ffffff;
                right: 0px;
                margin: auto;
                position: absolute;
                text-align: center;
            }
            .upload-container1 {
                flex: 0 0 auto;
                left: 0px;
                right: 0px;
                width: 878px;
                bottom: 36px;
                height: 337px;
                margin: auto;
                display: flex;
                position: absolute;
                align-items: center;
                flex-direction: column;
            }
            .upload-notification {
                flex: 0 0 auto;
                width: 683px;
                border: 2px dashed rgba(120, 120, 120, 0.4);
                height: 100px;
                display: flex;
                align-items: flex-start;
                flex-direction: column;
            }
            @media(max-width: 1600px) {
                .upload-upload-container {
                    top: 102px;
                    left: 0px;
                    right: 0px;
                    margin: auto;
                    align-items: flex-start;
                    justify-content: center;
                }
                .upload-drop-box {
                    left: 0px;
                    width: 100%;
                    bottom: -21px;
                    height: 100%;
                    position: absolute;
                    align-self: center;
                }
                .upload-uploadto-cloud {
                    padding-right: 20px;
                }
            }
            @media(max-width: 1366px) {
                .upload-upload-container {
                    left: 0px;
                    right: 0px;
                    width: 640px;
                    height: 340px;
                    margin: auto;
                }
                .upload-drop-box {
                    height: 363px;
                    margin-bottom: 0px;
                }
                .upload-uploadto-cloud {
                    z-index: 100;
                }
                .upload-group2 {
                    left: 0px;
                    right: 0px;
                    bottom: 2px;
                    margin: auto;
                }
                .upload-text {
                    top: 4px;
                    left: 0px;
                    color: #ffffff;
                    right: 0px;
                    margin: auto;
                    position: absolute;
                    font-size: 24px;
                    text-align: center;
                    font-family: Barlow;
                }
                .upload-text1 {
                    top: 39px;
                    left: 0px;
                    color: rgb(255, 255, 255);
                    right: 0px;
                    margin: auto;
                    position: absolute;
                    align-self: flex-end;
                    text-align: center;
                    font-family: Barlow;
                }
                .upload-text2 {
                    align-self: flex-end;
                }
                .upload-text4 {
                    left: 0px;
                    color: rgb(255, 255, 255);
                    right: 0px;
                    bottom: 28px;
                    margin: auto;
                    position: absolute;
                    text-align: center;
                    font-family: Barlow;
                }
            }
            @media(max-width: 1280px) {
                .upload-container {
                    box-shadow: 50px 50px 40px 0px rgba(0, 0, 0, 0.53);
                }
                .upload-drop-box {
                    height: 356px;
                    box-shadow: 50px 50px 1500px 0px #000000;
                }
                .upload-container1 {
                    left: 0px;
                    right: 0px;
                    margin: auto;
                    align-items: center;
                }
                .upload-notification {
                    justify-content: center;
                }
            }


        </style>

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
