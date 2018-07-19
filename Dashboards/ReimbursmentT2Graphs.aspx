<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ReimbursmentT2Graphs.aspx.cs" Inherits="Payroll_Dashboards_ReimbursmentT2Graphs" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        table { border-collapse: collapse; }
*, * focus {
	outline: none;
	margin: 0;
	padding: 0;
}
        .auto-style1 {
            width: 500px;
            height: 600px;
            color: buttontext;
            vertical-align: middle;
            border-style: none;
            border-color: inherit;
            border-width: 0;
            margin: 0;
            padding-left: 0px;
            padding-right: 0px;
            padding-top: 0px;
            padding-bottom: 3px;
            background-color: buttonface;
        }
        .auto-style2 {
            vertical-align: middle;
            border-style: none;
            border-color: inherit;
            border-width: 0;
            margin: 0;
            padding-left: 0px;
            padding-right: 0px;
            padding-top: 0px;
            padding-bottom: 3px;
        }
        .auto-style3 {
            font-weight: bold;
            vertical-align: middle;
            border-style: none;
            border-color: inherit;
            border-width: 0;
            margin: 0;
            padding-left: 0px;
            padding-right: 0px;
            padding-top: 0px;
            padding-bottom: 3px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <br />
            <telerik:RadHtmlChart ID="RadHtmlChart1" runat="server" DataSourceID="SqlDataSource1" Height="429px" Width="500px">
                 <PlotArea>
                        <Series>
                            <telerik:BarSeries Name="exptcod" DataFieldY="value">
                                <TooltipsAppearance Color="White" DataFormatString="${0}"></TooltipsAppearance>
                                <LabelsAppearance Visible="false">
                                </LabelsAppearance>
                            </telerik:BarSeries>
                        </Series>
                        <XAxis DataLabelsField="exptcod">
                            <MinorGridLines Visible="false"></MinorGridLines>
                            <MajorGridLines Visible="false"></MajorGridLines>
                        </XAxis>
                        <YAxis>
                            <LabelsAppearance DataFormatString="${0}"></LabelsAppearance>
                            <MinorGridLines Visible="false"></MinorGridLines>
                        </YAxis>
                    </PlotArea>
                    <Legend>
                        <Appearance Visible="false"></Appearance>
                    </Legend>
                <ChartTitle Text="Reimbursments by Category">
                </ChartTitle>
            </telerik:RadHtmlChart>
    
    </div>
    </form>
</body>
</html>
