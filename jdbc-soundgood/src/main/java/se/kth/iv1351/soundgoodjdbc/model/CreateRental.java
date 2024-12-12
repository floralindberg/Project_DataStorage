package se.kth.iv1351.soundgoodjdbc.model;
import java.sql.Timestamp;
import java.time.LocalDate;

public class CreateRental implements CreateRentalDTO{
    private final String maximumRentingPeriod;
    private final String studentId;
    private final String availableInstrumentId;
    private final Timestamp startDate;
    private final Timestamp endDate;
    private final String status;

    public CreateRental(String studentId, String availableInstrumentId){
        this.maximumRentingPeriod = "365";
        this.studentId = studentId;
        this.availableInstrumentId = availableInstrumentId;
        LocalDate start = LocalDate.now();
        this.startDate = Timestamp.valueOf(start.atStartOfDay());
        LocalDate end = start.plusDays(365);
        this.endDate = Timestamp.valueOf(end.atStartOfDay());
        this.status = "Active";
    }

    @Override
    public String getMaximumRentingPeriod(){
        return maximumRentingPeriod;
    }

    @Override
    public String getStudentId(){
        return studentId;
    }

    @Override
    public String getAvailableInstrumentId(){
        return availableInstrumentId;
    }

    @Override
    public Timestamp getStartDate(){
        return startDate;
    }

    @Override
    public Timestamp getEndDate(){
        return endDate;
    }

    @Override
    public String getStatus(){
        return status;
    }
}
