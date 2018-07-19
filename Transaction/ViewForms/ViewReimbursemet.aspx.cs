using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public partial class Payroll_Transaction_ViewForms_ViewReimbursemet : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string ReimbursementID = " ";
        if (Request.QueryString["ReimbursementID"] != null)
        {
            ReimbursementID = Request.QueryString["ReimbursementID"];
        
            bindCombos();
            if (!string.IsNullOrEmpty(Request.QueryString["ReimbursementID"]))
                bindRecord();

            ShowReadOnlyPage(this.Controls);
        }
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

            rCmbEmployee_SelectedIndexChanged(null, null);

            #endregion Fill Employees
        }
    }

    protected void bindRecord()
    {
        try
        {
            Hashtable ht = new Hashtable();
            ht.Add("@ReimbursmentID", Request.QueryString["ReimbursementID"]);
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

            Hashtable ht_attach = new Hashtable();
            ht_attach.Add("@ID", Request.QueryString["ReimbursementID"]);
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

    protected void rBtnSave_Click(object sender, EventArgs e)
    {
        try
        {
            save(1);
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
            Hashtable ht = new Hashtable();

            ht.Add("@ReimbursementID", Request.QueryString["ReimbursementID"]);
            ht.Add("@isRecalled", bool.Parse(Request.QueryString["isRecalled"]));
            ht.Add("@EmployeeUserID", rCmbEmployee.Items[0].Value);
            ht.Add("@SaveStatus", saveStatus);

            ht.Add("@employeeIDD", rCmbEmployee.Items[0].Value);
            ht.Add("@employeeCode", rCmbEmployee.Items[0].Text);

            ht.Add("@rembusIdd", rCmbReimbursment.Items[0].Value);
            ht.Add("@rembuscod", rCmbReimbursment.Items[0].Text);

            ht.Add("@rembusamt", string.IsNullOrEmpty(txtAmount.Text) ? 0 : Convert.ToDecimal(txtAmount.Text));
            ht.Add("@rembussub1", string.IsNullOrEmpty(txtSub1.Text) ? 0 : Convert.ToDecimal(txtSub1.Text));
            ht.Add("@rembussub2", string.IsNullOrEmpty(txtSub2.Text) ? 0 : Convert.ToDecimal(txtSub2.Text));
            ht.Add("@rembussub3", string.IsNullOrEmpty(txtSub3.Text) ? 0 : Convert.ToDecimal(txtSub3.Text));
            ht.Add("@rembusdsc", txtDescription.Text);
            ht.Add("@rembusdsc1", txtDescription1.Text);
            ht.Add("@rembusdsc2", txtDescription2.Text);
            ht.Add("@rembusdsc3", txtDescription3.Text);

            //ht.Add("@FormTypeID",Request.QueryString["FormType"]);

            ht.Add("@SubmittedByUserID", Convert.ToInt16((string)Session["_UserID"]));
            ht.Add("@DBMessage", "");

            {
                string DBMessage = clsDAL.ExecuteNonQuery("sp_User_Update_Reimbursment", ht, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;

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
                        ht_attachments.Add("@transactionidd", Request.QueryString["ReimbursementID"]);
                        ht_attachments.Add("@transactioncode", hfTransactionNo.Value);
                        ht_attachments.Add("@description", filedsc);

                        ht_attachments["@File"] = imgBinaryData;
                        ht_attachments["@Filetype"] = currentFile.ContentType;
                        ht_attachments["@Filename"] = filename;

                        clsDAL.ExecuteNonQuery(Constraints.sp_User_Insert_Attachment, ht_attachments);
                    }
                }

                if (saveStatus == 2)
                {
                    ht = null;
                    ht = new Hashtable();
                    ht.Add("@ReimbursementID", Request.QueryString["ReimbursementID"]);
                    ht.Add("@RedirectURL", Request.Url.AbsoluteUri);
                    ht.Add("@SubmittedByUserID", Convert.ToInt16((string)Session["_UserID"]));

                    clsCommon.SendMail(3, ht);
                }

                if ((null != DBMessage) && DBMessage.Contains("ERROR:"))
                {
                    ShowClientMessage("Sorry! some error has occurred. Please try again later.", MessageType.Error);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, Page.GetType(), "mykey", "CloseAndRebind();", true);
                }
            }
        }
        catch (Exception ex)
        {
            //ShowMessage(ex.Message, MessageType.Error);
        }
    }

    protected void rBtnSaveAndSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            save(2);
        }
        catch (Exception ex)
        {
            Logger.LogError(ex);
            throw ex;
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

    private void ShowReadOnlyPage(ControlCollection objCtrl)
    {
        try
        {
            
                this.Title = "View Reimbursment Details";
                foreach (Control c in objCtrl)
                {
                    System.Diagnostics.Debug.WriteLine(c.GetType().ToString());
                    DisableControl(c);
                    foreach (Control ctrl in c.Controls)
                    {
                        System.Diagnostics.Debug.WriteLine(ctrl.GetType().ToString());
                        DisableControl(ctrl);
                        if (ctrl.Controls.Count > 0)
                        {
                            ShowReadOnlyPage(ctrl.Controls);
                        }
                    }
                }

                rBtnSave.Visible = false;
                rBtnSaveAndSubmit.Visible = false;
            
        }
        catch (Exception)
        {
            throw;
        }
    }

    private void DisableControl(Control objC)
    {
        try
        {
           
            if (objC is Telerik.Web.UI.RadTextBox)
            {
                Telerik.Web.UI.RadTextBox obj = (Telerik.Web.UI.RadTextBox)objC;
                obj.ReadOnly = true;
            }

            if (objC is Telerik.Web.UI.RadComboBox)
            {
                Telerik.Web.UI.RadComboBox obj = (Telerik.Web.UI.RadComboBox)objC;
                obj.Enabled = false;
                obj.BackColor = Color.White;
                obj.ForeColor = Color.Black;
            }

            if (objC is Telerik.Web.UI.RadNumericTextBox)
            {
                Telerik.Web.UI.RadNumericTextBox obj = (Telerik.Web.UI.RadNumericTextBox)objC;
                obj.ReadOnly = true;
            }

            if (objC is Telerik.Web.UI.RadDatePicker)
            {
                Telerik.Web.UI.RadDatePicker obj = (Telerik.Web.UI.RadDatePicker)objC;
                obj.Enabled = false;
            }

            if (objC is Telerik.Web.UI.DatePickingCalendar)
            {
                Telerik.Web.UI.DatePickingCalendar obj = (Telerik.Web.UI.DatePickingCalendar)objC;
                obj.Enabled = false;
            }

            if (objC is System.Web.UI.WebControls.RadioButtonList)
            {
                System.Web.UI.WebControls.RadioButtonList obj = (System.Web.UI.WebControls.RadioButtonList)objC;
                obj.Enabled = false;
            }

            if (objC is System.Web.UI.WebControls.TextBox)
            {
                System.Web.UI.WebControls.TextBox obj = (System.Web.UI.WebControls.TextBox)objC;
                obj.ReadOnly = true;
            }

            if (objC is Telerik.Web.UI.RadUpload)
            {
                Telerik.Web.UI.RadUpload obj = (Telerik.Web.UI.RadUpload)objC;
                obj.Enabled = false;
            }

            if (objC is Telerik.Web.UI.RadAsyncUpload)
            {
                Telerik.Web.UI.RadAsyncUpload obj = (Telerik.Web.UI.RadAsyncUpload)objC;
                obj.Enabled = false;
            }

            if (objC is Telerik.Web.UI.RadButton)
            {
                Telerik.Web.UI.RadButton obj = (Telerik.Web.UI.RadButton)objC;
                obj.ReadOnly = true;
            }
        }
        catch (Exception)
        {
            throw;
        }
    }

    protected void rCmbEmployee_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
    {
        if (rCmbEmployee.Items[0].Value != null)
        {
            ucEmployeeCard.LoadEmployeeCard(rCmbEmployee.Items[0].Value);
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
        if (e.CommandName == "Download")
        {
            Int32 idd = Convert.ToInt32(e.CommandArgument.ToString());

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
    }

}