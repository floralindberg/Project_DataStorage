package se.kth.iv1351.soundgoodjdbc.integration;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import se.kth.iv1351.soundgoodjdbc.model.AvailableInstrument;
import se.kth.iv1351.soundgoodjdbc.model.CreateRentalDTO;
import se.kth.iv1351.soundgoodjdbc.model.Rental;

public class SoundgoodDAO {
    private static final String INSTRUMENT_COLUMN_NAME = "instrument_name";
    private static final String INSTRUMENT_TABLE_NAME = "instrument";
    private static final String INSTRUMENT_PK_NAME = "instrument_id";
    private static final String AVAIL_INSTR_BRAND_NAME = "brand";
    private static final String AVAIL_INSTR_PRICE_NAME = "price";
    private static final String AVAIL_INSTR_QUANTITY_NAME = "quantity";
    private static final String AVAIL_INSTR_TABLE_NAME = "available_instrument";
    private static final String STUDENT_TABLE_NAME = "student";
    private static final String STUDENT_PK_NAME = "student_id";
    private static final String AVAIL_INSTR_PK_NAME = "available_instrument_id";
    private static final String RENTAL_STATUS_NAME = "status";
    private static final String PERSON_TABLE_NAME = "person";
    private static final String PERSON_PK_NAME = "person_id";
    private static final String RENTAL_TABLE_NAME = "rental";
    private static final String RENTAL_MAXIMUM_RENTING_PERIOD = "maximum_renting_period";
    private static final String RENTAL_START_DATE = "start_date";
    private static final String RENTAL_END_DATE = "end_date";
    private static final String NAME_STUDENT = "student_name";

    private Connection connection;
    private PreparedStatement findAllAvailableInstruments;
    private PreparedStatement findSpecificAvailableInstruments;
    private PreparedStatement createRental;
    private PreparedStatement findAllRentals;
    private PreparedStatement findSpecificRental;
    private PreparedStatement terminateRental;
    private PreparedStatement lockRental;
    private PreparedStatement lockAvailableInstrument;

    /**
     * Constructs a new DAO object connected to the bank database.
     */
    public SoundgoodDAO() throws SoundgoodDBException {
        try {
            connectToSoundGoodDB();
            prepareStatements();
        } catch (ClassNotFoundException | SQLException exception) {
            throw new SoundgoodDBException("Could not connect to datasource.", exception);
        }
    }

    private void connectToSoundGoodDB() throws ClassNotFoundException, SQLException {
        connection = DriverManager.getConnection("jdbc:postgresql://localhost:5432/sgms",
                "postgres", "1234");
        connection.setAutoCommit(false);
    }

