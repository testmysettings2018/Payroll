<%@ Page Language="C#" AutoEventWireup="true" CodeFile="WorkflowChart.aspx.cs" MasterPageFile="~/MasterPages/Main.master" Inherits="Payroll_WorkflowChart" %>

<%@ Register Src="~/Controls/OrgChartDetailsTransactionEntry.ascx" TagPrefix="uc1" TagName="OrgChartDetailsTransactionEntry" %>

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

    <div class="widget">
        <div class="tab_container">
            <div id="tab1" class="tab_content">
                <fieldset>
                    <uc1:OrgChartDetailsTransactionEntry runat="server" ID="OrgChartDetailsTransactionEntry" />
                </fieldset>
            </div>
        </div>
    </div>
</asp:Content>