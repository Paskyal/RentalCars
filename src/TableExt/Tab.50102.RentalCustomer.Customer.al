tableextension 50102 "Rental Customer" extends Customer
{
    fields
    {
        field(50100; "Rental Customer Discount"; Decimal)
        {
            Caption = 'Customer Discount';
            DataClassification = CustomerContent;
        }
        field(50101; "Rental No. of Posted Orders"; Integer)
        {
            CalcFormula = Count("Rental Posted Order" where("Customer No." = field("No.")));
            Caption = 'No. of Rental Posted Orders';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50102; "Rental No. of Orders"; Integer)
        {
            CalcFormula = Count("Rental Order" where("Customer No." = field("No.")));
            Caption = 'No. of Rental Orders';
            Editable = false;
            FieldClass = FlowField;
        }
    }
}