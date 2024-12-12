package se.kth.iv1351.soundgoodjdbc.model;

public class Rental implements RentalDTO{
    private final String studentId;
    private final String availableInstrumentId;
    private final String studentName;
    private final String instrumentName;
    private final String brand;
    private final String price;
    private final String status;

    public Rental(String studentId, String availableInstrumentId, String studentName, String instrumentName, String brand, String price, String status){
        this.studentId = studentId;
        this.availableInstrumentId = availableInstrumentId;
        this.studentName = studentName;
        this.instrumentName = instrumentName;
        this.brand = brand;
        this.price = price;
        this.status = status;
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
    public String getStudentName(){
        return studentName;
    }

    @Override
    public String getInstrumentName(){
        return instrumentName;
    }

    @Override
    public String getBrand(){
        return brand;

    }

    @Override
    public String getPrice(){
        return price;
    }

    @Override
    public String getStatus(){
        return status;
    }

}