page 50103 "Rental Order Line"
{
    Caption = 'Rental Order Line';
    PageType = List;
    SourceTable = "Rental Order Line";
    UsageCategory = Administration;
    ApplicationArea = All;
    // Editable = false;

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
                }
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
                field("Price a day"; Rec."Price a day")
                {
                    ToolTip = 'Specifies the value of the Price a day field';
                    ApplicationArea = All;
                }
                field("Days Amt."; Rec."Days Amt.")
                {
                    Caption = 'Days Amt.';
                    ToolTip = 'Specifies the value of the Days Amt. field';
                    ApplicationArea = All;
                }
                field("Total Discount"; Rec."Line Discount")
                {
                    Caption = 'Total Discount';
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

}
