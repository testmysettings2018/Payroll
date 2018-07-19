<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/UserMasterPage.master" AutoEventWireup="true" CodeFile="EmployeeClassSetup.aspx.cs" Inherits="Payroll_EmployeeClassSetup" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .qsf-demo-canvas {
        }

            .qsf-demo-canvas label {
                padding-right: 10px !important;
                width: 200px !important;
                display: inline-block !important;
                text-align: right !important;
            }
        /** Columns */
        .rcbHeader ul,
        .rcbFooter ul,
        .rcbItem ul,
        .rcbHovered ul,
        .rcbDisabled ul {
            margin: 0 !important;
            padding: 0 !important;
            width: 100% !important;
            display: inline-block !important;
            list-style-type: none !important;
        }

        .col1,
        .col2,
        .col3 {
            margin: 0 !important;
            padding: 0 5px 0 0 !important;
            width: 110px !important;
            line-height: 14px !important;
            float: left !important;
        }

        .multipleRowsColumns .rcbItem,
        .multipleRowsColumns .rcbHovered {
            float: left !important;
            margin: 0 1px !important;
            min-height: 13px !important;
            overflow: hidden !important;
            padding: 2px 19px 2px 6px !important;
            width: 125px !important;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ControlContent" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="mainContentPlaceHolder" runat="Server">
    <telerik:RadCodeBlock ID="rcb1" runat="server">
        <script type="text/javascript">

            function KeyPress(sender, args) {
                if (args.get_keyCharacter() == sender.get_numberFormat().DecimalSeparator) {
                    args.set_cancel(true);
                }
            }

            function onRequestStart(sender, args) {
                if (args.get_eventTarget().indexOf("btnEmployeeClassExcelExport") >= 0 ||
                      args.get_eventTarget().indexOf("btnEmployeeClassCsvExport") >= 0 ||
                      args.get_eventTarget().indexOf("btnEmployeeClassPdfExport") >= 0 ||
                      args.get_eventTarget().indexOf("btnEmployeeClassPrint") >= 0 ||
                      args.get_eventTarget().indexOf("btnEmployeeClassRefresh") >= 0 ||

                    args.get_eventTarget().indexOf("btnContributionRecordsExportExcel") >= 0 ||
                   args.get_eventTarget().indexOf("btnContributionRecordsExportCsv") >= 0 ||
                   args.get_eventTarget().indexOf("btnContributionRecordsExportPdf") >= 0 ||
                   args.get_eventTarget().indexOf("btnContributionRecordsPrint") >= 0 ||
                   args.get_eventTarget().indexOf("btnContributionRecordsRefresh") >= 0 ||

                    args.get_eventTarget().indexOf("btnExportExcel") >= 0 ||
                   args.get_eventTarget().indexOf("btnExportCsv") >= 0 ||
                   args.get_eventTarget().indexOf("btnExportPdf") >= 0 ||
                   args.get_eventTarget().indexOf("btnPrint") >= 0 ||
                   args.get_eventTarget().indexOf("btnRefresh") >= 0 ||

                     args.get_eventTarget().indexOf("btnLoanExportExcel") >= 0 ||
                   args.get_eventTarget().indexOf("btnLoanExportCsv") >= 0 ||
                   args.get_eventTarget().indexOf("btnLoanExportPdf") >= 0 ||
                   args.get_eventTarget().indexOf("btnLoanPrint") >= 0 ||
                   args.get_eventTarget().indexOf("btnLoanRefresh") >= 0

                  ) {
                    args.set_enableAjax(false);
                }
            }
            function OnEmployeeClassTypeRowClicked(sender, args) {
                var cellValues = args.getDataKeyValue("Text");
                var id = args.getDataKeyValue("ValueSetID");
                var combo = $find(sender.ClientID.replace('_i0_rGrdEmployeeClassType4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(id);
                    combo.commitChanges();
                }, 50);
            }
            function OnPositionRowClicked(sender, args) {
                var cellValues = args.getDataKeyValue("poscod");
                var id = args.getDataKeyValue("recidd");
                var combo = $find(sender.ClientID.replace('_i0_rGrdPosition4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(id);
                    combo.commitChanges();
                }, 50);
            }
            function OnPositionRowClicked(sender, args) {
                var cellValues = args.getDataKeyValue("poscod");
                var id = args.getDataKeyValue("recidd");
                var combo = $find(sender.ClientID.replace('_i0_rGrdPosition4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(id);
                    combo.commitChanges();
                }, 50);
            }
            function OnBenifitCodeRowSelected(sender, args) {
                var grid = $find(sender.ClientID);
                var MasterTable = grid.get_masterTableView();
                var selectedRows = MasterTable.get_selectedItems();
                var headerValues = '';
                for (var i = 0; i < selectedRows.length; i++) {
                    var row = selectedRows[i];
                    var cell = MasterTable.getCellByColumnUniqueName(row, "bftcod")
                    if (headerValues != '')
                        headerValues = headerValues + ',';
                    headerValues = headerValues + cell.textContent;
                }
                var combo = $find(sender.ClientID.replace('_i0_rGrdBenifitCode4DDL', ''));
                combo.set_text(headerValues);
            }
            function OnDeductionCodeRowSelected(sender, args) {
                var grid = $find(sender.ClientID);
                var MasterTable = grid.get_masterTableView();
                var selectedRows = MasterTable.get_selectedItems();
                var headerValues = '';
                for (var i = 0; i < selectedRows.length; i++) {
                    var row = selectedRows[i];
                    var cell = MasterTable.getCellByColumnUniqueName(row, "dedcod")
                    if (headerValues != '')
                        headerValues = headerValues + ',';
                    headerValues = headerValues + cell.textContent;
                }
                var combo = $find(sender.ClientID.replace('_i0_rGrdDeductionCode4DDL', ''));
                combo.set_text(headerValues);
            }
            function OnContributionCodeRowSelected(sender, args) {
                var grid = $find(sender.ClientID);
                var MasterTable = grid.get_masterTableView();
                var selectedRows = MasterTable.get_selectedItems();
                var headerValues = '';
                for (var i = 0; i < selectedRows.length; i++) {
                    var row = selectedRows[i];
                    var cell = MasterTable.getCellByColumnUniqueName(row, "cntcod")
                    if (headerValues != '')
                        headerValues = headerValues + ',';
                    headerValues = headerValues + cell.textContent;
                }
                var combo = $find(sender.ClientID.replace('_i0_rGrdContributionCode4DDL', ''));
                combo.set_text(headerValues);
            }
            function OnPayCodeRowSelected(sender, args) {
                var grid = $find(sender.ClientID);
                var MasterTable = grid.get_masterTableView();
                var selectedRows = MasterTable.get_selectedItems();
                var headerValues = '';
                for (var i = 0; i < selectedRows.length; i++) {
                    var row = selectedRows[i];
                    var cell = MasterTable.getCellByColumnUniqueName(row, "paycod")
                    if (headerValues != '')
                        headerValues = headerValues + ',';
                    headerValues = headerValues + cell.textContent;
                }
                var combo = $find(sender.ClientID.replace('_i0_rGrdPayCode4DDL', ''));
                combo.set_text(headerValues);
            }
            function OnDepartmentRowClicked(sender, args) {
                var cellValues = args.getDataKeyValue("dptcod");
                var id = args.getDataKeyValue("dptidd");
                var combo = $find(sender.ClientID.replace('_i0_rGrdDepartment4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(id);
                    combo.commitChanges();
                }, 50);
            }
            function OnOvertimeRowClicked(sender, args) {
                var cellValues = args.getDataKeyValue("ovtcod");
                var id = args.getDataKeyValue("recidd");
                var combo = $find(sender.ClientID.replace('_i0_rGrdOvertime4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(id);
                    combo.commitChanges();
                }, 50);
            }
            function OnCalenderRowClicked(sender, args) {
                var cellValues = args.getDataKeyValue("calcod");
                var id = args.getDataKeyValue("recidd");
                var combo = $find(sender.ClientID.replace('_i0_rGrdCalender4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(id);
                    combo.commitChanges();
                }, 50);
            }
            function OnLoanCodeRowClick(sender, args) {
                var cellValues = args.getDataKeyValue("loncod");
                var id = args.getDataKeyValue("recidd");
                var combo = $find(sender.ClientID.replace('_i0_rGrdLoanCode4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(id);
                    combo.commitChanges();
                }, 50);
            }
            function OnGratuityRowClicked(sender, args) {
                var cellValues = args.getDataKeyValue("grtcod");
                var id = args.getDataKeyValue("recidd");
                var combo = $find(sender.ClientID.replace('_i0_rGrdGratuity4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(id);
                    combo.commitChanges();
                }, 50);
            }
            function OnLeaveRowClicked(sender, args) {
                var cellValues = args.getDataKeyValue("levcod");
                var id = args.getDataKeyValue("recidd");
                var combo = $find(sender.ClientID.replace('_i0_rGrdLeave4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(id);
                    combo.commitChanges();
                }, 50);
            }
            function OnEEmployeeClassRowClicked(sender, args) {
                var cellValues = args.getDataKeyValue("clscod");
                var id = args.getDataKeyValue("recidd");
                var combo = $find(sender.ClientID.replace('_i0_rGrdEEmployeeClass4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(id);
                    combo.commitChanges();
                }, 50);
            }
            function OnCEmployeeClassRowClicked(sender, args) {
                var cellValues = args.getDataKeyValue("clscod");
                var id = args.getDataKeyValue("recidd");
                var combo = $find(sender.ClientID.replace('_i0_rGrdCEmployeeClass4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(id);
                    combo.commitChanges();
                }, 50);
            }

            function OnGarnismentCategoryRowClicked(sender, args) {
                var cellValues = args.getDataKeyValue("Text");
                var id = args.getDataKeyValue("ValueSetID");
                var combo = $find(sender.ClientID.replace('_i0_rGrdGarnismentCategory4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(id);
                    combo.commitChanges();
                }, 50);
            }

            function OngrdPeriodRowClicked(sender, args) {
                var cellValues = args.getDataKeyValue("Text");
                var id = args.getDataKeyValue("ValueSetID");
                var combo = $find(sender.ClientID.replace('_i0_rGrdgrdPeriod4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(id);
                    combo.commitChanges();
                }, 50);
            }

            function OnTicketClassRowClicked(sender, args) {
                var cellValues = args.getDataKeyValue("Text");
                var id = args.getDataKeyValue("ValueSetID");
                var combo = $find(sender.ClientID.replace('_i0_rGrdTicketClass4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(id);
                    combo.commitChanges();
                }, 50);
            }
            function OnTicketPeriodRowClicked(sender, args) {
                var cellValues = args.getDataKeyValue("Text");
                var id = args.getDataKeyValue("ValueSetID");
                var combo = $find(sender.ClientID.replace('_i0_rGrdTicketPeriod4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(id);
                    combo.commitChanges();
                }, 50);
            }

            function OnEmploymentTypeRowClicked(sender, args) {
                var cellValues = args.getDataKeyValue("Text");
                var id = args.getDataKeyValue("ValueSetID");
                var combo = $find(sender.ClientID.replace('_i0_rGrdEmploymentType4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(id);
                    combo.commitChanges();
                }, 50);
            }

            function ValidateEmployeeClass(txtEmployeeClassCodeId, txtDescriptionId, ddlEmploymentTypeId, ddlTicketClassId, txtNoofTicketsId, ddlTicketPeriodId, txtTicketFrequencyId) {
                var str = '';
                if ($('#' + txtEmployeeClassCodeId).val() == undefined || $('#' + txtEmployeeClassCodeId).val() == "") {
                    str = 'Employee Class Code Required.<br/>';
                }

                if ($('#' + ddlEmploymentTypeId).val() == undefined || $('#' + ddlEmploymentTypeId).val() == "") {
                    str += 'Employment Type Required.<br/>';
                }
                if ($('#' + txtDescriptionId).val() == undefined || $('#' + txtDescriptionId).val() == "") {
                    str += 'Description Required.<br/>';
                }
                if ($('#' + ddlTicketPeriodId).val() == undefined || $('#' + ddlTicketPeriodId).val() == "") {
                    str += 'Ticket Period Required.<br/>';
                }
                if ($('#' + ddlTicketClassId).val() == undefined || $('#' + ddlTicketClassId).val() == "") {
                    str += 'Ticket Class Required.<br/>';
                }



                if ($('#' + txtTicketFrequencyId).val() == undefined || $('#' + txtTicketFrequencyId).val() == "") {
                    str += 'Ticket Frequency Required.<br/>';
                }
                if ($('#' + txtNoofTicketsId).val() == undefined || $('#' + txtNoofTicketsId).val() == "") {
                    str += 'No of Tickets Required.<br/>';
                }
                if (str != '') {
                    showError(str, null, 10000);
                }
            }

            function ValidateLoan(txtbxMaxLoanAmountId, ddlLoanCodeId) {
                var str = '';
                if ($('#' + ddlLoanCodeId).val() == undefined || $('#' + ddlLoanCodeId).val() == "") {
                    str = 'Loan Code Required.<br/>';
                }
                if ($('#' + txtbxMaxLoanAmountId).val() == undefined || $('#' + txtbxMaxLoanAmountId).val() == "") {
                    str += 'Maximum Loan Amount Required.<br/>';
                }

                if (str != '') {
                    showError(str, null, 10000);
                }
            }

            function ShowReport(Reportname) {
                window.open("../Reports/LaunchReport.aspx?Reportname=" + Reportname);
                return false;
            }

        </script>
    </telerik:RadCodeBlock>

    <fieldset>
        <div class="widget">
            <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" ClientEvents-OnRequestStart="onRequestStart" LoadingPanelID="RadAjaxLoadingPanel1">
                <div class="formRight">
                    <telerik:RadGrid ID="gvEmployeeClass" runat="server" AllowPaging="True" AllowSorting="True" AllowFilteringByColumn="true"
                        AutoGenerateColumns="False" CellSpacing="0" GridLines="None" OnInsertCommand="gvEmployeeClass_InsertCommand"
                        OnNeedDataSource="gvEmployeeClass_NeedDataSource" PageSize="20" OnDeleteCommand="gvEmployeeClass_DeleteCommand"
                        OnUpdateCommand="gvEmployeeClass_UpdateCommand" OnItemDataBound="gvEmployeeClass_ItemDataBound"
                        OnItemCommand="gvEmployeeClass_ItemCommand" OnDetailTableDataBind="gvEmployeeClass_DetailTableDataBind" OnItemCreated="gvEmployeeClass_ItemCreated">
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
                        <MasterTableView CommandItemDisplay="Top" AutoGenerateColumns="False" DataKeyNames="recidd"
                            InsertItemPageIndexAction="ShowItemOnCurrentPage" EditMode="EditForms" >
                            <DetailTables>

                                <telerik:GridTableView runat="server" AllowFilteringByColumn="false" Name="PayCodes" CommandItemDisplay="Top" DataKeyNames="recidd">
                                    <CommandItemTemplate>
                                        <tr class="rgCommandRow">

                                            <td colspan="8" class="rgCommandCell">

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
                                                                <asp:Button ID="btnAdd" runat="server" CssClass="rgAdd" CommandName="InitInsert" AlternateText="Add" ToolTip="Add" />
                                                                <asp:Label ID="lblPaycodes" runat="server" Text="Pay Codes Selection"></asp:Label>
                                                            </td>
                                                            <td align="right">
                                                                <asp:Button ID="btnRefresh" CssClass="rgRefresh" runat="server" CommandName="Rebind" AlternateText="Refresh" ToolTip="Refresh" />
                                                            </td>


                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </td>
                                        </tr>
                                    </CommandItemTemplate>
                                    <RowIndicatorColumn FilterControlAltText="Filter RowIndicator column" Visible="True">
                                        <HeaderStyle Width="20px" />
                                    </RowIndicatorColumn>
                                    <ExpandCollapseColumn FilterControlAltText="Filter ExpandColumn column" Visible="True">
                                        <HeaderStyle Width="20px" />
                                    </ExpandCollapseColumn>
                                    <DetailTables>
                                    </DetailTables>
                                    <Columns>
                                        <telerik:GridBoundColumn DataField="recidd" AllowFiltering="true" FilterControlAltText="Filter column column"
                                            HeaderText="ID" UniqueName="column" ReadOnly="True" DataType="System.Int32" Visible ="false">
                                            <ColumnValidationSettings>
                                                <ModelErrorMessage Text=""></ModelErrorMessage>
                                            </ColumnValidationSettings>
                                            <FilterTemplate>
                                                <strong>Search</strong>
                                            </FilterTemplate>
                                            <ItemStyle Width="50px" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridTemplateColumn DataField="paycod" SortExpression="paycod" FilterControlWidth="130px" AutoPostBackOnFilter="true"
                                            CurrentFilterFunction="Contains" FilterControlAltText="Filter TemplateColumn0 column"
                                            HeaderText="Pay Code" UniqueName="TemplateColumn001">
                                            <ItemTemplate>
                                                <asp:Label ID="lblpaycod" runat="server" Text='<%# Eval("paycod") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <table>
                                                    <tr>
                                                        <td style="width: 280px">
                                                            <asp:HiddenField ID="hfEmployeeClassId" runat="server" Value='<%# Eval("clsidd") %>' />
                                                            <telerik:RadComboBox ID="ddlPayCode" runat="server"
                                                                Width="260px" Height="200px" DropDownWidth="410px"
                                                                EmptyMessage="Please select...">
                                                                <ItemTemplate>
                                                                    <telerik:RadAjaxPanel ID="RadAjaxPanelPayCode" runat="server" Width="410px" LoadingPanelID="RadAjaxLoadingPanelPayCode" Height="200px">
                                                                        <telerik:RadGrid ID="rGrdPayCode4DDL" AllowMultiRowSelection="true" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                                            CellSpacing="0" GridLines="None" OnNeedDataSource="rGrdPayCode4DDL_NeedDataSource"
                                                                            Width="410px" ClientSettings-EnableRowHoverStyle="True">
                                                                            <ClientSettings>
                                                                                <Selecting AllowRowSelect="true" EnableDragToSelectRows="true"></Selecting>
                                                                            </ClientSettings>

                                                                            <MasterTableView DataKeyNames="recidd,paycod,payds1" ClientDataKeyNames="recidd,paycod,payds1">
                                                                                <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                                                                <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                                                                                    <HeaderStyle Width="20px"></HeaderStyle>
                                                                                </RowIndicatorColumn>
                                                                                <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                                                                                    <HeaderStyle Width="20px"></HeaderStyle>
                                                                                </ExpandCollapseColumn>
                                                                                <Columns>
                                                                                    <telerik:GridClientSelectColumn></telerik:GridClientSelectColumn>

                                                                                    <telerik:GridBoundColumn DataField="recidd" FilterControlAltText="Filter column1 column"
                                                                                        HeaderText="ID" UniqueName="recidd">
                                                                                    </telerik:GridBoundColumn>
                                                                                    <telerik:GridBoundColumn DataField="paycod" FilterControlAltText="Filter column2 column"
                                                                                        HeaderText="Code" UniqueName="paycod">
                                                                                    </telerik:GridBoundColumn>
                                                                                    <telerik:GridBoundColumn DataField="payds1" FilterControlAltText="Filter column3 column"
                                                                                        HeaderText="Description" UniqueName="payds1">
                                                                                    </telerik:GridBoundColumn>
                                                                                </Columns>
                                                                                <EditFormSettings>
                                                                                    <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                                                                    </EditColumn>
                                                                                </EditFormSettings>
                                                                            </MasterTableView>
                                                                            <ClientSettings>
                                                                                <ClientEvents OnRowDeselected="OnPayCodeRowSelected" OnRowSelected="OnPayCodeRowSelected"></ClientEvents>
                                                                            </ClientSettings>
                                                                            <FilterMenu EnableImageSprites="False">
                                                                            </FilterMenu>
                                                                        </telerik:RadGrid>
                                                                    </telerik:RadAjaxPanel>
                                                                    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanelPayCode" runat="server">
                                                                    </telerik:RadAjaxLoadingPanel>
                                                                </ItemTemplate>
                                                                <Items>
                                                                    <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                                                </Items>
                                                            </telerik:RadComboBox>

                                                            <%-- <asp:RequiredFieldValidator ID="RequiredFieldValidator122222" runat="server" ErrorMessage="*" ForeColor="Red"
                                            ControlToValidate="ddlPaycode"></asp:RequiredFieldValidator>--%>
                                                        </td>
                                                        <td></td>
                                                        <td></td>
                                                    </tr>
                                                </table>
                                            </EditItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn DataField="payds1" SortExpression="payds1" FilterControlWidth="130px" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" FilterControlAltText="Filter TemplateColumn2 column"
                                            HeaderText="Description" UniqueName="TemplateColumn2">
                                            <ItemTemplate>
                                                <asp:Label ID="lblDescription" runat="server" Text='<%# Eval("payds1") %>'></asp:Label>
                                            </ItemTemplate>

                                        </telerik:GridTemplateColumn>


                                        <telerik:GridEditCommandColumn FilterControlAltText="Filter EditCommandColumn column"
                                            UniqueName="EditPayCode" ButtonType="ImageButton" EditFormHeaderTextFormat="{0}:">
                                            <ItemStyle HorizontalAlign="Center" Width="25px" />
                                        </telerik:GridEditCommandColumn>
                                        <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" ConfirmText="Are you sure to delete this Pay Code record?"
                                            ConfirmTextFields="recidd" ConfirmTitle="Delete" FilterControlAltText="Filter column6 column"
                                            UniqueName="DeletePayCode" ConfirmTextFormatString='Are you sure to delete Pay Code record # {0}?'>
                                            <ItemStyle HorizontalAlign="Center" Width="25px" />
                                        </telerik:GridButtonColumn>
                                    </Columns>
                                    <SortExpressions>
                                        <telerik:GridSortExpression FieldName="recidd" SortOrder="Ascending" />
                                    </SortExpressions>
                                    <EditFormSettings>
                                        <EditColumn ButtonType="ImageButton" FilterControlAltText="Filter EditCommandColumn column">
                                        </EditColumn>
                                    </EditFormSettings>
                                </telerik:GridTableView>
                                
                                <telerik:GridTableView runat="server" AllowFilteringByColumn="false" Name="BenefitCodes" CommandItemDisplay="Top" DataKeyNames="recidd">
                                    <CommandItemTemplate>
                                        <tr class="rgCommandRow">

                                            <td colspan="8" class="rgCommandCell">

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
                                                                <asp:Button ID="btnAdd" runat="server" CssClass="rgAdd" CommandName="InitInsert" AlternateText="Add" ToolTip="Add" />
                                                                <asp:Label ID="lblbenefitcodes" runat="server" Text="Benefit Codes Selection"></asp:Label>
                                                                
                                                            </td>
                                                            <td align="right">

                                                                <asp:Button ID="btnRefresh" CssClass="rgRefresh" runat="server" CommandName="Rebind" AlternateText="Refresh" ToolTip="Refresh" />
                                                            </td>


                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </td>
                                        </tr>
                                    </CommandItemTemplate>
                                    <RowIndicatorColumn FilterControlAltText="Filter RowIndicator column" Visible="True">
                                        <HeaderStyle Width="20px" />
                                    </RowIndicatorColumn>
                                    <ExpandCollapseColumn FilterControlAltText="Filter ExpandColumn column" Visible="True">
                                        <HeaderStyle Width="20px" />
                                    </ExpandCollapseColumn>
                                    <DetailTables>
                                    </DetailTables>
                                    <Columns>
                                        <telerik:GridBoundColumn DataField="recidd" AllowFiltering="false" FilterControlAltText="Filter column column"
                                            HeaderText="ID" UniqueName="column" ReadOnly="True" DataType="System.Int32" Visible ="false">
                                            <ColumnValidationSettings>
                                                <ModelErrorMessage Text=""></ModelErrorMessage>
                                            </ColumnValidationSettings>
                                            <FilterTemplate>
                                                <strong>Search</strong>
                                            </FilterTemplate>
                                            <ItemStyle Width="50px" />
                                        </telerik:GridBoundColumn>

                                        <telerik:GridTemplateColumn DataField="bftcod" SortExpression="bftcod" FilterControlWidth="130px" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" FilterControlAltText="Filter TemplateColumn0 column"
                                            HeaderText="Benefit Code" UniqueName="TemplateColumn001">
                                            <ItemTemplate>
                                                <asp:Label ID="lblbftcod" runat="server" Text='<%# Eval("bftcod") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <table>
                                                    <tr>
                                                        <td style="width: 280px">
                                                            <asp:HiddenField ID="hfEmployeeClassId" runat="server" Value='<%# Eval("clsidd") %>' />
                                                            <telerik:RadComboBox ID="ddlBenifitCode" runat="server"
                                                                Width="260px" Height="200px" DropDownWidth="410px"
                                                                EmptyMessage="Please select...">
                                                                <ItemTemplate>
                                                                    <telerik:RadAjaxPanel ID="RadAjaxPanelBenifitCode" runat="server" Width="410px" LoadingPanelID="RadAjaxLoadingPanelBenifitCode" Height="200px">
                                                                        <telerik:RadGrid ID="rGrdBenifitCode4DDL" AllowMultiRowSelection="true" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                                            CellSpacing="0" GridLines="None" OnNeedDataSource="rGrdBenifitCode4DDL_NeedDataSource"
                                                                            Width="410px" ClientSettings-EnableRowHoverStyle="True">
                                                                            <ClientSettings>
                                                                                <Selecting AllowRowSelect="true" EnableDragToSelectRows="true"></Selecting>
                                                                            </ClientSettings>

                                                                            <MasterTableView DataKeyNames="recidd,bftcod,bftds1" ClientDataKeyNames="recidd,bftcod,bftds1">
                                                                                <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                                                                <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                                                                                    <HeaderStyle Width="20px"></HeaderStyle>
                                                                                </RowIndicatorColumn>
                                                                                <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                                                                                    <HeaderStyle Width="20px"></HeaderStyle>
                                                                                </ExpandCollapseColumn>
                                                                                <Columns>
                                                                                    <telerik:GridClientSelectColumn></telerik:GridClientSelectColumn>

                                                                                    <telerik:GridBoundColumn DataField="recidd" FilterControlAltText="Filter column1 column"
                                                                                        HeaderText="ID" UniqueName="recidd">
                                                                                    </telerik:GridBoundColumn>
                                                                                    <telerik:GridBoundColumn DataField="bftcod" FilterControlAltText="Filter column2 column"
                                                                                        HeaderText="Code" UniqueName="bftcod">
                                                                                    </telerik:GridBoundColumn>
                                                                                    <telerik:GridBoundColumn DataField="bftds1" FilterControlAltText="Filter column3 column"
                                                                                        HeaderText="Description" UniqueName="bftds1">
                                                                                    </telerik:GridBoundColumn>
                                                                                </Columns>
                                                                                <EditFormSettings>
                                                                                    <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                                                                    </EditColumn>
                                                                                </EditFormSettings>
                                                                            </MasterTableView>
                                                                            <ClientSettings>
                                                                                <ClientEvents OnRowDeselected="OnBenifitCodeRowSelected" OnRowSelected="OnBenifitCodeRowSelected"></ClientEvents>
                                                                            </ClientSettings>
                                                                            <FilterMenu EnableImageSprites="False">
                                                                            </FilterMenu>
                                                                        </telerik:RadGrid>
                                                                    </telerik:RadAjaxPanel>
                                                                    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanelBenifitCode" runat="server">
                                                                    </telerik:RadAjaxLoadingPanel>
                                                                </ItemTemplate>
                                                                <Items>
                                                                    <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                                                </Items>
                                                            </telerik:RadComboBox>
                                                        </td>
                                                        <td></td>
                                                        <td>
                                                            <%--<asp:CheckBox runat="server" ID="chkbxInclude" Text="" Checked='<%# CheckBoxValue( Eval("grdact")) %>' />--%>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </EditItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn DataField="bftds1" SortExpression="bftds1" FilterControlWidth="130px" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" FilterControlAltText="Filter TemplateColumn2 column"
                                            HeaderText="Description" UniqueName="TemplateColumn2">
                                            <ItemTemplate>
                                                <asp:Label ID="lblDescription" runat="server" Text='<%# Eval("bftds1") %>'></asp:Label>
                                            </ItemTemplate>

                                        </telerik:GridTemplateColumn>

                                        <telerik:GridEditCommandColumn FilterControlAltText="Filter EditCommandColumn column"
                                            UniqueName="EditBenefitCode" ButtonType="ImageButton" EditFormHeaderTextFormat="{0}:">
                                            <ItemStyle HorizontalAlign="Center" Width="25px" />
                                        </telerik:GridEditCommandColumn>
                                        <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" ConfirmText="Are you sure to delete this Benefit Code record?"
                                            ConfirmTextFields="recidd" ConfirmTitle="Delete" FilterControlAltText="Filter column6 column"
                                            UniqueName="DeleteBenefitCode" ConfirmTextFormatString='Are you sure to delete Benefit Code record # {0}?'>
                                            <ItemStyle HorizontalAlign="Center" Width="25px" />
                                        </telerik:GridButtonColumn>
                                    </Columns>
                                    <SortExpressions>
                                        <telerik:GridSortExpression FieldName="recidd" SortOrder="Ascending" />
                                    </SortExpressions>
                                    <EditFormSettings>
                                        <EditColumn ButtonType="ImageButton" FilterControlAltText="Filter EditCommandColumn column">
                                        </EditColumn>
                                    </EditFormSettings>
                                </telerik:GridTableView>
  
                                <telerik:GridTableView runat="server" AllowFilteringByColumn="false" Name="DeductionCodes" CommandItemDisplay="Top" DataKeyNames="recidd">
                                    <CommandItemTemplate>
                                        <tr class="rgCommandRow">

                                            <td colspan="8" class="rgCommandCell">

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
                                                                <asp:Button ID="btnAdd" runat="server" CssClass="rgAdd" CommandName="InitInsert" AlternateText="Add" ToolTip="Add" />
                                                                <asp:Label ID="lbldedcodes" runat="server" Text="Deduction Codes Selection"></asp:Label>
                                                            
                                                            </td>
                                                            <td align="right">

                                                                <asp:Button ID="btnRefresh" CssClass="rgRefresh" runat="server" CommandName="Rebind" AlternateText="Refresh" ToolTip="Refresh" />
                                                            </td>


                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </td>
                                        </tr>
                                    </CommandItemTemplate>
                                    <RowIndicatorColumn FilterControlAltText="Filter RowIndicator column" Visible="True">
                                        <HeaderStyle Width="20px" />
                                    </RowIndicatorColumn>
                                    <ExpandCollapseColumn FilterControlAltText="Filter ExpandColumn column" Visible="True">
                                        <HeaderStyle Width="20px" />
                                    </ExpandCollapseColumn>
                                    <DetailTables>
                                    </DetailTables>
                                    <Columns>
                                        <telerik:GridBoundColumn DataField="recidd" AllowFiltering="false" FilterControlAltText="Filter column column"
                                            HeaderText="ID" UniqueName="column" ReadOnly="True" DataType="System.Int32" Visible ="false">
                                            <ColumnValidationSettings>
                                                <ModelErrorMessage Text=""></ModelErrorMessage>
                                            </ColumnValidationSettings>
                                            <FilterTemplate>
                                                <strong>Search</strong>
                                            </FilterTemplate>
                                            <ItemStyle Width="50px" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridTemplateColumn DataField="dedcod" SortExpression="dedcod" FilterControlWidth="130px" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" FilterControlAltText="Filter TemplateColumn0 column"
                                            HeaderText="Deduction Code" UniqueName="TemplateColumn001">
                                            <ItemTemplate>
                                                <asp:Label ID="lbldedcod" runat="server" Text='<%# Eval("dedcod") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <table>
                                                    <tr>
                                                        <td style="width: 280px">
                                                            <asp:HiddenField ID="hfEmployeeClassId" runat="server" Value='<%# Eval("clsidd") %>' />
                                                            <telerik:RadComboBox ID="ddlDeductionCode" runat="server"
                                                                Width="260px" Height="200px" DropDownWidth="410px"
                                                                EmptyMessage="Please select...">
                                                                <ItemTemplate>
                                                                    <telerik:RadAjaxPanel ID="RadAjaxPanelDeductionCode" runat="server" Width="410px" LoadingPanelID="RadAjaxLoadingPanelDeductionCode" Height="200px">
                                                                        <telerik:RadGrid ID="rGrdDeductionCode4DDL" AllowMultiRowSelection="true" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                                            CellSpacing="0" GridLines="None" OnNeedDataSource="rGrdDeductionCode4DDL_NeedDataSource"
                                                                            Width="410px" ClientSettings-EnableRowHoverStyle="True">
                                                                            <ClientSettings>
                                                                                <Selecting AllowRowSelect="true" EnableDragToSelectRows="true"></Selecting>
                                                                            </ClientSettings>

                                                                            <MasterTableView DataKeyNames="recidd,dedcod,dedds1" ClientDataKeyNames="recidd,dedcod,dedds1">
                                                                                <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                                                                <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                                                                                    <HeaderStyle Width="20px"></HeaderStyle>
                                                                                </RowIndicatorColumn>
                                                                                <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                                                                                    <HeaderStyle Width="20px"></HeaderStyle>
                                                                                </ExpandCollapseColumn>
                                                                                <Columns>
                                                                                    <telerik:GridClientSelectColumn></telerik:GridClientSelectColumn>

                                                                                    <telerik:GridBoundColumn DataField="recidd" FilterControlAltText="Filter column1 column"
                                                                                        HeaderText="ID" UniqueName="recidd">
                                                                                    </telerik:GridBoundColumn>
                                                                                    <telerik:GridBoundColumn DataField="dedcod" FilterControlAltText="Filter column2 column"
                                                                                        HeaderText="Code" UniqueName="dedcod">
                                                                                    </telerik:GridBoundColumn>
                                                                                    <telerik:GridBoundColumn DataField="dedds1" FilterControlAltText="Filter column3 column"
                                                                                        HeaderText="Description" UniqueName="dedds1">
                                                                                    </telerik:GridBoundColumn>
                                                                                </Columns>
                                                                                <EditFormSettings>
                                                                                    <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                                                                    </EditColumn>
                                                                                </EditFormSettings>
                                                                            </MasterTableView>
                                                                            <ClientSettings>
                                                                                <ClientEvents OnRowDeselected="OnDeductionCodeRowSelected" OnRowSelected="OnDeductionCodeRowSelected"></ClientEvents>
                                                                            </ClientSettings>
                                                                            <FilterMenu EnableImageSprites="False">
                                                                            </FilterMenu>
                                                                        </telerik:RadGrid>
                                                                    </telerik:RadAjaxPanel>
                                                                    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanelDeductionCode" runat="server">
                                                                    </telerik:RadAjaxLoadingPanel>
                                                                </ItemTemplate>
                                                                <Items>
                                                                    <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                                                </Items>
                                                            </telerik:RadComboBox>

                                                        </td>
                                                        <td>
                                                            <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator1281" runat="server" ErrorMessage="*" ForeColor="Red"
                                                        ControlToValidate="txtEmployeeClassCode"></asp:RequiredFieldValidator>
                                                 <asp:Label ID="lblInclude" Style="padding-left: 13px" Width="250px" runat="server" Text="Inactive:"></asp:Label>--%>
                                                        </td>
                                                        <td>
                                                            <%--<asp:CheckBox runat="server" ID="chkbxInclude" Text="" Checked='<%# CheckBoxValue( Eval("grdact")) %>' />--%>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </EditItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn DataField="dedds1" SortExpression="dedds1" FilterControlWidth="130px" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" FilterControlAltText="Filter TemplateColumn2 column"
                                            HeaderText="Description" UniqueName="TemplateColumn2">
                                            <ItemTemplate>
                                                <asp:Label ID="lblDescription" runat="server" Text='<%# Eval("dedds1") %>'></asp:Label>
                                            </ItemTemplate>

                                        </telerik:GridTemplateColumn>


                                        <telerik:GridEditCommandColumn FilterControlAltText="Filter EditCommandColumn column"
                                            UniqueName="EditDeductionCode" ButtonType="ImageButton" EditFormHeaderTextFormat="{0}:">
                                            <ItemStyle HorizontalAlign="Center" Width="25px" />
                                        </telerik:GridEditCommandColumn>
                                        <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" ConfirmText="Are you sure to delete this Deduction Code record?"
                                            ConfirmTextFields="recidd" ConfirmTitle="Delete" FilterControlAltText="Filter column6 column"
                                            UniqueName="DeleteDeductionCode" ConfirmTextFormatString='Are you sure to delete Deduction Code record # {0}?'>
                                            <ItemStyle HorizontalAlign="Center" Width="25px" />
                                        </telerik:GridButtonColumn>
                                    </Columns>
                                    <SortExpressions>
                                        <telerik:GridSortExpression FieldName="recidd" SortOrder="Ascending" />
                                    </SortExpressions>
                                    <EditFormSettings>
                                        <EditColumn ButtonType="ImageButton" FilterControlAltText="Filter EditCommandColumn column">
                                        </EditColumn>
                                    </EditFormSettings>
                                </telerik:GridTableView>

                                <telerik:GridTableView runat="server" AllowFilteringByColumn="false" EditMode="InPlace" Name="LoanRecords" CommandItemDisplay="Top" DataKeyNames="recidd">
                                    <CommandItemTemplate>
                                        <tr class="rgCommandRow">

                                            <td colspan="8" class="rgCommandCell">

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
                                                                <asp:Button ID="btnAddLoan" runat="server" CssClass="rgAdd" CommandName="InitInsert" AlternateText="Add" ToolTip="Add" />
                                                                <asp:Label ID="lblloancodes" runat="server" Text="Loan Codes Selection"></asp:Label>
                                                                
                                                            </td>
                                                            <td align="right">

                                                                <asp:Button ID="btnLoanRefresh" CssClass="rgRefresh" runat="server" CommandName="Rebind" AlternateText="Refresh" ToolTip="Refresh" />
                                                            </td>


                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </td>
                                        </tr>
                                    </CommandItemTemplate>
                                    <RowIndicatorColumn FilterControlAltText="Filter RowIndicator column" Visible="True">
                                        <HeaderStyle Width="20px" />
                                    </RowIndicatorColumn>
                                    <ExpandCollapseColumn FilterControlAltText="Filter ExpandColumn column" Visible="True">
                                        <HeaderStyle Width="20px" />
                                    </ExpandCollapseColumn>
                                    <DetailTables>
                                    </DetailTables>
                                    <Columns>
                                        <telerik:GridBoundColumn DataField="recidd" AllowFiltering="false" FilterControlAltText="Filter column column"
                                            HeaderText="ID" UniqueName="column" ReadOnly="True" DataType="System.Int32" Visible ="false">
                                            <ColumnValidationSettings>
                                                <ModelErrorMessage Text=""></ModelErrorMessage>
                                            </ColumnValidationSettings>
                                            <FilterTemplate>
                                                <strong>Search</strong>
                                            </FilterTemplate>
                                            <ItemStyle Width="50px" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridTemplateColumn DataField="clslnc" SortExpression="clslnc" FilterControlWidth="130px" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" FilterControlAltText="Filter TemplateColumn0 column"
                                            HeaderText="Loan Code" UniqueName="TemplateColumn0301">
                                            <ItemTemplate>
                                                <asp:Label ID="lblclslnc" runat="server" Text='<%# Eval("clslnc") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <table>
                                                    <tr>
                                                        <td style="width: 280px;border-bottom:0px">
                                                          <asp:HiddenField ID="hfddlLoanCodeId" runat="server" Value='<%# Eval("clslni") %>' />
                                                          <asp:HiddenField ID="hfddlLoanCodeText" runat="server" Value='<%# Eval("clslnc") %>' />
                                                          <telerik:RadComboBox ID="ddlLoanCode" runat="server"
                                                                Width="260px" Height="200px" DropDownWidth="410px"
                                                                EmptyMessage="Please select...">
                                                                <ItemTemplate>
                                                                    <telerik:RadAjaxPanel ID="RadAjaxPanelLoanCode" runat="server" Width="410px" LoadingPanelID="RadAjaxLoadingPanelLoanCode" Height="200px">
                                                                        <telerik:RadGrid ID="rGrdLoanCode4DDL" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                                            CellSpacing="0" GridLines="None" OnNeedDataSource="rGrdLoanCode4DDL_NeedDataSource"
                                                                            Width="410px" ClientSettings-EnableRowHoverStyle="True">
                                                                            <ClientSettings>
                                                                                <Selecting AllowRowSelect="true" EnableDragToSelectRows="true"></Selecting>
                                                                            </ClientSettings>

                                                                            <MasterTableView DataKeyNames="recidd,loncod,lvcds1" ClientDataKeyNames="recidd,loncod,lvcds1">
                                                                                <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                                                                <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                                                                                    <HeaderStyle Width="20px"></HeaderStyle>
                                                                                </RowIndicatorColumn>
                                                                                <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                                                                                    <HeaderStyle Width="20px"></HeaderStyle>
                                                                                </ExpandCollapseColumn>
                                                                                <Columns>
                                                                                    <telerik:GridBoundColumn DataField="recidd" FilterControlAltText="Filter column1 column"
                                                                                        HeaderText="ID" UniqueName="recidd">
                                                                                    </telerik:GridBoundColumn>
                                                                                    <telerik:GridBoundColumn DataField="loncod" FilterControlAltText="Filter column2 column"
                                                                                        HeaderText="Code" UniqueName="loncod">
                                                                                    </telerik:GridBoundColumn>
                                                                                    <telerik:GridBoundColumn DataField="lvcds1" FilterControlAltText="Filter column3 column"
                                                                                        HeaderText="Description" UniqueName="lvcds1">
                                                                                    </telerik:GridBoundColumn>
                                                                                </Columns>
                                                                                <EditFormSettings>
                                                                                    <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                                                                    </EditColumn>
                                                                                </EditFormSettings>
                                                                            </MasterTableView>
                                                                            <ClientSettings>
                                                                                <ClientEvents OnRowClick="OnLoanCodeRowClick"></ClientEvents>
                                                                            </ClientSettings>
                                                                            <FilterMenu EnableImageSprites="False">
                                                                            </FilterMenu>
                                                                        </telerik:RadGrid>
                                                                    </telerik:RadAjaxPanel>
                                                                    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanelLoanCode" runat="server">
                                                                    </telerik:RadAjaxLoadingPanel>
                                                                </ItemTemplate>
                                                                <Items>
                                                                    <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                                                </Items>
                                                            </telerik:RadComboBox>

                                                        </td>
                                                        <td style="border-bottom:0px">
                                                         <asp:RequiredFieldValidator ID="RequiredFieldValidator1281" runat="server" ErrorMessage="*" ForeColor="Red"
                                                        ControlToValidate="ddlLoanCode"></asp:RequiredFieldValidator>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </EditItemTemplate>
                                        </telerik:GridTemplateColumn>
                                    
                                         <telerik:GridTemplateColumn DataField="clsmal" SortExpression="clsmal" FilterControlWidth="130px" CurrentFilterFunction="EqualTo" 
                                             AutoPostBackOnFilter="true" FilterControlAltText="Filter TemplateColumn2 column"
                                                HeaderText="Max. Loan Amount" UniqueName="TemplateColumn21">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblMaxLoanAmount" runat="server" Text='<%# Eval("clsmal", "{0:0.00}") %>'></asp:Label>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <table>
                                                        <tr>
                                                            <td style="width: 280px;border-bottom:0px">

                                                                <telerik:RadNumericTextBox runat="server" ID="txtbxMaxLoanAmount" ClientIDMode="Static" Width="75" MaxValue="999999" MaxLength="8"
                                                                    AllowOutOfRangeAutoCorrect="True" DataType="System.Decimal" Text='<%# Eval("clsmal") %>'
                                                                    EnableSingleInputRendering="True">
                                                                    <NumberFormat AllowRounding="False" DecimalDigits="2" KeepNotRoundedValue="True"
                                                                        KeepTrailingZerosOnFocus="True" />
                                                                </telerik:RadNumericTextBox>
                                                            </td>
                                                            <td style="border-bottom:0px">
                                                                 <asp:RequiredFieldValidator ID="RequiredFieldValidator2123" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                    ControlToValidate="txtbxMaxLoanAmount"></asp:RequiredFieldValidator>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </EditItemTemplate>
                                            </telerik:GridTemplateColumn>

                                        <telerik:GridEditCommandColumn FilterControlAltText="Filter EditCommandColumn column"
                                            UniqueName="EditLoanRecords" ButtonType="ImageButton" EditFormHeaderTextFormat="{0}:">
                                            <ItemStyle HorizontalAlign="Center" Width="40px" />
                                        </telerik:GridEditCommandColumn>
                                        <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" ConfirmText="Are you sure to delete this Employee Class Loan record?"
                                            ConfirmTextFields="recidd" ConfirmTitle="Delete" FilterControlAltText="Filter column6 column"
                                            UniqueName="DeleteLoanRecords" ConfirmTextFormatString='Are you sure to delete Employee Class Loan record # {0}?'>
                                            <ItemStyle HorizontalAlign="Center" Width="40px" />
                                        </telerik:GridButtonColumn>
                                    </Columns>
                                    <SortExpressions>
                                        <telerik:GridSortExpression FieldName="recidd" SortOrder="Ascending" />
                                    </SortExpressions>
                                    <EditFormSettings>
                                        <EditColumn ButtonType="ImageButton" FilterControlAltText="Filter EditCommandColumn column">
                                        </EditColumn>
                                    </EditFormSettings>
                                </telerik:GridTableView>

                                <telerik:GridTableView runat="server" AllowFilteringByColumn="false" Name="ContributionRecords" CommandItemDisplay="Top" DataKeyNames="recidd">
                                    <CommandItemTemplate>
                                        <tr class="rgCommandRow">

                                            <td colspan="8" class="rgCommandCell">

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
                                                                <asp:Button ID="btnContributionRecordsAdd" runat="server" CssClass="rgAdd" CommandName="InitInsert" AlternateText="Add" ToolTip="Add" />
                                                                <asp:Label ID="lblcontrcodes" runat="server" Text="Contribution Codes Selection"></asp:Label>
                                                                
                                                            </td>
                                                            <td align="right">
                                                                <asp:Button ID="btnContributionRecordsRefresh" CssClass="rgRefresh" runat="server" CommandName="Rebind" AlternateText="Refresh" ToolTip="Refresh" />
                                                            </td>


                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </td>
                                        </tr>
                                    </CommandItemTemplate>
                                    <RowIndicatorColumn FilterControlAltText="Filter RowIndicator column" Visible="True">
                                        <HeaderStyle Width="20px" />
                                    </RowIndicatorColumn>
                                    <ExpandCollapseColumn FilterControlAltText="Filter ExpandColumn column" Visible="True">
                                        <HeaderStyle Width="20px" />
                                    </ExpandCollapseColumn>
                                    <DetailTables>
                                    </DetailTables>
                                    <Columns>
                                        <telerik:GridBoundColumn DataField="recidd" AllowFiltering="false" FilterControlAltText="Filter column column"
                                            HeaderText="ID" UniqueName="column" ReadOnly="True" DataType="System.Int32" Visible ="false">
                                            <ColumnValidationSettings>
                                                <ModelErrorMessage Text=""></ModelErrorMessage>
                                            </ColumnValidationSettings>
                                            <FilterTemplate>
                                                <strong>Search</strong>
                                            </FilterTemplate>
                                            <ItemStyle Width="50px" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridTemplateColumn DataField="cntcod" SortExpression="cntcod" FilterControlWidth="130px" AutoPostBackOnFilter="true"
                                            CurrentFilterFunction="Contains" FilterControlAltText="Filter TemplateColumn0 column"
                                            HeaderText="Contribution Code" UniqueName="TemplateColumn001">
                                            <ItemTemplate>
                                                <asp:Label ID="lblcontributioncod" runat="server" Text='<%# Eval("cntcod") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <table>
                                                    <tr>
                                                        <td style="width: 280px">
                                                            <asp:HiddenField ID="hfEmployeeClassId" runat="server" Value='<%# Eval("clsidd") %>' />
                                                            <telerik:RadComboBox ID="ddlContributionCode" runat="server"
                                                                Width="260px" Height="200px" DropDownWidth="410px"
                                                                EmptyMessage="Please select...">
                                                                <ItemTemplate>
                                                                    <telerik:RadAjaxPanel ID="RadAjaxPanelContributionCode" runat="server" Width="410px" LoadingPanelID="RadAjaxLoadingPanelContributionCode" Height="200px">
                                                                        <telerik:RadGrid ID="rGrdContributionCode4DDL" AllowMultiRowSelection="true" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                                            CellSpacing="0" GridLines="None" OnNeedDataSource="rGrdContributionCode4DDL_NeedDataSource"
                                                                            Width="410px" ClientSettings-EnableRowHoverStyle="True">
                                                                            <ClientSettings>
                                                                                <Selecting AllowRowSelect="true" EnableDragToSelectRows="true"></Selecting>
                                                                            </ClientSettings>

                                                                            <MasterTableView DataKeyNames="recidd,cntcod,cntds1" ClientDataKeyNames="recidd,cntcod,cntds1">
                                                                                <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                                                                <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                                                                                    <HeaderStyle Width="20px"></HeaderStyle>
                                                                                </RowIndicatorColumn>
                                                                                <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                                                                                    <HeaderStyle Width="20px"></HeaderStyle>
                                                                                </ExpandCollapseColumn>
                                                                                <Columns>
                                                                                    <telerik:GridClientSelectColumn></telerik:GridClientSelectColumn>

                                                                                    <telerik:GridBoundColumn DataField="recidd" FilterControlAltText="Filter column1 column"
                                                                                        HeaderText="ID" UniqueName="recidd">
                                                                                    </telerik:GridBoundColumn>
                                                                                    <telerik:GridBoundColumn DataField="cntcod" FilterControlAltText="Filter column2 column"
                                                                                        HeaderText="Code" UniqueName="cntcod">
                                                                                    </telerik:GridBoundColumn>
                                                                                    <telerik:GridBoundColumn DataField="cntds1" FilterControlAltText="Filter column3 column"
                                                                                        HeaderText="Description" UniqueName="cntds1">
                                                                                    </telerik:GridBoundColumn>
                                                                                </Columns>
                                                                                <EditFormSettings>
                                                                                    <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                                                                    </EditColumn>
                                                                                </EditFormSettings>
                                                                            </MasterTableView>
                                                                            <ClientSettings>
                                                                                <ClientEvents OnRowDeselected="OnContributionCodeRowSelected" OnRowSelected="OnContributionCodeRowSelected"></ClientEvents>
                                                                            </ClientSettings>
                                                                            <FilterMenu EnableImageSprites="False">
                                                                            </FilterMenu>
                                                                        </telerik:RadGrid>
                                                                    </telerik:RadAjaxPanel>
                                                                    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanelContributionCode" runat="server">
                                                                    </telerik:RadAjaxLoadingPanel>
                                                                </ItemTemplate>
                                                                <Items>
                                                                    <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                                                </Items>
                                                            </telerik:RadComboBox>

                                                            <%-- <asp:RequiredFieldValidator ID="RequiredFieldValidator122222" runat="server" ErrorMessage="*" ForeColor="Red"
                                            ControlToValidate="ddlPaycode"></asp:RequiredFieldValidator>--%>
                                                        </td>
                                                        <td></td>
                                                        <td></td>
                                                    </tr>
                                                </table>
                                            </EditItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn DataField="cntds1" SortExpression="cntds1" FilterControlWidth="130px" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" FilterControlAltText="Filter TemplateColumn2 column"
                                            HeaderText="Description" UniqueName="TemplateColumn2">
                                            <ItemTemplate>
                                                <asp:Label ID="lblDescription" runat="server" Text='<%# Eval("cntds1") %>'></asp:Label>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridEditCommandColumn FilterControlAltText="Filter EditCommandColumn column"
                                            UniqueName="EditContributionCode" ButtonType="ImageButton" EditFormHeaderTextFormat="{0}:">
                                            <ItemStyle HorizontalAlign="Center" Width="25px" />
                                        </telerik:GridEditCommandColumn>
                                        <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" ConfirmText="Are you sure to delete this Contribution Code record?"
                                            ConfirmTextFields="recidd" ConfirmTitle="Delete" FilterControlAltText="Filter column6 column"
                                            UniqueName="DeleteContributionCode" ConfirmTextFormatString='Are you sure to delete Contribution Code record # {0}?'>
                                            <ItemStyle HorizontalAlign="Center" Width="25px" />
                                        </telerik:GridButtonColumn>
                                    </Columns>
                                    <SortExpressions>
                                        <telerik:GridSortExpression FieldName="recidd" SortOrder="Ascending" />
                                    </SortExpressions>
                                    <EditFormSettings>
                                        <EditColumn ButtonType="ImageButton" FilterControlAltText="Filter EditCommandColumn column">
                                        </EditColumn>
                                    </EditFormSettings>
                                </telerik:GridTableView>


                            </DetailTables>
                            <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                            <CommandItemTemplate>
                                <div class="title">
                                    <img src="../../images/icons/dark/list.png" alt="" class="titleIcon" /><h6>Employee Class Setup</h6>
                                </div>
                                <tr class="rgCommandRow">

                                    <td colspan="8" class="rgCommandCell">

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
                                                        <asp:Button ID="Button1" runat="server" CssClass="rgAdd" CommandName="InitInsert" AlternateText="Add" ToolTip="Add" />
                                                    </td>
                                                    <td align="right">
                                                        <asp:Button runat="server" ID="btnEmployeeClassExcelExport" CssClass="rgExportExcel" ClientIDMode="Static" CommandName="ExportToExcel" AlternateText="Excel" ToolTip="Excel" />
                                                        <asp:Button runat="server" ID="btnEmployeeClassCsvExport" CssClass="rgExportCsv" ClientIDMode="Static" CommandName="ExportToCsv" AlternateText="Csv" ToolTip="Csv" />
                                                        <asp:Button runat="server" ID="btnEmployeeClassPdfExport" CssClass="rgExportPdf" ClientIDMode="Static" CommandName="ExportToPdf" AlternateText="Pdf" ToolTip="Pdf" />
                                                             <telerik:RadComboBox ID="ddlPrintOptions" Style="margin: 0px 5px" runat="server" Width="250px" DropDownWidth="250px"></telerik:RadComboBox>
                                                       
                                                        <asp:Button runat="server" ID="btnEmployeeClassPrint" CssClass="rgPrint" ClientIDMode="Static" CommandName="Print" AlternateText="Print" ToolTip="Print" />
                                                        <asp:Button ID="btnEmployeeClassRefresh" CssClass="rgRefresh" runat="server" CommandName="Rebind" AlternateText="Refresh" ToolTip="Refresh" />
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
                                <telerik:GridBoundColumn DataField="recidd" AllowFiltering="false" FilterControlAltText="Filter column column"
                                    HeaderText="ID" UniqueName="column" ReadOnly="True" DataType="System.Int32" Visible ="false">
                                    <ItemStyle />
                                    <FilterTemplate>
                                        <strong>Search</strong>
                                    </FilterTemplate>
                                </telerik:GridBoundColumn>
                                <telerik:GridTemplateColumn DataField="clscod" SortExpression="clscod" FilterControlWidth="130px" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" FilterControlAltText="Filter TemplateColumn0 column"
                                    HeaderText="Employee Class Code" UniqueName="TemplateColumn001">
                                    <ItemTemplate>
                                        <asp:Label ID="lblclscod" runat="server" Text='<%# Eval("clscod") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <table>
                                            <tr>
                                                <td style="width: 280px">
                                                    <telerik:RadTextBox ID="txtEmployeeClassCode" MaxLength="15" runat="server" Text='<%# Eval("clscod") %>'>
                                                    </telerik:RadTextBox>
                                                </td>
                                                <td>

                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator120" runat="server" ErrorMessage="*" ForeColor="Red"
                                                        ControlToValidate="txtEmployeeClassCode"></asp:RequiredFieldValidator>
                                                    <asp:Label ID="lblEmployementType" Style="padding-left: 13px" Width="250px" runat="server" Text="Employment Type"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:HiddenField ID="hfEmploymentTypedllID" runat="server" Value='<%# Eval("clsetp") %>' />
                                                    <asp:HiddenField ID="hfEmploymentTypedllText" runat="server" Value='<%# Eval("clsetptext") %>' />
                                                    <telerik:RadComboBox ID="ddlEmploymentType" runat="server"
                                                        Width="260px" Height="200px" DropDownWidth="410px"
                                                        EmptyMessage="Please select...">
                                                        <ItemTemplate>
                                                            <telerik:RadAjaxPanel ID="RadAjaxPanelEmploymentType" runat="server" Width="410px" LoadingPanelID="RadAjaxLoadingPanelEmploymentType" Height="200px">
                                                                <telerik:RadGrid ID="rGrdEmploymentType4DDL" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                                    CellSpacing="0" GridLines="None" OnNeedDataSource="rGrdEmploymentType4DDL_NeedDataSource"
                                                                    Width="410px" ClientSettings-EnableRowHoverStyle="True">
                                                                    <ClientSettings>
                                                                        <Selecting AllowRowSelect="true"></Selecting>
                                                                    </ClientSettings>
                                                                    <MasterTableView DataKeyNames="ValueSetID,Text,Value" ClientDataKeyNames="ValueSetID,Text,Value">
                                                                        <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                                                        <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                                                                            <HeaderStyle Width="20px"></HeaderStyle>
                                                                        </RowIndicatorColumn>
                                                                        <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                                                                            <HeaderStyle Width="20px"></HeaderStyle>
                                                                        </ExpandCollapseColumn>
                                                                        <Columns>
                                                                            <telerik:GridBoundColumn DataField="ValueSetID" Visible="false" FilterControlAltText="Filter column1 column"
                                                                                HeaderText="ID" UniqueName="column1">
                                                                            </telerik:GridBoundColumn>
                                                                            <telerik:GridBoundColumn DataField="Text" FilterControlAltText="Filter column2 column"
                                                                                HeaderText="Text" UniqueName="column2">
                                                                            </telerik:GridBoundColumn>
                                                                            <telerik:GridBoundColumn DataField="Value" Visible="false" FilterControlAltText="Filter column3 column"
                                                                                HeaderText="Value" UniqueName="column3">
                                                                            </telerik:GridBoundColumn>
                                                                        </Columns>
                                                                        <EditFormSettings>
                                                                            <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                                                            </EditColumn>
                                                                        </EditFormSettings>
                                                                    </MasterTableView>
                                                                    <ClientSettings>
                                                                        <ClientEvents OnRowClick="OnEmploymentTypeRowClicked"></ClientEvents>
                                                                    </ClientSettings>
                                                                    <FilterMenu EnableImageSprites="False">
                                                                    </FilterMenu>
                                                                </telerik:RadGrid>
                                                            </telerik:RadAjaxPanel>
                                                            <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanelEmploymentType" runat="server">
                                                            </telerik:RadAjaxLoadingPanel>
                                                        </ItemTemplate>
                                                        <Items>
                                                            <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                                        </Items>
                                                    </telerik:RadComboBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator122" runat="server" ErrorMessage="*" ForeColor="Red"
                                                        ControlToValidate="ddlEmploymentType"></asp:RequiredFieldValidator>

                                                </td>
                                            </tr>
                                        </table>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn DataField="clsds1" SortExpression="clsds1" FilterControlWidth="130px" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" FilterControlAltText="Filter TemplateColumn2 column"
                                    HeaderText="Description" UniqueName="TemplateColumn2">
                                    <ItemTemplate>
                                        <asp:Label ID="lblDescription" runat="server" Text='<%# Eval("clsds1") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <telerik:RadTextBox ID="txtDescription" runat="server" Text='<%# Eval("clsds1") %>' MaxLength="200">
                                        </telerik:RadTextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" Style="padding-left: 5px" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                            ControlToValidate="txtDescription"></asp:RequiredFieldValidator>

                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn DataField="clsds2" SortExpression="clsds2" FilterControlWidth="130px" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" FilterControlAltText="Filter TemplateColumn133 column"
                                    HeaderText="Description 2" UniqueName="TemplateColumn133">
                                    <ItemTemplate>
                                        <asp:Label ID="lblArabicDescription" runat="server" Text='<%# Eval("clsds2") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <telerik:RadTextBox ID="txtArabicDescription" runat="server" Text='<%# Eval("clsds2") %>' MaxLength="200">
                                        </telerik:RadTextBox>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn DataField="" Visible="false" SortExpression="" AllowFiltering="false" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" FilterControlAltText="Filter TemplateColumn0 column"
                                    HeaderText="Department" UniqueName="TemplateColumn01">
                                    <ItemTemplate>
                                        <asp:Label ID="lblDepartment" runat="server" Text=''></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <table>
                                            <tr>
                                                <td style="width: 280px">
                                                    <asp:HiddenField ID="hfDepartmentdllID" runat="server" Value='<%# Eval("dptidd") %>' />
                                                    <asp:HiddenField ID="hfDepartmentdllText" runat="server" Value='<%# Eval("dptcod") %>' />
                                                    <telerik:RadComboBox ID="ddlDepartment" runat="server"
                                                        Width="260px" Height="200px" DropDownWidth="410px"
                                                        EmptyMessage="Please select...">
                                                        <ItemTemplate>
                                                            <telerik:RadAjaxPanel ID="RadAjaxPanelDepartment" runat="server" Width="410px" LoadingPanelID="RadAjaxLoadingPanelDepartment" Height="200px">
                                                                <telerik:RadGrid ID="rGrdDepartment4DDL" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                                    CellSpacing="0" GridLines="None" OnNeedDataSource="rGrdDepartment4DDL_NeedDataSource"
                                                                    Width="410px" ClientSettings-EnableRowHoverStyle="True">
                                                                    <ClientSettings>
                                                                        <Selecting AllowRowSelect="true"></Selecting>
                                                                    </ClientSettings>
                                                                    <MasterTableView DataKeyNames="dptidd,dptcod,dptds1" ClientDataKeyNames="dptidd,dptcod,dptds1">
                                                                        <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                                                        <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                                                                            <HeaderStyle Width="20px"></HeaderStyle>
                                                                        </RowIndicatorColumn>
                                                                        <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                                                                            <HeaderStyle Width="20px"></HeaderStyle>
                                                                        </ExpandCollapseColumn>
                                                                        <Columns>
                                                                            <telerik:GridBoundColumn DataField="dptidd" FilterControlAltText="Filter column1 column"
                                                                                HeaderText="ID" UniqueName="column1">
                                                                            </telerik:GridBoundColumn>
                                                                            <telerik:GridBoundColumn DataField="dptcod" FilterControlAltText="Filter column2 column"
                                                                                HeaderText="Code" UniqueName="column2">
                                                                            </telerik:GridBoundColumn>
                                                                            <telerik:GridBoundColumn DataField=",dptds1" FilterControlAltText="Filter column3 column"
                                                                                HeaderText="Description" UniqueName="column3">
                                                                            </telerik:GridBoundColumn>
                                                                        </Columns>
                                                                        <EditFormSettings>
                                                                            <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                                                            </EditColumn>
                                                                        </EditFormSettings>
                                                                    </MasterTableView>
                                                                    <ClientSettings>
                                                                        <ClientEvents OnRowClick="OnDepartmentRowClicked"></ClientEvents>
                                                                    </ClientSettings>
                                                                    <FilterMenu EnableImageSprites="False">
                                                                    </FilterMenu>
                                                                </telerik:RadGrid>
                                                            </telerik:RadAjaxPanel>
                                                            <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanelDepartment" runat="server">
                                                            </telerik:RadAjaxLoadingPanel>
                                                        </ItemTemplate>
                                                        <Items>
                                                            <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                                        </Items>
                                                    </telerik:RadComboBox>
                                                    <%-- <asp:RequiredFieldValidator ID="RequiredFieldValidator1221" runat="server" ErrorMessage="*" ForeColor="Red"
                                                        ControlToValidate="ddlDepartment"></asp:RequiredFieldValidator>--%>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblPosition" Style="padding-left: 13px" Width="250px" runat="server" Text="Position"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:HiddenField ID="hfPositiondllID" runat="server" Value='<%# Eval("posidd") %>' />
                                                    <asp:HiddenField ID="hfPositiondllText" runat="server" Value='<%# Eval("poscod") %>' />
                                                    <telerik:RadComboBox ID="ddlPosition" runat="server"
                                                        Width="260px" Height="200px" DropDownWidth="410px"
                                                        EmptyMessage="Please select...">
                                                        <ItemTemplate>
                                                            <telerik:RadAjaxPanel ID="RadAjaxPanelPosition" runat="server" Width="410px" LoadingPanelID="RadAjaxLoadingPanelPosition" Height="200px">
                                                                <telerik:RadGrid ID="rGrdPosition4DDL" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                                    CellSpacing="0" GridLines="None" OnNeedDataSource="rGrdPosition4DDL_NeedDataSource"
                                                                    Width="410px" ClientSettings-EnableRowHoverStyle="True">
                                                                    <ClientSettings>
                                                                        <Selecting AllowRowSelect="true"></Selecting>
                                                                    </ClientSettings>
                                                                    <MasterTableView DataKeyNames="recidd,poscod,posds1" ClientDataKeyNames="recidd,poscod,posds1">
                                                                        <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                                                        <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                                                                            <HeaderStyle Width="20px"></HeaderStyle>
                                                                        </RowIndicatorColumn>
                                                                        <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                                                                            <HeaderStyle Width="20px"></HeaderStyle>
                                                                        </ExpandCollapseColumn>
                                                                        <Columns>
                                                                            <telerik:GridBoundColumn DataField="recidd" FilterControlAltText="Filter column1 column"
                                                                                HeaderText="ID" UniqueName="column1">
                                                                            </telerik:GridBoundColumn>
                                                                            <telerik:GridBoundColumn DataField="poscod" FilterControlAltText="Filter column2 column"
                                                                                HeaderText="Code" UniqueName="column2">
                                                                            </telerik:GridBoundColumn>
                                                                            <telerik:GridBoundColumn DataField="posds1" FilterControlAltText="Filter column3 column"
                                                                                HeaderText="Description" UniqueName="column3">
                                                                            </telerik:GridBoundColumn>
                                                                        </Columns>
                                                                        <EditFormSettings>
                                                                            <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                                                            </EditColumn>
                                                                        </EditFormSettings>
                                                                    </MasterTableView>
                                                                    <ClientSettings>
                                                                        <ClientEvents OnRowClick="OnPositionRowClicked"></ClientEvents>
                                                                    </ClientSettings>
                                                                    <FilterMenu EnableImageSprites="False">
                                                                    </FilterMenu>
                                                                </telerik:RadGrid>
                                                            </telerik:RadAjaxPanel>
                                                            <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanelPosition" runat="server">
                                                            </telerik:RadAjaxLoadingPanel>
                                                        </ItemTemplate>
                                                        <Items>
                                                            <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                                        </Items>
                                                    </telerik:RadComboBox>
                                                    <%--  <asp:RequiredFieldValidator ID="RequiredFieldValidator15222" runat="server" ErrorMessage="*" ForeColor="Red"
                                                        ControlToValidate="ddlPosition"></asp:RequiredFieldValidator>--%>

                                                </td>
                                            </tr>
                                        </table>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn DataField="" Visible="false" SortExpression="" AllowFiltering="false" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" FilterControlAltText="Filter TemplateColumn0 column"
                                    HeaderText="Leave" UniqueName="TemplateColumn01364">
                                    <ItemTemplate>
                                        <asp:Label ID="lblLeave" runat="server" Text=''></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <table>
                                            <tr>
                                                <td style="width: 280px">
                                                    <asp:HiddenField ID="hfLeavedllID" runat="server" Value='<%# Eval("anlidd") %>' />
                                                    <asp:HiddenField ID="hfLeavedllText" runat="server" Value='<%# Eval("anlcod") %>' />
                                                    <telerik:RadComboBox ID="ddlLeave" runat="server"
                                                        Width="260px" Height="200px" DropDownWidth="410px"
                                                        EmptyMessage="Please select...">
                                                        <ItemTemplate>
                                                            <telerik:RadAjaxPanel ID="RadAjaxPanelLeave" runat="server" Width="410px" LoadingPanelID="RadAjaxLoadingPanelLeave" Height="200px">
                                                                <telerik:RadGrid ID="rGrdLeave4DDL" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                                    CellSpacing="0" GridLines="None" OnNeedDataSource="rGrdLeave4DDL_NeedDataSource"
                                                                    Width="410px" ClientSettings-EnableRowHoverStyle="True">
                                                                    <ClientSettings>
                                                                        <Selecting AllowRowSelect="true"></Selecting>
                                                                    </ClientSettings>
                                                                    <MasterTableView DataKeyNames="recidd,levcod,levdsc" ClientDataKeyNames="recidd,levcod,levdsc">
                                                                        <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                                                        <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                                                                            <HeaderStyle Width="20px"></HeaderStyle>
                                                                        </RowIndicatorColumn>
                                                                        <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                                                                            <HeaderStyle Width="20px"></HeaderStyle>
                                                                        </ExpandCollapseColumn>
                                                                        <Columns>
                                                                            <telerik:GridBoundColumn DataField="recidd" FilterControlAltText="Filter column1 column"
                                                                                HeaderText="ID" UniqueName="column1">
                                                                            </telerik:GridBoundColumn>
                                                                            <telerik:GridBoundColumn DataField="levcod" FilterControlAltText="Filter column2 column"
                                                                                HeaderText="Code" UniqueName="column2">
                                                                            </telerik:GridBoundColumn>
                                                                            <telerik:GridBoundColumn DataField="levdsc" FilterControlAltText="Filter column3 column"
                                                                                HeaderText="Description" UniqueName="column3">
                                                                            </telerik:GridBoundColumn>
                                                                        </Columns>
                                                                        <EditFormSettings>
                                                                            <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                                                            </EditColumn>
                                                                        </EditFormSettings>
                                                                    </MasterTableView>
                                                                    <ClientSettings>
                                                                        <ClientEvents OnRowClick="OnLeaveRowClicked"></ClientEvents>
                                                                    </ClientSettings>
                                                                    <FilterMenu EnableImageSprites="False">
                                                                    </FilterMenu>
                                                                </telerik:RadGrid>
                                                            </telerik:RadAjaxPanel>
                                                            <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanelLeave" runat="server">
                                                            </telerik:RadAjaxLoadingPanel>
                                                        </ItemTemplate>
                                                        <Items>
                                                            <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                                        </Items>
                                                    </telerik:RadComboBox>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblTicketPeriod" Style="padding-left: 13px" Width="250px" runat="server" Text="Ticket Period"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:HiddenField ID="hfTicketPerioddllID" runat="server" Value='<%# Eval("clsprd") %>' />
                                                    <asp:HiddenField ID="hfTicketPeriodddlText" runat="server" Value='<%# Eval("clsprdtext") %>' />
                                                    <telerik:RadComboBox ID="ddlTicketPeriod" runat="server"
                                                        Width="260px" Height="200px" DropDownWidth="410px"
                                                        EmptyMessage="Please select...">
                                                        <ItemTemplate>
                                                            <telerik:RadAjaxPanel ID="RadAjaxPanelTicketPeriod" runat="server" Width="410px" LoadingPanelID="RadAjaxLoadingPanelTicketPeriod" Height="200px">
                                                                <telerik:RadGrid ID="rGrdTicketPeriod4DDL" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                                    CellSpacing="0" GridLines="None" OnNeedDataSource="rGrdTicketPeriod4DDL_NeedDataSource"
                                                                    Width="410px" ClientSettings-EnableRowHoverStyle="True">
                                                                    <ClientSettings>
                                                                        <Selecting AllowRowSelect="true"></Selecting>
                                                                    </ClientSettings>
                                                                    <MasterTableView DataKeyNames="ValueSetID,Text,Value" ClientDataKeyNames="ValueSetID,Text,Value">
                                                                        <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                                                        <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                                                                            <HeaderStyle Width="20px"></HeaderStyle>
                                                                        </RowIndicatorColumn>
                                                                        <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                                                                            <HeaderStyle Width="20px"></HeaderStyle>
                                                                        </ExpandCollapseColumn>
                                                                        <Columns>
                                                                            <telerik:GridBoundColumn DataField="ValueSetID" Visible="false" FilterControlAltText="Filter column1 column"
                                                                                HeaderText="ID" UniqueName="column1">
                                                                            </telerik:GridBoundColumn>
                                                                            <telerik:GridBoundColumn DataField="Text" FilterControlAltText="Filter column2 column"
                                                                                HeaderText="Text" UniqueName="column2">
                                                                            </telerik:GridBoundColumn>
                                                                            <telerik:GridBoundColumn DataField="Value" Visible="false" FilterControlAltText="Filter column3 column"
                                                                                HeaderText="Value" UniqueName="column3">
                                                                            </telerik:GridBoundColumn>
                                                                        </Columns>
                                                                        <EditFormSettings>
                                                                            <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                                                            </EditColumn>
                                                                        </EditFormSettings>
                                                                    </MasterTableView>
                                                                    <ClientSettings>
                                                                        <ClientEvents OnRowClick="OnTicketPeriodRowClicked"></ClientEvents>
                                                                    </ClientSettings>
                                                                    <FilterMenu EnableImageSprites="False">
                                                                    </FilterMenu>
                                                                </telerik:RadGrid>
                                                            </telerik:RadAjaxPanel>
                                                            <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanelTicketPeriod" runat="server">
                                                            </telerik:RadAjaxLoadingPanel>
                                                        </ItemTemplate>
                                                        <Items>
                                                            <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                                        </Items>
                                                    </telerik:RadComboBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator12225" runat="server" ErrorMessage="*" ForeColor="Red"
                                                        ControlToValidate="ddlTicketPeriod"></asp:RequiredFieldValidator>

                                                </td>

                                            </tr>
                                        </table>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn DataField="" Visible="false" SortExpression="" AllowFiltering="false" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" FilterControlAltText="Filter TemplateColumn0 column"
                                    HeaderText="Gratuity" UniqueName="TemplateColumn013644">
                                    <ItemTemplate>
                                        <asp:Label ID="lblGratuity" runat="server" Text=''></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <table>
                                            <tr>
                                                <td style="width: 280px">
                                                    <asp:HiddenField ID="hfGratuitydllID" runat="server" Value='<%# Eval("grtidd") %>' />
                                                    <asp:HiddenField ID="hfGratuitydllText" runat="server" Value='<%# Eval("grtcod") %>' />
                                                    <telerik:RadComboBox ID="ddlGratuity" runat="server"
                                                        Width="260px" Height="200px" DropDownWidth="410px"
                                                        EmptyMessage="Please select...">
                                                        <ItemTemplate>
                                                            <telerik:RadAjaxPanel ID="RadAjaxPanelGratuity" runat="server" Width="410px" LoadingPanelID="RadAjaxLoadingPanelGratuity" Height="200px">
                                                                <telerik:RadGrid ID="rGrdGratuity4DDL" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                                    CellSpacing="0" GridLines="None" OnNeedDataSource="rGrdGratuity4DDL_NeedDataSource"
                                                                    Width="410px" ClientSettings-EnableRowHoverStyle="True">
                                                                    <ClientSettings>
                                                                        <Selecting AllowRowSelect="true"></Selecting>
                                                                    </ClientSettings>
                                                                    <MasterTableView DataKeyNames="recidd,grtcod,grtdsc" ClientDataKeyNames="recidd,grtcod,grtdsc">
                                                                        <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                                                        <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                                                                            <HeaderStyle Width="20px"></HeaderStyle>
                                                                        </RowIndicatorColumn>
                                                                        <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                                                                            <HeaderStyle Width="20px"></HeaderStyle>
                                                                        </ExpandCollapseColumn>
                                                                        <Columns>
                                                                            <telerik:GridBoundColumn DataField="recidd" FilterControlAltText="Filter column1 column"
                                                                                HeaderText="ID" UniqueName="column1">
                                                                            </telerik:GridBoundColumn>
                                                                            <telerik:GridBoundColumn DataField="grtcod" FilterControlAltText="Filter column2 column"
                                                                                HeaderText="Code" UniqueName="column2">
                                                                            </telerik:GridBoundColumn>
                                                                            <telerik:GridBoundColumn DataField="grtdsc" FilterControlAltText="Filter column3 column"
                                                                                HeaderText="Description" UniqueName="column3">
                                                                            </telerik:GridBoundColumn>
                                                                        </Columns>
                                                                        <EditFormSettings>
                                                                            <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                                                            </EditColumn>
                                                                        </EditFormSettings>
                                                                    </MasterTableView>
                                                                    <ClientSettings>
                                                                        <ClientEvents OnRowClick="OnGratuityRowClicked"></ClientEvents>
                                                                    </ClientSettings>
                                                                    <FilterMenu EnableImageSprites="False">
                                                                    </FilterMenu>
                                                                </telerik:RadGrid>
                                                            </telerik:RadAjaxPanel>
                                                            <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanelGratuity" runat="server">
                                                            </telerik:RadAjaxLoadingPanel>
                                                        </ItemTemplate>
                                                        <Items>
                                                            <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                                        </Items>
                                                    </telerik:RadComboBox>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblTicketClass" Style="padding-left: 13px" Width="250px" runat="server" Text="Ticket Class"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:HiddenField ID="hfTicketClassdllID" runat="server" Value='<%# Eval("clstcp") %>' />
                                                    <asp:HiddenField ID="hfTicketClassdllText" runat="server" Value='<%# Eval("clstcptext") %>' />

                                                    <telerik:RadComboBox ID="ddlTicketClass" runat="server"
                                                        Width="260px" Height="200px" DropDownWidth="410px"
                                                        EmptyMessage="Please select...">
                                                        <ItemTemplate>
                                                            <telerik:RadAjaxPanel ID="RadAjaxPanelTicketClass" runat="server" Width="410px" LoadingPanelID="RadAjaxLoadingPanelTicketClass" Height="200px">
                                                                <telerik:RadGrid ID="rGrdTicketClass4DDL" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                                    CellSpacing="0" GridLines="None" OnNeedDataSource="rGrdTicketClass4DDL_NeedDataSource"
                                                                    Width="410px" ClientSettings-EnableRowHoverStyle="True">
                                                                    <ClientSettings>
                                                                        <Selecting AllowRowSelect="true"></Selecting>
                                                                    </ClientSettings>
                                                                    <MasterTableView DataKeyNames="ValueSetID,Text,Value" ClientDataKeyNames="ValueSetID,Text,Value">
                                                                        <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                                                        <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                                                                            <HeaderStyle Width="20px"></HeaderStyle>
                                                                        </RowIndicatorColumn>
                                                                        <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                                                                            <HeaderStyle Width="20px"></HeaderStyle>
                                                                        </ExpandCollapseColumn>
                                                                        <Columns>
                                                                            <telerik:GridBoundColumn DataField="ValueSetID" Visible="false" FilterControlAltText="Filter column1 column"
                                                                                HeaderText="ID" UniqueName="column1">
                                                                            </telerik:GridBoundColumn>
                                                                            <telerik:GridBoundColumn DataField="Text" FilterControlAltText="Filter column2 column"
                                                                                HeaderText="Text" UniqueName="column2">
                                                                            </telerik:GridBoundColumn>
                                                                            <telerik:GridBoundColumn DataField="Value" Visible="false" FilterControlAltText="Filter column3 column"
                                                                                HeaderText="Value" UniqueName="column3">
                                                                            </telerik:GridBoundColumn>
                                                                        </Columns>
                                                                        <EditFormSettings>
                                                                            <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                                                            </EditColumn>
                                                                        </EditFormSettings>
                                                                    </MasterTableView>
                                                                    <ClientSettings>
                                                                        <ClientEvents OnRowClick="OnTicketClassRowClicked"></ClientEvents>
                                                                    </ClientSettings>
                                                                    <FilterMenu EnableImageSprites="False">
                                                                    </FilterMenu>
                                                                </telerik:RadGrid>
                                                            </telerik:RadAjaxPanel>
                                                            <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanelTicketClass" runat="server">
                                                            </telerik:RadAjaxLoadingPanel>
                                                        </ItemTemplate>
                                                        <Items>
                                                            <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                                        </Items>
                                                    </telerik:RadComboBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1222" runat="server" ErrorMessage="*" ForeColor="Red"
                                                        ControlToValidate="ddlTicketClass"></asp:RequiredFieldValidator>


                                                </td>

                                            </tr>
                                        </table>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn DataField="" Visible="false" SortExpression="" AllowFiltering="false" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" FilterControlAltText="Filter TemplateColumn0 column"
                                    HeaderText="Overtime" UniqueName="TemplateColumn02134">
                                    <ItemTemplate>
                                        <asp:Label ID="lblOvertime" runat="server" Text=''></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <table>
                                            <tr>
                                                <td style="width: 280px">
                                                    <asp:HiddenField ID="hfOvertimedllID" runat="server" Value='<%# Eval("ovtidd") %>' />
                                                    <asp:HiddenField ID="hfOvertimedllText" runat="server" Value='<%# Eval("ovtcod") %>' />
                                                    <telerik:RadComboBox ID="ddlOvertime" runat="server"
                                                        Width="260px" Height="200px" DropDownWidth="410px"
                                                        EmptyMessage="Please select...">
                                                        <ItemTemplate>
                                                            <telerik:RadAjaxPanel ID="RadAjaxPanelOvertime" runat="server" Width="410px" LoadingPanelID="RadAjaxLoadingPanelOvertime" Height="200px">
                                                                <telerik:RadGrid ID="rGrdOvertime4DDL" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                                    CellSpacing="0" GridLines="None" OnNeedDataSource="rGrdOvertime4DDL_NeedDataSource"
                                                                    Width="410px" ClientSettings-EnableRowHoverStyle="True">
                                                                    <ClientSettings>
                                                                        <Selecting AllowRowSelect="true"></Selecting>
                                                                    </ClientSettings>
                                                                    <MasterTableView DataKeyNames="recidd,ovtcod,ovtdsc" ClientDataKeyNames="recidd,ovtcod,ovtdsc">
                                                                        <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                                                        <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                                                                            <HeaderStyle Width="20px"></HeaderStyle>
                                                                        </RowIndicatorColumn>
                                                                        <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                                                                            <HeaderStyle Width="20px"></HeaderStyle>
                                                                        </ExpandCollapseColumn>
                                                                        <Columns>
                                                                            <telerik:GridBoundColumn DataField="recidd" FilterControlAltText="Filter column1 column"
                                                                                HeaderText="ID" UniqueName="column1">
                                                                            </telerik:GridBoundColumn>
                                                                            <telerik:GridBoundColumn DataField="ovtcod" FilterControlAltText="Filter column2 column"
                                                                                HeaderText="Code" UniqueName="column2">
                                                                            </telerik:GridBoundColumn>
                                                                            <telerik:GridBoundColumn DataField="ovtdsc" FilterControlAltText="Filter column3 column"
                                                                                HeaderText="Description" UniqueName="column3">
                                                                            </telerik:GridBoundColumn>
                                                                        </Columns>
                                                                        <EditFormSettings>
                                                                            <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                                                            </EditColumn>
                                                                        </EditFormSettings>
                                                                    </MasterTableView>
                                                                    <ClientSettings>
                                                                        <ClientEvents OnRowClick="OnOvertimeRowClicked"></ClientEvents>
                                                                    </ClientSettings>
                                                                    <FilterMenu EnableImageSprites="False">
                                                                    </FilterMenu>
                                                                </telerik:RadGrid>
                                                            </telerik:RadAjaxPanel>
                                                            <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanelOvertime" runat="server">
                                                            </telerik:RadAjaxLoadingPanel>
                                                        </ItemTemplate>
                                                        <Items>
                                                            <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                                        </Items>
                                                    </telerik:RadComboBox>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblTicketFrequency" Style="padding-left: 13px" Width="250px" runat="server" Text="Ticket Frequency"></asp:Label>
                                                </td>
                                                <td style="width: 280px">

                                                    <telerik:RadNumericTextBox
                                                        MinValue="0" Width="50px" DbValue='<%# Eval("clsfrq") %>'
                                                        MaxValue="999999999"
                                                        ID="txtTicketFrequency" MaxLength="8"
                                                        runat="server">
                                                        <NumberFormat GroupSeparator="" DecimalDigits="0" AllowRounding="true" KeepNotRoundedValue="false" />
                                                        <ClientEvents OnKeyPress="KeyPress" />
                                                    </telerik:RadNumericTextBox>
                                                </td>
                                                <td>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator12252" Style="padding-left: 5px" runat="server" ErrorMessage="*" ForeColor="Red"
                                                        ControlToValidate="txtTicketFrequency"></asp:RequiredFieldValidator>
                                                </td>

                                            </tr>
                                        </table>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn DataField="" Visible="false" SortExpression="" AllowFiltering="false" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" FilterControlAltText="Filter TemplateColumn0 column"
                                    HeaderText="No of Tickets" UniqueName="TemplateColumn01324">
                                    <ItemTemplate>
                                        <%--                                        <asp:Label ID="lblCalender" runat="server" Text=''></asp:Label>--%>
                                    </ItemTemplate>
                                    <EditItemTemplate>

                                        <table>
                                            <tr>
                                                <td style="width: 280px">
                                                    <telerik:RadNumericTextBox DbValue='<%# Eval("clstcc") %>'
                                                        MinValue="0" Width="50px"
                                                        MaxValue="999999999"
                                                        ID="txtNoofTickets" MaxLength="8"
                                                        runat="server">
                                                        <NumberFormat GroupSeparator="" DecimalDigits="0" AllowRounding="true" KeepNotRoundedValue="false" />
                                                        <ClientEvents OnKeyPress="KeyPress" />
                                                    </telerik:RadNumericTextBox>
                                                    <%--     <telerik:RadComboBox ID="ddlCalender" runat="server"
                                                        Width="260px" Height="200px" DropDownWidth="410px"
                                                        EmptyMessage="Please select...">
                                                        <ItemTemplate>
                                                            <telerik:RadAjaxPanel ID="RadAjaxPanelCalender" runat="server" Width="410px" LoadingPanelID="RadAjaxLoadingPanelCalender" Height="200px">
                                                                <telerik:RadGrid ID="rGrdCalender4DDL" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                                    CellSpacing="0" GridLines="None" OnNeedDataSource="rGrdCalender4DDL_NeedDataSource"
                                                                    Width="410px" ClientSettings-EnableRowHoverStyle="True">
                                                                    <ClientSettings>
                                                                        <Selecting AllowRowSelect="true"></Selecting>
                                                                    </ClientSettings>
                                                                    <MasterTableView DataKeyNames="recidd,calcod,caldsc" ClientDataKeyNames="recidd,calcod,caldsc">
                                                                        <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                                                        <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                                                                            <HeaderStyle Width="20px"></HeaderStyle>
                                                                        </RowIndicatorColumn>
                                                                        <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                                                                            <HeaderStyle Width="20px"></HeaderStyle>
                                                                        </ExpandCollapseColumn>
                                                                        <Columns>
                                                                            <telerik:GridBoundColumn DataField="recidd" FilterControlAltText="Filter column1 column"
                                                                                HeaderText="ID" UniqueName="column1">
                                                                            </telerik:GridBoundColumn>
                                                                            <telerik:GridBoundColumn DataField="calcod" FilterControlAltText="Filter column2 column"
                                                                                HeaderText="Text" UniqueName="column2">
                                                                            </telerik:GridBoundColumn>
                                                                            <telerik:GridBoundColumn DataField="caldsc" FilterControlAltText="Filter column3 column"
                                                                                HeaderText="Value" UniqueName="column3">
                                                                            </telerik:GridBoundColumn>
                                                                        </Columns>
                                                                        <EditFormSettings>
                                                                            <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                                                            </EditColumn>
                                                                        </EditFormSettings>
                                                                    </MasterTableView>
                                                                    <ClientSettings>
                                                                        <ClientEvents OnRowClick="OnCalenderRowClicked"></ClientEvents>
                                                                    </ClientSettings>
                                                                    <FilterMenu EnableImageSprites="False">
                                                                    </FilterMenu>
                                                                </telerik:RadGrid>
                                                            </telerik:RadAjaxPanel>
                                                            <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanelCalender" runat="server">
                                                            </telerik:RadAjaxLoadingPanel>
                                                        </ItemTemplate>
                                                        <Items>
                                                            <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                                        </Items>
                                                    </telerik:RadComboBox>--%>
                                                </td>
                                                <td>
                                                    <%--                                                     <asp:Label ID="lblNoofTickets" style="padding-left:13px" Width="250px" runat="server" Text="No of Tickets"></asp:Label>--%>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator122524" Style="padding-left: 5px" runat="server" ErrorMessage="*" ForeColor="Red"
                                                        ControlToValidate="txtNoofTickets"></asp:RequiredFieldValidator>
                                                </td>
                                                <td></td>
                                            </tr>
                                        </table>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridEditCommandColumn FilterControlAltText="Filter EditCommandColumn column"
                                    UniqueName="Editclscod" ButtonType="ImageButton" EditFormHeaderTextFormat="{0}:">
                                    <ItemStyle HorizontalAlign="Center" />
                                </telerik:GridEditCommandColumn>
                                <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" ConfirmText="Are you sure to delete this Employee Class Record?"
                                    ConfirmTextFields="recidd" ConfirmTitle="Delete" FilterControlAltText="Filter column6 column"
                                    UniqueName="Deleteclscod" ConfirmTextFormatString='Are you sure to delete Employee Class record # "{0}"?'>
                                    <ItemStyle HorizontalAlign="Center" />
                                </telerik:GridButtonColumn>
                            </Columns>
                            <EditFormSettings CaptionFormatString='Edit Details for EmployeeClass Record # "{0}":' CaptionDataField="recidd">
                                <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                </EditColumn>
                                <EditColumn ButtonType="ImageButton" />
                            </EditFormSettings>
                        </MasterTableView>
                    </telerik:RadGrid>
                </div>
            </telerik:RadAjaxPanel>
            <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Skin="Default" Transparency="20">
            </telerik:RadAjaxLoadingPanel>
            </div>
    </fieldset>
</asp:Content>

