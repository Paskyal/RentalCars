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
            field("Qty.of days in rent"; DaysInRent())
            {
                ToolTip = 'Specifies the value of the Qty.of days in rent field';
                ApplicationArea = All;
            }
            field("Idle Days"; RentalHistory.IdleDays())
            {
                ToolTip = 'Specifies the value of the Average Cost field';
                ApplicationArea = All;
            }

            // }
        }
    }
    trigger OnAfterGetRecord()
    begin

    end;

    local procedure DaysInRent(): Integer
    var
        RentalPostedOrderLine: Record "Rental Posted Order Line";
    begin
        RentalPostedOrderLine.SetRange("Car No.", Rec."Car No.");
        RentalPostedOrderLine.CalcSums("Days Amt.");
        exit(RentalPostedOrderLine."Days Amt.");
    end;

    var
        RentalHistory: Codeunit "Rental History";
}