    private void prepareStatements() throws SQLException {
        findAllAvailableInstruments = connection.prepareStatement(
                "SELECT i." + INSTRUMENT_COLUMN_NAME + ", ai." + AVAIL_INSTR_BRAND_NAME + ", ai."
                        + AVAIL_INSTR_PRICE_NAME + ", ai." + AVAIL_INSTR_QUANTITY_NAME +
                        " FROM " + AVAIL_INSTR_TABLE_NAME + " ai" +
                        " JOIN " + INSTRUMENT_TABLE_NAME + " i ON i." + INSTRUMENT_PK_NAME + " = ai."
                        + INSTRUMENT_PK_NAME +
                        " WHERE ai." + AVAIL_INSTR_QUANTITY_NAME + " > '0'" +
                        " ORDER BY i." + INSTRUMENT_COLUMN_NAME);

        findSpecificAvailableInstruments = connection.prepareStatement(
                "SELECT i." + INSTRUMENT_COLUMN_NAME + ", ai." + AVAIL_INSTR_BRAND_NAME + ", ai."
                        + AVAIL_INSTR_PRICE_NAME + ", ai." + AVAIL_INSTR_QUANTITY_NAME +
                        " FROM " + AVAIL_INSTR_TABLE_NAME + " ai" +
                        " JOIN " + INSTRUMENT_TABLE_NAME + " i ON i." + INSTRUMENT_PK_NAME + " = ai."
                        + INSTRUMENT_PK_NAME +
                        " WHERE i." + INSTRUMENT_COLUMN_NAME + " = ?" + " AND ai." + AVAIL_INSTR_QUANTITY_NAME +
                        " > '0'");

        findAllRentals = connection.prepareStatement(
                "SELECT s." + STUDENT_PK_NAME + ", CONCAT(p.first_name, ' ', p.last_name) AS " + NAME_STUDENT + ", " +
                        " i." + INSTRUMENT_COLUMN_NAME + " , ai." + AVAIL_INSTR_BRAND_NAME + " , ai."
                        + AVAIL_INSTR_PRICE_NAME + " , r." +
                        RENTAL_STATUS_NAME + ", ai." + AVAIL_INSTR_PK_NAME +
                        " FROM " + STUDENT_TABLE_NAME + " s " +
                        " JOIN " + PERSON_TABLE_NAME + " p" + " ON  p." + PERSON_PK_NAME + " = s." + PERSON_PK_NAME +
                        " JOIN " + RENTAL_TABLE_NAME + " r ON r." + STUDENT_PK_NAME + " = s. " + STUDENT_PK_NAME +
                        " JOIN " + AVAIL_INSTR_TABLE_NAME + " ai ON ai. " + AVAIL_INSTR_PK_NAME + " = r. "
                        + AVAIL_INSTR_PK_NAME +
                        " JOIN " + INSTRUMENT_TABLE_NAME + " i ON i. " + INSTRUMENT_PK_NAME + " = ai. "
                        + INSTRUMENT_PK_NAME);

        findSpecificRental = connection.prepareStatement(
                "SELECT s." + STUDENT_PK_NAME + ", CONCAT(p.first_name, ' ', p.last_name) AS " + NAME_STUDENT + ", " +
                        " i." + INSTRUMENT_COLUMN_NAME + " , ai." + AVAIL_INSTR_BRAND_NAME + " , ai."
                        + AVAIL_INSTR_PRICE_NAME + " , r." +
                        RENTAL_STATUS_NAME + ", ai." + AVAIL_INSTR_PK_NAME +
                        " FROM " + STUDENT_TABLE_NAME + " s " +
                        " JOIN " + PERSON_TABLE_NAME + " p" + " ON  p." + PERSON_PK_NAME + " = s." + PERSON_PK_NAME +
                        " JOIN " + RENTAL_TABLE_NAME + " r ON r." + STUDENT_PK_NAME + " = s. " + STUDENT_PK_NAME +
                        " JOIN " + AVAIL_INSTR_TABLE_NAME + " ai ON ai. " + AVAIL_INSTR_PK_NAME + " = r. "
                        + AVAIL_INSTR_PK_NAME +
                        " JOIN " + INSTRUMENT_TABLE_NAME + " i ON i." + INSTRUMENT_PK_NAME + " = ai. "
                        + INSTRUMENT_PK_NAME +
                        " WHERE s." + STUDENT_PK_NAME + " = ?");

        lockAvailableInstrument = connection.prepareStatement(
                "SELECT " + AVAIL_INSTR_PK_NAME + ", " + AVAIL_INSTR_PRICE_NAME +
                        " FROM " + AVAIL_INSTR_TABLE_NAME +
                        " WHERE " + AVAIL_INSTR_PK_NAME + "= ?" +
                        " FOR UPDATE");

        createRental = connection.prepareStatement(
                "INSERT INTO " + RENTAL_TABLE_NAME +
                        " (" + RENTAL_MAXIMUM_RENTING_PERIOD + ", " + STUDENT_PK_NAME + ", "
                        + AVAIL_INSTR_PK_NAME + ", " + RENTAL_START_DATE + "," + RENTAL_END_DATE + ","
                        + RENTAL_STATUS_NAME + ", " + AVAIL_INSTR_PRICE_NAME + ") " + "VALUES (?, ?, ?, ?, ?, ?, ?)");

        lockRental = connection.prepareStatement(
                "SELECT " + STUDENT_PK_NAME + ", " + AVAIL_INSTR_PK_NAME +
                        " FROM " + RENTAL_TABLE_NAME +
                        " WHERE " + STUDENT_PK_NAME + "= ? AND " + AVAIL_INSTR_PK_NAME + "= ?" +
                        " AND " + RENTAL_STATUS_NAME + "= 'Active'" +
                        " FOR UPDATE");

        terminateRental = connection.prepareStatement(
                "UPDATE " + RENTAL_TABLE_NAME + " " +
                        " SET " + RENTAL_STATUS_NAME + " = 'Ended'" +
                        " WHERE " + STUDENT_PK_NAME + " =  ? AND " +
                        AVAIL_INSTR_PK_NAME + " = ? AND " + RENTAL_STATUS_NAME + " = 'Active' ");
    }

    public List<AvailableInstrument> findAllAvailableInstruments() throws SoundgoodDBException {
        String failureMsg = "Could not list instruments.";
        List<AvailableInstrument> availableInstrument = new ArrayList<>();
        try (ResultSet result = findAllAvailableInstruments.executeQuery()) {
            while (result.next()) {
                availableInstrument.add(new AvailableInstrument(result.getString(INSTRUMENT_COLUMN_NAME),
                        result.getString(AVAIL_INSTR_BRAND_NAME),
                        result.getString(AVAIL_INSTR_QUANTITY_NAME),
                        result.getString(AVAIL_INSTR_PRICE_NAME)));
            }
            connection.commit();
        } catch (SQLException sqle) {
            handleException(failureMsg, sqle);
        }
        return availableInstrument;
    }

