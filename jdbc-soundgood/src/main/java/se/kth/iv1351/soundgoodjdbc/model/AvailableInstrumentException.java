package se.kth.iv1351.soundgoodjdbc.model;

public class AvailableInstrumentException extends Exception {

/**
 * Thrown when create, read or delete of an account fails.
 */

    /**
     * Create a new instance thrown because of the specified reason.
     *
     * @param reason Why the exception was thrown.
     */
    public AvailableInstrumentException(String reason) {
        super(reason);
    }

    /**
     * Create a new instance thrown because of the specified reason and exception.
     *
     * @param reason    Why the exception was thrown.
     * @param rootCause The exception that caused this exception to be thrown.
     */
    public AvailableInstrumentException(String reason, Throwable rootCause) {
        super(reason, rootCause);
    }



}