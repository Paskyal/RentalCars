page 50101 "Rental Order Line Part"
{
    Caption = 'Lines';
    PageType = ListPart;
    SourceTable = "Rental Order Line";
    UsageCategory = Administration;
    ApplicationArea = all;
    PopulateAllFields = true;
    AutoSplitKey = true;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Order No."; Rec."Order No.")
                {
                    ToolTip = 'Specifies the value of the Order No. field';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Car No."; Rec."Car No.")
                {
                    Caption = 'Car No.';
                    ToolTip = 'Specifies the value of the Car No. field';
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        Rec.CalcFields("Car Description");
                    end;
                }
                field("Car Description"; Rec."Car Description")
                {
                    ToolTip = 'Specifies the value of the "Car Description" field';
                    ApplicationArea = All;
                }
                field(Price; Rec."Price a day")
                {
                    ToolTip = 'Specifies the value of the Price field';
                    ApplicationArea = All;
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                    ToolTip = 'Specifies the value of the Unit Cost field';
                    ApplicationArea = All;
                }
                field("Starting Date"; Rec."Starting Date")
                {
                    ToolTip = 'Specifies the value of the Starting Date field';
                    ApplicationArea = All;
                    StyleExpr = CarUnavailable;
                }
                field("Ending Date"; Rec."Ending Date")
                {
                    ToolTip = 'Specifies the value of the Ending Date field';
                    ApplicationArea = All;
                    StyleExpr = CarUnavailable;
                }
                field("Days Amt."; Rec."Days Amt.")
                {
                    ToolTip = 'Specifies the value of the Days Amt. field';
                    ApplicationArea = All;
                }
                field("Rental Car Discount"; Rec."Rental Car Discount")
                {
                    ToolTip = 'Specifies the value of the Car Discount field';
                    ApplicationArea = All;
                }
                field("Line Discount"; Rec."Line Discount")
                {
                    Caption = 'Line Discount';
                    ToolTip = 'Specifies the value of the Total Discount field';
                    ApplicationArea = All;
                }
                field("Line Amount"; Rec."Line Amount")
                {
                    ToolTip = 'Specifies the value of the Line Amount field';
                    ApplicationArea = All;
                }
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        SetStyle();
    end;

    local procedure SetStyle()
    begin
        SetUnfavorableStyle(CarUnavailable);
    end;

    local procedure SetUnfavorableStyle(var Style: Text)
    var
        RentalPostedOrderLine: Record "Rental Posted Order Line";
    begin
        RentalPostedOrderLine.SetRange("Car No.", Rec."Car No.");
        RentalPostedOrderLine.SETFILTER("Starting Date", '%1|%1..%2|<%1&<%2|>%1&<%2', Rec."Starting Date", Rec."Ending Date");
        RentalPostedOrderLine.SETFILTER("Ending Date", '%2|%1..%2|>%1&<%2|>%1', Rec."Starting Date", Rec."Ending Date");
        IF not RentalPostedOrderLine.IsEmpty() THEN
            Style := 'Unfavorable'
        else
            Style := '';
    end;

    var
        CarUnavailable: Text;
}