    public List<AvailableInstrument> findSpecificAvailableInstruments(String instrument)
            throws SoundgoodDBException, SQLException {
        String failureMsg = "Could not list instruments.";
        findSpecificAvailableInstruments.setString(1, instrument);
        List<AvailableInstrument> availableInstrument = new ArrayList<>();
        try (ResultSet result = findSpecificAvailableInstruments.executeQuery()) {
            while (result.next()) {
                availableInstrument.add(new AvailableInstrument(result.getString(INSTRUMENT_COLUMN_NAME),
                        result.getString(AVAIL_INSTR_BRAND_NAME),
                        result.getString(AVAIL_INSTR_QUANTITY_NAME),
                        result.getString(AVAIL_INSTR_PRICE_NAME)));
            }
            connection.commit();
        } catch (SQLException sqle) {
            handleException(failureMsg, sqle);
        }
        return availableInstrument;
    }

    private void addRentals(List<Rental> rentals, ResultSet result) throws SoundgoodDBException, SQLException {

        rentals.add(new Rental(result.getString(STUDENT_PK_NAME),
                result.getString(AVAIL_INSTR_PK_NAME),
                result.getString(NAME_STUDENT),
                result.getString(INSTRUMENT_COLUMN_NAME),
                result.getString(AVAIL_INSTR_BRAND_NAME),
                result.getString(AVAIL_INSTR_PRICE_NAME),
                result.getString(RENTAL_STATUS_NAME)));
    }

    public List<Rental> findaAllRentals() throws SoundgoodDBException {
        String failureMsg = "Could not find rentals";
        List<Rental> rentals = new ArrayList<>();
        try (ResultSet result = findAllRentals.executeQuery()) {
            while (result.next()) {
                addRentals(rentals, result);
            }
            connection.commit();
        } catch (SQLException sqle) {
            handleException(failureMsg, sqle);
        }
        return rentals;
    }

    public List<Rental> findSpecificRental(String id) throws SoundgoodDBException, SQLException {
        String failureMsg = "Could not find rentals";
        int studentId = Integer.parseInt(id);
        findSpecificRental.setInt(1, studentId);
        List<Rental> rentals = new ArrayList<>();
        try (ResultSet result = findSpecificRental.executeQuery()) {
            while (result.next()) {
                addRentals(rentals, result);
            }
            connection.commit();
        } catch (SQLException sqle) {
            handleException(failureMsg, sqle);
        }
        return rentals;
    }

    private void handleException(String failureMsg, Exception cause) throws SoundgoodDBException {
        String completeFailureMsg = failureMsg;
        try {
            connection.rollback();
        } catch (SQLException rollbackExc) {
            completeFailureMsg = completeFailureMsg +
                    ". Also failed to rollback transaction because of: " + rollbackExc.getMessage();
        }

        if (cause != null) {
            throw new SoundgoodDBException(failureMsg, cause);
        } else {
            throw new SoundgoodDBException(failureMsg);
        }
    }

    public void createRental(CreateRentalDTO rental) throws SoundgoodDBException, SQLException {
        String failureMsg = "Could not create the rental for student with id: " + rental.getStudentId()
                + ", and available instrument id: " + rental.getAvailableInstrumentId();
        int updatedRows = 0;
        int availInstrumentId = Integer.parseInt(rental.getAvailableInstrumentId());

        lockAvailableInstrument.setInt(1, availInstrumentId);
        try (ResultSet result = lockAvailableInstrument.executeQuery();) {
            if (result.next()) {
                String price = result.getString(2);

                createRental.setString(1, rental.getMaximumRentingPeriod());
                createRental.setInt(2, Integer.parseInt(rental.getStudentId()));
                createRental.setInt(3, availInstrumentId);
                createRental.setTimestamp(4, rental.getStartDate());
                createRental.setTimestamp(5, rental.getEndDate());
                createRental.setString(6, rental.getStatus());
                createRental.setString(7, price);
            }
            updatedRows = createRental.executeUpdate();

            if (updatedRows != 1) {
                handleException(failureMsg, null);
            }
            connection.commit();
        } catch (SQLException sqle) {
            handleException(failureMsg, sqle);
        }
    }

    public void updateTerminateRental(String studentId, String availableInstrumentId)
            throws SoundgoodDBException, SQLException {
        String failureMsg = "Could not end the rental for student with id: " + studentId
                + ", and available instrument id: " + availableInstrumentId;
        int updatedRows = 0;
        int student = Integer.parseInt(studentId);
        int availInstrumentId = Integer.parseInt(availableInstrumentId);

        lockRental.setInt(1, student);
        lockRental.setInt(2, availInstrumentId);

        try (ResultSet result = lockRental.executeQuery();) {
            if (result.next()) {
                terminateRental.setInt(1, student);
                terminateRental.setInt(2, availInstrumentId);

                updatedRows = terminateRental.executeUpdate();
                if (updatedRows == 0) {
                    handleException(failureMsg, null);
                }
                connection.commit();
            }
        } catch (SQLException sqle) {
            handleException(failureMsg, sqle);
        }
    }
}
