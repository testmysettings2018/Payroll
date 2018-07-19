<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/UserMasterPage.master" AutoEventWireup="true" CodeFile="SearchLeaveBalance.aspx.cs" Inherits="Payroll_SearchLeaveBalance" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ControlContent" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="mainContentPlaceHolder" runat="Server">
    <style>
        .formRow .formCol > label {
            margin-top: 5px !important;
        }
    </style>
    <telerik:RadCodeBlock ID="rcb1" runat="server">
        <script type="text/javascript">
            function onRequestStart(sender, args) {
                if (
                     args.get_eventTarget().indexOf("btnLeaveExportExcel") >= 0 ||
                      args.get_eventTarget().indexOf("btnLeaveExportCsv") >= 0 ||
                      args.get_eventTarget().indexOf("btnLeaveExportPdf") >= 0 ||
                      args.get_eventTarget().indexOf("btnLeavePrint") >= 0 ||
                      args.get_eventTarget().indexOf("btnLeaveRefresh") >= 0
                    //||
                   // args.get_eventTarget().indexOf("ddlEmployee") >= 0
                   ) {
                    args.set_enableAjax(false);
                }
            }

            function RowClicked(sender, args) {
                var cellValues = args.getDataKeyValue("FullNameWithID");
                var EmployeeID = args.getDataKeyValue("EmployeeID");

                var combo = $find(sender.ClientID.replace('_i0_rGrdEmployees4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(EmployeeID);
                    combo.commitChanges();
                }, 50);
            }

            function OnEmployeeRowClicked(sender, args) {
                var cellValues = args.getDataKeyValue("empcod");
                var id = args.getDataKeyValue("recidd");
                var combo = $find(sender.ClientID.replace('_i0_rGrdEmployee4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(id);
                    combo.commitChanges();
                    $('#btnSearch').click();
                }, 50);
            }
            function ShowReport(Reportname) {


                window.open("../Reports/LaunchReport.aspx?Reportname=" + Reportname);
                return false;
            }
        </script>
    </telerik:RadCodeBlock>
    <fieldset>
        <div class="widget">
            <div class="title">
                <img src="../../images/icons/dark/list.png" alt="" class="titleIcon" /><h6>Leave Balance</h6>
            </div>
            <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server"  clientevents-onrequeststart="onRequestStart" LoadingPanelID="RadAjaxLoadingPanel1">
                <div class="formRow">
                    <div class="formCol">
                        <label>Employee</label>
                        <div class="formRight">
                            <telerik:RadComboBox ID="ddlEmployee" runat="server"
                                Width="255px" Height="200px" DropDownWidth="410px"
                                EmptyMessage="Please select..." OnSelectedIndexChanged="ddlEmployee_SelectedIndexChanged">
                                <ItemTemplate>
                                    <telerik:RadAjaxPanel ID="RadAjaxPanel2" runat="server" Width="410px" LoadingPanelID="RadAjaxLoadingPanelEmployee" Height="200px">
                                        <telerik:RadGrid ID="rGrdEmployee4DDL" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                            CellSpacing="0" GridLines="None" OnNeedDataSource="rGrdEmployee4DDL_NeedDataSource"
                                            Width="410px" ClientSettings-EnableRowHoverStyle="True">
                                            <ClientSettings>
                                                <Selecting AllowRowSelect="true"></Selecting>
                                            </ClientSettings>
                                            <MasterTableView DataKeyNames="recidd,empcod,empfsn" ClientDataKeyNames="recidd,empcod,empfsn">
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
                                                    <telerik:GridBoundColumn DataField="empcod" FilterControlAltText="Filter column2 column"
                                                        HeaderText="Code" UniqueName="column2">
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn DataField="empfsn" FilterControlAltText="Filter column3 column"
                                                        HeaderText="Name" UniqueName="column3">
                                                    </telerik:GridBoundColumn>
                                                </Columns>
                                                <EditFormSettings>
                                                    <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                                    </EditColumn>
                                                </EditFormSettings>
                                            </MasterTableView>
                                            <ClientSettings>
                                                <ClientEvents OnRowClick="OnEmployeeRowClicked"></ClientEvents>
                                            </ClientSettings>
                                            <FilterMenu EnableImageSprites="False">
                                            </FilterMenu>
                                        </telerik:RadGrid>
                                    </telerik:RadAjaxPanel>
                                    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanelEmployee" runat="server" Skin="Default" Transparency="20">
                                    </telerik:RadAjaxLoadingPanel>
                                </ItemTemplate>
                                <Items>
                                    <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                </Items>
                            </telerik:RadComboBox>
                        </div>
                    </div>
                    <div class="formCol">
                        <label>As of Date</label>
                        <div class="formRight">
                            <telerik:RadDatePicker ID="dtpdate" runat="server" Culture="en-US" Style="margin: 2px; padding: 1px 0px;" Width="175px">
                                <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x" DayCellToolTipFormat=" MM, dd, yyyy"></Calendar>
                                <DateInput DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%"></DateInput>
                            </telerik:RadDatePicker>
                        </div>
                    </div>
                    <div class="clear"></div>
                </div>
                <div class="formRow">
                    <div class="formCol">
                        <label>Joinging Date</label>
                        <div class="formRight" style="width: 165px !important;">
                            <telerik:RadTextBox ID="txtbxJoingingDate" Enabled="false" runat="server" Width="200px">
                            </telerik:RadTextBox>
                        </div>
                    </div>
                    <div class="clear"></div>
                </div>
                <div class="formRow">
                    <div class="formCol">
                        <label>Calender ID</label>
                        <div class="formRight" style="width: 165px !important;">
                            <telerik:RadTextBox ID="txtbxCalenderID" Enabled="false" runat="server" Width="200px">
                            </telerik:RadTextBox>
                        </div>
                    </div>
                    <div class="clear"></div>
                </div>
                <div class="formRow">
                   
                    <telerik:RadButton ID="btnSearch" ClientIDMode="Static" runat="server" OnClick="btnSearch_Click"
                        Text="Search" >
                    </telerik:RadButton>
                    <div class="clear"></div>
                </div>
                <div class="formRow">
                    <telerik:RadGrid ID="grdLeaves" runat="server" AllowPaging="True" AllowSorting="True"
                        AutoGenerateColumns="False" CellSpacing="0" GridLines="None" 
                        OnNeedDataSource="grdLeaves_NeedDataSource" PageSize="20" 
                         ShowStatusBar="False" 
                        OnItemCommand="grdLeaves_ItemCommand">
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
                        <MasterTableView CommandItemDisplay="Top" AutoGenerateColumns="False" DataKeyNames="OpeningBalance"
                            InsertItemPageIndexAction="ShowItemOnCurrentPage" EditMode="EditForms">
                            <CommandItemTemplate>
                                <tr class="rgCommandRow">
                                    <td colspan="13" class="rgCommandCell">
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
                                                        <%--                                                            <asp:Button ID="Button1" runat="server" CssClass="rgAdd" CommandName="InitInsert" AlteracteText="Add" ToolTip="Add" />--%>
                                                    </td>
                                                    <td align="right">
                                                        <asp:Button runat="server" ID="btnLeaveExportExcel" CssClass="rgExportExcel" ClientIDMode="Static" CommandName="ExportToExcel" AlteracteText="Excel" ToolTip="Excel" />
                                                        <asp:Button runat="server" ID="btnLeaveExportCsv" CssClass="rgExportCsv" ClientIDMode="Static" CommandName="ExportToCsv" AlteracteText="Csv" ToolTip="Csv" />
                                                        <asp:Button runat="server" ID="btnLeaveExportPdf" CssClass="rgExportPdf" ClientIDMode="Static" CommandName="ExportToPdf" AlteracteText="Pdf" ToolTip="Pdf" />
                                                        <telerik:RadComboBox ID="ddlPrintOptions" Style="margin: 0px 5px" runat="server" Width="250px" DropDownWidth="250px">
                                                        </telerik:RadComboBox>
                                                        <asp:Button runat="server" ID="btnLeavePrint" CssClass="rgPrint" ClientIDMode="Static" CommandName="Print" AlteracteText="Print" ToolTip="Print" />
                                                        <asp:Button ID="btnLeaveRefresh" CssClass="rgRefresh" runat="server" CommandName="Rebind" AlteracteText="Refresh" ToolTip="Refresh" />
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
                                <telerik:GridBoundColumn DataField="LeaveType" FilterControlAltText="Filter LeaveType column"
                                    HeaderText="Leave Type" UniqueName="LeaveType">
                                    <ItemStyle />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="LeaveID" FilterControlAltText="Filter LeaveID column"
                                    HeaderText="LeaveID" UniqueName="LeaveID">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="OpeningBalance" FilterControlAltText="Filter OpeningBalance column"
                                    HeaderText="Opening Balance" UniqueName="OpeningBalance">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="BroughtForwards" FilterControlAltText="Filter BroughtForwards column"
                                    HeaderText="Brought Forwards" UniqueName="BroughtForwards">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="Entitlement" FilterControlAltText="Filter Entitlement column"
                                    HeaderText="Entitlement" UniqueName="Entitlement">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="Earned" FilterControlAltText="Filter Earned column"
                                    HeaderText="Earned" UniqueName="Earned">
                                </telerik:GridBoundColumn>
                                 <telerik:GridBoundColumn DataField="EnchasmentDays" FilterControlAltText="Filter EnchasmentDays column"
                                    HeaderText="Enchasment Days" UniqueName="EnchasmentDays">
                                </telerik:GridBoundColumn>
                                 <telerik:GridBoundColumn DataField="AdjustedDays" FilterControlAltText="Filter AdjustedDays column"
                                    HeaderText="Adjusted Days" UniqueName="AdjustedDays">
                                </telerik:GridBoundColumn>
                                 <telerik:GridBoundColumn DataField="LeaveTakenYTD" FilterControlAltText="Filter LeaveTakenYTD column"
                                    HeaderText="Leave Taken YTD" UniqueName="LeaveTakenYTD">
                                </telerik:GridBoundColumn>
                                 <telerik:GridBoundColumn DataField="LeaveTakenLTD" FilterControlAltText="Filter LeaveTakenLTD column"
                                    HeaderText="Leave Taken LTD" UniqueName="LeaveTakenLTD">
                                </telerik:GridBoundColumn>
                                 <telerik:GridBoundColumn DataField="Balance" FilterControlAltText="Filter Balance column"
                                    HeaderText="Balance" UniqueName="Balance">
                                </telerik:GridBoundColumn>
                                 <telerik:GridBoundColumn DataField="UnpostedLeaves" FilterControlAltText="Filter UnpostedLeaves column"
                                    HeaderText="Unposted Leaves" UniqueName="UnpostedLeaves">
                                </telerik:GridBoundColumn>
                                 <telerik:GridBoundColumn DataField="LastLeave" FilterControlAltText="Filter LastLeave column"
                                    HeaderText="Last Leave" UniqueName="LastLeave">
                                </telerik:GridBoundColumn>
                                <%-- <telerik:GridEditCommandColumn FilterControlAltText="Filter EditCommandColumn column"
                                    ButtonType="ImageButton" EditFormHeaderTextFormat="{0}:">
                                    <ItemStyle HorizontalAlign="Center" />
                                </telerik:GridEditCommandColumn>
                                <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" ConfirmText="Are you sure to delete this user?"
                                    ConfirmTextFields="Username" ConfirmTitle="Delete" FilterControlAltText="Filter column6 column"
                                    UniqueName="column6" ConfirmTextFormatString='Are you sure to delete user "{0}"?'>
                                    <ItemStyle HorizontalAlign="Center" />
                                </telerik:GridButtonColumn>--%>
                            </Columns>
                            <EditFormSettings CaptionFormatString='Edit Details for user "{0}":' CaptionDataField="Username">
                                <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                </EditColumn>
                                <EditColumn ButtonType="ImageButton" />
                            </EditFormSettings>
                        </MasterTableView>
                    </telerik:RadGrid>
                </div>
            </telerik:RadAjaxPanel>
            <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" />
        </div>
    </fieldset>
</asp:Content>

