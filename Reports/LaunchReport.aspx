<%@ Page Language="C#" AutoEventWireup="true" CodeFile="LaunchReport.aspx.cs" Inherits="Reports_LaunchReport" %>

<%@ Register Assembly="Telerik.ReportViewer.WebForms, Version=10.2.16.1025, Culture=neutral, PublicKeyToken=a9d7983dfcc261be" Namespace="Telerik.ReportViewer.WebForms" TagPrefix="telerik" %>



<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Report Viewer</title>
    <style type="text/css">   
    html#html, body#body, form#form1, div#content
    { 
        height: 100%;
        width: 100%;
    }
    </style>
</head>
<body  id="body" style="background:white">
    
    <form id="form1" runat="server">              
    <div id="content">


     
        <telerik:ReportViewer ID="ReportViewer1" runat="server" Width=100% Height="100%"></telerik:ReportViewer>


     
    </div>
    </form>
</body>
</html>
