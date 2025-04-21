package com.occasio.util;

import org.mindrot.jbcrypt.BCrypt;

/**
 * Utility class for securely handling passwords using the BCrypt hashing algorithm.
 * <p>
 * Provides methods for hashing passwords and verifying password attempts against stored hashes.
 * </p>
 * <p>
 * Requires the jBCrypt library (org.mindrot:jbcrypt).
 * </p>
 */
public final class PasswordUtil { // Mark as final as it's a utility class

    // The workload factor (log rounds) for BCrypt. Higher is more secure but slower.
    // 12 is a common and reasonable default. Adjust if needed based on performance/security requirements.
    private static final int WORKLOAD = 12;

    /**
     * Private constructor to prevent instantiation of this utility class.
     */
    private PasswordUtil() {
        throw new IllegalStateException("Utility class should not be instantiated.");
    }

    /**
     * Hashes a plain-text password using BCrypt with a generated salt.
     * The salt and workload factor are embedded within the resulting hash string.
     *
     * @param plainPassword The plain-text password to hash. Cannot be null or empty.
     * @return A BCrypt hash string representing the password (includes salt and cost factor).
     * @throws IllegalArgumentException if plainPassword is null or empty.
     */
    public static String hashPassword(String plainPassword) {
        if (plainPassword == null || plainPassword.isEmpty()) {
            throw new IllegalArgumentException("Password cannot be null or empty.");
        }
        // BCrypt.gensalt() automatically generates a salt with the default workload.
        // Or specify the workload: BCrypt.gensalt(WORKLOAD)
        String salt = BCrypt.gensalt(WORKLOAD);
        return BCrypt.hashpw(plainPassword, salt);
    }

    /**
     * Verifies a plain-text password attempt against a stored BCrypt hash.
     *
     * @param plainPassword  The plain-text password attempt (e.g., from a login form).
     * @param hashedPassword The stored BCrypt hash string retrieved from the database.
     * @return {@code true} if the plain password matches the hash, {@code false} otherwise.
     *         Returns {@code false} if either input is null/empty or if hashedPassword is not a valid BCrypt format.
     */
    public static boolean checkPassword(String plainPassword, String hashedPassword) {
        if (plainPassword == null || plainPassword.isEmpty() || hashedPassword == null || hashedPassword.isEmpty()) {
            // System.err.println("Password check failed: Null or empty input provided."); // Optional logging
            return false;
        }

        try {
            // BCrypt.checkpw handles extracting the salt and cost factor from the stored hash
            // and compares the plain password against it.
            return BCrypt.checkpw(plainPassword, hashedPassword);
        } catch (IllegalArgumentException e) {
            // This typically happens if the hashedPassword is not in a valid BCrypt format.
            System.err.println("Password check failed: Invalid hash format provided. " + e.getMessage());
            return false;
        } catch (Exception e) {
            // Catch any other unexpected errors during checkpw
            System.err.println("An unexpected error occurred during password check: " + e.getMessage());
            return false;
        }
    }
}