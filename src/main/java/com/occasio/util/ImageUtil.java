//package com.occasio.util;
//
////import java.io.File;
//import java.io.IOException;
//import java.io.InputStream;
//import java.nio.file.Files;
//import java.nio.file.Path;
//import java.nio.file.Paths;
//import java.nio.file.StandardCopyOption;
//import java.util.UUID;
//import java.util.logging.Level;
//import java.util.logging.Logger;
//
//import jakarta.servlet.http.Part;
//
///**
// * Utility class for handling image file uploads securely and robustly.
// */
//public final class ImageUtil { // Make final as it's a utility class
//
//    private static final Logger LOGGER = Logger.getLogger(ImageUtil.class.getName());
//
//    // Private constructor to prevent instantiation
//    private ImageUtil() {
//        throw new IllegalStateException("Utility class should not be instantiated.");
//    }
//
//    /**
//     * Extracts the original filename from the Part's submitted file name.
//     *
//     * @param part The file part from the multipart request.
//     * @return The original filename, or null if the part is null or no filename is submitted.
//     */
//    public static String getOriginalFilename(Part part) {
//        if (part == null) {
//            return null;
//        }
//        String submittedFileName = part.getSubmittedFileName();
//        if (submittedFileName == null || submittedFileName.trim().isEmpty()) {
//            return null;
//        }
//        // Handle potential path characters in the submitted filename (some browsers might include them)
//        return Paths.get(submittedFileName).getFileName().toString();
//    }
//
//    /**
//     * Extracts the file extension from a filename.
//     *
//     * @param filename The filename (e.g., "photo.jpg").
//     * @return The extension including the dot (e.g., ".jpg"), or an empty string if no extension found.
//     */
//    public static String getFileExtension(String filename) {
//        if (filename == null || filename.lastIndexOf('.') == -1) {
//            return ""; // No extension found
//        }
//        return filename.substring(filename.lastIndexOf('.')); // Includes the dot
//    }
//
//    /**
//     * Generates a unique filename using UUID and the original file extension.
//     *
//     * @param originalFilename The original filename to extract the extension from.
//     * @return A unique filename (e.g., "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx.jpg").
//     */
//    public static String generateUniqueFilename(String originalFilename) {
//        String extension = getFileExtension(originalFilename);
//        return UUID.randomUUID().toString() + extension;
//    }
//
//    /**
//     * Saves an uploaded file Part to a specified directory with a unique filename.
//     *
//     * @param part             The file Part from the request.
//     * @param baseUploadPath   The configured base directory where uploads should be stored.
//     * @param subFolder        The subfolder within the base path (e.g., "profile_pics").
//     * @param uniqueFilename   The unique filename (generated using generateUniqueFilename) to save the file as.
//     * @return The relative path where the file was saved (e.g., "profile_pics/unique_name.jpg"), or null if upload failed or no file was provided.
//     */
//    public static String saveImage(Part part, String baseUploadPath, String subFolder, String uniqueFilename) {
//        if (part == null || part.getSize() == 0 || uniqueFilename == null) {
//            LOGGER.fine("No file provided or filename is null.");
//            return null; // No file uploaded or no unique name provided
//        }
//
//        // Construct the full target directory path
//        Path uploadDirPath = Paths.get(baseUploadPath, subFolder);
//        // Construct the full target file path
//        Path filePath = uploadDirPath.resolve(uniqueFilename);
//
//        try {
//            // Ensure the target directory exists, create if necessary (including parents)
//            Files.createDirectories(uploadDirPath);
//
//            // Copy the file stream to the target path
//            try (InputStream fileContent = part.getInputStream()) {
//                Files.copy(fileContent, filePath, StandardCopyOption.REPLACE_EXISTING); // Use REPLACE_EXISTING defensively
//                LOGGER.log(Level.INFO, "Successfully uploaded file to: {0}", filePath);
//
//                // Return the relative path for storage in the database
//                // Using File.separator makes it OS-independent, but web paths usually use '/'
//                 return Paths.get(subFolder, uniqueFilename).toString().replace("\\", "/"); // Ensure forward slashes for web paths
//
//            } catch (IOException e) {
//                LOGGER.log(Level.SEVERE, "Could not save uploaded file: " + filePath, e);
//                // Attempt to delete partially written file if copy failed? Optional.
//                // Files.deleteIfExists(filePath);
//                return null; // Indicate failure
//            }
//        } catch (IOException e) {
//            LOGGER.log(Level.SEVERE, "Could not create upload directory: " + uploadDirPath, e);
//            return null; // Indicate failure
//        }
//    }
//}

package com.occasio.util;

import java.io.File;
import java.io.IOException;

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
	public boolean uploadImage(Part part, ServletContext context, String saveFolder) {
		String savePath = getSavePath(context, saveFolder);
		File fileSaveDir = new File(savePath);

		// Ensure the directory exists
		if (!fileSaveDir.exists()) {
			if (!fileSaveDir.mkdirs()) {
				System.err.println("Failed to create directory: " + fileSaveDir.getAbsolutePath());
				return false; // Failed to create the directory
			}
		}
		try {
			// Get the image name
			String imageName = getImageNameFromPart(part);
			// Create the file path
			String filePath = savePath + "/" + imageName;
			// Write the file to the server
			part.write(filePath);
			return true; // Upload successful
		} catch (IOException e) {
			e.printStackTrace(); // Log the exception
			return false; // Upload failed
		}
	}
	
	public String getSavePath(ServletContext context, String saveFolder) {
		String basePath = context.getRealPath("/resources/images/" + saveFolder + "/");
	    return basePath;
	}
}