<%@ Page Language="C#" AutoEventWireup="true" CodeFile="FlowChart.aspx.cs" MasterPageFile="~/MasterPages/Main.master" Inherits="Payroll_FlowChart" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="~/Controls/Diagram.ascx" TagPrefix="uc1" TagName="Diagram" %>


<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">

    <table>
         
        <tr>
        <div>
            <uc1:Diagram
                runat = "server"
                ID = "Diagram"/>

        </div>
            </tr>
    </table>


</asp:Content>