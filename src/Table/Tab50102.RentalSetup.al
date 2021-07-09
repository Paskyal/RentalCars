table 50102 "Rental Setup"
{
    Caption = 'Rental Setup';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
        }
        field(2; "Order Nos."; Code[20])
        {
            Caption = 'Order Nos.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(3; "Posted Order Nos."; Code[20])
        {
            Caption = 'Posted Order Nos.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
    }

    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }

}
