page 50106 "Rental Customers"
{
    ApplicationArea = All;
    Caption = 'Customers';
    PageType = List;
    SourceTable = Customer;
    UsageCategory = Lists;
    CardPageID = "Customer Card";
    Editable = false;
    RefreshOnActivate = true;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field';
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Contact field';
                    ApplicationArea = All;
                    Caption = 'Name';
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ToolTip = 'Specifies the value of the Phone No. field';
                    ApplicationArea = All;
                }
                field("Rental Discount"; Rec."Rental Discount")
                {
                    ToolTip = 'Specifies the value of the Discount field';
                    ApplicationArea = All;
                }
                field(Payments; Rec.Payments)
                {
                    ToolTip = 'Specifies the value of the Payments field';
                    ApplicationArea = All;
                }
                field(Balance; Rec.Balance)
                {
                    ToolTip = 'Specifies the value of the Balance field';
                    ApplicationArea = All;
                }
            }
        }
    }

}
