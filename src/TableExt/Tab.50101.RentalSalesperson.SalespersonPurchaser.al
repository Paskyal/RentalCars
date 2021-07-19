tableextension 50101 "Rental Salesperson" extends "Salesperson/Purchaser"
{
    fields
    {
        field(50100; "Rental No."; Code[30])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
        }
    }
}