package se.kth.iv1351.soundgoodjdbc.model;
import java.sql.Timestamp;
import java.time.LocalDate;

public class CreateRental implements CreateRentalDTO{
    private String maximumRentingPeriod;
    private String studentId;
    private String availableInstrumentId;
    private Timestamp startDate;
    private Timestamp endDate;
    private String status;

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

    public String getMaximumRentingPeriod(){
        return maximumRentingPeriod;
    }

    public String getStudentId(){
        return studentId;
    }

    public String getAvailableInstrumentId(){
        return availableInstrumentId;
    }

    public Timestamp getStartDate(){
        return startDate;
    }

    public Timestamp getEndDate(){
        return endDate;
    }

    public String getStatus(){
        return status;
    }
}
