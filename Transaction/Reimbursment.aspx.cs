using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Drawing;
using System.IO;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public partial class Reimbursment : BasePage
{
    #region Startup

    protected override void Page_Init(object sender, EventArgs e)
    {
        FormName = "Reimbursment";
        base.Page_Init(sender, e);

    }

    protected void Page_Load(object sender, EventArgs e)
    {
        Color col_current = System.Drawing.ColorTranslator.FromHtml("#FF0090");
        Color col_pending = System.Drawing.ColorTranslator.FromHtml("#F7A29C");
        Color col_approved = System.Drawing.ColorTranslator.FromHtml("#49F27C");
        Color col_returned = System.Drawing.ColorTranslator.FromHtml("#49de94");
        Color col_rejected = System.Drawing.ColorTranslator.FromHtml("#FF0090 ");
        Color col_revised = System.Drawing.ColorTranslator.FromHtml("#A7B3DB");
        Color col_initiated = System.Drawing.ColorTranslator.FromHtml("#FAF873");
        Color col_completed = System.Drawing.ColorTranslator.FromHtml("#006400");
        Color col_completed_fore = System.Drawing.ColorTranslator.FromHtml("#fffaf0");
        if (!IsPostBack)
        {
            if (Session["_UserID"] != null)
            {
                //bindCombos();
                clearForm();
            }
        }
    }

    #endregion Startup

    #region Misc. Functions

    /// <summary>
    /// Gets the full name of the user.
    /// </summary>
    /// <param name="EmployeeUserID">The employee user ID.</param>
    /// <param name="EmployeeFullName">Full name of the employee.</param>
    /// <returns></returns>
    protected string GetUserFullName(int EmployeeUserID, string EmployeeFullName)
    {
        if (EmployeeUserID == int.Parse(Session["_UserID"].ToString()))
        {
            return "Self";
        }
        else
        {
            return EmployeeFullName;
        }
    }

    protected bool isEditVisible(string Last_Status_ID, int EmployeeUserID)
    {
        clsCommon.RequestStatus statusID = (clsCommon.RequestStatus)int.Parse(Last_Status_ID);

        switch (statusID)
        {
            case clsCommon.RequestStatus.Initiated:
                return true;

            case clsCommon.RequestStatus.Edited:
                return true;

            case clsCommon.RequestStatus.Recalled:
                return true;

            default:
                return false;
        }
    }

    protected bool isRecallVisible(string Last_Status_ID, int EmployeeUserID)
    {
        clsCommon.RequestStatus statusID = (clsCommon.RequestStatus)int.Parse(Last_Status_ID);

        switch (statusID)
        {
            case clsCommon.RequestStatus.Pending:
                return true;

            case clsCommon.RequestStatus.InProcess:
                return true;

            case clsCommon.RequestStatus.Approved:
                return true;

            case clsCommon.RequestStatus.Canceled:
                return true;

            default:
                return false;
        }
    }

    protected bool isSubmitVisible(string Last_Status_ID, int EmployeeUserID)
    {
        clsCommon.RequestStatus statusID = (clsCommon.RequestStatus)int.Parse(Last_Status_ID);

        switch (statusID)
        {
            case clsCommon.RequestStatus.Initiated:
                return true;

            case clsCommon.RequestStatus.Edited:
                return true;

            case clsCommon.RequestStatus.Recalled:
                return true;

            default:
                return false;
        }
    }

    protected bool isInProcessVisible(string Last_Status_ID)
    {
        clsCommon.RequestStatus statusID = (clsCommon.RequestStatus)int.Parse(Last_Status_ID);

        switch (statusID)
        {
            case clsCommon.RequestStatus.Pending:
                return true;

            case clsCommon.RequestStatus.InProcess:
                return true;

            default:
                return false;
        }
    }

    protected bool isCompletedVisible(string lastStatusID)
    {
        clsCommon.RequestStatus statusID = (clsCommon.RequestStatus)int.Parse(lastStatusID);

        switch (statusID)
        {
            case clsCommon.RequestStatus.Completed:
                return true;

            default:
                return false;
        }
    }

    protected bool isRejectedVisible(string Last_Status_ID)
    {
        clsCommon.RequestStatus statusID = (clsCommon.RequestStatus)int.Parse(Last_Status_ID);

        switch (statusID)
        {
            case clsCommon.RequestStatus.Rejected:
                return true;

            default:
                return false;
        }
    }

    #region ----- Workflow chart -----

    protected void OnAjaxUpdate(object sender, ToolTipUpdateEventArgs args)
    {
        System.Web.UI.Control ctrl = Page.LoadControl("~/Controls/Diagram.ascx");
        ctrl.ID = "UcInfoCustomers1";
        args.UpdatePanel.ContentTemplateContainer.Controls.Add(ctrl);
        Controls_Diagram details = (Controls_Diagram)ctrl;
        details.TransactionEntryID = int.Parse(args.Value);
    }

    #endregion ----- Workflow chart -----

    protected void RadAjaxPanel1_AjaxRequest(object sender, AjaxRequestEventArgs e)
    {
        clearForm();
    }

    protected void rBtnPrint_Click(object sender, EventArgs e)
    {

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

    #endregion Misc. Functions

    #region Tab1 - New Requests

    private void bindComboReimbursment()
    {
        //if (null != Session["_UserID"] && !string.IsNullOrEmpty(Request.QueryString["FormType"]))
        {
            RadGrid grid;

            #region Fill Reimbursment

            rCmbReimbursment.ClearSelection();
            grid = rCmbReimbursment.Items[0].FindControl("rGrdReimbursments4DDL") as RadGrid;
            grid.DataSource = clsDAL.GetDataSet("sp_Payroll_Get_All_Batches").Tables[0];
            //grid.Rebind();

            #endregion Fill Reimbursment

            //#region Fill Employees
            //rCmbEmployee.ClearSelection();
            //Hashtable ht = new Hashtable();
            //ht.Add("@UserID", Session["_UserID"].ToString());
            //ht.Add("@FormTypeID", Request.QueryString["FormType"]);
            //grid = rCmbEmployee.Items[0].FindControl("rGrdEmployees4DDL") as RadGrid;
            //grid.DataSource = clsDAL.GetDataSet_admin("sp_User_Get_Employees_By_UserID_4_DDL", ht).Tables[0];
            //grid.Rebind();
            //rCmbEmployee.Items[0].Value = Session["_UserID"].ToString();
            //rCmbEmployee.Items[0].Text = "Self";
            //rCmbEmployee.Text = "Self";
            //foreach (GridItem item in grid.MasterTableView.Items)
            //{
            //    if (item is GridDataItem)
            //    {
            //        GridDataItem dataItem = (GridDataItem)item;
            //        if (dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["UserID"].ToString() == Session["_UserID"].ToString())
            //        {
            //            dataItem.Selected = true;
            //            break;
            //        }
            //    }
            //}
            //rCmbEmployee_SelectedIndexChanged(null, null);
            //#endregion Fill Employees
            //bindComboEmployee();
        }
    }

    private void bindComboEmployee()
    {
        if (null != Session["_UserID"] && !string.IsNullOrEmpty(Request.QueryString["FormType"]))
        {
            RadGrid grid;

            #region Fill Employees

            rCmbEmployee.ClearSelection();

            Hashtable ht = new Hashtable();
            ht.Add("@UserID", Session["_UserID"].ToString());
            ht.Add("@FormTypeID", Request.QueryString["FormType"]);

            grid = rCmbEmployee.Items[0].FindControl("rGrdEmployees4DDL") as RadGrid;
            grid.DataSource = clsDAL.GetDataSet_admin("sp_User_Get_Employees_By_UserID_4_DDL", ht).Tables[0];
            //grid.Rebind();
            //grid.DataBind();

            rCmbEmployee.Items[0].Value = Session["_UserID"].ToString();
            rCmbEmployee.Items[0].Text = "Self";
            rCmbEmployee.Text = "Self";

            foreach (GridItem item in grid.MasterTableView.Items)
            {
                if (item is GridDataItem)
                {
                    GridDataItem dataItem = (GridDataItem)item;
                    if (dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["UserID"].ToString() == Session["_UserID"].ToString())
                    {
                        dataItem.Selected = true;
                        break;
                    }
                }
            }

            rCmbEmployee_SelectedIndexChanged(null, null);

            #endregion Fill Employees
        }
    }

    private void clearForm()
    {
        ClearReimbursementType();

        txtAmount.Text = "";
        txtSub1.Text = "";
        txtSub2.Text = "";
        txtSub3.Text = "";

        txtDescription.Text = "";
        txtDescription1.Text = "";
        txtDescription2.Text = "";
        txtDescription3.Text = "";

        rCmbEmployee_SelectedIndexChanged(null, null);

        gvSavedRequests.Rebind();
        gvSubmittedRequests.Rebind();
        gvPendingAppRequests.Rebind();
        gvApprovedRequests.Rebind();

    }

    private void ClearReimbursementType()
    {
        RadGrid grid_LeaveType = rCmbReimbursment.Items[0].FindControl("rGrdReimbursments4DDL") as RadGrid;
        if (grid_LeaveType != null)
        {
            grid_LeaveType.SelectedIndexes.Clear();
            rCmbReimbursment.Text = "";
            rCmbReimbursment.ClearSelection();
        }
    }

    protected void rBtnSave_Click(object sender, EventArgs e)
    {
        try
        {
            //if (checkduplicateemail())
            {
                save(1);
                
                ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowTab", "ShowTab('#tab1');", true);
            }
        }
        catch (Exception ex)
        {
            Logger.LogError(ex);
            throw ex;
        }
    }

    private void save(int saveStatus)
    {
        try
        {
            if (!string.IsNullOrEmpty(txtAmount.Text) && !string.IsNullOrEmpty(txtDescription.Text))
            {
                Hashtable ht = new Hashtable();

              ht.Add("@FormTypeID", Request.QueryString["FormType"]);
                ht.Add("@EmployeeUserID", rCmbEmployee.Items[0].Value);

                ht.Add("@employeeIDD", rCmbEmployee.Items[0].Value);
                ht.Add("@employeeCode", rCmbEmployee.Items[0].Text);
                ht.Add("@rembusIdd", rCmbReimbursment.Items[0].Value);
                ht.Add("@rembuscod", rCmbReimbursment.Items[0].Text);
                ht.Add("@remtypIdd", 1);
                ht.Add("@remtypcod", "1");
                ht.Add("@rembusamt", string.IsNullOrEmpty(txtAmount.Text) ? 0 : Convert.ToDecimal(txtAmount.Text));
                ht.Add("@rembussub1", string.IsNullOrEmpty(txtSub1.Text) ? 0 : Convert.ToDecimal(txtSub1.Text));
                ht.Add("@rembussub2", string.IsNullOrEmpty(txtSub2.Text) ? 0 : Convert.ToDecimal(txtSub2.Text));
                ht.Add("@rembussub3", string.IsNullOrEmpty(txtSub3.Text) ? 0 : Convert.ToDecimal(txtSub3.Text));
                ht.Add("@rembusdsc", txtDescription.Text);
                ht.Add("@rembusdsc1", txtDescription1.Text);
                ht.Add("@rembusdsc2", txtDescription2.Text);
                ht.Add("@rembusdsc3", txtDescription3.Text);
                ht.Add("@SaveStatus", saveStatus);
                ht.Add("@SubmittedByUserID", (string)Session["_UserID"]);
                ht.Add("@TransRemarks", "");
                ht.Add("@ReimbursmentID", 0);

            
       
                string nextnumber;
                Hashtable ht_nextnumber = new Hashtable();
                ht_nextnumber.Add("@seqcod", "REIMBURSEMENT");
                ht_nextnumber.Add("@TRX_ID", null);

                nextnumber = clsDAL.ExecuteNonQuery(Constraints.sp_User_Get_Next_Number, ht_nextnumber, "@TRX_ID", System.Data.SqlDbType.NVarChar, 255) as string;

                ht.Add("@transactionNumber", nextnumber);

                int Appidd = 0;

                Appidd = int.Parse(clsDAL.ExecuteNonQuery(Constraints.sp_User_Insert_Reimbursment, ht, "@ReimbursmentID", System.Data.SqlDbType.Int, 0).ToString());

                /*Add attachments - Start*/

                {
                    Hashtable ht_attachments = new Hashtable();

                    if (ruDocument.UploadedFiles.Count > 0)
                    {
                        for (int l = 0; l <= ruDocument.UploadedFiles.Count - 1; l++)
                        {
                            var currentFile = ruDocument.UploadedFiles[l];
                            var filedsc = currentFile.GetFieldValue("TextBox").ToString();
                            var filename = ruDocument.UploadedFiles[l].FileName;
                            var imgStream = currentFile.InputStream;
                            int imgLen = int.Parse(currentFile.ContentLength.ToString());

                            byte[] imgBinaryData = new byte[imgLen];
                            int n = imgStream.Read(imgBinaryData, 0, imgLen);

                            // Image to Base64 string and save in database
                            // Convert byte[] to Base64 String

                            string base64String = Convert.ToBase64String(imgBinaryData);

                            ht_attachments = new Hashtable();
                            ht_attachments.Add("@transactionname", "PayrollReimbursment");
                            ht_attachments.Add("@transactionidd", Appidd);
                            ht_attachments.Add("@transactioncode", nextnumber);
                            ht_attachments.Add("@description", filedsc);

                            ht_attachments["@File"] = imgBinaryData;
                            ht_attachments["@Filetype"] = currentFile.ContentType;
                            ht_attachments["@Filename"] = filename;

                            clsDAL.ExecuteNonQuery(Constraints.sp_User_Insert_Attachment, ht_attachments);
                        }
                    }
                }

                if (Appidd > 0)
                {
                    int wfid;
                    Hashtable ht_message = new Hashtable();
                    ht_message.Add("@FormTypeID", Request.QueryString["FormType"]);
                    ht_message.Add("@SubmittedByUserID", (string)Session["_UserID"]);
                    ht_message.Add("@WorkFlowMasterID", "0");

                    wfid = int.Parse(clsDAL.ExecuteNonQuery_admin(Constraints.get_WorkFlowID, ht_message, "@WorkFlowMasterID", System.Data.SqlDbType.Int, 0).ToString());

                    if (saveStatus == 2)
                    {
                        ht = null;
                        ht = new Hashtable();
                        ht.Add("@ReimbursmentID", Appidd);
                        ht.Add("@RedirectURL", Request.Url.AbsoluteUri);

                        clsCommon.SendMail(3, ht);
                    }
                    clearForm();

                    if (wfid == 0)
                    {
                        ShowClientMessage(string.Format("New Transaction ID: {0} is Saved but cannot be Sumbitted due to missing workflow.", Appidd.ToString()), MessageType.Warning);
                    }
                    else if (wfid > 0 && saveStatus == 2)
                    {
                        ShowClientMessage(string.Format("New Transaction ID: {0} is Saved and submitted.", Appidd.ToString()), MessageType.Success);
                    }
                    else if (wfid > 0 && saveStatus == 1)
                    {
                        ShowClientMessage(string.Format("New Transaction ID: {0} is Saved and can be submitted from Saved Requests tab.", Appidd.ToString()), MessageType.Info);
                    }
                    clearForm();
                }
                else
                {
                    ShowClientMessage("Sorry! some error has occurred. Please try again later.", MessageType.Error);
                }
              
            }
            else
            { 
                if(string.IsNullOrEmpty(txtAmount.Text) && string.IsNullOrEmpty(txtDescription.Text))
                    ShowClientMessage("Amount and Description required", MessageType.Error);
                else if (string.IsNullOrEmpty(txtAmount.Text))
                    ShowClientMessage("Amount required", MessageType.Error);
                else if (String.IsNullOrEmpty(txtDescription.Text))
                    ShowClientMessage("Description required", MessageType.Error);
            }
        }
        catch (Exception ex)
        {
            ShowClientMessage(string.Format("Sorry! some error has occurred. Please try again later.<br/>{0}", ex.Message), MessageType.Error);
            Logger.LogError(ex);
        }
    }

    protected void rBtnSaveAndSubmit_Click(object sender, EventArgs e)
    {
        //if (checkduplicateemail())
        {
            save(2);
            ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowTab", "ShowTab('#tab1');", true);
        }
    }

    protected void rCmbEmployee_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
    {
        if (rCmbEmployee.Items[0].Value != null)
        {
            ucEmployeeCard.LoadEmployeeCard(rCmbEmployee.Items[0].Value);
        }
    }

    protected void rGrdEmployees4DDL_ItemCommand(object sender, GridCommandEventArgs e)
    {
        rCmbEmployee_SelectedIndexChanged(null, null);
    }

    protected void rGrdEmployees4DDL_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {
        bindComboEmployee();
    }

    protected void rGrdEmployees4DDL_DataBound(object sender, EventArgs e)
    {
        RadGrid grid = rCmbEmployee.Items[0].FindControl("rGrdEmployees4DDL") as RadGrid;

        foreach (GridItem item in grid.MasterTableView.Items)
        {
            if (item is GridDataItem)
            {
                GridDataItem dataItem = (GridDataItem)item;
                if (dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["UserID"].ToString() == Session["_UserID"].ToString())
                {
                    dataItem.Selected = true;
                    break;
                }
            }
        }
        //rCmbEmployee_SelectedIndexChanged(null, null);
    }

    protected void rGrdReimbursments4DDL_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {
        bindComboReimbursment();
    }

    #endregion Tab1 - New Requests

    #region Tab2 - Saved Requests

    protected void gvSavedRequests_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {
        if (!string.IsNullOrEmpty(Request.QueryString["FormType"]))
        {
            Hashtable ht = new Hashtable();
            ht.Add("@UserID", Session["_UserID"].ToString());
            ht.Add("@FormTypeID", Request.QueryString["FormType"]);

            DataTable dt = clsDAL.GetDataSet("sp_User_Get_Saved_Reimbursment", ht).Tables[0];
            dt.TableName = "eb_prlreitrx";
            gvSavedRequests.DataSource = dt;
            gvSavedRequests.DataMember = "eb_prlreitrx";
        }
    }

    protected void gvSavedRequests_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == "Print")
        {
            string requestId = clsEncryption.EncryptData(e.CommandArgument.ToString());
            // bring report from formtype
            string rptName = clsEncryption.EncryptData("ReimbursTrxEntryByID");
            ScriptManager.RegisterStartupScript(this, Page.GetType(), "mykey", "ShowReport('" + requestId + "','" + rptName + "');", true);
        }
        if (e.CommandName == "Submit")
        {
            Hashtable ht_reimburse = new Hashtable();

            ht_reimburse.Add("@ReimbursmentID", e.CommandArgument.ToString());
            ht_reimburse.Add("@SubmittedbyUserID", (string)Session["_UserID"]);
            ht_reimburse.Add("@FormTypeID", Request.QueryString["FormType"]);

            clsDAL.ExecuteNonQuery("sp_User_Submit_Reimbursment", ht_reimburse);

            //gvSavedRequests.Rebind();

            Hashtable ht_email = new Hashtable();

            ht_email.Add("@ReimbursmentID", e.CommandArgument.ToString());

            DataTable dt = clsDAL.GetDataSet("sp_User_Get_Reimbursment_Info_4_Email", ht_email).Tables[0];

            if ((null != dt) && dt.Rows.Count > 0)
            {
                string sBody = "";
                string htmlEmailFormat = Server.MapPath("~/EmailTemplates/NotifyApplicantApproverEmail.htm");

                //sBody = File.ReadAllText(htmlEmailFormat);
                //sBody = sBody.Replace("<%UserFullName%>", dt.Rows[0]["MainApproverFullName"].ToString());
                //sBody = sBody.Replace("<%ID%>", Request.QueryString["ReimbursmentID"]);
                ////sBody = sBody.Replace("<%FullName%>", txtFirstName.Text + txtMiddleName.Text + txtLastName.Text);
                ////sBody = sBody.Replace("<%Position%>", rCmbPosition.SelectedValue.ToString());
                ////sBody = sBody.Replace("<%Remarks%>", rTxtRemarks.Text);
                //sBody = sBody.Replace("<%RedirectURL%>", Request.Url.AbsoluteUri);
                //clsCommon.SendMail(sBody, dt.Rows[0]["Email"].ToString(), ConfigurationManager.AppSettings["EMAIL_ACC"], "A request is pending for your approval.");
            }

            //gvSavedRequests.DataSource = "";
            //gvSavedRequests.Rebind();

            ShowClientMessage("New Transaction ID:" + e.CommandArgument.ToString() + "  is submitted for approval.", MessageType.Success);
            clearForm();
            ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowTab", "ShowTab('#tab2');", true);
            ScriptManager.RegisterStartupScript(this, this.GetType(), "RefreshGrid", "refreshGrid2();", true);
        }

        if (e.CommandName == "imgBtnPrint")
        {
            Button btnActionPrint = (Button)e.Item.FindControl("imgBtnPrint");
            String qstring = clsEncryption.EncryptData("BatchMaster");
            btnActionPrint.Attributes["onclick"] = String.Format("return ShowReport('{0}');", qstring);
        }

        if (e.CommandName == "Delete")
        {
            Hashtable ht_delete = new Hashtable();
            ht_delete.Add("@Reimbursementid", e.CommandArgument.ToString());
            clsDAL.ExecuteNonQuery("sp_User_Delete_Reimbursement", ht_delete);
            ShowClientMessage("Transaction ID:" + e.CommandArgument.ToString() + "  is Deleted.", MessageType.Success);
            ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowTab", "ShowTab('#tab2');", true);
            ScriptManager.RegisterStartupScript(this, this.GetType(), "RefreshGrid", "refreshGrid2();", true);
        }
    }

    protected void gvSavedRequests_DetailTableDataBind(object sender, GridDetailTableDataBindEventArgs e)
    {
        GridDataItem dataItem = e.DetailTableView.ParentItem;

        switch (e.DetailTableView.Name)
        {
            case "RequestStatuses":
                {
                    string ID = dataItem.GetDataKeyValue("RequestID").ToString();

                    Hashtable ht = new Hashtable();
                    ht.Add("@ReimbursmentID", ID);

                    DataTable dt = clsDAL.GetDataSet("sp_User_Get_Reimbursment_Statuses", ht).Tables[0];
                    dt.TableName = "tbl_Reimbursment_Status";
                    e.DetailTableView.DataSource = dt;
                    e.DetailTableView.DataMember = "tbl_Reimbursment_Status";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowTab", "ShowTab('#tab2');", true);

                    break;
                }
        }
    }

    protected void gvSavedRequests_ItemCreated(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridDataItem && e.Item.OwnerTableView.DataMember == "eb_prlreitrx")
        {
            ImageButton imgBtnEdit = (ImageButton)e.Item.FindControl("imgBtnEdit");
            if (imgBtnEdit != null)
                imgBtnEdit.Attributes["onclick"] = String.Format("return ShowEditForm('{0}','{1}','{2}','{3}');", e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["RequestID"], e.Item.ItemIndex, Request.QueryString["FormType"], false);

            ImageButton imgBtnRecall = (ImageButton)e.Item.FindControl("imgBtnRecall");
            if (imgBtnRecall != null)
                imgBtnRecall.Attributes["onclick"] = String.Format("return ShowEditForm('{0}','{1}','{2}','{3}');", e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["RequestID"], e.Item.ItemIndex, Request.QueryString["FormType"], true);

            ImageButton imgBtnOrgChart = (ImageButton)e.Item.FindControl("imgBtnOrgChart");
            imgBtnOrgChart.Attributes["onclick"] = String.Format("return ShowOrgChart('{0}','{1}');", e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["RequestID"], e.Item.ItemIndex);

            ImageButton imgBtnView = (ImageButton)e.Item.FindControl("imgBtnView");
            if (imgBtnView != null)
                imgBtnView.Attributes["onclick"] = String.Format("return ShowSavedViewForm('{0}','{1}','{2}','{3}');", e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["RequestID"], e.Item.ItemIndex, Request.QueryString["FormType"], true);
        }
    }

    protected void gvSavedRequests_ItemDataBound(object sender, GridItemEventArgs e)
    {
        //if (e.Item is GridDataItem && e.Item.OwnerTableView.Name == "RequestStatuses")
        //{

        //    Color col_current = System.Drawing.ColorTranslator.FromHtml("#FF0090");
        //    Color col_pending = System.Drawing.ColorTranslator.FromHtml("#F7A29C");
        //    Color col_approved = System.Drawing.ColorTranslator.FromHtml("#49F27C");
        //    Color col_returned = System.Drawing.ColorTranslator.FromHtml("#49de94");
        //    Color col_rejected = System.Drawing.ColorTranslator.FromHtml("#FF0090 ");
        //    Color col_revised = System.Drawing.ColorTranslator.FromHtml("#A7B3DB");
        //    Color col_initiated = System.Drawing.ColorTranslator.FromHtml("#FAF873");
        //    Color col_completed = System.Drawing.ColorTranslator.FromHtml("#006400");
        //    Color col_completed_fore = System.Drawing.ColorTranslator.FromHtml("#fffaf0");

        //    GridDataItem dataItem = e.Item as GridDataItem;
        //    TableCell cell = (TableCell)dataItem["colRequestStatus"];

        //    if (dataItem["colRequestStatus"].Text == "Pending")
        //        cell.BackColor = col_pending;

        //    if (dataItem["colRequestStatus"].Text == "Revised")
        //        cell.BackColor = col_revised;

        //    if (dataItem["colRequestStatus"].Text == "Approved")
        //        cell.BackColor = col_approved;

        //    if (dataItem["colRequestStatus"].Text == "returned")
        //        cell.BackColor = col_returned;

        //    if (dataItem["colRequestStatus"].Text == "Revised")
        //        cell.BackColor = col_revised;

        //    if (dataItem["colRequestStatus"].Text == "Initiated")
        //        cell.BackColor = col_initiated;

        //    if (dataItem["colRequestStatus"].Text == "Completed")
        //    {
        //        cell.BackColor = col_completed;
        //        cell.ForeColor = col_completed_fore;
        //    }


        //    if (dataItem["collevelcolor"].Text == "True")

        //        cell.BackColor = col_current;
        //    //                cell.CssClass = "MyMexicoRowClass";
        //}
    }

    #endregion Tab2 - Saved Requests

    #region Tab3 - Submitted Request

    protected void gvSubmittedRequests_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {
        if (!string.IsNullOrEmpty(Request.QueryString["FormType"]))
        {
            Hashtable ht_submitted = new Hashtable();
            ht_submitted.Add("@UserID", Session["_UserID"].ToString());
            ht_submitted.Add("@FormTypeID", Request.QueryString["FormType"]);

            DataTable dt = clsDAL.GetDataSet("sp_User_Get_Submitted_Reimbursment", ht_submitted).Tables[0];
            gvSubmittedRequests.DataSource = dt;
        }
    }

    protected void gvSubmittedRequests_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == "Print")
        {
            string requestId = clsEncryption.EncryptData(e.CommandArgument.ToString());
            // bring report from formtype
            string rptName = clsEncryption.EncryptData("ReimbursTrxEntryByID");
            ScriptManager.RegisterStartupScript(this, Page.GetType(), "mykey", "ShowReport('" + requestId + "','" + rptName + "');", true);
        }
    }

    protected void gvSubmittedRequests_ItemCreated(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridDataItem)
        {
            ImageButton imgBtnRecall = (ImageButton)e.Item.FindControl("imgBtnRecall");
            if (imgBtnRecall != null) 
                imgBtnRecall.Attributes["onclick"] = String.Format("return ShowRecallForm('{0}','{1}','{2}','{3}');", e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["RequestID"], e.Item.ItemIndex, Request.QueryString["FormType"], true);

            ImageButton imgBtnView = (ImageButton)e.Item.FindControl("imgBtnView");
            if (imgBtnView != null)
                imgBtnView.Attributes["onclick"] = String.Format("return ShowSubmittedViewForm('{0}','{1}','{2}','{3}');", e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["RequestID"], e.Item.ItemIndex, Request.QueryString["FormType"], true);
           
          
            ImageButton imgBtnOrgChart = (ImageButton)e.Item.FindControl("imgBtnOrgChart");
            if (imgBtnOrgChart != null)
            imgBtnOrgChart.Attributes["onclick"] = String.Format("return ShowOrgChart('{0}','{1}');", e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["RequestID"], e.Item.ItemIndex);
        }
    }

    protected void gvSubmittedRequests_DetailTableDataBind(object sender, GridDetailTableDataBindEventArgs e)
    {
        GridDataItem dataItem = e.DetailTableView.ParentItem;

        switch (e.DetailTableView.Name)
        {
            case "RequestStatuses":
                {
                    string ID = dataItem.GetDataKeyValue("RequestID").ToString();

                    Hashtable ht = new Hashtable();
                    ht.Add("@ReimbursmentID", ID);

                    DataTable dt = clsDAL.GetDataSet("sp_User_Get_Reimbursment_Statuses", ht).Tables[0];
                    dt.TableName = "tbl_Reimbursment_Status";
                    e.DetailTableView.DataSource = dt;
                    e.DetailTableView.DataMember = "tbl_Reimbursment_Status";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowTab", "ShowTab('#tab3');", true);

                    break;
                }
        }
    }

    protected string getImagePathForTrue(string status)
    {
        if( status == "Initiated")
            return "~/Images/16x16_process.png";
        if (status == "In Process")
            return "~/Images/16x16_process.png";
        if (status == "Request Completed with Approval")
            return "~/Images/16x16_approved.png";
        if (status == "Request Completed with Rejection")
            return "~/Images/16x16_rejected.png";
        else
            return "";
    }

    protected void gvSubmittedRequests_ItemDataBound(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridDataItem && e.Item.OwnerTableView.Name == "RequestStatuses")
        {

            Color col_current = System.Drawing.ColorTranslator.FromHtml("#FF0090");
            Color col_pending = System.Drawing.ColorTranslator.FromHtml("#F7A29C");
            Color col_approved = System.Drawing.ColorTranslator.FromHtml("#49F27C");
            Color col_returned = System.Drawing.ColorTranslator.FromHtml("#49de94");
            Color col_rejected = System.Drawing.ColorTranslator.FromHtml("#FF0090 ");
            Color col_revised = System.Drawing.ColorTranslator.FromHtml("#ffa500");
            Color col_initiated = System.Drawing.ColorTranslator.FromHtml("#FAF873");
            Color col_completed = System.Drawing.ColorTranslator.FromHtml("#006400");
            Color col_completed_fore = System.Drawing.ColorTranslator.FromHtml("#fffaf0");
            Color col_recalled = System.Drawing.ColorTranslator.FromHtml("#5e1716");

            GridDataItem dataItem = e.Item as GridDataItem;
            TableCell cell = (TableCell) dataItem["colRequestStatus"];

            if (dataItem["colRequestStatus"].Text == "Pending")
                cell.BackColor = col_pending;

            if (dataItem["colRequestStatus"].Text == "Revised")
                cell.BackColor = col_revised;

            if (dataItem["colRequestStatus"].Text == "Approved")
                cell.BackColor = col_approved;

            if (dataItem["colRequestStatus"].Text == "returned")
                cell.BackColor = col_returned;

            if (dataItem["colRequestStatus"].Text == "Revised")
                cell.BackColor = col_revised;

            if (dataItem["colRequestStatus"].Text == "Initiated")
                cell.BackColor = col_initiated;

            if (dataItem["colRequestStatus"].Text == "Recalled")
            {
                cell.BackColor = col_recalled;
            
            cell.ForeColor = col_completed_fore;
        }
        if (dataItem["colRequestStatus"].Text == "Completed")
            {
                cell.BackColor = col_completed;
                cell.ForeColor = col_completed_fore;
            }
        if (dataItem["colRequestStatus"].Text == "Rejected")
        {
            cell.BackColor = col_completed;
            cell.ForeColor = col_completed_fore;
        }
        if (dataItem["colRequestStatus"].Text == "Rejected")
        {
            cell.BackColor = col_completed;
            cell.ForeColor = col_completed_fore;
        }


            if (dataItem["collevelcolor"].Text == "True")

                cell.BackColor = col_current;
            //                cell.CssClass = "MyMexicoRowClass";
        }
    }

    #endregion

    #region Tab4 - Pending Approval

    protected void gvPendingAppRequests_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {
        if (!string.IsNullOrEmpty(Request.QueryString["FormType"]))
        {
            Hashtable ht = new Hashtable();
            ht.Add("@ApproverUserID", Session["_UserID"].ToString());
            DataTable dt = clsDAL.GetDataSet("sp_User_Get_ReimbursmentT2_For_Approval", ht).Tables[0];
            gvPendingAppRequests.DataSource = dt;
        }
    }

    protected void gvPendingAppRequests_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == "Print")
        {
            string requestId = clsEncryption.EncryptData(e.CommandArgument.ToString());
            // bring report from formtype
            string rptName = clsEncryption.EncryptData("ReimbursTrxEntryByID");
            ScriptManager.RegisterStartupScript(this, Page.GetType(), "mykey", "ShowReport('" + requestId + "','" + rptName + "');", true);
        }
    }

    protected void gvPendingAppRequests_ItemCreated(object sender, GridItemEventArgs e)
    {
        ImageButton imgBtnApprove = (ImageButton)e.Item.FindControl("imgBtnApprove");
        if (imgBtnApprove != null)
            imgBtnApprove.Attributes["onclick"] = String.Format("return ShowApproveForm('{0}','{1}','{2}','{3}');", 
                e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["RequestID"], 
                e.Item.ItemIndex, 
                e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["RequestStatusID"], 
                Request.QueryString["FormType"]);

        ImageButton imgBtnView = (ImageButton)e.Item.FindControl("imgBtnView");
        if (imgBtnView != null)
            imgBtnView.Attributes["onclick"] = String.Format("return ShowPendingViewForm('{0}','{1}','{2}','{3}');", e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["RequestID"], e.Item.ItemIndex, Request.QueryString["FormType"], true);
        ImageButton imgBtnOrgChart = (ImageButton)e.Item.FindControl("imgBtnOrgChart");
        if(imgBtnOrgChart!=null)
        imgBtnOrgChart.Attributes["onclick"] = String.Format("return ShowOrgChart('{0}','{1}');", e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["RequestID"], e.Item.ItemIndex);
    }

    protected void gvPendingAppRequests_DetailTableDataBind(object sender, GridDetailTableDataBindEventArgs e)
    {
        GridDataItem dataItem = e.DetailTableView.ParentItem;
        switch (e.DetailTableView.Name)
        {
            case "RequestStatuses":
                {
                    string ID = dataItem.GetDataKeyValue("RequestID").ToString();
                    Hashtable ht = new Hashtable();
                    ht.Add("@ReimbursmentID", ID);
                    DataTable dt = clsDAL.GetDataSet("sp_User_Get_Reimbursment_Statuses", ht).Tables[0];
                    dt.TableName = "tbl_Reimbursment_Status";
                    e.DetailTableView.DataSource = dt;
                    e.DetailTableView.DataMember = "tbl_Reimbursment_Status";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowTab", "ShowTab('#tab4');", true);
                    break;
                }
        }
    }

    protected void gvPendingAppRequests_ItemDataBound(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridDataItem && e.Item.OwnerTableView.Name == "RequestStatuses")
        {

            Color col_current = System.Drawing.ColorTranslator.FromHtml("#FF0090");
            Color col_pending = System.Drawing.ColorTranslator.FromHtml("#F7A29C");
            Color col_approved = System.Drawing.ColorTranslator.FromHtml("#49F27C");
            Color col_returned = System.Drawing.ColorTranslator.FromHtml("#49de94");
            Color col_rejected = System.Drawing.ColorTranslator.FromHtml("#FF0090 ");
            Color col_revised = System.Drawing.ColorTranslator.FromHtml("#A7B3DB");
            Color col_initiated = System.Drawing.ColorTranslator.FromHtml("#FAF873");
            Color col_completed = System.Drawing.ColorTranslator.FromHtml("#006400");
            Color col_completed_fore = System.Drawing.ColorTranslator.FromHtml("#fffaf0");

            GridDataItem dataItem = e.Item as GridDataItem;
            TableCell cell = (TableCell)dataItem["colRequestStatus"];

            if (dataItem["colRequestStatus"].Text == "Pending")
                cell.BackColor = col_pending;

            if (dataItem["colRequestStatus"].Text == "Revised")
                cell.BackColor = col_revised;

            if (dataItem["colRequestStatus"].Text == "Approved")
                cell.BackColor = col_approved;

            if (dataItem["colRequestStatus"].Text == "returned")
                cell.BackColor = col_returned;

            if (dataItem["colRequestStatus"].Text == "Revised")
                cell.BackColor = col_revised;

            if (dataItem["colRequestStatus"].Text == "Initiated")
                cell.BackColor = col_initiated;

            if (dataItem["colRequestStatus"].Text == "Completed")
            {
                cell.BackColor = col_completed;
                cell.ForeColor = col_completed_fore;
            }

            if (dataItem["collevelcolor"].Text == "True")
                cell.BackColor = col_current;
        }
    }

    #endregion

    #region Tab5 - Approval Requests

    protected void gvApprovedRequests_ItemCreated(object sender, GridItemEventArgs e)
    {
        ImageButton imgBtnView = (ImageButton)e.Item.FindControl("imgBtnView");
        if (imgBtnView != null)
            imgBtnView.Attributes["onclick"] = String.Format("return ShowApprovalViewForm('{0}','{1}','{2}','{3}');", e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["RequestID"], e.Item.ItemIndex, Request.QueryString["FormType"], true);
        ImageButton imgBtnOrgChart = (ImageButton)e.Item.FindControl("imgBtnOrgChart");

        if(imgBtnOrgChart!=null)
        imgBtnOrgChart.Attributes["onclick"] = String.Format("return ShowOrgChart('{0}','{1}');", e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["RequestID"], e.Item.ItemIndex);


    }

    protected void gvApprovedRequests_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == "Print")
        {
            string requestId = clsEncryption.EncryptData(e.CommandArgument.ToString());
            // bring report from formtype
            string rptName = clsEncryption.EncryptData("ReimbursTrxEntryByID");
            ScriptManager.RegisterStartupScript(this, Page.GetType(), "mykey", "ShowReport('" + requestId + "','" + rptName + "');", true);
        }
    }

    protected void gvApprovedRequests_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {
        if (!string.IsNullOrEmpty(Request.QueryString["FormType"]))
        {
            Hashtable ht_submitted = new Hashtable();
            ht_submitted.Add("@UserID", Session["_UserID"].ToString());
            ht_submitted.Add("@FormTypeID", Request.QueryString["FormType"]);

            // datasrouce need to change 
            DataTable dt_approved = clsDAL.GetDataSet("sp_User_Get_Approved_Reimbursment", ht_submitted).Tables[0];
            gvApprovedRequests.DataSource = dt_approved;
        }
    }
  
    protected void gvApprovedRequests_DetailTableDataBind(object sender, GridDetailTableDataBindEventArgs e)
    {
        GridDataItem dataItem = e.DetailTableView.ParentItem;
        switch (e.DetailTableView.Name)
        {
            case "RequestStatuses":
                {
                    string ID = dataItem.GetDataKeyValue("RequestID").ToString();
                    Hashtable ht = new Hashtable();
                    ht.Add("@ReimbursmentID", ID);
                    DataTable dt = clsDAL.GetDataSet("sp_User_Get_Reimbursment_Statuses", ht).Tables[0];
                    dt.TableName = "tbl_Reimbursment_Status";
                    e.DetailTableView.DataSource = dt;
                    e.DetailTableView.DataMember = "tbl_Reimbursment_Status";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowTab", "ShowTab('#tab5');", true);
                    break;
                }
        }
    }

    protected void gvApprovedRequests_ItemDataBound(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridDataItem && e.Item.OwnerTableView.Name == "RequestStatuses")
        {

            Color col_current = System.Drawing.ColorTranslator.FromHtml("#FF0090");
            Color col_pending = System.Drawing.ColorTranslator.FromHtml("#F7A29C");
            Color col_approved = System.Drawing.ColorTranslator.FromHtml("#49F27C");
            Color col_returned = System.Drawing.ColorTranslator.FromHtml("#49de94");
            Color col_rejected = System.Drawing.ColorTranslator.FromHtml("#FF0090 ");
            Color col_revised = System.Drawing.ColorTranslator.FromHtml("#A7B3DB");
            Color col_initiated = System.Drawing.ColorTranslator.FromHtml("#FAF873");
            Color col_completed = System.Drawing.ColorTranslator.FromHtml("#006400");
            Color col_completed_fore = System.Drawing.ColorTranslator.FromHtml("#fffaf0");

            GridDataItem dataItem = e.Item as GridDataItem;
            TableCell cell = (TableCell)dataItem["colRequestStatus"];

            if (dataItem["colRequestStatus"].Text == "Pending")
                cell.BackColor = col_pending;

            if (dataItem["colRequestStatus"].Text == "Revised")
                cell.BackColor = col_revised;

            if (dataItem["colRequestStatus"].Text == "Approved")
                cell.BackColor = col_approved;

            if (dataItem["colRequestStatus"].Text == "returned")
                cell.BackColor = col_returned;

            if (dataItem["colRequestStatus"].Text == "Revised")
                cell.BackColor = col_revised;

            if (dataItem["colRequestStatus"].Text == "Initiated")
                cell.BackColor = col_initiated;

            if (dataItem["colRequestStatus"].Text == "Request Approved")
            {
                cell.BackColor = col_completed;
                cell.ForeColor = col_completed_fore;
            }
            if (dataItem["colRequestStatus"].Text == "Request Rejected")
            {
                cell.BackColor = col_rejected;
                cell.ForeColor = col_completed_fore;
            }
            if (dataItem["colRequestStatus"].Text == "Rejected")
            {
                cell.BackColor = col_rejected;
                cell.ForeColor = col_completed_fore;
            }
            if (dataItem["collevelcolor"].Text == "True")
                cell.BackColor = col_current;
        }
    }
    
    #endregion Tab5 - Approval Requests
}