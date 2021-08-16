codeunit 50101 "Rental History"
{
    trigger OnRun()
    begin
    end;

    procedure IdleDays(): Integer
    begin
        exit(0);
    end;

    procedure CountDaysInRent(CarNo: Code[20]): Integer
    var
        RentalPostedOrderLine: Record "Rental Posted Order Line";
    begin
        RentalPostedOrderLine.SetRange("Car No.", CarNo);
        RentalPostedOrderLine.CalcSums("Days Amt.");
        exit(RentalPostedOrderLine."Days Amt.");
    end;
}
