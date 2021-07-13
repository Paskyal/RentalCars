/// <summary>
/// PageExtension Rental Customer Card (ID 50100) extends Record Customer Card.
/// </summary>
pageextension 50100 "Rental Customer Card" extends "Customer Card"
{
    Layout
    {
        addafter("Disable Search by Name")
        {
            field("Customer Discount"; Rec."Customer Discount")
            {
                ToolTip = 'Specifies the value of the Discount field';
                ApplicationArea = All;
                MaxValue = 100;
                MinValue = 0;

            }
        }


    }

}
