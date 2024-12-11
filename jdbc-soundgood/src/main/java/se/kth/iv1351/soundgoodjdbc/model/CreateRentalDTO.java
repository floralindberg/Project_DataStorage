package se.kth.iv1351.soundgoodjdbc.model;
import java.sql.Timestamp;

public interface CreateRentalDTO {

    public String getMaximumRentingPeriod();

    public String getStudentId();

    public String getAvailableInstrumentId();

    public Timestamp getStartDate();

    public Timestamp getEndDate();

    public String getStatus();

}
