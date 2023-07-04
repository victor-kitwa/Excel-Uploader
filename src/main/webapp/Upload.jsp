<%@ page import="java.io.*, java.util.*, javax.servlet.http.*, org.apache.poi.ss.usermodel.*, org.apache.poi.openxml4j.exceptions.InvalidFormatException" %>
<%@ page import="javax.servlet.annotation.MultipartConfig" %>
<%@ page import="javax.servlet.http.HttpServletResponse" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.Timestamp" %>

<%
    // Get the uploaded file
    javax.servlet.http.Part filePart = request.getPart("file");
    List<String> errorMessages = new ArrayList<>(); // List to store error messages

    if (filePart == null || filePart.getSize() == 0) {
        errorMessages.add("No file selected for upload.");
    } else {
        String fileName = filePart.getSubmittedFileName();
        // Validate the file extension
        if (!fileName.endsWith(".xlsx")) {
            errorMessages.add("Please upload a valid Excel (.xlsx) file.");
        } else {
            // Save the file to a temporary location
            String uploadPath = "D:\\Program Files\\ExcelUploader\\uploads"; //  desired upload path
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
                errorMessages.add("An error occurred while saving the uploaded file.");
            }

            // Validate the uploaded Excel document
            try {
                Workbook workbook = WorkbookFactory.create(file);
                Sheet sheet = workbook.getSheetAt(0);
                // Perform validation logic
                //  check the number of columns
                int expectedColumns = 3;
                Row headerRow = sheet.getRow(0);
                int actualColumns = headerRow == null ? 0 : headerRow.getLastCellNum();
                boolean isValid = actualColumns == expectedColumns;

                // Establish a database connection
                String jdbcUrl = "jdbc:mysql://localhost:3306/excels";
                String username = "root";
                String password = "admin";
                try (Connection connection = DriverManager.getConnection(jdbcUrl, username, password)) {
                    // Prepare the SQL statement
                    String sql = "INSERT INTO uploads (id, document_name, upload_time, document_content) VALUES (?, ?, ?, ?)";
                    PreparedStatement statement = connection.prepareStatement(sql);
                    statement.setString(1, fileName);
                    statement.setBinaryStream(2, new FileInputStream(file));
                    statement.setTimestamp(3, new Timestamp(System.currentTimeMillis()));

                    // Execute the SQL statement
                    int rowsAffected = statement.executeUpdate();
                    if (rowsAffected > 0) {
                        errorMessages.add("File upload was successful!");
                    } else {
                        errorMessages.add("Error: The file requesting upload is not a valid xlsx document.<br/>The system only supports Excel documents.");
                    }
                } catch (Exception e) {
                    if (e instanceof InvalidFormatException) {
                        e.printStackTrace();
                        errorMessages.add("Error: The file requesting upload is not a valid xlsx document.<br/>The system only supports Excel documents.");
                    } else if (e instanceof IOException) {
                        e.printStackTrace();
                        errorMessages.add("An error occurred while reading the uploaded file.");
                    } else {
                        e.printStackTrace();
                        errorMessages.add("An error occurred while processing the uploaded file.");
                    }
                } finally {
                    // Delete the temporary file
                    file.delete();
                }
            } catch (Exception e) {
                e.printStackTrace();
                errorMessages.add("An error occurred while processing the uploaded file.");
            }
        }
    }

    // Store the error messages in the session
    session.setAttribute("errorMessages", errorMessages);

    // Redirect to the index.jsp page
    response.sendRedirect("index.jsp");
%>
