tableextension 50100 "Car" extends Item
{
    fields
    {
        //field(50100;
        // "Model,Year";
        // Text[50])
        // {
        //     Caption = 'Model,Year';
        //     DataClassification = CustomerContent;
        // }
        field(50101; Color; Text[20])
        {
            Caption = 'Color';
            DataClassification = CustomerContent;
        }
        field(50102; Transmission; Text[20])
        {
            Caption = 'Transmission';
            DataClassification = CustomerContent;
        }
        field(50103; Seats; Integer)
        {
            Caption = 'Seats';
            DataClassification = CustomerContent;
        }
        field(50104; "Fuel type"; Text[20])
        {
            Caption = 'Fuel type';
            DataClassification = CustomerContent;
        }
        field(50105; Mileage; Integer)
        {
            Caption = 'Mileage';
            DataClassification = CustomerContent;
        }
        field(50106; "Fuel Cons./100km"; Text[20])
        {
            Caption = 'Fuel Cons./100km';
            DataClassification = CustomerContent;
        }
        field(50107; "Price/1 day"; Integer)
        {
            Caption = 'Price/1 day';
            DataClassification = CustomerContent;
        }
        field(50108; "Doors"; Integer)
        {
            Caption = 'Doors';
            DataClassification = CustomerContent;
        }
        field(50109; "Trunk Vol./Bags"; Text[30])
        {
            Caption = 'Trunk Vol./Bags';
            DataClassification = CustomerContent;
        }
        field(50110; "Car Discount"; Decimal)
        {
            Caption = 'Car Discount';
            DataClassification = CustomerContent;
        }

    }

    // keys
    // {
    //     key(PK; "Model,Year")
    //     {

    //     }
    // }
}

