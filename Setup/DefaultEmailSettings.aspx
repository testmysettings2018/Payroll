<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DefaultEmailSettings.aspx.cs" Inherits="Payroll_Setup_DefaultEmailSettings" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <telerik:RadScriptManager ID="RadScriptManager1" Runat="server">
        </telerik:RadScriptManager>
        <telerik:RadButton ID="RadButton1" runat="server" OnClick="RadButton1_Click" Text="Test Email">
        </telerik:RadButton>
    
    </div>
    </form>
</body>
</html>
