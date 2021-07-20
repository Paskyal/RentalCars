page 50102 "Rental Order Card"
{
    Caption = 'Rental Order';
    PageType = Card;
    SourceTable = "Rental Order";
    UsageCategory = Lists;
    ApplicationArea = all;
    PromotedActionCategories = 'New,Process,Report,Approve,Release,Posting,Prepare,Order,Request Approval,History,Print/Send,Navigate';
    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ToolTip = 'Specifies the value of the Customer No. field';
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        CurrPage.Update(true);
                    end;
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Customer Name';
                    ShowMandatory = true;
                    ToolTip = 'Specifies the name of the customer who will receive the products and be billed by default.';
                }
                field("Rental Customer Discount"; Rec."Rental Customer Discount")
                {
                    ToolTip = 'Specifies the value of the Customer Discount field';
                    ApplicationArea = All;
                }
                field("Salesperson Name"; Rec."Salesperson Name")
                {
                    ToolTip = 'Specifies the value of the Salesperson No. field';
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the value of the Posting Date field';
                    ApplicationArea = All;
                }
            }
            part("Rental Order Line Part"; "Rental Order Line Part")
            {
                SubPageLink = "Order No." = field("No.");
                ApplicationArea = all;
                UpdatePropagation = Both;
            }
        }
    }
    actions
    {
        area(processing)
        {
            group("P&osting")
            {
                Caption = 'P&osting';
                Image = Post;
                action(Post)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'P&ost';
                    Ellipsis = true;
                    Image = PostOrder;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Category6;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';
                    ToolTip = 'Finalize the document or journal by posting the amounts and quantities to the related accounts in your company books.';

                    trigger OnAction()
                    begin
                        PostRentalOrder(CODEUNIT::"Rental Posted Order")//, "Navigate After Posting"::"Posted Document");
                    end;
                }
            }
        }
    }
    local procedure PostRentalOrder(PostingCodeunitID: Integer) // Navigate: Enum "Navigate After Posting")
    // var
    //   RentalOrder: Record "Rental Order";
    //     LinesInstructionMgt: Codeunit "Lines Instruction Mgt.";
    //     InstructionMgt: Codeunit "Instruction Mgt.";
    //     IsHandled: Boolean;
    begin
        //     if ApplicationAreaMgmtFacade.IsFoundationEnabled then
        //         LinesInstructionMgt.SalesCheckAllLinesHaveQuantityAssigned(Rec);

        SendToPosting(PostingCodeunitID);

        //     DocumentIsScheduledForPosting := "Job Queue Status" = "Job Queue Status"::"Scheduled for Posting";
        //     DocumentIsPosted := (not SalesHeader.Get("Document Type", "No.")) or DocumentIsScheduledForPosting;
        //     OnPostOnAfterSetDocumentIsPosted(SalesHeader, DocumentIsScheduledForPosting, DocumentIsPosted);

        //     CurrPage.Update(false);

        //     IsHandled := false;
        //     OnPostDocumentBeforeNavigateAfterPosting(Rec, PostingCodeunitID, Navigate, DocumentIsPosted, IsHandled);
        //     if IsHandled then
        //         exit;

        //if PostingCodeunitID <> CODEUNIT::"Sales-Post (Yes/No)" then
        //         exit;

        //     case Navigate of
        //         "Navigate After Posting"::"Posted Document":
        //             begin
        //                 if InstructionMgt.IsEnabled(InstructionMgt.ShowPostedConfirmationMessageCode) then
        //                     ShowPostedConfirmationMessage();

        //                 if DocumentIsScheduledForPosting or DocumentIsPosted then
        //                     CurrPage.Close();
        //             end;
        // "Navigate After Posting"::"New Document":
        //     if DocumentIsPosted then begin
        //         Clear(SalesHeader);
        //         SalesHeader.Init();
        //         SalesHeader.Validate("Document Type", SalesHeader."Document Type"::Order);
        //         OnPostOnBeforeSalesHeaderInsert(SalesHeader);
        //         SalesHeader.Insert(true);
        //         PAGE.Run(PAGE::"Sales Order", SalesHeader);
        //     end;
    end;

    procedure SendToPosting(PostingCodeunitID: Integer) IsSuccess: Boolean
    // var
    //     ErrorContextElement: Codeunit "Error Context Element";
    //     ErrorMessageMgt: Codeunit "Error Message Management";
    //     ErrorMessageHandler: Codeunit "Error Message Handler";
    begin
        //if not IsApprovedForPosting then
        //   exit;

        Commit();
        // ErrorMessageMgt.Activate(ErrorMessageHandler);
        // ErrorMessageMgt.PushContext(ErrorContextElement, RecordId, 0, '');
        IsSuccess := CODEUNIT.Run(PostingCodeunitID, Rec);
        // if not IsSuccess then
        //    ErrorMessageHandler.ShowErrors;
    end;

    // var
    //     PostingCodeunitID: CODEUNIT "Rental Posted Order";
}
