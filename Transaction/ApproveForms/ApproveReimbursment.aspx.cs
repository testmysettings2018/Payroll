using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections;
using System.Data;
using Telerik.Web.UI;
using System.IO;
using System.Configuration;
using System.Data.SqlClient;

public partial class ApproveReimbursment : BasePage
{
    public static Hashtable htSearchParams = null;
    public bool exporting = false;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            MasterPage.BodyClass = "class='nobg'";
            if (!string.IsNullOrEmpty(Request.QueryString["RequestID"]))
            {
                bindCombos();
                bindRecord();
                bindAttach();
            }
        }
    }

    protected void Page_Init(object sender, EventArgs e)
    {
        // FormName = "RequisitionForm";
        base.Page_Init(sender, e);
    }

    private void bindCombos()
    {
        if (null != Session["_UserID"] && !string.IsNullOrEmpty(Request.QueryString["FormType"]))
        {
            RadGrid grid;

            #region Fill Reimbursment

            rCmbReimbursment.ClearSelection();
            grid = rCmbReimbursment.Items[0].FindControl("rGrdReimbursments4DDL") as RadGrid;
            grid.DataSource = clsDAL.GetDataSet("sp_Payroll_Get_All_Batches").Tables[0];
            grid.Rebind();

            #endregion Fill Reimbursment

            #region Fill Employees

            rCmbEmployee.ClearSelection();

            Hashtable ht = new Hashtable();
            ht.Add("@UserID", Session["_UserID"].ToString());
            ht.Add("@FormTypeID", Request.QueryString["FormType"]);

            grid = rCmbEmployee.Items[0].FindControl("rGrdEmployees4DDL") as RadGrid;
            grid.DataSource = clsDAL.GetDataSet_admin("sp_User_Get_Employees_By_UserID_4_DDL", ht).Tables[0];
            grid.Rebind();

            rCmbEmployee_SelectedIndexChanged(null, null);

            #endregion Fill Employees

            #region Fill users and level
            
            rCmbLevels.ClearSelection();
            Hashtable ht_transactionentryid = new Hashtable();
            ht_transactionentryid.Add("@ReimbursmentID", Request.QueryString["RequestID"]);
            grid = rCmbLevels.Items[0].FindControl("rGrdLevels4DDL") as RadGrid;
            grid.DataSource = clsDAL.GetDataSet("sp_Get_Revise_Users_Of_Reimbursment", ht_transactionentryid).Tables[0];
            grid.Rebind();

            #endregion Fill Batch
        }
    }

    protected void rCmbEmployee_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
    {
        if (rCmbEmployee.Items[0].Value != null)
        {
            ucEmployeeCard.LoadEmployeeCard(rCmbEmployee.Items[0].Value);
        }
    }

    protected void bindRecord()
    {
        try
        {
            Hashtable ht = new Hashtable();
            ht.Add("@ReimbursmentID", Request.QueryString["RequestID"]);
            DataTable dt = clsDAL.GetDataSet("sp_User_Get_Reimbursment_ByID", ht).Tables[0];

            if (dt != null && dt.Rows.Count > 0)
            {

                this.SetEmployee(Convert.ToString(dt.Rows[0]["EmployeeUserID"]));
                this.SetReimbursment(Convert.ToString(dt.Rows[0]["rembusIdd"]));
                txtAmount.Text = Convert.ToString(dt.Rows[0]["rembusamt"]);
                txtSub1.Text = Convert.ToString(dt.Rows[0]["rembussub1"]);
                txtSub2.Text = Convert.ToString(dt.Rows[0]["rembussub2"]);
                txtSub3.Text = Convert.ToString(dt.Rows[0]["rembussub3"]);
                txtDescription.Text = Convert.ToString(dt.Rows[0]["rembusdsc"]);
                txtDescription1.Text = Convert.ToString(dt.Rows[0]["rembusdsc1"]);
                txtDescription2.Text = Convert.ToString(dt.Rows[0]["rembusdsc2"]);
                txtDescription3.Text = Convert.ToString(dt.Rows[0]["rembusdsc3"]);
                hfTransactionNo.Value = Convert.ToString(dt.Rows[0]["transactionNumber"]);
                rCmbEmployee_SelectedIndexChanged(null, null);
            }
        }
        catch (Exception)
        {
            throw;
        }
    }

    private void SetEmployee(string strID)
    {
        RadGrid grid = rCmbEmployee.Items[0].FindControl("rGrdEmployees4DDL") as RadGrid;
        if (grid != null)
            foreach (GridItem item in grid.MasterTableView.Items)
            {
                if (item is GridDataItem)
                {
                    GridDataItem dataItem = (GridDataItem)item;
                    if (dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["UserID"].ToString() == strID)
                    {
                        dataItem.Selected = true;

                        rCmbEmployee.Items[0].Value = strID;
                        rCmbEmployee.Items[0].Text = dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["EmployeeFullNameWithID"].ToString();
                        rCmbEmployee.Text = dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["EmployeeFullNameWithID"].ToString();

                        break;
                    }
                }
            }
    }

    private void SetReimbursment(string departmentID)
    {
        RadGrid grid = rCmbReimbursment.Items[0].FindControl("rGrdReimbursments4DDL") as RadGrid;
        if (grid != null)
            foreach (GridItem item in grid.MasterTableView.Items)
            {
                if (item is GridDataItem)
                {
                    GridDataItem dataItem = (GridDataItem)item;
                    if (dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["recidd"].ToString() == departmentID)
                    {
                        dataItem.Selected = true;

                        rCmbReimbursment.Items[0].Value = departmentID;
                        rCmbReimbursment.Items[0].Text = dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["bchcod"].ToString();
                        rCmbReimbursment.Text = dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["bchcod"].ToString();

                        break;
                    }
                }
            }
    }

    protected void Repeater1_ItemCommand(object source, System.Web.UI.WebControls.RepeaterCommandEventArgs e)
    {
        Int32 idd = Convert.ToInt32(e.CommandArgument.ToString());
        if (e.CommandName == "Download")
        {
            try
            {
                using (SqlConnection myConnection = new SqlConnection(
                    ConfigurationManager.ConnectionStrings["eb_payroll"].ConnectionString))
                {
                    const string SQL = @"SELECT idd,documentname ,description, documenttype,document FROM dbo.eb_prlattach 
                                        WHERE idd = @IDD";
                    SqlCommand myCommand = new SqlCommand(SQL, myConnection);
                    myCommand.Parameters.AddWithValue("@IDD", idd);

                    myConnection.Open();
                    SqlDataReader myReader = myCommand.ExecuteReader();

                    RadAjaxManager manager = new RadAjaxManager();
                    manager.EnableAJAX = false;

                    if (myReader.Read())
                    {
                        Response.Clear();
                        Response.ContentType = myReader["documenttype"].ToString();
                        Response.AddHeader("Content-Disposition", "attachment;filename=" + myReader["documentname"].ToString());
                        Response.BinaryWrite((byte[])myReader["document"]);
                        Response.Flush();
                        Response.Close();
                        Response.End();
                    }

                    myReader.Close();
                    myConnection.Close();
                }
            }
            catch (Exception ex)
            {
                Response.Write(ex.ToString());
            }

        }
        else if (e.CommandName == "Remove")
        {
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("@Id", idd);
                clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Delete_Attachment", ht);

                bindAttach();

                ShowClientMessage("Attachment record deleted successfuly.", MessageType.Success);
            }
            catch (Exception ex)
            {
                ShowClientMessage(ex.Message, MessageType.Error);
            }
        }
        else if (e.CommandName == "Change")
        {
            try
            {
                RadTextBox txtfiledescription = e.Item.FindControl("txtfiledescription") as RadTextBox;
                if (txtfiledescription != null)
                {
                    Hashtable ht = new Hashtable();
                    ht.Add("@id", idd);
                    ht.Add("@desc", txtfiledescription.Text);
                    clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Update_Attachment", ht);

                    bindAttach();

                    ShowClientMessage("Attachment description udpated successfuly.", MessageType.Success);
                }
            }
            catch (Exception ex)
            {
                ShowClientMessage(ex.Message, MessageType.Error);
            }
        }
    }

    protected void bindAttach()
    {
        try
        {
            Hashtable ht_attach = new Hashtable();
            ht_attach.Add("@ID", Request.QueryString["RequestID"]);
            ht_attach.Add("@transactioname", "PayrollReimbursment");

            DataTable dt_attach = clsDAL.GetDataSet("sp_User_Get_attach_ByID", ht_attach).Tables[0];

            if (dt_attach != null && dt_attach.Rows.Count > 0)
            {
                ltrNoResults.Visible = false;
                Repeater1.Visible = true;
                Repeater1.DataSource = dt_attach;
                Repeater1.DataBind();
            }
            else
            {
                ltrNoResults.Visible = true;
                Repeater1.Visible = false;
            }
        }
        catch (Exception)
        {
            throw;
        }
    }


    protected void RBtnApproveClick(object sender, EventArgs e)
    {
        try
        {
            Hashtable ht = new Hashtable();

            ht.Add("@ReimbursmentID", Request.QueryString["RequestID"]);
            ht.Add("@ReimbursmentStatusID", Request.QueryString["RequestStatusID"]);
            ht.Add("@ApproverUserID", Session["_UserID"].ToString());
            ht.Add("@TransRemarks", txtremarks.Text);
            ht.Add("@DBMessage", "");

            string DBMessage = clsDAL.ExecuteNonQuery("sp_User_Approve_Reimbursment", ht, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;

            ht = null;
            ht = new Hashtable();
            ht.Add("@ReimbursmentID", Request.QueryString["RequestID"]);

            DataTable dt = clsDAL.GetDataSet("sp_User_Get_Reimbursment_Info_4_Email", ht).Tables[0];

            if ((null != dt) && dt.Rows.Count > 0)
            {
                ht = null;
                ht = new Hashtable();
                ht.Add("@ReimbursmentID", Request.QueryString["RequestID"]);
                ht.Add("@RedirectURL", Request.Url.AbsoluteUri);

                clsCommon.SendMail(3, ht);
            }

            if ((null != DBMessage) && DBMessage.Contains("ERROR:"))
            {
                ShowMessage("Sorry! some error has occurred. Please try again later.", MessageType.Error);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, Page.GetType(), "mykey", "CloseAndRebind();", true);
                //ShowClientMessage("Processed successfully.", MessageType.Success);
            }
        }
        catch (Exception ex)
        {
            ShowMessage(ex.Message, MessageType.Error);
        }
    }

    public void ShowClientMessage(string message, MessageType type, string redirect = "")
    {
        if (type == MessageType.Error)
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "radalert", string.Format("showError('{0}', '{1}', 5000)", message, redirect), true);
        }
        else if (type == MessageType.Success)
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "radalert", string.Format("showSuccess('{0}', '{1}', 5000)", message, redirect), true);
        }
        else if (type == MessageType.Warning)
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "radalert", string.Format("showWarning('{0}', '{1}', 5000)", message, redirect), true);
        }
        else if (type == MessageType.Info)
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "radalert", string.Format("showInfo('{0}', '{1}', 5000)", message, redirect), true);
        }
    }


    protected void RBtnRejectClick(object sender, EventArgs e)
    {
        try
        {
            Hashtable ht = new Hashtable();

            ht.Add("@ReimbursmentRequestID", Request.QueryString["RequestID"]);
            ht.Add("@ReimbursmentStatusID", Request.QueryString["RequestStatusID"]);
            ht.Add("@ApproverUserID", Session["_UserID"].ToString());
            ht.Add("@transremarks", txtremarks.Text);
            ht.Add("@DBMessage", "");

            string dBMessage = clsDAL.ExecuteNonQuery("sp_User_Reject_Reimbursment_Request", ht, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;

            if ((null != dBMessage) && dBMessage.Contains("ERROR:"))
            {
                ShowMessage("Sorry! some error has occurred. Please try again later.", MessageType.Error);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, Page.GetType(), "mykey", "CloseAndRebind();", true);
                //ShowMessage("Processed successfully.", MessageType.Success);
            }
        }
        catch (Exception ex)
        {
            ShowMessage(ex.Message, MessageType.Error);
        }
    }

    protected void RBtnReviseClick(object sender, EventArgs e)
    {
        try
        {
            RadGrid grid;
            grid = rCmbLevels.Items[0].FindControl("rGrdLevels4DDL") as RadGrid;

            if (grid.SelectedValue != null)
            {
                int transactionstatusid;
                transactionstatusid = Int32.Parse(grid.SelectedValue.ToString());
                Hashtable ht = new Hashtable();
                ht.Add("@TransactionEntryRequestID", Request.QueryString["RequestID"]);
                ht.Add("@TransactionEntryStatusID", Request.QueryString["RequestStatusID"]);
                ht.Add("@ApproverUserID", Session["_UserID"].ToString());
                ht.Add("@transRemarks", txtremarks.Text);
                ht.Add("@revisetostatusid", transactionstatusid);
                ht.Add("@DBMessage", "");
                string DBMessage = clsDAL.ExecuteNonQuery("sp_User_Revise_Reimbursment_Request", ht, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                if ((null != DBMessage) && DBMessage.Contains("ERROR:"))
                {
                    ShowMessage("Sorry! some error has occurred. Please try again later.", MessageType.Error);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, Page.GetType(), "mykey", "CloseAndRebind('" + "Processed Successfully" + "');", true);
                }
            }
            else
                ShowClientMessage("User Required", MessageType.Error);
        }
        catch (Exception ex)
        {
            ShowClientMessage(ex.Message, MessageType.Error);
        }
    }

    protected void RBtnBackClick(object sender, EventArgs e)
    {

    }


    // History grid data loading and binding
    protected void gvHistory_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {
        htSearchParams = new Hashtable();
        htSearchParams.Add("@recordId", Request.QueryString["RequestID"]);
        DataTable dt = clsDAL.GetDataSet_Payroll("sp_User_Get_Reimburs_History", htSearchParams).Tables[0];
        dt.TableName = "HistoryMaster";
        Session["Rows"] = dt.Rows.Count;
        gvHistory.DataSource = dt;
        gvHistory.DataMember = "HistoryMaster";
    }

    // form controls setting for insert/udpate
    // grid exporting functions
    protected void gvHistory_ItemCommand(object sender, GridCommandEventArgs e)
    {
        RadGrid grid = (sender as RadGrid);
        if (e.CommandName == RadGrid.InitInsertCommandName)
        {
            grid.MasterTableView.ClearEditItems();
        }
        if (e.CommandName == RadGrid.EditCommandName)
        {
            e.Item.OwnerTableView.IsItemInserted = false;
        }
        if (e.CommandName == RadGrid.RebindGridCommandName)
        {
            grid.MasterTableView.ClearEditItems();
            e.Item.OwnerTableView.IsItemInserted = false;

            if (htSearchParams != null)
                htSearchParams.Clear();
        }
        if (e.CommandName == RadGrid.ExportToExcelCommandName)
        {
            exporting = true;
            grid.GridLines = GridLines.Both;
            grid.BorderStyle = BorderStyle.Solid;
            grid.BorderWidth = Unit.Pixel(1);

            grid.MasterTableView.GetColumn("EditHistory").Visible = false;
            grid.MasterTableView.GetColumn("DeleteHistory").Visible = false;

            grid.MasterTableView.ExportToExcel();
        }
        if (e.CommandName == RadGrid.ExportToCsvCommandName)
        {
            exporting = true;
            grid.GridLines = GridLines.Both;
            grid.BorderStyle = BorderStyle.Solid;
            grid.BorderWidth = Unit.Pixel(1);

            grid.MasterTableView.GetColumn("EditHistory").Visible = false;
            grid.MasterTableView.GetColumn("DeleteHistory").Visible = false;

            grid.ExportSettings.ExportOnlyData = false;
            grid.MasterTableView.ExportToCSV();
        }
        if (e.CommandName == RadGrid.ExportToPdfCommandName)
        {
            exporting = true;
            grid.GridLines = GridLines.Both;
            grid.BorderStyle = BorderStyle.Solid;
            grid.BorderWidth = Unit.Pixel(1);

            grid.MasterTableView.GetColumn("EditHistory").Visible = false;
            grid.MasterTableView.GetColumn("DeleteHistory").Visible = false;

            grid.MasterTableView.ExportToPdf();
        }
    }

    // form controls settings for insert/udpate
    protected void gvHistory_ItemDataBound(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridEditableItem && e.Item.IsInEditMode)
        {
            if (e.Item.OwnerTableView.DataMember == "HistoryMaster")
            {

            }
        }

        // get count literal and assign grid list count
        if (e.Item is GridCommandItem)
        {
            GridCommandItem commandItem = (GridCommandItem)e.Item;
            Literal ltNotiCount = (Literal)commandItem.FindControl("ltNotiCount");
            if (ltNotiCount != null)
            {
                ltNotiCount.Text = Session["Rows"] != null ? Session["Rows"].ToString() : "0";
            }
        }
    }

}