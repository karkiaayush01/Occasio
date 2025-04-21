package com.occasio.util;

//import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.UUID;
import java.util.logging.Level;
import java.util.logging.Logger;

import jakarta.servlet.http.Part;

/**
 * Utility class for handling image file uploads securely and robustly.
 */
public final class ImageUtil { // Make final as it's a utility class

    private static final Logger LOGGER = Logger.getLogger(ImageUtil.class.getName());

    // Private constructor to prevent instantiation
    private ImageUtil() {
        throw new IllegalStateException("Utility class should not be instantiated.");
    }

    /**
     * Extracts the original filename from the Part's submitted file name.
     *
     * @param part The file part from the multipart request.
     * @return The original filename, or null if the part is null or no filename is submitted.
     */
    public static String getOriginalFilename(Part part) {
        if (part == null) {
            return null;
        }
        String submittedFileName = part.getSubmittedFileName();
        if (submittedFileName == null || submittedFileName.trim().isEmpty()) {
            return null;
        }
        // Handle potential path characters in the submitted filename (some browsers might include them)
        return Paths.get(submittedFileName).getFileName().toString();
    }

    /**
     * Extracts the file extension from a filename.
     *
     * @param filename The filename (e.g., "photo.jpg").
     * @return The extension including the dot (e.g., ".jpg"), or an empty string if no extension found.
     */
    public static String getFileExtension(String filename) {
        if (filename == null || filename.lastIndexOf('.') == -1) {
            return ""; // No extension found
        }
        return filename.substring(filename.lastIndexOf('.')); // Includes the dot
    }

    /**
     * Generates a unique filename using UUID and the original file extension.
     *
     * @param originalFilename The original filename to extract the extension from.
     * @return A unique filename (e.g., "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx.jpg").
     */
    public static String generateUniqueFilename(String originalFilename) {
        String extension = getFileExtension(originalFilename);
        return UUID.randomUUID().toString() + extension;
    }

    /**
     * Saves an uploaded file Part to a specified directory with a unique filename.
     *
     * @param part             The file Part from the request.
     * @param baseUploadPath   The configured base directory where uploads should be stored.
     * @param subFolder        The subfolder within the base path (e.g., "profile_pics").
     * @param uniqueFilename   The unique filename (generated using generateUniqueFilename) to save the file as.
     * @return The relative path where the file was saved (e.g., "profile_pics/unique_name.jpg"), or null if upload failed or no file was provided.
     */
    public static String saveImage(Part part, String baseUploadPath, String subFolder, String uniqueFilename) {
        if (part == null || part.getSize() == 0 || uniqueFilename == null) {
            LOGGER.fine("No file provided or filename is null.");
            return null; // No file uploaded or no unique name provided
        }

        // Construct the full target directory path
        Path uploadDirPath = Paths.get(baseUploadPath, subFolder);
        // Construct the full target file path
        Path filePath = uploadDirPath.resolve(uniqueFilename);

        try {
            // Ensure the target directory exists, create if necessary (including parents)
            Files.createDirectories(uploadDirPath);

            // Copy the file stream to the target path
            try (InputStream fileContent = part.getInputStream()) {
                Files.copy(fileContent, filePath, StandardCopyOption.REPLACE_EXISTING); // Use REPLACE_EXISTING defensively
                LOGGER.log(Level.INFO, "Successfully uploaded file to: {0}", filePath);

                // Return the relative path for storage in the database
                // Using File.separator makes it OS-independent, but web paths usually use '/'
                 return Paths.get(subFolder, uniqueFilename).toString().replace("\\", "/"); // Ensure forward slashes for web paths

            } catch (IOException e) {
                LOGGER.log(Level.SEVERE, "Could not save uploaded file: " + filePath, e);
                // Attempt to delete partially written file if copy failed? Optional.
                // Files.deleteIfExists(filePath);
                return null; // Indicate failure
            }
        } catch (IOException e) {
            LOGGER.log(Level.SEVERE, "Could not create upload directory: " + uploadDirPath, e);
            return null; // Indicate failure
        }
    }
}