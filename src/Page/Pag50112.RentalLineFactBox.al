page 50112 "Rental Line FactBox"
{

    Caption = 'Rental Line FactBox';
    PageType = CardPart;
    SourceTable = "Rental Order Line";

    layout
    {
        area(content)
        {
            field("Car No."; Rec."Car No.")
            {
                ToolTip = 'Specifies the value of the Item No. field';
                ApplicationArea = All;
            }
            field("Car Description"; Rec."Car Description")
            {
                ToolTip = 'Specifies the value of the Car Description field';
                ApplicationArea = All;
            }
            field("Average Cost"; Rec."Average Cost")
            {
                ToolTip = 'Specifies the value of the Average Cost field';
                ApplicationArea = All;
            }
            field("Qty.of days in rent"; RentalHistory.CountDaysInRent(Rec."Car No."))
            {
                Caption = 'Qty.of days in rent';
                ToolTip = 'Specifies the value of the Qty.of days in rent field';
                ApplicationArea = All;

            }
            field("Idle Days"; IdleDays())
            {
                Caption = 'Idle days';
                ToolTip = 'Specifies the value of the Idle Days field';
                ApplicationArea = All;
            }
        }
    }
    procedure IdleDays(): Integer
    var
    // RentalPostedOrderLine: Record "Rental Posted Order Line";
    begin
        //     RentalPostedOrderLine.SetRange("Car No.", Rec."Car No.");
        //     RentalPostedOrderLine.SetFilter("Starting Date", '<>0');
        //     if RentalPostedOrderLine.FindFirst() then begin //todo

        //         RentalPostedOrderLine.SETFILTER("Starting Date", '%1|%1..%2|<%1&<%2|>%1&<%2', StartingDate, EndingDate);
        //         RentalPostedOrderLine.SETFILTER("Ending Date", '%2|%1..%2|>%1&<%2|>%1', StartingDate, EndingDate);
        //     end else
        //         RentalPostedOrderLine.SETFILTER("Starting Date", '%1..', StartingDate);
        //     if not RentalPostedOrderLine.IsEmpty() = IsAvailable then
        //         CurrReport.Skip();
    end;

    var
        RentalHistory: Codeunit "Rental History";

}
