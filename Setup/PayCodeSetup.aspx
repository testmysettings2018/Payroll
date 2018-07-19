<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/UserMasterPage.master" AutoEventWireup="true" CodeFile="PayCodeSetup.aspx.cs" Inherits="Payroll_PayCodeSetup" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ControlContent" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="mainContentPlaceHolder" runat="Server">
   <style>

        .rgDetailTable .RadComboBox .rcbInputCellLeft {
            width : 118px !important;   
            overflow:hidden; 
        }
         .rgDetailTable   .RadComboBox .rcbInputCellLeft inputs {
            width : 140px !important;
            }
          .rgDetailTable  .RadComboBoxDropDown{
    min-width:150px !important;
}
    </style>
     <telerik:RadCodeBlock ID="rcb1" runat="server">
        <script type="text/javascript">
            function onRequestStart(sender, args) {
                if (args.get_eventTarget().indexOf("btnPayCodeExcelExport") >= 0 ||
                      args.get_eventTarget().indexOf("btnPayCodeCsvExport") >= 0 ||
                      args.get_eventTarget().indexOf("btnPayCodePdfExport") >= 0 ||
                      args.get_eventTarget().indexOf("btnPayCodePrint") >= 0 ||
                      args.get_eventTarget().indexOf("btnPayCodeRefresh") >= 0 ||

                    args.get_eventTarget().indexOf("btnCitizensExportExcel") >= 0 ||
                      args.get_eventTarget().indexOf("btnCitizensExportCsv") >= 0 ||
                      args.get_eventTarget().indexOf("btnCitizensExportPdf") >= 0 ||
                      args.get_eventTarget().indexOf("btnCitizensPrint") >= 0 ||
                      args.get_eventTarget().indexOf("btnCitizensRefresh") >= 0 ||

                    args.get_eventTarget().indexOf("btnExpatriateExportExcel") >= 0 ||
                   args.get_eventTarget().indexOf("btnExpatriateExportCsv") >= 0 ||
                   args.get_eventTarget().indexOf("btnExpatriateExportPdf") >= 0 ||
                   args.get_eventTarget().indexOf("btnExpatriatePrint") >= 0 ||
                   args.get_eventTarget().indexOf("btnExpatriateRefresh") >= 0

                  ) {
                    args.set_enableAjax(false);
                }
            }
            function OnPayCodeTypeRowClicked(sender, args) {
                var cellValues = args.getDataKeyValue("Text");
                var id = args.getDataKeyValue("ValueSetID");
                var combo = $find(sender.ClientID.replace('_i0_rGrdPayCodeType4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(id);
                    combo.commitChanges();
                }, 50);
            }
            function OnEGradeRowClicked(sender, args) {
                var cellValues = args.getDataKeyValue("grdcode");
                var id = args.getDataKeyValue("grdidd");
                var combo = $find(sender.ClientID.replace('_i0_rGrdEGrade4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(id);
                    combo.commitChanges();
                }, 50);
            }
            function OnCGradeRowClicked(sender, args) {
                var cellValues = args.getDataKeyValue("grdcode");
                var id = args.getDataKeyValue("grdidd");
                var combo = $find(sender.ClientID.replace('_i0_rGrdCGrade4DDL', ''));
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

            function OnPayPeriodRowClicked(sender, args) {
                var cellValues = args.getDataKeyValue("Text");
                var id = args.getDataKeyValue("ValueSetID");
                var combo = $find(sender.ClientID.replace('_i0_rGrdPayPeriod4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(id);
                    combo.commitChanges();
                }, 50);
            }

            function OnMethodRowClicked(sender, args) {
                var cellValues = args.getDataKeyValue("Text");
                var id = args.getDataKeyValue("ValueSetID");
                var combo = $find(sender.ClientID.replace('_i0_rGrdMethod4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(id);
                    combo.commitChanges();
                }, 50);
            }

            function ValidatePayCode(txtPayCodeCodeId, txtDescriptionId, ddlPayCodeTypeId, ddlPayPeriodId) {
                var str = '';
                if ($('#' + txtPayCodeCodeId).val() == undefined || $('#' + txtPayCodeCodeId).val() == "") {
                    str = 'PayCode Code Required.<br/>';
                }
                if ($('#' + txtDescriptionId).val() == undefined || $('#' + txtDescriptionId).val() == "") {
                    str += 'Description Required.<br/>';
                }
                if ($('#' + ddlPayCodeTypeId).val() == undefined || $('#' + ddlPayCodeTypeId).val() == "") {
                    str += 'Pay Code Type Required.<br/>';
                }
                if ($('#' + ddlPayPeriodId).val() == undefined || $('#' + ddlPayPeriodId).val() == "") {
                    str += 'Pay Period Required.<br/>';
                }
                if (str != '') {
                    showError(str, null, 10000);
                }
            }

            function ValidateCitizens(txtCsngfrmId, txtBxCsngtooId, txtBxCmarfrmId, txtBxCmartooId, ddlCGradeId) {
                var str = '';
                var needSingleCamparison = true;
                var needMarriedCamparison = true;
                if ($('#' + ddlCGradeId).val() == undefined || $('#' + ddlCGradeId).val() == "") {
                    str = 'Grade Required.<br/>';
                }
                if ($('#' + txtCsngfrmId).val() == undefined || $('#' + txtCsngfrmId).val() == "") {
                    str += 'Single from Required.<br/>';
                    needSingleCamparison = false;
                }
                if ($('#' + txtBxCsngtooId).val() == undefined || $('#' + txtBxCsngtooId).val() == "") {
                    str += 'Single To Required.<br/>';
                    needSingleCamparison = false;
                }
                if (needSingleCamparison) {
                    if (parseInt($('#' + txtCsngfrmId).val()) > parseInt($('#' + txtBxCsngtooId).val())) {
                        str += 'Greater Single To Value Required.<br/>';
                    }
                }
                if ($('#' + txtBxCmarfrmId).val() == undefined || $('#' + txtBxCmarfrmId).val() == "") {
                    str += 'Married from Required.<br/>';
                    needMarriedCamparison = false;
                }
                if ($('#' + txtBxCmartooId).val() == undefined || $('#' + txtBxCmartooId).val() == "") {
                    str += 'Married to Required.<br/>';
                    needMarriedCamparison = false;
                }
                if (needMarriedCamparison) {
                    if (parseInt($('#' + txtBxCmarfrmId).val()) > parseInt($('#' + txtBxCmartooId).val())) {
                        str += 'Greater Married To Value Required.<br/>';
                    }
                }
                if (str != '') {
                    showError(str, null, 10000);
                }
            }

            function ValidateExpatriate(txtEsngfrmId, txtBxEsngtooId, txtBxEmarfrmId, txtBxEmartooId, ddlEGradeId) {
                var str = '';
                var needSingleCamparison = true;
                var needMarriedCamparison = true;
                if ($('#' + ddlEGradeId).val() == undefined || $('#' + ddlEGradeId).val() == "") {
                    str = 'Grade Required.<br/>';
                }
                if ($('#' + txtEsngfrmId).val() == undefined || $('#' + txtEsngfrmId).val() == "") {
                    str += 'Single from Required.<br/>';
                    needSingleCamparison = false;
                }
                if ($('#' + txtBxEsngtooId).val() == undefined || $('#' + txtBxEsngtooId).val() == "") {
                    str += 'Single to Required.<br/>';
                    needSingleCamparison = false;
                }
                if (needSingleCamparison) {
                    if (parseInt($('#' + txtEsngfrmId).val()) > parseInt($('#' + txtBxEsngtooId).val())) {
                        str += 'Greater Single To Value Required.<br/>';
                    }
                }
                if ($('#' + txtBxEmarfrmId).val() == undefined || $('#' + txtBxEmarfrmId).val() == "") {
                    str += 'Married from Required.<br/>';
                    needMarriedCamparison = false;
                }
                if ($('#' + txtBxEmartooId).val() == undefined || $('#' + txtBxEmartooId).val() == "") {
                    str += 'Married to Required.<br/>';
                    needMarriedCamparison = false;
                }
                if (needMarriedCamparison) {
                    if (parseInt($('#' + txtBxEmarfrmId).val()) > parseInt($('#' + txtBxEmartooId).val())) {
                        str += 'Greater Married To Value Required.<br/>';
                    }
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
                    <telerik:RadGrid ID="gvPayCode" runat="server" AllowPaging="True" AllowSorting="True" AllowFilteringByColumn="true"
                        AutoGenerateColumns="False" CellSpacing="0" GridLines="None" OnInsertCommand="gvPayCode_InsertCommand"
                        OnNeedDataSource="gvPayCode_NeedDataSource" PageSize="20" OnDeleteCommand="gvPayCode_DeleteCommand"
                        OnUpdateCommand="gvPayCode_UpdateCommand" OnItemDataBound="gvPayCode_ItemDataBound"
                        OnItemCommand="gvPayCode_ItemCommand" OnDetailTableDataBind="gvPayCode_DetailTableDataBind" OnItemCreated="gvPayCode_ItemCreated">
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
                            InsertItemPageIndexAction="ShowItemOnCurrentPage" EditMode="EditForms">
                            <DetailTables>
                                <telerik:GridTableView runat="server" AllowFilteringByColumn="false" Name="Citizens" EditMode="InPlace" CommandItemDisplay="Top" DataKeyNames="recidd">
                                    <CommandItemTemplate>
                                        <div class="title">
                                            <img src="../../images/icons/dark/list.png" alt="" class="titleIcon" /><h6>Citizens</h6>
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
                                                                <asp:Button ID="btnCitizensAdd" runat="server" CssClass="rgAdd" CommandName="InitInsert" AlternateText="Add" ToolTip="Add" />
                                                            </td>
                                                            <td align="right">
                                                                <asp:Button runat="server" ID="btnCitizensExportExcel" CssClass="rgExportExcel" ClientIDMode="Static" CommandName="ExportToExcel" AlternateText="Excel" ToolTip="Excel" />

                                                                <asp:Button runat="server" ID="btnCitizensExportCsv" CssClass="rgExportCsv" ClientIDMode="Static" CommandName="ExportToCsv" AlternateText="Csv" ToolTip="Csv" />

                                                                <asp:Button runat="server" ID="btnCitizensExportPdf" CssClass="rgExportPdf" ClientIDMode="Static" CommandName="ExportToPdf" AlternateText="Pdf" ToolTip="Pdf" />
                                                                <asp:Button runat="server" ID="btnCitizensPrint" CssClass="rgPrint" ClientIDMode="Static" CommandName="Print" AlternateText="Print" ToolTip="Print" />

                                                                <asp:Button ID="btnCitizensRefresh" CssClass="rgRefresh" runat="server" CommandName="Rebind" AlternateText="Refresh" ToolTip="Refresh" />
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
                                            HeaderText="ID" UniqueName="column" ReadOnly="True" DataType="System.Int32" Visible="false">
                                            <ColumnValidationSettings>
                                                <ModelErrorMessage Text=""></ModelErrorMessage>
                                            </ColumnValidationSettings>
                                            <FilterTemplate>
                                                <strong>Search</strong>
                                            </FilterTemplate>
                                            <ItemStyle Width="50px" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridTemplateColumn DataField="grdcod" SortExpression="grdcod" FilterControlWidth="130px" CurrentFilterFunction="EqualTo" AutoPostBackOnFilter="true" AllowFiltering="true" FilterControlAltText="Filter TemplateColumn0 column"
                                            HeaderText="Grade" UniqueName="TemplateColumn0">
                                            <ItemTemplate>
                                                <asp:Label ID="lblCGrade" runat="server" Text='<%# Eval("grdcod") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <table>
                                                    <tr>
                                                        <td style="width: 280px;border-bottom:0px">
                                                            <asp:HiddenField ID="hfGradedllID" runat="server" Value='<%# Eval("grdidd") %>' />
                                                            <asp:HiddenField ID="hfGradedllText" runat="server" Value='<%# Eval("grdcod") %>' />
                                                            <telerik:RadComboBox ID="ddlCGrade" runat="server"
                                                                Width="155px" Height="200px" DropDownWidth="410px"
                                                                EmptyMessage="Please select...">
                                                                <ItemTemplate>
                                                                    <telerik:RadAjaxPanel ID="RadAjaxPanelCGrade" runat="server" Width="410px" LoadingPanelID="RadAjaxLoadingPanelCGrade" Height="200px">
                                                                        <telerik:RadGrid ID="rGrdCGrade4DDL" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                                            CellSpacing="0" GridLines="None" OnNeedDataSource="rGrdGrade4DDL_NeedDataSource"
                                                                            Width="410px" ClientSettings-EnableRowHoverStyle="True">
                                                                            <ClientSettings>
                                                                                <Selecting AllowRowSelect="true"></Selecting>
                                                                            </ClientSettings>
                                                                            <MasterTableView DataKeyNames="grdidd,grdcode,grdds1" ClientDataKeyNames="grdidd,grdcode,grdds1">
                                                                                <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                                                                <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                                                                                    <HeaderStyle Width="20px"></HeaderStyle>
                                                                                </RowIndicatorColumn>
                                                                                <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                                                                                    <HeaderStyle Width="20px"></HeaderStyle>
                                                                                </ExpandCollapseColumn>
                                                                                <Columns>
                                                                                    <telerik:GridBoundColumn DataField="grdidd" FilterControlAltText="Filter column1 column"
                                                                                        HeaderText="ID" UniqueName="column1">
                                                                                    </telerik:GridBoundColumn>
                                                                                    <telerik:GridBoundColumn DataField="grdcode" FilterControlAltText="Filter column2 column"
                                                                                        HeaderText="Code" UniqueName="column2">
                                                                                    </telerik:GridBoundColumn>
                                                                                    <telerik:GridBoundColumn DataField="grdds1" FilterControlAltText="Filter column3 column"
                                                                                        HeaderText="Description" UniqueName="column3">
                                                                                    </telerik:GridBoundColumn>
                                                                                </Columns>
                                                                                <EditFormSettings>
                                                                                    <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                                                                    </EditColumn>
                                                                                </EditFormSettings>
                                                                            </MasterTableView>
                                                                            <ClientSettings>
                                                                                <ClientEvents OnRowClick="OnCGradeRowClicked"></ClientEvents>
                                                                            </ClientSettings>
                                                                            <FilterMenu EnableImageSprites="False">
                                                                            </FilterMenu>
                                                                        </telerik:RadGrid>
                                                                    </telerik:RadAjaxPanel>
                                                                    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanelCGrade" runat="server">
                                                                    </telerik:RadAjaxLoadingPanel>
                                                                </ItemTemplate>
                                                                <Items>
                                                                    <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                                                </Items>
                                                            </telerik:RadComboBox>
                                                            
                                                        </td >
                                                        <td style="border-bottom:0px"><asp:RequiredFieldValidator ID="RequiredFieldValidator1221" runat="server" ErrorMessage="*" ForeColor="Red"
                                                                ControlToValidate="ddlCGrade"></asp:RequiredFieldValidator></td>
                                                        
                                                    </tr>
                                                </table>
                                            </EditItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn DataField="sngfrm" SortExpression="sngfrm" FilterControlAltText="Filter TemplateColumn1 column" FilterControlWidth="130px" CurrentFilterFunction="EqualTo" AutoPostBackOnFilter="true" AllowFiltering="true"
                                            HeaderText="Single From" UniqueName="TemplateColumn1">
                                            <ItemTemplate>
                                                <asp:Label ID="lblCsngfrm" runat="server" Text='<%# Eval("sngfrm", "{0:0.00}") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <table>
                                                    <tr>
                                                        <td style="border-bottom:0px">
                                                            <telerik:RadNumericTextBox runat="server" ID="txtCsngfrm" Width="75" MaxValue="999999" MaxLength="8"
                                                                AllowOutOfRangeAutoCorrect="True" DataType="System.Decimal" Text='<%# Eval("sngfrm") %>'
                                                                EnableSingleInputRendering="True">
                                                                <NumberFormat AllowRounding="False" DecimalDigits="2" KeepNotRoundedValue="True"
                                                                    KeepTrailingZerosOnFocus="True" />
                                                            </telerik:RadNumericTextBox>
                                                        </td>
                                                        <td style="border-bottom:0px">
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                ControlToValidate="txtCsngfrm"></asp:RequiredFieldValidator>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </EditItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn DataField="sngtoo" SortExpression="sngtoo" FilterControlAltText="Filter TemplateColumn2 column" FilterControlWidth="130px" CurrentFilterFunction="EqualTo" AutoPostBackOnFilter="true" AllowFiltering="true"
                                            HeaderText="Single To" UniqueName="TemplateColumn2">
                                            <ItemTemplate>
                                                <asp:Label ID="lblCsngtoo" runat="server" Text='<%# Eval("sngtoo", "{0:0.00}") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <table>
                                                    <tr>
                                                        <td style="border-bottom:0px">
                                                            <telerik:RadNumericTextBox runat="server" ID="txtBxCsngtoo" Width="75" MaxValue="999999" MaxLength="8"
                                                                AllowOutOfRangeAutoCorrect="True" DataType="System.Decimal" Text='<%# Eval("sngtoo") %>'
                                                                EnableSingleInputRendering="True">
                                                                <NumberFormat AllowRounding="False" DecimalDigits="2" KeepNotRoundedValue="True"
                                                                    KeepTrailingZerosOnFocus="True" />
                                                            </telerik:RadNumericTextBox>

                                                        </td>
                                                        <td style="border-bottom:0px">
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                ControlToValidate="txtBxCsngtoo"></asp:RequiredFieldValidator>
                                                            <asp:CompareValidator ID ="comparefieldvalidator" runat="server" ErrorMessage="*"  ForeColor="Red"  Display="Dynamic"
                                                                        ControlToValidate ="txtBxCsngtoo" Operator="GreaterThanEqual" Type="Integer" 
                                                                ControlToCompare="txtCsngfrm" ></asp:CompareValidator>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </EditItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn DataField="marfrm" SortExpression="marfrm" FilterControlAltText="Filter TemplateColumn3 column" FilterControlWidth="130px" CurrentFilterFunction="EqualTo" AutoPostBackOnFilter="true" AllowFiltering="true"
                                            HeaderText="Married From" UniqueName="TemplateColumn3">
                                            <ItemTemplate>
                                                <asp:Label ID="lblCmarfrm" runat="server" Text='<%# Eval("marfrm", "{0:0.00}") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <table>
                                                    <tr>
                                                        <td style="border-bottom:0px">
                                                            <telerik:RadNumericTextBox runat="server" ID="txtBxCmarfrm" Width="75" MaxValue="999999" MaxLength="8"
                                                                AllowOutOfRangeAutoCorrect="True" DataType="System.Decimal" Text='<%# Eval("marfrm") %>'
                                                                EnableSingleInputRendering="True">
                                                                <NumberFormat AllowRounding="False" DecimalDigits="2" KeepNotRoundedValue="True"
                                                                    KeepTrailingZerosOnFocus="True" />
                                                            </telerik:RadNumericTextBox>

                                                        </td>
                                                        <td style="border-bottom:0px">
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                ControlToValidate="txtBxCmarfrm"></asp:RequiredFieldValidator>
                                                     
                                                        </td>
                                                    </tr>
                                                </table>
                                            </EditItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn DataField="martoo" SortExpression="martoo" FilterControlWidth="130px" CurrentFilterFunction="EqualTo" AutoPostBackOnFilter="true" AllowFiltering="true" FilterControlAltText="Filter TemplateColumn4 column"
                                            HeaderText="Married To" UniqueName="TemplateColumn4">
                                            <ItemTemplate>
                                                <asp:Label ID="lblmartoo" runat="server" Text='<%# Eval("martoo", "{0:0.00}") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <table>
                                                    <tr>
                                                        <td style="border-bottom:0px">
                                                            <telerik:RadNumericTextBox runat="server" ID="txtBxCmartoo" Width="75" MaxLength="8"
                                                                AllowOutOfRangeAutoCorrect="True" DataType="System.Decimal" MaxValue="999999" Text='<%# Eval("martoo") %>'
                                                                EnableSingleInputRendering="True">
                                                                <NumberFormat AllowRounding="False" DecimalDigits="2" KeepNotRoundedValue="True"
                                                                    KeepTrailingZerosOnFocus="True" />
                                                            </telerik:RadNumericTextBox>


                                                        </td>
                                                        <td style="border-bottom:0px">
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                ControlToValidate="txtBxCmartoo"></asp:RequiredFieldValidator>
                                                                    <asp:CompareValidator ID ="marcomparefieldvalidator" runat="server" ErrorMessage="*"  ForeColor="Red"  Display="Dynamic"
                                                                        ControlToValidate ="txtBxCmartoo" Operator="GreaterThanEqual" Type="Integer"
                                                                         ControlToCompare="txtBxCmarfrm" ></asp:CompareValidator>

                                                        </td>
                                                    </tr>
                                                </table>
                                            </EditItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridEditCommandColumn FilterControlAltText="Filter EditCommandColumn column"
                                            UniqueName="EditCitizen" ButtonType="ImageButton" EditFormHeaderTextFormat="{0}:">
                                            <ItemStyle HorizontalAlign="Center" Width="45px" />
                                        </telerik:GridEditCommandColumn>
                                        <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" ConfirmText="Are you sure to delete this Citizen record?"
                                            ConfirmTextFields="recidd" ConfirmTitle="Delete" FilterControlAltText="Filter column6 column"
                                            UniqueName="DeleteCitizen" ConfirmTextFormatString='Are you sure to delete Citizen record # {0}?'>
                                            <ItemStyle HorizontalAlign="Center" Width="0px" />
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
                                <telerik:GridTableView runat="server" AllowFilteringByColumn="false" EditMode="InPlace" Name="Expatriate" CommandItemDisplay="Top" DataKeyNames="recidd">
                                    <CommandItemTemplate>
                                        <div class="title">
                                            <img src="../../images/icons/dark/list.png" alt="" class="titleIcon" /><h6>Expatriate</h6>
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
                                                                <asp:Button ID="btnExpatriateAdd" runat="server" CssClass="rgAdd" CommandName="InitInsert" AlternateText="Add" ToolTip="Add" />
                                                            </td>
                                                            <td align="right">
                                                                <asp:Button runat="server" ID="btnExpatriateExportExcel" CssClass="rgExportExcel" ClientIDMode="Static" CommandName="ExportToExcel" AlternateText="Excel" ToolTip="Excel" />

                                                                <asp:Button runat="server" ID="btnExpatriateExportCsv" CssClass="rgExportCsv" ClientIDMode="Static" CommandName="ExportToCsv" AlternateText="Csv" ToolTip="Csv" />

                                                                <asp:Button runat="server" ID="btnExpatriateExportPdf" CssClass="rgExportPdf" ClientIDMode="Static" CommandName="ExportToPdf" AlternateText="Pdf" ToolTip="Pdf" />
                                                                <asp:Button runat="server" ID="btnExpatriatePrint" CssClass="rgPrint" ClientIDMode="Static" CommandName="Print" AlternateText="Print" ToolTip="Print" />

                                                                <asp:Button ID="btnExpatriateRefresh" CssClass="rgRefresh" runat="server" CommandName="Rebind" AlternateText="Refresh" ToolTip="Refresh" />
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
                                            HeaderText="ID" UniqueName="column" ReadOnly="True" DataType="System.Int32" Visible="false">
                                            <ColumnValidationSettings>
                                                <ModelErrorMessage Text=""></ModelErrorMessage>
                                            </ColumnValidationSettings>
                                            <FilterTemplate>
                                                <strong>Search</strong>
                                            </FilterTemplate>
                                            <ItemStyle Width="50px" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridTemplateColumn DataField="grdcod" SortExpression="grdcod" FilterControlWidth="130px" CurrentFilterFunction="EqualTo" AutoPostBackOnFilter="true" AllowFiltering="true" FilterControlAltText="Filter TemplateColumn0 column"
                                            HeaderText="Grade" UniqueName="TemplateColumn0">
                                            <ItemTemplate>
                                                <asp:Label ID="lblGrade" runat="server" Text='<%# Eval("grdcod") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <table>
                                                    <tr>
                                                        <td style="width: 280px;border-bottom:0px">
                                                            <asp:HiddenField ID="hfEGradedllID" runat="server" Value='<%# Eval("grdidd") %>' />
                                                            <asp:HiddenField ID="hfEGradedllText" runat="server" Value='<%# Eval("grdcod") %>' />
                                                            <telerik:RadComboBox ID="ddlEGrade" runat="server"
                                                                Width="155px" Height="200px" DropDownWidth="410px"
                                                                EmptyMessage="Please select...">
                                                                <ItemTemplate>
                                                                    <telerik:RadAjaxPanel ID="RadAjaxPanelGrade" runat="server" Width="410px" LoadingPanelID="RadAjaxLoadingPanelGrade" Height="200px">
                                                                        <telerik:RadGrid ID="rGrdEGrade4DDL" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                                            CellSpacing="0" GridLines="None" OnNeedDataSource="rGrdGrade4DDL_NeedDataSource"
                                                                            Width="410px" ClientSettings-EnableRowHoverStyle="True">
                                                                            <ClientSettings>
                                                                                <Selecting AllowRowSelect="true"></Selecting>
                                                                            </ClientSettings>
                                                                            <MasterTableView DataKeyNames="grdidd,grdcode,grdds1" ClientDataKeyNames="grdidd,grdcode,grdds1">
                                                                                <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                                                                <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                                                                                    <HeaderStyle Width="20px"></HeaderStyle>
                                                                                </RowIndicatorColumn>
                                                                                <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                                                                                    <HeaderStyle Width="20px"></HeaderStyle>
                                                                                </ExpandCollapseColumn>
                                                                                <Columns>
                                                                                    <telerik:GridBoundColumn DataField="grdidd" FilterControlAltText="Filter column1 column"
                                                                                        HeaderText="ID" UniqueName="column1">
                                                                                    </telerik:GridBoundColumn>
                                                                                    <telerik:GridBoundColumn DataField="grdcode" FilterControlAltText="Filter column2 column"
                                                                                        HeaderText="Code" UniqueName="column2">
                                                                                    </telerik:GridBoundColumn>
                                                                                    <telerik:GridBoundColumn DataField="grdds1" FilterControlAltText="Filter column3 column"
                                                                                        HeaderText="Description" UniqueName="column3">
                                                                                    </telerik:GridBoundColumn>
                                                                                </Columns>
                                                                                <EditFormSettings>
                                                                                    <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                                                                    </EditColumn>
                                                                                </EditFormSettings>
                                                                            </MasterTableView>
                                                                            <ClientSettings>
                                                                                <ClientEvents OnRowClick="OnEGradeRowClicked"></ClientEvents>
                                                                            </ClientSettings>
                                                                            <FilterMenu EnableImageSprites="False">
                                                                            </FilterMenu>
                                                                        </telerik:RadGrid>
                                                                    </telerik:RadAjaxPanel>
                                                                    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanelGrade" runat="server">
                                                                    </telerik:RadAjaxLoadingPanel>
                                                                </ItemTemplate>
                                                                <Items>
                                                                    <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                                                </Items>
                                                            </telerik:RadComboBox>
                                                           
                                                        </td>
                                                        <td style="border-bottom:0px"> <asp:RequiredFieldValidator ID="RequiredFieldValidator122" runat="server" ErrorMessage="*" ForeColor="Red"
                                                                ControlToValidate="ddlEGrade"></asp:RequiredFieldValidator></td>
                                                    </tr>
                                                </table>
                                            </EditItemTemplate>
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn DataField="sngfrm" SortExpression="sngfrm" FilterControlAltText="Filter TemplateColumn1 column" FilterControlWidth="130px" CurrentFilterFunction="EqualTo" AutoPostBackOnFilter="true" AllowFiltering="true"
                                            HeaderText="Single From" UniqueName="TemplateColumn1">
                                            <ItemTemplate>
                                                <asp:Label ID="lblEsngfrm" runat="server" Text='<%# Eval("sngfrm", "{0:0.00}") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <table>
                                                    <tr>
                                                        <td style="border-bottom:0px">
                                                            <telerik:RadNumericTextBox runat="server" ID="txtEsngfrm" Width="75" MaxLength="8"
                                                                AllowOutOfRangeAutoCorrect="True" DataType="System.Decimal" MaxValue="999999" Text='<%# Eval("sngfrm") %>'
                                                                EnableSingleInputRendering="True">
                                                                <NumberFormat AllowRounding="False" DecimalDigits="2" KeepNotRoundedValue="True"
                                                                    KeepTrailingZerosOnFocus="True" />
                                                            </telerik:RadNumericTextBox>
                                                        </td>
                                                        <td style="border-bottom:0px">
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                ControlToValidate="txtEsngfrm"></asp:RequiredFieldValidator>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </EditItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn DataField="sngtoo" SortExpression="sngtoo" FilterControlAltText="Filter TemplateColumn2 column" FilterControlWidth="130px" CurrentFilterFunction="EqualTo" AutoPostBackOnFilter="true" AllowFiltering="true"
                                            HeaderText="Single To" UniqueName="TemplateColumn2">
                                            <ItemTemplate>
                                                <asp:Label ID="lblEsngtoo" runat="server" Text='<%# Eval("sngtoo", "{0:0.00}") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <table>
                                                    <tr>
                                                        <td style="border-bottom:0px">
                                                            <telerik:RadNumericTextBox runat="server" ID="txtBxEsngtoo" Width="75" MaxLength="8"
                                                                AllowOutOfRangeAutoCorrect="True" DataType="System.Decimal" MaxValue="999999" Text='<%# Eval("sngtoo") %>'
                                                                EnableSingleInputRendering="True">
                                                                <NumberFormat AllowRounding="False" DecimalDigits="2" KeepNotRoundedValue="True"
                                                                    KeepTrailingZerosOnFocus="True" />
                                                            </telerik:RadNumericTextBox>

                                                        </td>
                                                        <td style="border-bottom:0px">
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                ControlToValidate="txtBxEsngtoo"></asp:RequiredFieldValidator>
                                                              <asp:CompareValidator ID ="singcomparefieldvalidator" runat="server" ErrorMessage="*"  ForeColor="Red"  Display="Dynamic"
                                                                        ControlToValidate ="txtBxEsngtoo" Operator="GreaterThanEqual" Type="Integer"
                                                                         ControlToCompare="txtEsngfrm" ></asp:CompareValidator>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </EditItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn DataField="marfrm" SortExpression="marfrm" FilterControlAltText="Filter TemplateColumn3 column" FilterControlWidth="130px" CurrentFilterFunction="EqualTo" AutoPostBackOnFilter="true" AllowFiltering="true"
                                            HeaderText="Married From" UniqueName="TemplateColumn3">
                                            <ItemTemplate>
                                                <asp:Label ID="lblEmarfrm" runat="server" Text='<%# Eval("marfrm", "{0:0.00}") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <table>
                                                    <tr>
                                                        <td style="border-bottom:0px">
                                                            <telerik:RadNumericTextBox runat="server" ID="txtBxEmarfrm" Width="75" MaxLength="8"
                                                                AllowOutOfRangeAutoCorrect="True" DataType="System.Decimal" MaxValue="999999" Text='<%# Eval("marfrm") %>'
                                                                EnableSingleInputRendering="True">
                                                                <NumberFormat AllowRounding="False" DecimalDigits="2" KeepNotRoundedValue="True"
                                                                    KeepTrailingZerosOnFocus="True" />
                                                            </telerik:RadNumericTextBox>

                                                        </td>
                                                        <td style="border-bottom:0px">
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                ControlToValidate="txtBxEmarfrm"></asp:RequiredFieldValidator>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </EditItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn DataField="martoo" SortExpression="martoo" FilterControlWidth="130px" CurrentFilterFunction="EqualTo" AutoPostBackOnFilter="true" AllowFiltering="true" FilterControlAltText="Filter TemplateColumn4 column"
                                            HeaderText="Married To" UniqueName="TemplateColumn4">
                                            <ItemTemplate>
                                                <asp:Label ID="lblEmartoo" runat="server" Text='<%# Eval("martoo", "{0:0.00}") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <table>
                                                    <tr>
                                                        <td style="border-bottom:0px">
                                                            <telerik:RadNumericTextBox runat="server" ID="txtBxEmartoo" Width="75" MaxLength="8"
                                                                AllowOutOfRangeAutoCorrect="True" DataType="System.Decimal" MaxValue="999999" Text='<%# Eval("martoo") %>'
                                                                EnableSingleInputRendering="True">
                                                                <NumberFormat AllowRounding="False" DecimalDigits="2" KeepNotRoundedValue="True"
                                                                    KeepTrailingZerosOnFocus="True" />
                                                            </telerik:RadNumericTextBox>


                                                        </td>
                                                        <td style="border-bottom:0px">
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                ControlToValidate="txtBxEmartoo"></asp:RequiredFieldValidator>
                                                            <asp:CompareValidator ID ="marcomparefieldvalidator" runat="server" ErrorMessage="*"  ForeColor="Red"  Display="Dynamic"
                                                                        ControlToValidate ="txtBxEmartoo" Operator="GreaterThanEqual" Type="Integer"
                                                                         ControlToCompare="txtBxEmarfrm" ></asp:CompareValidator>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </EditItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridEditCommandColumn FilterControlAltText="Filter EditCommandColumn column"
                                            UniqueName="EditExpat" ButtonType="ImageButton" EditFormHeaderTextFormat="{0}:">
                                            <ItemStyle HorizontalAlign="Center" Width="45px" />
                                        </telerik:GridEditCommandColumn>
                                        <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" ConfirmText="Are you sure to delete this Expatriate record?"
                                            ConfirmTextFields="recidd" ConfirmTitle="Delete" FilterControlAltText="Filter column6 column"
                                            UniqueName="DeleteExpat" ConfirmTextFormatString='Are you sure to delete Expatriate record # {0}?'>
                                            <ItemStyle HorizontalAlign="Center" Width="0px" />
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
                                    <img src="../../images/icons/dark/list.png" alt="" class="titleIcon" /><h6>Pay Code Setup</h6>
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
                                                        <asp:Button runat="server" ID="btnPayCodeExcelExport" CssClass="rgExportExcel" ClientIDMode="Static" CommandName="ExportToExcel" AlternateText="Excel" ToolTip="Excel" />
                                                        <asp:Button runat="server" ID="btnPayCodeCsvExport" CssClass="rgExportCsv" ClientIDMode="Static" CommandName="ExportToCsv" AlternateText="Csv" ToolTip="Csv" />
                                                        <asp:Button runat="server" ID="btnPayCodePdfExport" CssClass="rgExportPdf" ClientIDMode="Static" CommandName="ExportToPdf" AlternateText="Pdf" ToolTip="Pdf" />
                                                             <telerik:RadComboBox ID="ddlPrintOptions" Style="margin: 0px 5px" runat="server" Width="250px" DropDownWidth="250px"></telerik:RadComboBox>
                                                        <asp:Button runat="server" ID="btnPayCodePrint" CssClass="rgPrint" ClientIDMode="Static" CommandName="Print" AlternateText="Print" ToolTip="Print" />
                                                        <asp:Button ID="btnPayCodeRefresh" CssClass="rgRefresh" runat="server" CommandName="Rebind" AlternateText="Refresh" ToolTip="Refresh" />
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
                                <telerik:GridBoundColumn DataField="recidd" AllowFiltering="true" FilterControlAltText="Filter column column"
                                    HeaderText="ID" UniqueName="column" ReadOnly="True" DataType="System.Int32" Visible="false">
                                    <ItemStyle />
                                    <FilterTemplate>
                                        <strong>Search</strong>
                                    </FilterTemplate>
                                </telerik:GridBoundColumn>
                                <telerik:GridTemplateColumn DataField="paycod" SortExpression="paycod" FilterControlWidth="130px" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" FilterControlAltText="Filter TemplateColumn0 column"
                                    HeaderText="Pay Code" UniqueName="TemplateColumn001">
                                    <ItemTemplate>
                                        <asp:Label ID="lblpaycod" runat="server" Text='<%# Eval("paycod") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <table>
                                            <tr>
                                                <td style="width: 280px">
                                                    <telerik:RadTextBox ID="txtPayCodeCode" MaxLength="15" runat="server" Text='<%# Eval("paycod") %>'>
                                                    </telerik:RadTextBox>
                                                </td>
                                                <td>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator12" runat="server" ErrorMessage="*" ForeColor="Red"
                                                        ControlToValidate="txtPayCodeCode"></asp:RequiredFieldValidator>
                                                    <asp:Label ID="lblInclude" Style="padding-left: 13px" Width="250px" runat="server" Text="Inactive:"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:CheckBox runat="server" ID="chkbxInclude" Text="" Checked='<%# CheckBoxValue( Eval("payact")) %>' />
                                                </td>
                                            </tr>
                                        </table>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn DataField="payds1" SortExpression="payds1" FilterControlWidth="130px" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" FilterControlAltText="Filter TemplateColumn2 column"
                                    HeaderText="Description" UniqueName="TemplateColumn2">
                                    <ItemTemplate>
                                        <asp:Label ID="lblDescription" runat="server" Text='<%# Eval("payds1") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <telerik:RadTextBox ID="txtDescription" runat="server" Text='<%# Eval("payds1") %>' MaxLength="200">
                                        </telerik:RadTextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                            ControlToValidate="txtDescription"></asp:RequiredFieldValidator>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn DataField="payds2" SortExpression="payds2" FilterControlWidth="130px" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" FilterControlAltText="Filter TemplateColumn133 column"
                                    HeaderText="Description 2" UniqueName="TemplateColumn133">
                                    <ItemTemplate>
                                        <asp:Label ID="lblArabicDescription" runat="server" Text='<%# Eval("payds2") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <telerik:RadTextBox ID="txtArabicDescription" runat="server" Text='<%# Eval("payds2") %>' MaxLength="200">
                                        </telerik:RadTextBox>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn DataField="" Visible="false" SortExpression="" AllowFiltering="true" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" FilterControlAltText="Filter TemplateColumn0 column"
                                    HeaderText="Pay Type" UniqueName="TemplateColumn0">
                                    <ItemTemplate>
                                        <asp:Label ID="lblPayCodeType" runat="server" Text=''></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <table>
                                            <tr>
                                                <td style="width: 280px">
                                                    <asp:HiddenField ID="hfPayCodeTypedllID" runat="server" Value='<%# Eval("paytyp") %>' />
                                                    <asp:HiddenField ID="hfPayCodeTypedllText" runat="server" Value='<%# Eval("paytyptext") %>' />
                                                    <asp:HiddenField ID="hfPayCodeTypedllValue" runat="server" Value='<%# Eval("paytypvalue") %>' />
                                                    <telerik:RadComboBox ID="ddlPayCodeType" runat="server"
                                                        Width="260px" Height="200px" DropDownWidth="410px"
                                                        EmptyMessage="Please select...">
                                                        <ItemTemplate>
                                                            <telerik:RadAjaxPanel ID="RadAjaxPanelPayCodeType" runat="server" Width="410px" LoadingPanelID="RadAjaxLoadingPanelPayCodeType" Height="200px">
                                                                <telerik:RadGrid ID="rGrdPayCodeType4DDL" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                                    CellSpacing="0" GridLines="None" OnNeedDataSource="rGrdPayCodeType4DDL_NeedDataSource"
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
                                                                        <ClientEvents OnRowClick="OnPayCodeTypeRowClicked"></ClientEvents>
                                                                    </ClientSettings>
                                                                    <FilterMenu EnableImageSprites="False">
                                                                    </FilterMenu>
                                                                </telerik:RadGrid>
                                                            </telerik:RadAjaxPanel>
                                                            <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanelPayCodeType" runat="server">
                                                            </telerik:RadAjaxLoadingPanel>
                                                        </ItemTemplate>
                                                        <Items>
                                                            <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                                        </Items>
                                                    </telerik:RadComboBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator122" runat="server" ErrorMessage="*" ForeColor="Red"
                                                        ControlToValidate="ddlPayCodeType"></asp:RequiredFieldValidator>
                                                </td>
                                                <td></td>
                                                <td></td>
                                            </tr>
                                        </table>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn Visible="false" FilterControlAltText="Filter TemplateColumn711 column"
                                    HeaderText="Pay Rate" UniqueName="TemplateColumn711">
                                    <EditItemTemplate>
                                        <table>
                                            <tr>
                                                <td style="width: 280px">
                                                    <telerik:RadNumericTextBox runat="server" ID="txtPayrate" Width="75" MaxLength="8"
                                                        AllowOutOfRangeAutoCorrect="True" DataType="System.Decimal" MaxValue="999999" Text='<%# Eval("payrat") %>'
                                                        EnableSingleInputRendering="True">
                                                        <NumberFormat AllowRounding="False" DecimalDigits="2" KeepNotRoundedValue="True"
                                                            KeepTrailingZerosOnFocus="True" />
                                                    </telerik:RadNumericTextBox>
                                                </td>
                                                <td>
                                                    <%--                                                    <asp:Label ID="lblUnitofPay" Style="padding-left: 13px" Width="250px" runat="server" Text="Unit of Pay:"></asp:Label>--%>
                                                </td>
                                                <td>
                                                    <%-- <telerik:RadTextBox ID="txtUnitofPay" ReadOnly="true" runat="server"  MaxLength="100" Text='<%# Eval("payunp") %>'>
                                                    </telerik:RadTextBox>--%>
                                                </td>
                                            </tr>
                                        </table>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn Visible="false" FilterControlAltText="Filter TemplateColumn71 column"
                                    HeaderText="Pay Period" UniqueName="TemplateColumn71">
                                    <EditItemTemplate>
                                        <table>
                                            <tr>
                                                <td style="width: 280px">
                                                    <asp:HiddenField ID="hfPayPerioddllID" runat="server" Value='<%# Eval("payper") %>' />
                                                    <asp:HiddenField ID="hfPayPeriodddlText" runat="server" Value='<%# Eval("paypertext") %>' />
                                                    <asp:HiddenField ID="hfPayPeriodddlValue" runat="server" Value='<%# Eval("paypervalue") %>' />
                                                    <telerik:RadComboBox ID="ddlPayPeriod" runat="server"
                                                        Width="255px" Height="200px" DropDownWidth="410px"
                                                        EmptyMessage="Please select...">
                                                        <ItemTemplate>
                                                            <telerik:RadAjaxPanel ID="RadAjaxPanelPayPeriod" runat="server" Width="410px" LoadingPanelID="RadAjaxLoadingPanelPayPeriod" Height="200px">
                                                                <telerik:RadGrid ID="rGrdPayPeriod4DDL" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                                    CellSpacing="0" GridLines="None" OnNeedDataSource="rGrdPayPeriod4DDL_NeedDataSource"
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
                                                                        <ClientEvents OnRowClick="OnPayPeriodRowClicked"></ClientEvents>
                                                                    </ClientSettings>
                                                                    <FilterMenu EnableImageSprites="False">
                                                                    </FilterMenu>
                                                                </telerik:RadGrid>
                                                            </telerik:RadAjaxPanel>
                                                            <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanelPayCodeType" runat="server">
                                                            </telerik:RadAjaxLoadingPanel>
                                                        </ItemTemplate>
                                                        <Items>
                                                            <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                                        </Items>

                                                    </telerik:RadComboBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator12222" runat="server" ErrorMessage="*" ForeColor="Red"
                                                        ControlToValidate="ddlPayPeriod"></asp:RequiredFieldValidator>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblPayperperiod" Style="padding-left: 13px" Width="250px" runat="server" Text="Pay per Period:"></asp:Label>
                                                </td>
                                                <td>
                                                    <telerik:RadNumericTextBox runat="server" ID="txtpayperpriod" Width="75" MaxLength="8"
                                                        AllowOutOfRangeAutoCorrect="True" DataType="System.Decimal" MaxValue="999999" Text='<%# Eval("payppr") %>'
                                                        EnableSingleInputRendering="True">
                                                        <NumberFormat AllowRounding="False" DecimalDigits="2" KeepNotRoundedValue="True"
                                                            KeepTrailingZerosOnFocus="True" />
                                                    </telerik:RadNumericTextBox>
                                                </td>
                                            </tr>
                                        </table>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn Visible="false" DataField="paydft" SortExpression="paydft" FilterControlWidth="130px" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" FilterControlAltText="Filter TemplateColumn0111 column"
                                    HeaderText="Is Default Code" UniqueName="TemplateColumn0011">
                                    <ItemTemplate>
                                        <asp:Label ID="lblpaydft" runat="server" Text='<%# Eval("paydft") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <table>
                                            <tr>
                                                <td style="width: 280px">
                                                    <asp:CheckBox runat="server" ID="chkbxDefault" Text="" Checked='<%# CheckBoxValue( Eval("paydft")) %>' />
                                                </td>
                                                <td></td>
                                                <td></td>
                                            </tr>
                                        </table>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridEditCommandColumn FilterControlAltText="Filter EditCommandColumn column"
                                    UniqueName="EditPaycod" ButtonType="ImageButton" EditFormHeaderTextFormat="{0}:">
                                    <ItemStyle HorizontalAlign="Center" />
                                </telerik:GridEditCommandColumn>
                                <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" ConfirmText="Are you sure to delete this Pay Code Record?"
                                    ConfirmTextFields="recidd" ConfirmTitle="Delete" FilterControlAltText="Filter column6 column"
                                    UniqueName="DeletePaycod" ConfirmTextFormatString='Are you sure to delete Pay Code record  # "{0}"?'>
                                    <ItemStyle HorizontalAlign="Center" />
                                </telerik:GridButtonColumn>
                            </Columns>
                            <EditFormSettings CaptionFormatString='Edit Details for PayCode Record # "{0}":' CaptionDataField="recidd">
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

