<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ApproveReimbursment.aspx.cs" MasterPageFile="~/MasterPages/Main.master" Inherits="ApproveReimbursment" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="~/Controls/ucEmployeeCard.ascx" TagPrefix="uc1" TagName="ucEmployeeCard" %>


<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
    <style type="text/css">
        .style1 {
            height: 15px;
        }

        body {
            background: white !important;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">


    <script type="text/javascript">
        function CloseAndRebind(msg) {
            GetRadWindow().BrowserWindow.refreshGrid2();
            GetRadWindow().BrowserWindow.showSuccessMessage(msg);
            GetRadWindow().close();
        }

        function GetRadWindow() {
            var oWindow = null;
            if (window.radWindow)
                oWindow = window.radWindow; //Will work in Moz in all cases, including clasic dialog
            else if (window.frameElement.radWindow)
                oWindow = window.frameElement.radWindow; //IE (and Moz as well)

            return oWindow;
        }

        function CancelEdit() {
            GetRadWindow().close();
        }

        function pageLoad() {
            var rID = getParameterByName("RequestID");

            if (rID == "") {
                CancelEdit();
            }
        }

        function getParameterByName(name) {
            name = name.replace(/[\[]/, "\\\[").replace(/[\]]/, "\\\]");
            var regexS = "[\\?&]" + name + "=([^&#]*)";
            var regex = new RegExp(regexS);
            var results = regex.exec(window.location.search);
            if (results == null)
                return "";
            else
                return decodeURIComponent(results[1].replace(/\+/g, " "));
        }


        var isSorted = false;
        var ctrlId = "";
        function setSorted(senderID) {
            isSorted = true;
            ctrlId = senderID;
        }
        function OnClientDropDownClosing(sender, eventArgs) {
            if (sender.get_id() == ctrlId && isSorted) {
                eventArgs.set_cancel(true);
            }
            else {
                eventArgs.set_cancel(false);
            }
            isSorted = false;
            ctrlId = "";
            if (sender.get_value() == "")
                sender.set_text("");
        }

        function RowSelect(row, senderID) {
            var combo = $find(senderID);
            setTimeout(function () {
                combo.set_text($(row).find('td.text').text().trim());
                combo.set_value($(row).find('td.value').text().trim());
            }, 50);
        }
        function OnClientLoad(editor, args) {
            editor.add_modeChange(function (editor, args) {
                var mode = editor.get_mode();
                if (mode == 2) {
                    var htmlMode = editor.get_textArea();  //get a reference to the Html mode textarea
                    htmlMode.disabled = "true";
                }
            });
        }

        function RowClickedEmployee(sender, args) {
            var cellValues = args.getDataKeyValue("EmployeeFullNameWithID");
            var UserID = args.getDataKeyValue("UserID");

            var combo = $find(sender.ClientID.replace('_i0_rGrdEmployees4DDL', ''));
            setTimeout(function () {
                combo.trackChanges();
                combo.set_text(cellValues);
                combo.get_items().getItem(0).set_value(UserID);
                combo.commitChanges();
            }, 50);
        }
        function RowClickedReimbursment(sender, args) {
            var cellValues = args.getDataKeyValue("bchcod");
            var UserID = args.getDataKeyValue("recidd");

            var combo = $find(sender.ClientID.replace('_i0_rGrdReimbursments4DDL', ''));
            setTimeout(function () {
                combo.trackChanges();
                combo.set_text(cellValues);
                combo.get_items().getItem(0).set_value(UserID);
                combo.commitChanges();
            }, 50);
        }

        function onRequestStart(sender, args) {
            if (args.get_eventTarget().indexOf("linkButton") >= 0
               ) {
                args.set_enableAjax(false);
            }
        }

        function RowClickedRevise(sender, args) {
            var cellValues = args.getDataKeyValue("ID");
            var UserID = args.getDataKeyValue("ID");

            var combo = $find(sender.ClientID.replace('_i0_rGrdLevels4DDL', ''));
            setTimeout(function () {
                combo.trackChanges();
                combo.set_text(cellValues);
                combo.get_items().getItem(0).set_value(UserID);
                combo.get_items().getItem(0).set_text(cellValues);

                combo.commitChanges();
            }, 50);
        }

    </script>
    <telerik:RadAjaxPanel ID="RadAjaxPanel11" runat="server" LoadingPanelID="RadAjaxLoadingPanel1"     ClientEvents-OnRequestStart="onRequestStart"
        Width="100%" Height="100%" >

        <div class="widget">
            <div class="tab_container">
                <div id="tab1" class="tab_content">

                    <div class="fluid">
                        <div class="span8">
                            <div class="widget">
                                <div class="title">
                                    <img src="../../../images/icons/dark/list.png" alt="" class="titleIcon" />
                                    <h6>Personal Details</h6>
                                </div>

                                <div class="formRow">
                                    <div class="formCol">
                                        <label>Requested By</label>
                                        <div class="formRight">

                                            <telerik:RadComboBox ID="rCmbEmployee" BackColor="White" ForeColor="Black" Enabled="false" runat="server" Width="400px" DropDownWidth="400px" EmptyMessage="Please select...">
                                                <ItemTemplate>
                                                    <telerik:RadGrid ID="rGrdEmployees4DDL" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                        CellSpacing="0" GridLines="None" Width="400px" ClientSettings-EnableRowHoverStyle="True">
                                                        <ClientSettings>
                                                            <Selecting AllowRowSelect="true"></Selecting>
                                                        </ClientSettings>
                                                        <MasterTableView DataKeyNames="UserID,EmployeeID" ClientDataKeyNames="UserID,EmployeeID,EmployeeFullNameWithID">
                                                            <Columns>
                                                                <telerik:GridBoundColumn DataField="UserID" FilterControlAltText="Filter column column"
                                                                    HeaderText="User ID" UniqueName="column">
                                                                </telerik:GridBoundColumn>
                                                                <telerik:GridBoundColumn DataField="EmployeeID" FilterControlAltText="Filter column1 column"
                                                                    HeaderText="Employee ID" UniqueName="column1">
                                                                </telerik:GridBoundColumn>
                                                                <telerik:GridBoundColumn DataField="EmployeeFullNameWithID" FilterControlAltText="Filter column2 column"
                                                                    HeaderText="Name" UniqueName="column2">
                                                                </telerik:GridBoundColumn>
                                                            </Columns>
                                                        </MasterTableView>
                                                        <ClientSettings>
                                                            <ClientEvents OnRowClick="RowClickedEmployee"></ClientEvents>
                                                        </ClientSettings>
                                                    </telerik:RadGrid>
                                                </ItemTemplate>
                                                <Items>
                                                    <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                                </Items>
                                            </telerik:RadComboBox>
                                        </div>
                                    </div>

                                    <div class="formCol">
                                        <label></label>
                                        <div class="formRight">
                                            <label></label>
                                        </div>
                                    </div>
                                    <div class="clear"></div>
                                </div>

                                <div class="formRow">
                                    <div class="formCol">
                                        <label>Reimbursement Type</label>
                                        <div class="formRight">
                                            <telerik:RadComboBox ID="rCmbReimbursment"   BackColor="White" ForeColor="Black" Enabled="false" runat="server" Width="400px" DropDownWidth="400px" EmptyMessage="Please select...">
                                                <ItemTemplate>
                                                    <telerik:RadGrid ID="rGrdReimbursments4DDL" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                        CellSpacing="0" GridLines="None" Width="400px" ClientSettings-EnableRowHoverStyle="True">
                                                        <ClientSettings>
                                                            <Selecting AllowRowSelect="true"></Selecting>
                                                        </ClientSettings>
                                                        <MasterTableView DataKeyNames="recidd" ClientDataKeyNames="recidd,bchcod,bchdsc">
                                                            <Columns>
                                                                <telerik:GridBoundColumn DataField="recidd" FilterControlAltText="Filter column column" HeaderText="ID" UniqueName="column">
                                                                </telerik:GridBoundColumn>
                                                                <telerik:GridBoundColumn DataField="bchcod" FilterControlAltText="Filter column1 column" HeaderText="Batch" UniqueName="column1">
                                                                </telerik:GridBoundColumn>
                                                                <telerik:GridBoundColumn DataField="bchdsc" FilterControlAltText="Filter column2 column" HeaderText="Description" UniqueName="column2">
                                                                </telerik:GridBoundColumn>
                                                            </Columns>
                                                        </MasterTableView>
                                                        <ClientSettings>
                                                            <ClientEvents OnRowClick="RowClickedReimbursment"></ClientEvents>
                                                        </ClientSettings>
                                                    </telerik:RadGrid>
                                                </ItemTemplate>
                                                <Items>
                                                    <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                                </Items>
                                            </telerik:RadComboBox>
                                        </div>
                                    </div>
                                    <div class="formCol">
                                        <label></label>
                                        <div class="formRight">
                                            <label></label>
                                        </div>
                                    </div>

                                    <div class="clear"></div>
                                </div>

                                <div class="formRow">

                                    <div class="formCol">
                                        <label>Amount </label>
                                        <div class="formRight"   style="width:100px;">
                                            <telerik:RadNumericTextBox ID="txtAmount"  Enabled="false" runat="server" MaxLength="10" Height="25px"></telerik:RadNumericTextBox>

                                            <asp:RequiredFieldValidator
                                                ID="RequiredFieldValidator1"
                                                ControlToValidate="txtAmount"
                                                ErrorMessage="*"
                                                Display="Dynamic"
                                                CssClass="requiredvalidators"
                                                ValidationGroup="FrmSubmit"
                                                SetFocusOnError="False"
                                                runat="server"></asp:RequiredFieldValidator>

                                        </div>
                                    </div>
                                    <div class="formCol">
                                        <label></label>
                                        <div class="formRight">
                                            <label></label>
                                        </div>
                                    </div>

                                    <div class="clear"></div>
                                </div>

                                                                  <div class="formRow">
                                <div class="formCol">
                                    <label>Sub Amount 1</label>
                                    <div class="formRight"  style="width:100px;">
                                        <telerik:RadNumericTextBox ID="txtSub1"  Enabled="false" runat="server" MaxLength="10" Height="25px"></telerik:RadNumericTextBox>

                                    </div>

                                </div>

                                <div class="clear"></div>
                            </div>
                                      <div class="formRow">
                                <div class="formCol">
                                    <label>Sub Amount 2</label>
                                    <div class="formRight"  style="width:100px;">
                                        <telerik:RadNumericTextBox ID="txtSub2"  Enabled="false" runat="server" MaxLength="10" Height="25px"></telerik:RadNumericTextBox>

                                    </div>

                                </div>

                                <div class="clear"></div>
                            </div>
                                      <div class="formRow">
                                <div class="formCol">
                                    <label>Sub Amount 3</label>
                                    <div class="formRight"  style="width:100px;">
                                        <telerik:RadNumericTextBox ID="txtSub3"  Enabled="false" runat="server" MaxLength="10" Height="25px"></telerik:RadNumericTextBox>

                                    </div>

                                </div>

                                <div class="clear"></div>
                            </div>


                                 <div class="formRow">
                                   <div class="formCol">
                                        <label>Description</label>
                                        <div class="formRight">
                                            <telerik:RadTextBox ID="txtDescription"  Enabled="false" runat="server" MaxLength="200" Height="25px">
                                            </telerik:RadTextBox>

                                            <asp:RequiredFieldValidator
                                                ID="Required_txtDescription"
                                                ControlToValidate="txtDescription"
                                                ErrorMessage="*"
                                                Display="Dynamic"
                                                CssClass="requiredvalidators"
                                                ValidationGroup="FrmSubmit"
                                                SetFocusOnError="False"
                                                runat="server"></asp:RequiredFieldValidator>
                                        </div>
                                    </div>
                                    <div class="formCol">
                                        <label></label>
                                        <div class="formRight">
                                            <label></label>
                                        </div>
                                    </div>

                                    <div class="clear"></div>
                                </div>

                                                             <div class="formRow">
                                <div class="formCol">
                                    <label>Description 1</label>
                                    <div class="formRight">
                                        <telerik:RadTextBox ID="txtDescription1"  Enabled="false" runat="server" MaxLength="200" Height="25px">
                                        </telerik:RadTextBox>

                                      
                                    </div>
                                </div>
                                <div class="clear"></div>
                            </div>
                              <div class="formRow">
                                <div class="formCol">
                                    <label>Description 2</label>
                                    <div class="formRight">
                                        <telerik:RadTextBox ID="txtDescription2" runat="server" MaxLength="200" Height="25px">
                                        </telerik:RadTextBox>

                                      
                                    </div>
                                </div>
                                <div class="clear"></div>
                            </div>

                              <div class="formRow">
                                <div class="formCol">
                                    <label>Description 3</label>
                                    <div class="formRight">
                                        <telerik:RadTextBox ID="txtDescription3"  Enabled="false" runat="server" MaxLength="200" Height="25px">
                                        </telerik:RadTextBox>                                  
                                    </div>
                                </div>
                                <div class="clear"></div>
                            </div>
<%--<div class="formRow">
                                    <div class="formCol">
                                        <label>Attachments</label>
                                        <div class="formRight">
                                            <telerik:RadAsyncUpload runat="server" ID="ruDocument" overwriteexistingfiles="true"
                                                AllowedFileExtensions="txt,pdf,doc,jpg,png,gif,bmp,docx,xlsx"
                                                MultipleFileSelection="Automatic" MaxFileSize="524288"
                                                MaxFileInputsCount="3"
                                                OnClientFileUploaded="onClientFileUploaded"
                                                TemporaryFolder="~\App_Data\RadUploadTemp\">
                                            </telerik:RadAsyncUpload>

                                        </div>
                                    </div>
                                    <div class="clear"></div>
                                </div>--%>


                            </div>
                        </div>
                        <div class="span4">
                            <uc1:ucEmployeeCard runat="server" ID="ucEmployeeCard" />
                        </div>
                       
                         <asp:HiddenField ID="hfTransactionNo" runat="server" />
                        <div class="span4" style="padding:15px">
                              <div class="formCol">
                                    <label></label>
                                    <div class="formRight">
                                        <h3>Uploaded Files</h3>
 
                                 <hr class="qsf-clear-float" />
 
                                <div class="uploaded-files">
                                    <asp:Literal runat="server" ID="ltrNoResults" Visible="True" Text="<strong>No files uploaded</strong>" />
                                    <asp:Repeater runat="server" ID="Repeater1" OnItemCommand="Repeater1_ItemCommand">
                                        <HeaderTemplate>
                                            <ul>
                                        </HeaderTemplate>
                                        <FooterTemplate></ul></FooterTemplate>
                                        <ItemTemplate>
                                                
                                               <li>
                                                <dl>
                                                    <dt>File name : 

                                                    <asp:LinkButton ID="linkButton" ClientIDMode="Static" runat="server" CssClass="linkattachments" Text='<%# DataBinder.Eval(Container.DataItem, "documentname").ToString() %>'
                                                     CommandName="Download" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "idd").ToString() %>' ></asp:LinkButton>

 
                                                    <asp:ImageButton ID="delAttch" Visible="false" runat="server" CommandName="Remove" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "idd").ToString() %>' Text="Delete Attachment"
                                                        ValidationGroup="FrmSubmit" CausesValidation="True" ImageUrl="~/Images/icons/remove.png"></asp:ImageButton>
                                                
                                 
                                                                           </dt>
                                                    <dt>File Description:
                                                       <telerik:RadTextBox ID="txtfiledescription" runat="server" Height="200px" Text='<%# DataBinder.Eval(Container.DataItem, "description").ToString() %>' TextMode="MultiLine" Columns="200" Rows="3"></telerik:RadTextBox>
                                                                            <asp:ImageButton ID="upAttach" Visible="false" runat="server" CommandName="Change" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "idd").ToString() %>' Text="Update"
                                                        ValidationGroup="FrmSubmit" CausesValidation="True" ImageUrl="~/Images/icons/change.png" AlternateText="Update"></asp:ImageButton>
                                
                                                  </dt>
                                                                                                        
                                                </dl>

                                               </li>
                                             
                                            
                                           
                                                                                    </ItemTemplate>
                                    </asp:Repeater>
                                </div>

                                    </div>
                                    
                                                                  </div>
                               <div class="clear"></div>
                        </div>
                       

                        
                        <div class="clear"></div>
                        <div class="widget">
                            <div class="title">
                                <img src="../../../images/icons/dark/list.png" alt="" class="titleIcon" />
                                <h6>Decision Remarks</h6>
                            </div>
                            <div class="formRow">
                                <div class="formCol">
                                    <label>Remarks</label>
                                    <div class="formRight">
                                        <telerik:RadTextBox ID="txtremarks" runat="server" MaxLength="50">
                                        </telerik:RadTextBox>
                                    </div>
                                </div>

                                <div class="clear"></div>
                            </div>
                        </div>

                                            <div class="widget">
                            <div class="title">
                                <img src="../../../images/icons/dark/list.png" alt="" class="titleIcon" />
                                <h6>Select User to Revise/Review</h6>
                            </div>
                            <div class="formRow">
                                <div class="formCol">
                                    <label>Remarks</label>
                                    <div class="formRight">
                                          <telerik:RadComboBox ID="rCmbLevels" runat="server" Width="400px" DropDownWidth="400px" EmptyMessage="Please select...">
                                            <ItemTemplate>
                                                <telerik:RadGrid ID="rGrdLevels4DDL" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                    CellSpacing="0" GridLines="None" Width="400px" ClientSettings-EnableRowHoverStyle="True">
                                                    <ClientSettings>
                                                        <Selecting AllowRowSelect="true"></Selecting>

                                                    </ClientSettings>
                                                    <MasterTableView DataKeyNames="ID" ClientDataKeyNames="ID">

                                                        <Columns>
                                                            <telerik:GridBoundColumn DataField="ID" FilterControlAltText="Filter column column"
                                                                HeaderText="ID" UniqueName="column">
                                                            </telerik:GridBoundColumn>

                                                            <telerik:GridBoundColumn DataField="UserLevel" FilterControlAltText="Filter column column"
                                                                HeaderText="Level" UniqueName="column">
                                                            </telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn DataField="ApprovedByUserID" FilterControlAltText="Filter column1 column"
                                                                HeaderText="User" UniqueName="column1">
                                                            </telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn DataField="RequestStatusID" FilterControlAltText="Filter column2 column"
                                                                HeaderText="RequestStatusID" UniqueName="column2">
                                                            </telerik:GridBoundColumn>
                                                        </Columns>
                                                    </MasterTableView>
                                                    <ClientSettings>
                                                        <ClientEvents OnRowClick="RowClickedRevise"></ClientEvents>
                                                    </ClientSettings>
                                                </telerik:RadGrid>
                                            </ItemTemplate>
                                            <Items>
                                                <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                            </Items>
                                        </telerik:RadComboBox>
                                    </div>
                                </div>

                                <div class="clear"></div>
                            </div>
                    </div>


                        <div class="wizButtons">
                            <span class="wNavButtons">

                                <asp:Button ID="rBtnApprove" runat="server" OnClick="RBtnApproveClick" Text="Approve"
                                    ValidationGroup="FrmSubmit" class="button greenB" CausesValidation="True"></asp:Button>

                                <asp:Button ID="rBtnReject" runat="server" OnClick="RBtnRejectClick"
                                    Text="Reject" class="button blueB" ValidationGroup="FrmSubmit" CausesValidation="True"></asp:Button>

                                <asp:Button ID="rBtnRevise" runat="server" OnClick="RBtnReviseClick"
                                    Text="Revise" class="button blueB" ValidationGroup="FrmSubmit" CausesValidation="True"></asp:Button>
                            </span>
                        </div>
                        <div class="clear"></div>

                                        <div class="formRight">
                    <telerik:RadGrid ID="gvHistory" runat="server" AllowPaging="True" AllowSorting="True"
                        AllowFilteringByColumn="false" AutoGenerateColumns="False" CellSpacing="0" GridLines="None"
                        OnNeedDataSource="gvHistory_NeedDataSource" PageSize="20"
                        ShowStatusBar="false" OnItemCommand="gvHistory_ItemCommand"
                        OnItemDataBound="gvHistory_ItemDataBound"
                        >
                        <FilterMenu EnableImageSprites="False">
                        </FilterMenu>
                        <ClientSettings>
                            <Selecting CellSelectionMode="None"></Selecting>
                        </ClientSettings>
                        <ExportSettings
                            HideStructureColumns="true"
                            ExportOnlyData="true"
                            IgnorePaging="true"
                            OpenInNewWindow="true">
                            <Csv ColumnDelimiter="Tab" RowDelimiter="NewLine" FileExtension="TXT" EncloseDataWithQuotes="false" />
                            <Pdf PaperSize="A4">
                            </Pdf>
                        </ExportSettings>
                        <MasterTableView CommandItemDisplay="Top" AutoGenerateColumns="False" DataKeyNames="ID"
                            InsertItemPageIndexAction="ShowItemOnCurrentPage" EditMode="EditForms">
                            <DetailTables>
                            </DetailTables>
                            <CommandItemTemplate>
                                <tr class="rgCommandRow">
                                    <div class="title">
                                        <img src="/images/icons/dark/users.png" alt="" class="titleIcon" /><h6>Request History</h6>
                                        <div class="num">
                                            <a class="blueNum">
                                                <asp:Literal ID="ltNotiCount" runat="server"></asp:Literal></a>
                                        </div>
                                    </div>
                                    <td colspan="10" class="rgCommandCell">

                                        <table style="width: 100%;" summary="Command item for additional functionalities for the grid like adding a new record and exporting." class="rgCommandTable">
                                            <caption>

                                                <span style="display: none">Command item</span>
                                            </caption>
                                            <thead>
                                                <tr>
                                                    <th scope="col"></th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr>
                                                    <td align="left">
                                                    </td>
                                                    <td align="right">
                                                        <asp:Button ID="btnNotificationRefresh" CssClass="rgRefresh" runat="server" CommandName="Rebind" AlteracteText="Refresh" ToolTip="Refresh" />
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </td>
                                </tr>
                            </CommandItemTemplate>
                            <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                            </RowIndicatorColumn>
                            <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                            </ExpandCollapseColumn>
                            <Columns>
                                <telerik:GridBoundColumn DataField="ID" Visible="false" SortExpression="ID" FilterControlAltText="Filter column column"
                                    HeaderText="ID" UniqueName="ID" ReadOnly="True" DataType="System.Int32">
                                    <ColumnValidationSettings>
                                        <ModelErrorMessage Text=""></ModelErrorMessage>
                                    </ColumnValidationSettings>
                                    <FilterTemplate>
                                        <strong>Search</strong>
                                    </FilterTemplate>
                                </telerik:GridBoundColumn>
                                <telerik:GridTemplateColumn DataField="ApprovedByUserID" FilterControlWidth="130px" SortExpression="ApprovedByUserID"
                                    AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" FilterControlAltText="Filter TemplateColumn0 column"
                                    HeaderText="Approved By User" UniqueName="ApprovedByUserID">
                                    <ItemTemplate>
                                        <asp:Label ID="lblApprovedByUserID" runat="server" Text='<%# Eval("ApprovedByUserID") %>'></asp:Label>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn DataField="UpdateDate" FilterControlWidth="130px" SortExpression="UpdateDate"
                                    AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" FilterControlAltText="Filter TemplateColumn0 column"
                                    HeaderText="Update Date" UniqueName="UpdateDate">
                                    <ItemTemplate>
                                        <asp:Label ID="lblUpdateDate" runat="server" Text='<%# Eval("UpdateDate") %>'></asp:Label>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                 <telerik:GridTemplateColumn DataField="Remarks" FilterControlWidth="130px" SortExpression="Remarks"
                                    AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" FilterControlAltText="Filter TemplateColumn0 column"
                                    HeaderText="Remarks" UniqueName="Remarks">
                                    <ItemTemplate>
                                        <asp:Label ID="lblRemarks" runat="server" Text='<%# Eval("Remarks") %>'></asp:Label>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                 <telerik:GridTemplateColumn DataField="Transremarks" FilterControlWidth="130px" SortExpression="Transremarks"
                                    AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" FilterControlAltText="Filter TemplateColumn0 column"
                                    HeaderText="Trans Remarks" UniqueName="Transremarks">
                                    <ItemTemplate>
                                        <asp:Label ID="lblTransremarks" runat="server" Text='<%# Eval("Transremarks") %>'></asp:Label>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>

                            </Columns>
                            <EditFormSettings CaptionFormatString='Edit Details for Notification "{0}":' CaptionDataField="ID">
                                <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                </EditColumn>
                                <EditColumn ButtonType="ImageButton" />
                            </EditFormSettings>
                        </MasterTableView>
                    </telerik:RadGrid>
                </div>

                    </div>
                </div>
            </div>
        </div>
    </telerik:RadAjaxPanel>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" />
</asp:Content>
