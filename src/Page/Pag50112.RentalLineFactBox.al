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
            field(Availability; RentalHistory.CarAvailability())
            {
                ToolTip = 'Specifies the value of the Availability field';
                ApplicationArea = All;
                Caption = 'Availability';
            }
            field("Average Cost"; Rec."Average Cost")
            {
                ToolTip = 'Specifies the value of the Average Cost field';
                ApplicationArea = All;
            }
            field("Qty.of days in rent"; RentalHistory.DaysInRentCount(Rec."Car No."))
            {
                Caption = 'Qty.of days in rent';
                ToolTip = 'Specifies the value of the Qty.of days in rent field';
                ApplicationArea = All;

            }
            field("Idle Days"; RentalHistory.IdleDaysCount(Rec."Car No."))
            {
                Caption = 'Idle days';
                ToolTip = 'Specifies the value of the Idle Days field';
                ApplicationArea = All;
            }
        }
    }


    var
        RentalHistory: Codeunit "Rental History";

}
