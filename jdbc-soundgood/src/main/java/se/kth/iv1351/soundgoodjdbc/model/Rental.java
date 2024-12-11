package se.kth.iv1351.soundgoodjdbc.model;

public class Rental implements RentalDTO{
    private String studentId;
    private String availableInstrumentId;
    private String studentName;
    private String instrumentName;
    private String brand;
    private String price;
    private String status;

    public Rental(String studentId, String availableInstrumentId, String studentName, String instrumentName, String brand, String price, String status){
        this.studentId = studentId;
        this.availableInstrumentId = availableInstrumentId;
        this.studentName = studentName;
        this.instrumentName = instrumentName;
        this.brand = brand;
        this.price = price;
        this.status = status;
    }

    public String getStudentId(){
        return studentId;
    }

    public String getAvailableInstrumentId(){
        return availableInstrumentId;
    }

    public String getStudentName(){
        return studentName;
    }

    public String getInstrumentName(){
        return instrumentName;
    }

    public String getBrand(){
        return brand;

    }

    public String getPrice(){
        return price;
    }

    public String getStatus(){
        return status;
    }

}