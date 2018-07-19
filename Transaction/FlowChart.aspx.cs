using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI.Diagram;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using Telerik.Web.UI;
 

public partial class Payroll_FlowChart : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
             
            //Diagram.TransactionEntryID = int.Parse(Request.QueryString["ReimbursmentID"]);
            Diagram.Render("eb_prlreitrx_Status", "ReimbursmentID", int.Parse(Request.QueryString["ReimbursmentID"]), 1024, 500, "Flow Chart for Request ID: " + int.Parse(Request.QueryString["ReimbursmentID"]));
    
        }
    
    }

 
    
}