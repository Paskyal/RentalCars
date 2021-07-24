table 50103 "Rental Posted Order"
{
    Caption = 'Rental Posted Order';
    DataClassification = CustomerContent;
    LookupPageId = "Rental Posted Order line";
    DrillDownPageId = "Rental Posted Order line";
    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    GetRentalSetup();
                    NoSeriesMgt.TestManual(GetNoSeriesCode());
                end;
            end;
        }
        field(2; "Salesperson Name"; Code[50])
        {
            Caption = 'Salesperson Name';
            DataClassification = CustomerContent;
            TableRelation = "Salesperson/Purchaser";
        }
        field(3; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            DataClassification = CustomerContent;
            TableRelation = Customer;
            trigger OnValidate()
            begin
                CopyFromCustomer();
            end;
        }
        field(4; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            DataClassification = CustomerContent;
        }
        field(5; "Customer Name"; Text[100])
        {
            Caption = 'Customer Name';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Lookup(Customer.Name WHERE("No." = field("Customer No.")));
            TableRelation = Customer.Name;
            ValidateTableRelation = false;
        }
        field(6; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "No. Series";
        }
        field(7; "Rental Customer Discount"; Decimal)
        {
            Caption = 'Customer Discount';
            DataClassification = CustomerContent;
            MaxValue = 100;
            MinValue = 0;
            trigger OnValidate()
            begin
                UpdateLineDiscount();
            end;
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin
        InitInsert();
    end;

    procedure InitInsert()
    begin
        if "No." = '' then begin
            TestNoSeries();
            NoSeriesMgt.InitSeries(GetNoSeriesCode(), xRec."No. Series", "Posting Date", "No.", "No. Series");
        end;
    end;

    local procedure TestNoSeries()
    begin
        GetRentalSetup();
        RentalSetup.Testfield("Posted Order Nos.");

    end;

    local procedure GetRentalSetup()
    begin
        if RentalSetup.Get() then
            exit;
        RentalSetup.Init();
        RentalSetup.Insert(true);
        Commit();
    end;

    local procedure CopyFromCustomer()
    var
        Customer: Record Customer;
    begin
        Customer.Get("Customer No.");
        Rec.Validate("Rental Customer Discount", Customer."Rental Customer Discount");
    end;

    local procedure UpdateLineDiscount()
    var
        RentalOrderLine: Record "Rental Order Line";
    begin
        if Rec."Rental Customer Discount" = xRec."Rental Customer Discount" then
            exit;
        RentalOrderLine.SetRange("Order No.", Rec."No.");
        if RentalOrderLine.FindSet(true, false) then
            repeat
                if RentalOrderLine.UpdateLineDiscount("Rental Customer Discount") then
                    RentalOrderLine.Modify(true);
            until RentalOrderLine.Next() = 0;
    end;

    procedure GetNoSeriesCode(): Code[20]
    begin
        exit(NoSeriesMgt.GetNoSeriesWithCheck(RentalSetup."Posted Order Nos.", false, "No. Series"));
    end;

    var
        RentalSetup: Record "Rental Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
}