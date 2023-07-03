<%@ page import="java.io.*, java.util.*, javax.servlet.http.*, org.apache.poi.ss.usermodel.*, org.apache.poi.openxml4j.exceptions.InvalidFormatException" %>

<%
    // Get the uploaded file
    Part filePart = request.getPart("file");
    String fileName = ((Part) filePart).getSubmittedFileName();

    // Validate the file extension
    if (!fileName.endsWith(".xlsx")) {
        out.println("<h2>Error!</h2>");
        out.println("<p>Please upload a valid Excel (.xlsx) file.</p>");
        return;
    }

    // Save the file to a temporary location
    String uploadPath = "C:\\uploads\\"; // Specify your desired upload path
    File file = new File(uploadPath + fileName);
    try (InputStream inputStream = filePart.getInputStream();
         OutputStream outputStream = new FileOutputStream(file)) {
        byte[] buffer = new byte[1024];
        int bytesRead;
        while ((bytesRead = inputStream.read(buffer)) != -1) {
            outputStream.write(buffer, 0, bytesRead);
        }
    } catch (IOException e) {
        e.printStackTrace();
        out.println("<h2>Error!</h2>");
        out.println("<p>An error occurred while saving the uploaded filez.</p>");
        return;
    }

    // Validate the uploaded Excel document
    try {
        Workbook workbook = WorkbookFactory.create(file);
        Sheet sheet = workbook.getSheetAt(0);
        // Perform your specific validation logic here
        // For example, check the number of columns
        int expectedColumns = 3;
        Row headerRow = sheet.getRow(0);
        int actualColumns = headerRow == null ? 0 : headerRow.getLastCellNum();
        boolean isValid = actualColumns == expectedColumns;

        // Display the validation result
        if (isValid) {
            out.println("<h2>Validation Successful!</h2>");
            out.println("<p>The uploaded Excel document is valid.</p>");
        } else {
            out.println("<h2>Validation Failed!</h2>");
            out.println("<p>The uploaded Excel document is invalid.</p>");
        }
    } catch (Exception e) {
        if (e instanceof InvalidFormatException) {
            e.printStackTrace();
            out.println("<h2>Error!</h2>");
            out.println("<p>The uploaded file is not a valid Excel document.</p>");
        } else if (e instanceof IOException) {
            e.printStackTrace();
            out.println("<h2>Error!</h2>");
            out.println("<p>An error occurred while reading the uploaded file.</p>");
        } else {
            e.printStackTrace();
            out.println("<h2>Error!</h2>");
            out.println("<p>An error occurred while processing the uploaded file.</p>");
        }
    } finally {
        // Delete the temporary file
        file.delete();
    }
%>