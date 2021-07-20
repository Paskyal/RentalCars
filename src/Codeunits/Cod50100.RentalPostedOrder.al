codeunit 50100 "Rental Posted Order"
{
    TableNo = "Rental Order";

    trigger OnRun()
    var
        DoneMsg: Label 'Done';
    begin
        CopyRentalOrderToPostedRO(Rec);
        Message(DoneMsg);
    end;

    local procedure CopyRentalOrderToPostedRO(RentalOrder: Record "Rental Order")
    var
        RentalPostedOrder: Record "Rental Posted Order";
        PostDocumentNo: Code[20];
    begin
        RentalPostedOrder."No." := '';
        RentalPostedOrder.Insert(true);
        PostDocumentNo := RentalPostedOrder."No.";
        RentalPostedOrder.TransferFields(RentalOrder);
        RentalPostedOrder."No." := PostDocumentNo;
        RentalPostedOrder.Modify(true);
        CopyRentalOrderLineToPostedROLine(RentalOrder, PostDocumentNo);
        // RentalOrder.Delete(true);
    end;

    Local procedure CopyRentalOrderLineToPostedROLine(RentalOrder: Record "Rental Order"; PostDocumentNo: Code[20]);
    var
        RentalOrderLine: Record "Rental Order Line";
        RentalPostedOrderLine: Record "Rental Posted Order Line";
    begin
        RentalOrderLine.SetRange("Order No.", RentalOrder."No.");
        if RentalOrderLine.FindSet(false, false) then
            repeat
                RentalPostedOrderLine."Order No." := PostDocumentNo;
                RentalPostedOrderLine."Line No." := RentalOrderLine."Line No.";
                RentalPostedOrderLine.Insert(true);
                RentalPostedOrderLine.TransferFields(RentalOrderLine);
                RentalPostedOrderLine."Order No." := PostDocumentNo;
                RentalPostedOrderLine.Modify(true);
            until RentalOrderLine.Next() = 0;
    end;
}