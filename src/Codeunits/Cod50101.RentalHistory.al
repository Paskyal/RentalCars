codeunit 50101 "Rental History"
{
    trigger OnRun()
    begin
    end;

    // procedure IdleDays(CarNo: Code[20]; "Starting Date": Date; "Ending Date": Date): Integer
    // begin
    //     exit(0);
    // end;

    procedure DaysInRentCount(CarNo: Code[20]): Integer
    var
        RentalPostedOrderLine: Record "Rental Posted Order Line";
    begin
        RentalPostedOrderLine.SetRange("Car No.", CarNo);
        RentalPostedOrderLine.CalcSums("Days Amt.");
        exit(RentalPostedOrderLine."Days Amt.");
    end;

    procedure CarAvailability(): Boolean
    begin

    end;

    procedure IdleDaysCount(CarNo: Code[20]): Integer
    var
        RentalPostedOrderLine: Record "Rental Posted Order Line";
        IdleDaysSum: Integer;
        StartDate: Date;
    begin
        RentalPostedOrderLine.SetCurrentKey("Starting Date");
        RentalPostedOrderLine.SetRange("Car No.", CarNo);
        RentalPostedOrderLine.Ascending := true;
        if RentalPostedOrderLine.FindFirst() then
            StartDate := RentalPostedOrderLine."Starting Date";
        RentalPostedOrderLine.SetCurrentKey("Ending Date");
        if RentalPostedOrderLine.FindLast() then
            IdleDaysSum := RentalPostedOrderLine."Ending Date" - StartDate - DaysInRentCount(CarNo) + 1;
        exit(IdleDaysSum);
    end;
}
