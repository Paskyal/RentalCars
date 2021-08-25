codeunit 50101 "Rental History"
{
    trigger OnRun()
    begin
    end;

    procedure DaysInRentCount(CarNo: Code[20]): Integer
    var
        RentalPostedOrderLine: Record "Rental Posted Order Line";
    begin
        RentalPostedOrderLine.SetRange("Car No.", CarNo);
        RentalPostedOrderLine.CalcSums("Days Amt.");
        exit(RentalPostedOrderLine."Days Amt.");
    end;

    procedure CarAvailability(CarNo: Code[20]): Boolean
    var
        // RentalOrderLine: Record "Rental Order Line";
        RentalPostedOrderLine: Record "Rental Posted Order Line";
    begin
        RentalPostedOrderLine.SetRange("Car No.", CarNo);
        // RentalPostedOrderLine.SETFILTER("Starting Date", '=%1', Today); //'%1|%1..%2|<%1&<%2|>%1&<%2', Today RentalOrderLine."Starting Date", RentalOrderLine."Ending Date");
        // RentalPostedOrderLine.SETFILTER("Ending Date", '=%1', Today); //'%2|%1..%2|>%1&<%2|>%1', RentalOrderLine."Starting Date", RentalOrderLine."Ending Date");
        // IF RentalPostedOrderLine.IsEmpty() THEN
        if (RentalPostedOrderLine."Starting Date" <= Today) and (RentalPostedOrderLine."Ending Date" >= Today) then
            exit(false);
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