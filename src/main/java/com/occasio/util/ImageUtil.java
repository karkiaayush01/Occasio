package com.occasio.util;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.Part;

/**
 * Utility class for handling image file uploads.
 * <p>
 * This class provides methods for extracting the file name from a {@link Part}
 * object and uploading the image file to a specified directory on the server.
 * </p>
 */
public class ImageUtil {

	/**
	 * Extracts the file name from the given {@link Part} object based on the
	 * "content-disposition" header.
	 * 
	 * <p>
	 * This method parses the "content-disposition" header to retrieve the file name
	 * of the uploaded image. If the file name cannot be determined, a default name
	 * "download.png" is returned.
	 * </p>
	 * 
	 * @param part the {@link Part} object representing the uploaded file.
	 * @return the extracted file name. If no filename is found, returns a default
	 *         name "download.png".
	 */
	public String getImageNameFromPart(Part part) {
		// Retrieve the content-disposition header from the part
		String contentDisp = part.getHeader("content-disposition");

		// Split the header by semicolons to isolate key-value pairs
		String[] items = contentDisp.split(";");

		// Initialize imageName variable to store the extracted file name
		String imageName = null;

		// Iterate through the items to find the filename
		for (String s : items) {
			if (s.trim().startsWith("filename")) {
				// Extract the file name from the header value
				imageName = s.substring(s.indexOf("=") + 2, s.length() - 1);
			}
		}

		// Check if the filename was not found or is empty
		if (imageName == null || imageName.isEmpty()) {
			// Assign a default file name if none was provided
			imageName = "";
		}

		// Return the extracted or default file name
		return imageName;
	}

	/**
	 * Uploads the image file from the given {@link Part} object to a specified
	 * directory on the server.
	 * 
	 * <p>
	 * This method ensures that the directory where the file will be saved exists
	 * and creates it if necessary. It writes the uploaded file to the server's file
	 * system. Returns {@code true} if the upload is successful, and {@code false}
	 * otherwise.
	 * </p>
	 * 
	 * @param part the {@link Part} object representing the uploaded image file.
	 * @return {@code true} if the file was successfully uploaded, {@code false}
	 *         otherwise.
	 */
	public boolean uploadImage(Part part, ServletContext context,  String saveFolder) {
		String savePath = getSavePath(saveFolder);
		String servletPath = getServletPath(context, saveFolder);
		
		File fileSaveDir = new File(savePath);
		File deploymentDir = new File(servletPath);

		// Ensure the directory exists
		if (!fileSaveDir.exists()) {
			if (!fileSaveDir.mkdirs()) {
				System.err.println("Failed to create directory: " + fileSaveDir.getAbsolutePath());
				return false; // Failed to create the directory
			}
		}
		
		//Ensure deployment directory exists
		if (!deploymentDir.exists() && !deploymentDir.mkdirs()) {
	        System.err.println("Failed to create deployment directory: " + deploymentDir.getAbsolutePath());
	        return false;
	    }
		
		try {
			// Get the image name
			String imageName = getImageNameFromPart(part);
			// Create the file path
			String filePath = savePath + File.separator + imageName;
			String servletSavePath = servletPath + File.separator + imageName; 
			
			System.out.println(servletSavePath);
			// Write the file to the server
			part.write(filePath);
			
			 // If we have a valid deployment path, copy the file there
	        if (servletSavePath != null) {
	            try {
	                Files.copy(Paths.get(filePath), Paths.get(servletSavePath), 
	                          StandardCopyOption.REPLACE_EXISTING);
	                System.out.println("Successfully copied to deployment path: " + servletSavePath);
	            } catch (IOException e) {
	                System.err.println("Warning: Failed to copy to deployment path: " + e.getMessage());
	                // Continue anyway - at least the first location was saved
	            }
	        }
			return true; // Upload successful
		} catch (IOException e) {
			e.printStackTrace(); // Log the exception
			return false; // Upload failed
		}
	}
	
	public String getSavePath(String saveFolder) {
		String basePath = "D:/Arpeet/College/Islington/Year2/Sem4/Advanced Programming/Occasio/src/main/webapp/resources/images/" + saveFolder;
	    return basePath;
	}
	
	public String getServletPath(ServletContext context, String saveFolder) {
		return context.getRealPath("/resources/images/" + saveFolder);
	}
}