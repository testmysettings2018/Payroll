<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/UserMasterPage.master" AutoEventWireup="true" CodeFile="PayrollSetup.aspx.cs" Inherits="Payroll_PayrollSetup" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ControlContent" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="mainContentPlaceHolder" runat="Server">
    <style type="text/css">
        .radLabelCss_Default {
            display: inline-block;
            width: 50px;
        }
    </style>
    <telerik:RadCodeBlock ID="rcb1" runat="server">

        <script type="text/javascript">


            function KeyPress(sender, args) {
                if (args.get_keyCharacter() == sender.get_numberFormat().DecimalSeparator) {
                    args.set_cancel(true);
                }
            }
            function showSuccess(str, redirect, delay) {
                if (delay) {
                    $('#alertMessage').removeClass('error info warning').addClass('success').html(str).stop(true, true).show().animate({ opacity: 1, right: '10' }, 500, function () {
                        $(this).delay(delay).animate({ opacity: 0, right: '-20' }, 500, function () { $(this).hide(); if (redirect != null) { redirectWindow(redirect); } });
                    });
                    return false;
                }
                $('#alertMessage').addClass('success').html(str).stop(true, true).show().animate({ opacity: 1, right: '10' }, 500);
            }
            function showError(str, redirect, delay) {

                if (delay) {
                    $('#alertMessage').removeClass('success info warning').addClass('error').html(str).stop(true, true).show().animate({ opacity: 1, right: '10' }, 500, function () {
                        $(this).delay(delay).animate({ opacity: 0, right: '-20' }, 500, function () { $(this).hide(); if (redirect != null) { redirectWindow(redirect); } });
                    });
                    return false;
                }
                $('#alertMessage').addClass('error').html(str).stop(true, true).show().animate({ opacity: 1, right: '10' }, 500);
            }

            function OnDftRollDownRowClicked(sender, args) {
                var cellValues = args.getDataKeyValue("Text");
                var id = args.getDataKeyValue("ValueSetID");
                var combo = $find(sender.ClientID.replace('_i0_rGrdDftRollDown4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(id);
                    combo.commitChanges();
                }, 50);
            }

            function OnCountryRowClicked(sender, args) {
                var cellValues = args.getDataKeyValue("ctrcod");
                var id = args.getDataKeyValue("recidd");
                var combo = $find(sender.ClientID.replace('_i0_rGrdCountry4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(id);
                    combo.commitChanges();
                }, 50);
            }
            function OnGraduityRowClicked(sender, args) {
                var cellValues = args.getDataKeyValue("grtcod");
                var id = args.getDataKeyValue("recidd");
                var combo = $find(sender.ClientID.replace('_i0_rGrdGraduity4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(id);
                    combo.commitChanges();
                }, 50);
            }
            function OndftCalenderRowClicked(sender, args) {
                var cellValues = args.getDataKeyValue("calcod");
                var id = args.getDataKeyValue("recidd");
                var combo = $find(sender.ClientID.replace('_i0_rGrddftCalender4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(id);
                    combo.commitChanges();
                }, 50);
            }
            function OndftOvertimeRowClicked(sender, args) {
                var cellValues = args.getDataKeyValue("ovtcod");
                var id = args.getDataKeyValue("recidd");
                var combo = $find(sender.ClientID.replace('_i0_rGrddftOvertime4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(id);
                    combo.commitChanges();
                }, 50);
            }
            function OnTicketBnefitRowClicked(sender, args) {
                var cellValues = args.getDataKeyValue("bftcod");
                var id = args.getDataKeyValue("recidd");
                var combo = $find(sender.ClientID.replace('_i0_rGrdTicketBnefit4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(id);
                    combo.commitChanges();
                }, 50);
            }
            function OnTicketPaycodeRowClicked(sender, args) {
                var cellValues = args.getDataKeyValue("paycod");
                var id = args.getDataKeyValue("recidd");
                var combo = $find(sender.ClientID.replace('_i0_rGrdTicketPaycode4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(id);
                    combo.commitChanges();
                }, 50);
            }
            function OnOvertimePaycodeRowClicked(sender, args) {
                var cellValues = args.getDataKeyValue("paycod");
                var id = args.getDataKeyValue("recidd");
                var combo = $find(sender.ClientID.replace('_i0_rGrdOvertimePaycode4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(id);
                    combo.commitChanges();
                }, 50);
            }
            function OnLeaveEnchasmentRowClicked(sender, args) {
                var cellValues = args.getDataKeyValue("Text");
                var id = args.getDataKeyValue("ValueSetID");
                var combo = $find(sender.ClientID.replace('_i0_rGrdLeaveEnchasment4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(id);
                    combo.commitChanges();
                }, 50);
            }
            function OnEmployeeSalaryCalculationRowClicked(sender, args) {
                var cellValues = args.getDataKeyValue("Text");
                var id = args.getDataKeyValue("ValueSetID");
                var combo = $find(sender.ClientID.replace('_i0_rEmployeeSalaryCalculation4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(id);
                    combo.commitChanges();
                }, 50);
            }
            function OnOvertimeDataEntryRowClicked(sender, args) {
                var cellValues = args.getDataKeyValue("Text");
                var id = args.getDataKeyValue("ValueSetID");
                var combo = $find(sender.ClientID.replace('_i0_rOvertimeDataEntry4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(id);
                    combo.commitChanges();
                }, 50);
            }

            function OnDefaultPayrollTypeRowClicked(sender, args) {
                var cellValues = args.getDataKeyValue("Text");
                var id = args.getDataKeyValue("ValueSetID");
                var combo = $find(sender.ClientID.replace('_i0_rGrdDefaultPayrollTypeon4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(id);
                    combo.commitChanges();
                }, 50);
            }

            function ValidateSupervisor(ddlCountry, txtDescriptionId, ddlCountry) {
                var str = '';
                if ($('#ctl00_ctl00_MainContent_mainContentPlaceHolder_ddlCountry').val() == undefined ||
                    $('#ctl00_ctl00_MainContent_mainContentPlaceHolder_ddlCountry').val() == "") {
                    str = 'Country Required.<br/>';
                }
                if ($('#ctl00_ctl00_MainContent_mainContentPlaceHolder_ddlDefaultPayrollTypeon').val() == undefined ||
                    $('#ctl00_ctl00_MainContent_mainContentPlaceHolder_ddlDefaultPayrollTypeon').val() == "") {
                    str += 'Default Payroll Type Required.<br/>';
                }
                if ($('#ctl00_ctl00_MainContent_mainContentPlaceHolder_ddlLeaveEnchasment').val() == undefined ||
                    $('#ctl00_ctl00_MainContent_mainContentPlaceHolder_ddlLeaveEnchasment').val() == "") {
                    str += 'Leave Enchasment Required.<br/>';
                }
                if ($('#ctl00_ctl00_MainContent_mainContentPlaceHolder_ddlEmployeeSalaryCalculation').val() == undefined ||
                    $('#ctl00_ctl00_MainContent_mainContentPlaceHolder_ddlEmployeeSalaryCalculation').val() == "") {
                    str += 'Employee Salary Calculation Required.<br/>';
                }
                if ($('#ctl00_ctl00_MainContent_mainContentPlaceHolder_dllDftRollDown').val() == undefined ||
                    $('#ctl00_ctl00_MainContent_mainContentPlaceHolder_dllDftRollDown').val() == "") {
                    str += 'Default Rolldown Settings Required.<br/>';
                }
                if ($('#ctl00_ctl00_MainContent_mainContentPlaceHolder_txtbxPayrollCuttoffDay').val() == undefined ||
                  $('#ctl00_ctl00_MainContent_mainContentPlaceHolder_txtbxPayrollCuttoffDay').val() == "") {
                    str += 'Payroll Cutoff Day Required.<br/>';
                }
                if ($('#ctl00_ctl00_MainContent_mainContentPlaceHolder_txtOvertimeCuttoffDay').val() == undefined ||
                  $('#ctl00_ctl00_MainContent_mainContentPlaceHolder_txtOvertimeCuttoffDay').val() == "") {
                    str += 'Overtime Cutoff Day Required.<br/>';
                }
                if ($('#ctl00_ctl00_MainContent_mainContentPlaceHolder_ddlOvertimeDataEntry').val() == undefined ||
                  $('#ctl00_ctl00_MainContent_mainContentPlaceHolder_ddlOvertimeDataEntry').val() == "") {
                    str += 'Overtime Data Entry Required.<br/>';
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
            <div class="title">
                <img src="../../images/icons/dark/list.png" alt="" class="titleIcon" />
                <h6>Payroll Setup</h6>
                <div style="float: right; padding: 5px 0px; margin-right: 10px;">
                    <div style="float: right; margin-top: 0px; margin-right: 10px;">
                       

                        <asp:ImageButton ID="rbutUpdate" runat="server"  ClientIDMode="Static"  ImageUrl="../../Images/save.gif" ToolTip="Update Settings." CausesValidation="true"  OnClientClick="ValidateSupervisor()" OnClick="rbutUpdate_Click"  />
                    </div>
                    <div style="float: right; padding-top: 10px; margin-right: 10px;">
                        <asp:Button runat="server" ID="btnPayrollPrint" CssClass="rgPrint" Style="margin-top: -5px" CausesValidation="false" ClientIDMode="Static" CommandName="Print" AlternateText="Print" ToolTip="Print" OnClick="btnNationalityPrint_Click" />
                    </div>
                    <div style="float: right; margin-top: 0px; margin-right: 10px;">
                        <telerik:RadComboBox ID="ddlPrintOptions" runat="server" Width="250px" DropDownWidth="250px">
                        </telerik:RadComboBox>
                    </div>
                </div>
            </div>
            <div class="formRow">
                <div class="formCol">
                    <label>
                        Country    
                    </label>
                    <div class="formRight">
                        <div style="float: left">
                            <telerik:RadComboBox ID="ddlCountry" runat="server"
                                Width="255px" Height="200px" DropDownWidth="410px"
                                EmptyMessage="Please select...">
                                <ItemTemplate>
                                    <telerik:RadAjaxPanel ID="RadAjaxPanel4" runat="server" Width="410px" LoadingPanelID="RadAjaxLoadingPanelCountry" Height="200px">
                                        <telerik:RadGrid ID="rGrdCountry4DDL" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                            CellSpacing="0" GridLines="None" OnNeedDataSource="rGrdCountry4DDL_NeedDataSource"
                                            Width="410px" ClientSettings-EnableRowHoverStyle="True">
                                            <ClientSettings>
                                                <Selecting AllowRowSelect="true"></Selecting>
                                            </ClientSettings>
                                            <MasterTableView DataKeyNames="recidd, ctrcod,ctrnam" ClientDataKeyNames="recidd, ctrcod,ctrnam">
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
                                                    <telerik:GridBoundColumn DataField="ctrcod" FilterControlAltText="Filter column2 column"
                                                        HeaderText="Code" UniqueName="column2">
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn DataField="ctrnam" FilterControlAltText="Filter column3 column"
                                                        HeaderText="Name" UniqueName="column3">
                                                    </telerik:GridBoundColumn>
                                                </Columns>
                                                <EditFormSettings>
                                                    <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                                    </EditColumn>
                                                </EditFormSettings>
                                            </MasterTableView>
                                            <ClientSettings>
                                                <ClientEvents OnRowClick="OnCountryRowClicked"></ClientEvents>
                                            </ClientSettings>
                                            <FilterMenu EnableImageSprites="False">
                                            </FilterMenu>
                                        </telerik:RadGrid>
                                    </telerik:RadAjaxPanel>
                                    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanelCountry" runat="server" Skin="Default" Transparency="20">
                                    </telerik:RadAjaxLoadingPanel>
                                </ItemTemplate>
                                <Items>
                                    <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                </Items>
                            </telerik:RadComboBox>
                        </div>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                            ControlToValidate="ddlCountry"></asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="formCol">
                    <label>
                        Payroll Cuttoff Day
                    </label>
                    <div class="formRight" style="width: 65px !important;">
                        <div style="float: left">
                            <telerik:RadNumericTextBox
                                MinValue="0" Width="50px"
                                MaxValue="999999999"
                                ID="txtbxPayrollCuttoffDay" MaxLength="8"
                                runat="server">
                                <NumberFormat GroupSeparator="" DecimalDigits="0" AllowRounding="true" KeepNotRoundedValue="false" />
                                <ClientEvents OnKeyPress="KeyPress" />
                            </telerik:RadNumericTextBox>
                        </div>
                    </div>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator100" Style="margin-left: -17px" runat="server" ErrorMessage="*" ForeColor="Red"
                        ControlToValidate="txtbxPayrollCuttoffDay"></asp:RequiredFieldValidator>
                </div>
                <div class="clear"></div>
            </div>
            <div class="formRow">
                <div class="formCol">
                    <label>
                        Default Payroll Type
                    </label>
                    <div class="formRight">
                        <div style="float: left">
                            <telerik:RadComboBox ID="ddlDefaultPayrollTypeon" runat="server"
                                Width="250px" Height="200px" DropDownWidth="410px"
                                EmptyMessage="Please select...">
                                <ItemTemplate>
                                    <telerik:RadAjaxPanel ID="RadAjaxPanelDefaultPayrollType" runat="server" Width="410px" LoadingPanelID="RadAjaxLoadingPanelDefaultPayrollType" Height="200px">
                                        <telerik:RadGrid ID="rGrdDefaultPayrollTypeon4DDL" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                            CellSpacing="0" GridLines="None" OnNeedDataSource="rGrdDefaultPayrollTypeon4DDL_NeedDataSource"
                                            Width="410px" ClientSettings-EnableRowHoverStyle="True">
                                            <ClientSettings>
                                                <Selecting AllowRowSelect="true"></Selecting>
                                            </ClientSettings>
                                            <MasterTableView DataKeyNames="ValueSetID,Text,Value" ClientDataKeyNames="ValueSetID,Text,Value">
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
                                                <ClientEvents OnRowClick="OnDefaultPayrollTypeRowClicked"></ClientEvents>
                                            </ClientSettings>
                                            <FilterMenu EnableImageSprites="False">
                                            </FilterMenu>
                                        </telerik:RadGrid>
                                    </telerik:RadAjaxPanel>
                                    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanelDefaultPayrollType" runat="server" Skin="Default" Transparency="20">
                                    </telerik:RadAjaxLoadingPanel>
                                </ItemTemplate>
                                <Items>
                                    <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                </Items>
                            </telerik:RadComboBox>
                        </div>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator51" runat="server" Style="padding-left: 5px" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                            ControlToValidate="ddlDefaultPayrollTypeon"></asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="formCol">
                    <label>
                        Overtime Cuttoff Day
                    </label>
                    <div class="formRight" style="width: 65px !important;">
                        <div style="float: left">
                            <telerik:RadNumericTextBox
                                MinValue="0" Width="50px"
                                MaxValue="999999999"
                                ID="txtOvertimeCuttoffDay" MaxLength="8"
                                runat="server">
                                <NumberFormat GroupSeparator="" DecimalDigits="0" AllowRounding="true" KeepNotRoundedValue="false" />
                                <ClientEvents OnKeyPress="KeyPress" />
                            </telerik:RadNumericTextBox>
                        </div>
                    </div>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator101" Style="margin-left: -17px" runat="server" ErrorMessage="*" ForeColor="Red"
                        ControlToValidate="txtOvertimeCuttoffDay"></asp:RequiredFieldValidator>
                </div>
                <div class="clear"></div>
            </div>
            <div class="formRow">
                <div class="formCol">
                    <label>
                        Leave Enchasment
                    </label>
                    <div class="formRight ">
                        <div style="float: left">
                            <telerik:RadComboBox ID="ddlLeaveEnchasment" runat="server"
                                Width="250px" Height="200px" DropDownWidth="410px"
                                EmptyMessage="Please select...">
                                <ItemTemplate>
                                    <telerik:RadAjaxPanel ID="RadAjaxPanelLeaveEnchasment" runat="server" Width="410px" LoadingPanelID="RadAjaxLoadingPanelLeaveEnchasment" Height="200px">
                                        <telerik:RadGrid ID="rGrdLeaveEnchasment4DDL" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                            CellSpacing="0" GridLines="None" OnNeedDataSource="rGrdLeaveEnchasment4DDL_NeedDataSource"
                                            Width="410px" ClientSettings-EnableRowHoverStyle="True">
                                            <ClientSettings>
                                                <Selecting AllowRowSelect="true"></Selecting>
                                            </ClientSettings>
                                            <MasterTableView DataKeyNames="ValueSetID,Text,Value" ClientDataKeyNames="ValueSetID,Text,Value">
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
                                                <ClientEvents OnRowClick="OnLeaveEnchasmentRowClicked"></ClientEvents>
                                            </ClientSettings>
                                            <FilterMenu EnableImageSprites="False">
                                            </FilterMenu>
                                        </telerik:RadGrid>
                                    </telerik:RadAjaxPanel>
                                    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanelDefaultPayrollType" runat="server" Skin="Default" Transparency="20">
                                    </telerik:RadAjaxLoadingPanel>
                                </ItemTemplate>
                                <Items>
                                    <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                </Items>
                            </telerik:RadComboBox>
                        </div>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" Style="padding-left: 5px" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                            ControlToValidate="ddlLeaveEnchasment"></asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="formCol">
                    <label>
                        Overtime Data Entry
                    </label>
                    <div class="formRight ">
                        <div style="float: left">
                            <telerik:RadComboBox ID="ddlOvertimeDataEntry" runat="server"
                                Width="250px" Height="200px" DropDownWidth="410px"
                                EmptyMessage="Please select...">
                                <ItemTemplate>
                                    <telerik:RadAjaxPanel ID="RadAjaxPanelDftRollDown" runat="server" Width="410px" LoadingPanelID="RadAjaxLoadingPanelDftRollDown" Height="200px">
                                        <telerik:RadGrid ID="rOvertimeDataEntry4DDL" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                            CellSpacing="0" GridLines="None" OnNeedDataSource="rOvertimeDataEntry4DDL_NeedDataSource"
                                            Width="410px" ClientSettings-EnableRowHoverStyle="True">
                                            <ClientSettings>
                                                <Selecting AllowRowSelect="true"></Selecting>
                                            </ClientSettings>
                                            <MasterTableView DataKeyNames="ValueSetID,Text,Value" ClientDataKeyNames="ValueSetID,Text,Value">
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
                                                <ClientEvents OnRowClick="OnOvertimeDataEntryRowClicked"></ClientEvents>
                                            </ClientSettings>
                                            <FilterMenu EnableImageSprites="False">
                                            </FilterMenu>
                                        </telerik:RadGrid>
                                    </telerik:RadAjaxPanel>
                                    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanelDefaultPayrollType" runat="server" Skin="Default" Transparency="20">
                                    </telerik:RadAjaxLoadingPanel>
                                </ItemTemplate>
                                <Items>
                                    <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                </Items>
                            </telerik:RadComboBox>
                        </div>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" Style="padding-left: 5px" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                            ControlToValidate="ddlOvertimeDataEntry"></asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="clear"></div>
            </div>
            <div class="formRow">
                <div class="formCol">
                    <label>
                        Employee Salary Calculation
                    </label>
                    <div class="formRight ">
                        <div style="float: left">
                            <telerik:RadComboBox ID="ddlEmployeeSalaryCalculation" runat="server"
                                Width="250px" Height="200px" DropDownWidth="410px"
                                EmptyMessage="Please select...">
                                <ItemTemplate>
                                    <telerik:RadAjaxPanel ID="RadAjaxPanelLeaveEnchasment" runat="server" Width="410px" LoadingPanelID="RadAjaxLoadingPanelLeaveEnchasment" Height="200px">
                                        <telerik:RadGrid ID="rEmployeeSalaryCalculation4DDL" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                            CellSpacing="0" GridLines="None" OnNeedDataSource="rEmployeeSalaryCalculation4DDL_NeedDataSource"
                                            Width="410px" ClientSettings-EnableRowHoverStyle="True">
                                            <ClientSettings>
                                                <Selecting AllowRowSelect="true"></Selecting>
                                            </ClientSettings>
                                            <MasterTableView DataKeyNames="ValueSetID,Text,Value" ClientDataKeyNames="ValueSetID,Text,Value">
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
                                                <ClientEvents OnRowClick="OnEmployeeSalaryCalculationRowClicked"></ClientEvents>
                                            </ClientSettings>
                                            <FilterMenu EnableImageSprites="False">
                                            </FilterMenu>
                                        </telerik:RadGrid>
                                    </telerik:RadAjaxPanel>
                                    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanelDefaultPayrollType" runat="server" Skin="Default" Transparency="20">
                                    </telerik:RadAjaxLoadingPanel>
                                </ItemTemplate>
                                <Items>
                                    <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                </Items>
                            </telerik:RadComboBox>
                        </div>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" Style="padding-left: 5px" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                            ControlToValidate="ddlEmployeeSalaryCalculation"></asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="formCol">
                    <label>
                        Overtime Paycode
                    </label>
                    <div class="formRight ">
                        <div style="float: left">
                            <telerik:RadComboBox ID="ddlOvertimePaycode" runat="server"
                                Width="255px" Height="200px" DropDownWidth="410px"
                                EmptyMessage="Please select...">
                                <ItemTemplate>
                                    <telerik:RadAjaxPanel ID="RadAjaxPanel4" runat="server" Width="410px" LoadingPanelID="RadAjaxLoadingPanelOvertimePaycode" Height="200px">
                                        <telerik:RadGrid ID="rGrdOvertimePaycode4DDL" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                            CellSpacing="0" GridLines="None" OnNeedDataSource="rGrdOvertimePaycode4DDL_NeedDataSource"
                                            Width="410px" ClientSettings-EnableRowHoverStyle="True">
                                            <ClientSettings>
                                                <Selecting AllowRowSelect="true"></Selecting>
                                            </ClientSettings>
                                            <MasterTableView DataKeyNames="recidd, paycod,payds1" ClientDataKeyNames="recidd, paycod,payds1">
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
                                                    <telerik:GridBoundColumn DataField="paycod" FilterControlAltText="Filter column2 column"
                                                        HeaderText="Code" UniqueName="column2">
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn DataField="payds1" FilterControlAltText="Filter column3 column"
                                                        HeaderText="Description" UniqueName="column3">
                                                    </telerik:GridBoundColumn>
                                                </Columns>
                                                <EditFormSettings>
                                                    <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                                    </EditColumn>
                                                </EditFormSettings>
                                            </MasterTableView>
                                            <ClientSettings>
                                                <ClientEvents OnRowClick="OnOvertimePaycodeRowClicked"></ClientEvents>
                                            </ClientSettings>
                                            <FilterMenu EnableImageSprites="False">
                                            </FilterMenu>
                                        </telerik:RadGrid>
                                    </telerik:RadAjaxPanel>
                                    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanelOvertimePaycode" runat="server" Skin="Default" Transparency="20">
                                    </telerik:RadAjaxLoadingPanel>
                                </ItemTemplate>
                                <Items>
                                    <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                </Items>
                            </telerik:RadComboBox>
                        </div>
                    </div>
                </div>
                <div class="clear"></div>
            </div>
            <div class="formRow">
                <div class="formCol">
                    <label>
                        Default Graduity ID
                    </label>
                    <div class="formRight ">
                        <div style="float: left">
                            <telerik:RadComboBox ID="ddlGraduity" runat="server"
                                Width="255px" Height="200px" DropDownWidth="410px"
                                EmptyMessage="Please select...">
                                <ItemTemplate>
                                    <telerik:RadAjaxPanel ID="RadAjaxPanel4" runat="server" Width="410px" LoadingPanelID="RadAjaxLoadingPanelGraduity" Height="200px">
                                        <telerik:RadGrid ID="rGrdGraduity4DDL" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                            CellSpacing="0" GridLines="None" OnNeedDataSource="rGrdGraduity4DDL_NeedDataSource"
                                            Width="410px" ClientSettings-EnableRowHoverStyle="True">
                                            <ClientSettings>
                                                <Selecting AllowRowSelect="true"></Selecting>
                                            </ClientSettings>
                                            <MasterTableView DataKeyNames="recidd, grtcod,grtdsc" ClientDataKeyNames="recidd, grtcod,grtdsc">
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
                                                <ClientEvents OnRowClick="OnGraduityRowClicked"></ClientEvents>
                                            </ClientSettings>
                                            <FilterMenu EnableImageSprites="False">
                                            </FilterMenu>
                                        </telerik:RadGrid>
                                    </telerik:RadAjaxPanel>
                                    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanelGraduity" runat="server" Skin="Default" Transparency="20">
                                    </telerik:RadAjaxLoadingPanel>
                                </ItemTemplate>
                                <Items>
                                    <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                </Items>
                            </telerik:RadComboBox>
                        </div>

                    </div>
                </div>
                <div class="formCol">
                    <label>
                        Ticket Benefit ID
                    </label>
                    <div class="formRight ">
                        <div style="float: left">
                            <telerik:RadComboBox ID="ddlTicketBnefit" runat="server"
                                Width="255px" Height="200px" DropDownWidth="410px"
                                EmptyMessage="Please select...">
                                <ItemTemplate>
                                    <telerik:RadAjaxPanel ID="RadAjaxPanel4" runat="server" Width="410px" LoadingPanelID="RadAjaxLoadingPanelTicketBnefit" Height="200px">
                                        <telerik:RadGrid ID="rGrdTicketBnefit4DDL" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                            CellSpacing="0" GridLines="None" OnNeedDataSource="rGrdTicketBnefit4DDL_NeedDataSource"
                                            Width="410px" ClientSettings-EnableRowHoverStyle="True">
                                            <ClientSettings>
                                                <Selecting AllowRowSelect="true"></Selecting>
                                            </ClientSettings>
                                            <MasterTableView DataKeyNames="recidd, bftcod,bftds1" ClientDataKeyNames="recidd, bftcod,bftds1">
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
                                                    <telerik:GridBoundColumn DataField="bftcod" FilterControlAltText="Filter column2 column"
                                                        HeaderText="Code" UniqueName="column2">
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn DataField="bftds1" FilterControlAltText="Filter column3 column"
                                                        HeaderText="Description" UniqueName="column3">
                                                    </telerik:GridBoundColumn>
                                                </Columns>
                                                <EditFormSettings>
                                                    <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                                    </EditColumn>
                                                </EditFormSettings>
                                            </MasterTableView>
                                            <ClientSettings>
                                                <ClientEvents OnRowClick="OnTicketBnefitRowClicked"></ClientEvents>
                                            </ClientSettings>
                                            <FilterMenu EnableImageSprites="False">
                                            </FilterMenu>
                                        </telerik:RadGrid>
                                    </telerik:RadAjaxPanel>
                                    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanelTicketBnefit" runat="server" Skin="Default" Transparency="20">
                                    </telerik:RadAjaxLoadingPanel>
                                </ItemTemplate>
                                <Items>
                                    <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                </Items>
                            </telerik:RadComboBox>
                        </div>
                    </div>
                </div>
                <div class="clear"></div>
            </div>
            <div class="formRow">
                <div class="formCol">
                    <label>
                        Default Overtime ID
                    </label>
                    <div class="formRight ">
                        <div style="float: left">
                            <telerik:RadComboBox ID="ddldftOvertime" runat="server"
                                Width="255px" Height="200px" DropDownWidth="410px"
                                EmptyMessage="Please select...">
                                <ItemTemplate>
                                    <telerik:RadAjaxPanel ID="RadAjaxPanel4" runat="server" Width="410px" LoadingPanelID="RadAjaxLoadingPaneldftOvertime" Height="200px">
                                        <telerik:RadGrid ID="rGrddftOvertime4DDL" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                            CellSpacing="0" GridLines="None" OnNeedDataSource="rGrddftOvertime4DDL_NeedDataSource"
                                            Width="410px" ClientSettings-EnableRowHoverStyle="True">
                                            <ClientSettings>
                                                <Selecting AllowRowSelect="true"></Selecting>
                                            </ClientSettings>
                                            <MasterTableView DataKeyNames="recidd, ovtcod,ovtdsc" ClientDataKeyNames="recidd, ovtcod,ovtdsc">
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
                                                <ClientEvents OnRowClick="OndftOvertimeRowClicked"></ClientEvents>
                                            </ClientSettings>
                                            <FilterMenu EnableImageSprites="False">
                                            </FilterMenu>
                                        </telerik:RadGrid>
                                    </telerik:RadAjaxPanel>
                                    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPaneldftOvertime" runat="server" Skin="Default" Transparency="20">
                                    </telerik:RadAjaxLoadingPanel>
                                </ItemTemplate>
                                <Items>
                                    <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                </Items>
                            </telerik:RadComboBox>
                        </div>
                    </div>
                </div>
                <div class="formCol">
                    <label>
                        Ticket Paycode
                    </label>
                    <div class="formRight ">
                        <div style="float: left">
                            <telerik:RadComboBox ID="ddlTicketPaycode" runat="server"
                                Width="255px" Height="200px" DropDownWidth="410px"
                                EmptyMessage="Please select...">
                                <ItemTemplate>
                                    <telerik:RadAjaxPanel ID="RadAjaxPanel4" runat="server" Width="410px" LoadingPanelID="RadAjaxLoadingPanelTicketPaycode" Height="200px">
                                        <telerik:RadGrid ID="rGrdTicketPaycode4DDL" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                            CellSpacing="0" GridLines="None" OnNeedDataSource="rGrdTicketPaycode4DDL_NeedDataSource"
                                            Width="410px" ClientSettings-EnableRowHoverStyle="True">
                                            <ClientSettings>
                                                <Selecting AllowRowSelect="true"></Selecting>
                                            </ClientSettings>
                                            <MasterTableView DataKeyNames="recidd, paycod,payds1" ClientDataKeyNames="recidd, paycod,payds1">
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
                                                    <telerik:GridBoundColumn DataField="paycod" FilterControlAltText="Filter column2 column"
                                                        HeaderText="Code" UniqueName="column2">
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn DataField="payds1" FilterControlAltText="Filter column3 column"
                                                        HeaderText="Description" UniqueName="column3">
                                                    </telerik:GridBoundColumn>
                                                </Columns>
                                                <EditFormSettings>
                                                    <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                                    </EditColumn>
                                                </EditFormSettings>
                                            </MasterTableView>
                                            <ClientSettings>
                                                <ClientEvents OnRowClick="OnTicketPaycodeRowClicked"></ClientEvents>
                                            </ClientSettings>
                                            <FilterMenu EnableImageSprites="False">
                                            </FilterMenu>
                                        </telerik:RadGrid>
                                    </telerik:RadAjaxPanel>
                                    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanelTicketPaycode" runat="server" Skin="Default" Transparency="20">
                                    </telerik:RadAjaxLoadingPanel>
                                </ItemTemplate>
                                <Items>
                                    <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                </Items>
                            </telerik:RadComboBox>
                        </div>
                    </div>
                </div>
                <div class="clear"></div>
            </div>
            <div class="formRow">
                <div class="formCol">
                    <label>
                        Default Calender ID
                    </label>
                    <div class="formRight ">
                        <div style="float: left">
                            <telerik:RadComboBox ID="ddldftCalender" runat="server"
                                Width="255px" Height="200px" DropDownWidth="410px"
                                EmptyMessage="Please select...">
                                <ItemTemplate>
                                    <telerik:RadAjaxPanel ID="RadAjaxPanel4" runat="server" Width="410px" LoadingPanelID="RadAjaxLoadingPaneldftCalender" Height="200px">
                                        <telerik:RadGrid ID="rGrddftCalender4DDL" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                            CellSpacing="0" GridLines="None" OnNeedDataSource="rGrddftCalender4DDL_NeedDataSource"
                                            Width="410px" ClientSettings-EnableRowHoverStyle="True">
                                            <ClientSettings>
                                                <Selecting AllowRowSelect="true"></Selecting>
                                            </ClientSettings>
                                            <MasterTableView DataKeyNames="recidd, calcod,caldsc" ClientDataKeyNames="recidd, calcod,caldsc">
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
                                                        HeaderText="Code" UniqueName="column2">
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn DataField="caldsc" FilterControlAltText="Filter column3 column"
                                                        HeaderText="Description" UniqueName="column3">
                                                    </telerik:GridBoundColumn>
                                                </Columns>
                                                <EditFormSettings>
                                                    <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                                    </EditColumn>
                                                </EditFormSettings>
                                            </MasterTableView>
                                            <ClientSettings>
                                                <ClientEvents OnRowClick="OndftCalenderRowClicked"></ClientEvents>
                                            </ClientSettings>
                                            <FilterMenu EnableImageSprites="False">
                                            </FilterMenu>
                                        </telerik:RadGrid>
                                    </telerik:RadAjaxPanel>
                                    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPaneldftCalender" runat="server" Skin="Default" Transparency="20">
                                    </telerik:RadAjaxLoadingPanel>
                                </ItemTemplate>
                                <Items>
                                    <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                </Items>
                            </telerik:RadComboBox>
                        </div>
                    </div>
                </div>
                <div class="formCol">
                    <div class="formCol">
                        <label>
                            Ticket Up to Age
                        </label>
                        <div class="formRight " style="width: 25%">
                            <div style="float: left">
                                <telerik:RadNumericTextBox
                                    MinValue="0" Width="50px"
                                    MaxValue="999999999"
                                    ID="txtbxUptoAge" MaxLength="8"
                                    runat="server">
                                    <NumberFormat GroupSeparator="" DecimalDigits="0" AllowRounding="true" KeepNotRoundedValue="false" />
                                    <ClientEvents OnKeyPress="KeyPress" />
                                </telerik:RadNumericTextBox>
                            </div>
                        </div>
                    </div>
                    <div class="formCol">
                        <label>
                            Child Age
                        </label>
                        <div class="formRight " style="width: 25%">
                            <div style="float: left">
                                <telerik:RadNumericTextBox
                                    MinValue="0" Width="50px"
                                    MaxValue="999999999"
                                    ID="txtbxChildAge" MaxLength="8"
                                    runat="server">
                                    <NumberFormat GroupSeparator="" DecimalDigits="0" AllowRounding="true" KeepNotRoundedValue="false" />
                                    <ClientEvents OnKeyPress="KeyPress" />
                                </telerik:RadNumericTextBox>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="clear"></div>
            </div>
            <div class="formRow">
                <div class="formCol">
                    <label>
                        Default Rolldown Setting
                    </label>
                    <div class="formRight ">
                        <div style="float: left">
                            <telerik:RadComboBox ID="dllDftRollDown" runat="server"
                                Width="250px" Height="200px" DropDownWidth="410px"
                                EmptyMessage="Please select...">
                                <ItemTemplate>
                                    <telerik:RadAjaxPanel ID="RadAjaxPanelLeaveEnchasment" runat="server" Width="410px" LoadingPanelID="RadAjaxLoadingPanelDftRollDown" Height="200px">
                                        <telerik:RadGrid ID="rGrdDftRollDown4DDL" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                            CellSpacing="0" GridLines="None" OnNeedDataSource="rGrdDftRollDown4DDL_NeedDataSource"
                                            Width="410px" ClientSettings-EnableRowHoverStyle="True">
                                            <ClientSettings>
                                                <Selecting AllowRowSelect="true"></Selecting>
                                            </ClientSettings>
                                            <MasterTableView DataKeyNames="ValueSetID,Text,Value" ClientDataKeyNames="ValueSetID,Text,Value">
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
                                                <ClientEvents OnRowClick="OnDftRollDownRowClicked"></ClientEvents>
                                            </ClientSettings>
                                            <FilterMenu EnableImageSprites="False">
                                            </FilterMenu>
                                        </telerik:RadGrid>
                                    </telerik:RadAjaxPanel>
                                    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanelDefaultPayrollType" runat="server" Skin="Default" Transparency="20">
                                    </telerik:RadAjaxLoadingPanel>
                                </ItemTemplate>
                                <Items>
                                    <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                </Items>
                            </telerik:RadComboBox>
                        </div>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" Style="padding-left: 5px" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                            ControlToValidate="dllDftRollDown"></asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="formCol">
                    <div class="formCol">
                        <label>
                            Infant Age
                        </label>
                        <div class="formRight " style="width: 25%">
                            <div style="float: left">
                                <telerik:RadNumericTextBox
                                    MinValue="0" Width="50px"
                                    MaxValue="999999999"
                                    ID="txtbxInfantAge" MaxLength="8"
                                    runat="server">
                                    <NumberFormat GroupSeparator="" DecimalDigits="0" AllowRounding="true" KeepNotRoundedValue="false" />
                                    <ClientEvents OnKeyPress="KeyPress" />
                                </telerik:RadNumericTextBox>
                            </div>
                        </div>
                    </div>
                    <div class="formCol">
                        <label>
                            Max Children
                        </label>
                        <div class="formRight " style="width: 25%">
                            <div style="float: left">
                                <telerik:RadNumericTextBox
                                    MinValue="0" Width="50px"
                                    MaxValue="999999999"
                                    ID="txtbxMaxChildren" MaxLength="8"
                                    runat="server">
                                    <NumberFormat GroupSeparator="" DecimalDigits="0" AllowRounding="true" KeepNotRoundedValue="false" />
                                    <ClientEvents OnKeyPress="KeyPress" />
                                </telerik:RadNumericTextBox>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="clear"></div>
            </div>
            <div class="formRow">
                <div class="formCol">
                    <div class="formRight ">
                        <asp:CheckBox ID="chkbxAutoAssignEmployeeId" Text="Auto Assign Employee Id" runat="server" />
                    </div>
                </div>
                <div class="formCol">
                    <div class="formRight ">
                        <asp:CheckBox ID="chkbxAllowAdvanceLeave" Text="Auto Calc Ticket Accual" runat="server" />
                    </div>
                </div>
                <div class="clear"></div>
            </div>
        </div>
    </fieldset>
</asp:Content>
