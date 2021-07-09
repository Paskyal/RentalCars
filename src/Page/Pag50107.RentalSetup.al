page 50107 "Rental Setup"
{
    Caption = 'Rental Setup';
    SourceTable = "Rental Setup";
    ApplicationArea = all;
    UsageCategory = Administration;
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;

    layout
    {
        area(content)
        {
            group(Numbering)
            {
                Caption = 'Numbering';
                field("Order Nos."; Rec."Order Nos.")
                {
                    ToolTip = 'Specifies the value of the Order Nos. field';
                    ApplicationArea = All;
                }
                field("Posted Order Nos."; Rec."Posted Order Nos.")
                {
                    ToolTip = 'Specifies the value of the Posted Order Nos. field';
                    ApplicationArea = All;
                }
            }
        }
    }

}
