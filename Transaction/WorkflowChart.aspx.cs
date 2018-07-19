using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Payroll_WorkflowChart : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            OrgChartDetailsTransactionEntry.TransactionEntryID = int.Parse(Request.QueryString["TransactionEntryID"]);
        }
    }
}