using System;
using System.Collections;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using System.Drawing;

public partial class Payroll_AttendanceEntryProject : BasePage
{
    #region Startup
    
    public static Hashtable htSearchParams = null;
    public bool exporting = false;
    int formType = 3169;
    static int RequestID = 0;
    
    protected override void Page_Init(object sender, EventArgs e)
    {
        FormName = "AttendanceT2 ";
        base.Page_Init(sender, e);
        //Response.Cache.SetCacheability(HttpCacheability.NoCache);
        //Response.Cache.SetExpires(DateTime.Now.AddSeconds(-1));
        //Response.Cache.SetNoStore();
    }
    
    protected void Page_Load(object sender, EventArgs e)
    {
        ScriptManager.RegisterStartupScript(this, this.GetType(), "MainFunction", "MainFunction();", true);
        if (!IsPostBack)
        {
            Session["_CurrtrxNumber"] = null;
            RequestID = 0;
            Session["_recidd"] = 0;
            //Session.Abandon();
            ApprovalPanel.Visible = false;
            //Hashtable ht_nextnumber = new Hashtable();
            //ht_nextnumber.Add("@seqcod", "ATTENTRYT2");
            //ht_nextnumber.Add("@TRX_ID", null);
           
            //string trxNo = clsDAL.ExecuteNonQuery("sp_User_Get_Next_Transaction_Number", ht_nextnumber, "@TRX_ID", System.Data.SqlDbType.NVarChar, 255) as string;
            //if (trxNo != null)
            //{
            //    Session["_CurrtrxNumber"] = trxNo;

            //}
            //if (!(Session["_recidd"]== null) && (Convert.ToInt32(Session["_recidd"])>0))
            //{
            //    string trxNo ;
            //    trxNo = Session["_CurrtrxNumber"].ToString() ;

            //    Hashtable ht_currentRequestID = new Hashtable();

            //    ht_currentRequestID.Add("@TRX_ID", trxNo);
            //    ht_currentRequestID.Add("@RequestID", 0);

            //    RequestID = Convert.ToInt32(clsDAL.ExecuteNonQuery("sp_User_Get_AttT2RequestIDFrom_TrxNo", ht_currentRequestID, "@RequestID", System.Data.SqlDbType.Int, 0) as string);
            //}
            Session["_Tab1Function"] = "New";

            if (Request.QueryString["recidd"] != null)
            {
                Session["IdTemplate"] = Request.QueryString["recidd"];
                RequestID = Int32.Parse(Request.QueryString["recidd"]);
                //int requestStatusid = Int32.Parse(arg[1]);
                int requestStatusid = 3;
                Session["_recidd"] = RequestID;

                Hashtable ht_currentTrxNo= new Hashtable();
                ht_currentTrxNo.Add("@RequestID", RequestID);
                ht_currentTrxNo.Add("@TRX_ID", 0);

                string trxNo = clsDAL.ExecuteNonQuery("sp_User_Get_AttT2TrxNoFrom_RequestID", ht_currentTrxNo, "@TRX_ID", System.Data.SqlDbType.NVarChar, 255) as string;

                if (trxNo != null)
                {
                    Session["_CurrtrxNumber"] = trxNo;
                }
                else
                {
                    ShowClientMessage("Empty Transaction Number", MessageType.Error);
                }

                //Session["_CurrtrxNumber"] = clsDAL.ExecuteNonQuery("sp_User_Get_AttT2TrxNoFrom_RequestID", ht_currentTrxNo, "@TRX_ID", System.Data.SqlDbType.NVarChar, 255);
                Session["_Tab1Function"] = "Edit";
                Session["_RequestStatusID"] = requestStatusid;
                gvAtt.Rebind();
                rBtnSave.Visible = false;
                rBtnSaveAndSubmit.Visible = false;
                TopPanel.Visible = false;
                ApprovalPanel.Visible = true;
            }

            Hashtable ht_Reports = new Hashtable();
            ht_Reports.Add("@userid", Session["_UserID"].ToString());
            ht_Reports.Add("@formtypeid", 3169); // Att Setup form type = 3103

            DataTable dt_Reports = clsDAL.GetDataSet_admin("sp_Payroll_Get_Reports", ht_Reports).Tables[0];
            if (ddlPrintOptions != null)
            {
                ddlPrintOptions.DataSource = dt_Reports;
                ddlPrintOptions.DataTextField = "reportname";
                ddlPrintOptions.DataValueField = "idd";
                ddlPrintOptions.DataBind();
                ddlPrintOptions.SelectedIndex = 0;
            }



        }
        else
        {
            //if (!(Session["_recidd"] == null) && (Convert.ToInt32(Session["_recidd"]) > 0))
            //{
            //    RequestID = Convert.ToInt32(Session["_recidd"]);
            //}

        }

        //to set submit btn text and submit btn client message from configuration
        Hashtable htt = new Hashtable();
        DataTable dtConfigs = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_AttEntConfigs", htt).Tables[0];
        if (dtConfigs.Rows.Count > 0)
        {
            if (!string.IsNullOrEmpty(dtConfigs.Rows[0]["btnsubtxt"].ToString()))
            {
            rBtnSaveAndSubmit.Text = dtConfigs.Rows[0]["btnsubtxt"].ToString();
            }
            if (!string.IsNullOrEmpty(dtConfigs.Rows[0]["btnsubmsg"].ToString()))
            {
            hfbtnsubtxt.Value = dtConfigs.Rows[0]["btnsubmsg"].ToString();
        }
        }
        //rBtnSaveAndSubmit.Attributes.Add("onclick", "return confirm('Are you sure you want to do this');");

    }
    
    protected void Page_PreRender(object sender, EventArgs e)
    {
        RadGrid rGrdEmployeeOuter4DDL = ddlEmployeeOuter.Items[0].FindControl("rGrdEmployeeOuter4DDL") as RadGrid;
        RadGrid rGrdHourClassOuter4DDL = ddlHourClassOuter.Items[0].FindControl("rGrdHourClassOuter4DDL") as RadGrid;

        RadAjaxManager1.AjaxSettings.AddAjaxSetting(rGrdEmployeeOuter4DDL, rGrdEmployeeOuter4DDL);
        RadAjaxManager1.AjaxSettings.AddAjaxSetting(rGrdHourClassOuter4DDL, rGrdHourClassOuter4DDL);

        
    }
    
    #endregion
    
    #region  Misc. Functions
    
    public void ShowClientMessage(string message, MessageType type, string redirect = "")
    {
        if (type == MessageType.Error)
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "radalert", "showError('" + message + "', '" + redirect + "', 5000)", true);
        }
        else if (type == MessageType.Success)
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "radalert", "showSuccess('" + message + "', '" + redirect + "', 5000)", true);
        }
        else if (type == MessageType.Warning)
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "radalert", "showWarning('" + message + "', '" + redirect + "', 5000)", true);
        }
        else if (type == MessageType.Info)
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "radalert", "showInfo('" + message + "', '" + redirect + "', 5000)", true);
        }
    }
    
    protected string getImagePathForTrue(string status)
    {
        if (status == "In Process")
            return "~/Images/16x16_process.png";
        if (status == "Request Completed with Approval")
            return "~/Images/16x16_approved.png";
        if (status == "Request Completed with Rejection")
            return "~/Images/16x16_rejected.png";
        
        else
            return "";
    }
    
    protected string GetUserFullName(int EmployeeUserID, string EmployeeFullName)
    {
        if (EmployeeUserID == int.Parse(Session["_UserID"].ToString()))
            return "Self";
        else
            return EmployeeFullName;
    }
    
    protected bool isCompletedVisible(string Last_Status_ID)
    {
        clsCommon.RequestStatus statusID = (clsCommon.RequestStatus)int.Parse(Last_Status_ID);
        
        switch (statusID)
        {
            case clsCommon.RequestStatus.Completed:
                return true;
            
            default:
                return false;
        }
    }
    
    protected bool isEditVisible(string Last_Status_ID, int EmployeeUserID)
    {
        if (!string.IsNullOrEmpty(Last_Status_ID))
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
        else
            return false;
    }
    
    protected bool isInProcessVisible(string Last_Status_ID)
    {
        if (!string.IsNullOrEmpty(Last_Status_ID))
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
        else
            return false;
    }
    
    protected bool isRecallVisible(string Last_Status_ID, int EmployeeUserID)
    {
        if (!string.IsNullOrEmpty(Last_Status_ID))
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
        else
            return false;
    }
    
    protected bool isRejectedVisible(string Last_Status_ID)
    {
        if (!string.IsNullOrEmpty(Last_Status_ID))
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
        else
            return false;
    }
    
    protected bool isSubmitVisible(string Last_Status_ID, int EmployeeUserID)
    {
        if (!string.IsNullOrEmpty(Last_Status_ID))
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
        else
            return false;
    }
    
    public string GetDate()
    {
        return System.DateTime.Now.ToString();
    }
    
    protected void RadAjaxPanel1_AjaxRequest(object sender, AjaxRequestEventArgs e)
    {
        refreshGrids();
    }
    
    public void refreshGrids()
    {
        gvSavedRequests.Rebind();
        gvSubmittedRequests.Rebind();
        gvPendingAppRequests.Rebind();
        gvApprovedRequests.Rebind();
    }
    
    #endregion
    
    #region Tab1 - New Requests
    
    // get value of grid boolean column
    protected bool CheckBoxValue(object value)
    {
        if (Convert.ToString(value) == "1") return true;
        else if (Convert.ToString(value) == "True") return true;
        else if (Convert.ToString(value) == "true") return true;
        
        return false;
    }
    
    protected void rGrdEmployeeOuter4DDL_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {
        htSearchParams = new Hashtable();
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsDAL.GetDataSet_Payroll("sp_payroll_GetAllEmployeeRecords", htSearchParams).Tables[0];
    }
    
    protected void rGrdPremTypeOuter4DDL_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {
        htSearchParams = new Hashtable();
        RadGrid grid = sender as RadGrid;
        htSearchParams.Add("@type",1);

        grid.DataSource = clsDAL.GetDataSet_Payroll("sp_payroll_GetPremiumTypeRecords", htSearchParams).Tables[0];
    }
    
    // Att grid data loading and binding
    protected void gvAtt_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {
        htSearchParams = new Hashtable();
        RequestID = Convert.ToInt32(Session["_recidd"]);
        htSearchParams["@prmtrx"] = RequestID; //Session["_CurrtrxNumber"];
        DataTable dt = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_EmpAtt", htSearchParams).Tables[0];
        dt.TableName = "AttMaster";
        gvAtt.DataSource = dt;
        gvAtt.DataMember = "AttMaster";
    }
    
    protected void gvAtt_PreRender(object sender, EventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        int count = grid.MasterTableView.Items.Count;
        if (count > 0)
        {
            foreach (GridCommandItem item in grid.MasterTableView.GetItems(GridItemType.CommandItem))
            {
                Button btn = (Button)item.FindControl("btnNewEntries");
                btn.Visible = true;
            }
        }
        else
        {
            foreach (GridCommandItem item in grid.MasterTableView.GetItems(GridItemType.CommandItem))
            {
                Button btn = (Button)item.FindControl("btnNewEntries");
                btn.Visible = false;
            }
        }

        //RadGrid rGrdEmployeeOuter4DDL = ddlEmployeeOuter.Items[0].FindControl("rGrdEmployeeOuter4DDL") as RadGrid;
        //RadGrid rGrdHourClassOuter4DDL = ddlHourClassOuter.Items[0].FindControl("rGrdHourClassOuter4DDL") as RadGrid;

        //RadAjaxManager1.AjaxSettings.AddAjaxSetting(rGrdEmployeeOuter4DDL, rGrdEmployeeOuter4DDL);
        //RadAjaxManager1.AjaxSettings.AddAjaxSetting(rGrdHourClassOuter4DDL, rGrdHourClassOuter4DDL);

        //foreach (GridEditableItem item in grid.MasterTableView.GetItems(GridItemType.EditFormItem))
        //{
        //    RadComboBox ddlEmployee = (RadComboBox)item.FindControl("ddlEmployee");
        //    RadGrid rGrdEmployee4DDL = ddlEmployee.Items[0].FindControl("rGrdEmployee4DDL") as RadGrid;
        //    RadAjaxManager1.AjaxSettings.AddAjaxSetting(rGrdEmployee4DDL, rGrdEmployee4DDL);

        //    RadComboBox ddlSubProject = (RadComboBox)item.FindControl("ddlSubProject");
        //    RadGrid rGrdSubProject4DDL = ddlSubProject.Items[0].FindControl("rGrdSubProject4DDL") as RadGrid;
        //    RadAjaxManager1.AjaxSettings.AddAjaxSetting(rGrdSubProject4DDL, rGrdSubProject4DDL);
        //}

        //GridEditableItem editItem = (GridEditableItem)grid.MasterTableView.GetItems(GridItemType.EditFormItem)[0];
        //RadComboBox ddlEmployee = (RadComboBox)editItem.FindControl("ddlEmployee");
        //RadGrid rGrdEmployee4DDL = ddlEmployee.Items[0].FindControl("rGrdEmployee4DDL") as RadGrid;
        //RadAjaxManager1.AjaxSettings.AddAjaxSetting(rGrdEmployee4DDL, rGrdEmployee4DDL);



    }
    
    // grid update command
    protected void gvAtt_UpdateCommand(object sender, GridCommandEventArgs e)
    {
        Insert_or_Update_Att(ref e, "Update");
    }
    
    // grid delete command
    protected void gvAtt_DeleteCommand(object sender, GridCommandEventArgs e)
    {
        GridDataItem item = (GridDataItem)e.Item;
        
        if (e.Item.OwnerTableView.DataMember == "AttMaster")
        {
            Hashtable newValues = new Hashtable();
            newValues["@recidd"] = Int32.Parse(item.GetDataKeyValue("recidd").ToString());
            newValues["@userid"] = Session["_UserID"].ToString();
            clsDAL.ExecuteNonQuery_payroll("sp_User_delete_EmpAttEnt", newValues);
            gvAtt.Rebind();
            ShowClientMessage("Record deleted successfully.", MessageType.Success);
        }
        if (e.Item.OwnerTableView.DataMember == "HourType")
        {
            Hashtable newValues = new Hashtable();
            newValues["@recidd"] = Int32.Parse(item.GetDataKeyValue("recidd").ToString());
            newValues["@userid"] = Session["_UserID"].ToString();
            clsDAL.ExecuteNonQuery_payroll("sp_User_delete_EmpAtt_HrtDetailEnt", newValues);
            ShowClientMessage("Record deleted successfully.", MessageType.Success);
        }
        if (e.Item.OwnerTableView.DataMember == "PremiumType")
        {
            Hashtable newValues = new Hashtable();
            newValues["@recidd"] = Int32.Parse(item.GetDataKeyValue("recidd").ToString());
            newValues["@userid"] = Session["_UserID"].ToString();
            clsDAL.ExecuteNonQuery_payroll("sp_User_delete_EmpAtt_PrtDetailEnt", newValues);
            ShowClientMessage("Record deleted successfully.", MessageType.Success);
        }
        else if (e.Item.OwnerTableView.DataMember == "PremiumType2")
        {
            Hashtable newValues = new Hashtable();
            newValues["@recidd"] = Int32.Parse(item.GetDataKeyValue("recidd").ToString());
            newValues["@userid"] = Session["_UserID"].ToString();
            clsDAL.ExecuteNonQuery_payroll("sp_User_delete_Hrt_PrtDetailEnt", newValues);
            ShowClientMessage("Record deleted successfully.", MessageType.Success);
        }
    }
    
    // client side validation function for Att form
    public void ValidateAtt(GridItemEventArgs e)
    {
        GridEditableItem editForm = (GridEditableItem)e.Item;
        ImageButton update = (ImageButton)editForm.FindControl("UpdateButton");
        ImageButton insert = (ImageButton)editForm.FindControl("PerformInsertButton");
        
        RadComboBox ddlEmployee = (editForm.FindControl("ddlEmployee") as RadComboBox);
        RadComboBox ddlEmpPos = (editForm.FindControl("ddlEmpPos") as RadComboBox);
        RadComboBox ddlProject = (editForm.FindControl("ddlProject") as RadComboBox);
        RadDatePicker dtpDate = (editForm.FindControl("dtpDate") as RadDatePicker);
        //RadTextBox txtattcmt = (editForm.FindControl("txtattcmt") as RadTextBox);
        TextBox txtattcmt = (editForm.FindControl("txtattcmt") as TextBox);
        
        if (update != null)
        {
            update.Attributes.Add("onclick", "return ValidateAtt('" +
                                             ddlEmployee.ClientID + "','" +
                                             ddlEmpPos.ClientID + "','" +
                                             ddlProject.ClientID + "','" +
                                             dtpDate.ClientID + "','" +
                txtattcmt.ClientID
                + "')");
        }
        if (insert != null)
        {
            insert.Attributes.Add("onclick", "return ValidateAtt('" +
                                             ddlEmployee.ClientID + "','" +
                                             ddlEmpPos.ClientID + "','" +
                                             ddlProject.ClientID + "','" +
                                             dtpDate.ClientID + "','" +
                txtattcmt.ClientID
                + "')");
        }
    }
    
    // client side validation function for Hour Type detail form
    public void ValidateHourtype(GridItemEventArgs e)
    {
        GridEditableItem editForm = (GridEditableItem)e.Item;
        ImageButton update = (ImageButton)editForm.FindControl("UpdateButton");
        ImageButton insert = (ImageButton)editForm.FindControl("PerformInsertButton");
        
        RadComboBox ddlHourClass = (editForm.FindControl("ddlHourClass") as RadComboBox);
        RadNumericTextBox txtHours = (editForm.FindControl("txtHours") as RadNumericTextBox);
        
        if (update != null)
        {
            update.Attributes.Add("onclick", "return ValidateHourtype('" +
                                             ddlHourClass.ClientID + "','" +
                txtHours.ClientID
                + "')");
        }
        if (insert != null)
        {
            insert.Attributes.Add("onclick", "return ValidateHourtype('" +
                                             ddlHourClass.ClientID + "','" +
                txtHours.ClientID
                + "')");
        }
    }
    
    // client side validation function for Premium Type detail form
    public void ValidatePremtype(GridItemEventArgs e)
    {
        GridEditableItem editForm = (GridEditableItem)e.Item;
        ImageButton update = (ImageButton)editForm.FindControl("UpdateButton");
        ImageButton insert = (ImageButton)editForm.FindControl("PerformInsertButton");
        
        RadComboBox ddlPremType = (editForm.FindControl("ddlPremType") as RadComboBox);
        RadNumericTextBox txtPremium = (editForm.FindControl("txtPremium") as RadNumericTextBox);
        
        if (update != null)
        {
            update.Attributes.Add("onclick", "return ValidatePremtype('" +
                                             ddlPremType.ClientID + "','" +
                txtPremium.ClientID
                + "')");
        }
        if (insert != null)
        {
            insert.Attributes.Add("onclick", "return ValidatePremtype('" +
                                             ddlPremType.ClientID + "','" +
                txtPremium.ClientID
                + "')");
        }
    }
    
    // client side validation function for Premium Type2 detail form
    public void ValidatePremtype2(GridItemEventArgs e)
    {
        GridEditableItem editForm = (GridEditableItem)e.Item;
        ImageButton update = (ImageButton)editForm.FindControl("UpdateButton");
        ImageButton insert = (ImageButton)editForm.FindControl("PerformInsertButton");

        RadComboBox ddlPremType = (editForm.FindControl("ddlPremType2") as RadComboBox);
        RadNumericTextBox txtPremium = (editForm.FindControl("txtPremium") as RadNumericTextBox);

        if (update != null)
        {
            update.Attributes.Add("onclick", "return ValidatePremtype('" +
                                             ddlPremType.ClientID + "','" +
                txtPremium.ClientID
                + "')");
        }
        if (insert != null)
        {
            insert.Attributes.Add("onclick", "return ValidatePremtype('" +
                                             ddlPremType.ClientID + "','" +
                txtPremium.ClientID
                + "')");
        }
    }
    
    // set form input controls for insert/update
    protected void gvAtt_ItemDataBound(object sender, GridItemEventArgs e)
    {
        RadGrid grid = sender as RadGrid;

        Hashtable htt = new Hashtable();
        DataTable dtConfigs = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_AttEntConfigs", htt).Tables[0];

        if (dtConfigs.Rows.Count > 0)
        {
            if (dtConfigs.Rows[0]["isddlposvis"].ToString() != "True")
            {
                grid.MasterTableView.GetColumn("poscod").Visible = false;
            }
        }

        if (e.Item is GridEditableItem && e.Item.IsInEditMode)
        {
            
            if (e.Item is GridEditFormInsertItem && e.Item.OwnerTableView.IsItemInserted)
            {
                #region Insert
                GridEditFormInsertItem editItem = (GridEditFormInsertItem)e.Item;
                
                if (e.Item.OwnerTableView.DataMember == "AttMaster")
                {
                    #region Att Master
                    try
                    {
                        //to set visibility of ddl employee position according to configuration
                        if (dtConfigs.Rows.Count > 0)
                        {
                            if (dtConfigs.Rows[0]["isddlposvis"].ToString() != "True")
                            {
                                RadComboBox ddlEmpPos = editItem.FindControl("ddlEmpPos") as RadComboBox;
                                if (ddlEmpPos != null)
                                {
                                    (e.Item.FindControl("ddlEmpPos") as RadComboBox).Visible = false;
                                    ddlEmpPos.Parent.Parent.Visible = false;//to hide ddlemppos and its header
                                    (e.Item.FindControl("rfvddlEmpPos") as RequiredFieldValidator).Enabled = false;
                                }
                            }
                        }

                        Label lblprmtrx1 = (Label)editItem.FindControl("lblprmtrx1");
                        
                        if (lblprmtrx1 != null)
                        {
                            lblprmtrx1.Text = Session["_CurrtrxNumber"].ToString();
                        }
                        
                        if (grid.MasterTableView.Items.Count > 0)
                        {
                            RadDatePicker datepicker = (RadDatePicker)editItem.FindControl("dtpDate");
                            if (datepicker != null)
                            {
                                datepicker.SelectedDate = Convert.ToDateTime(grid.Items[grid.MasterTableView.Items.Count - 1].GetDataKeyValue("Date").ToString());
                            }
                        }
                        else
                        {
                            RadDatePicker datepicker = (RadDatePicker)editItem.FindControl("dtpDate");
                            if (datepicker != null)
                            {
                                datepicker.SelectedDate = DateTime.Now;
                            }
                        }
                        
                        if (ddlEmployeeOuter.Items[0].Value != null && rcbEmployeeddl.Checked == true)
                        {
                            RadComboBox ddlemp = (RadComboBox)editItem.FindControl("ddlEmployee");
                            if (ddlemp != null)
                            {
                                string value = ddlEmployeeOuter.Items[0].Value.ToString();
                                string text = ddlEmployeeOuter.Items[0].Text.ToString();
                                ddlemp.Items[0].Value = value;
                                ddlemp.Items[0].Text = text;
                                ddlemp.SelectedValue = value;
                                if (!string.IsNullOrEmpty(text))
                                {
                                    htSearchParams["@employeeCode"] = text;
                                    DataTable dt = clsDAL.GetDataSet_Payroll("sp_User_Get_EmpPosDetail", htSearchParams).Tables[0];
                                    if (dt.Rows.Count > 0)
                                    {
                                        DataRow row = dt.Rows[0];
                                        string id = row[0].ToString();
                                        string code = row[1].ToString();
                                        RadComboBox ddlPos = (RadComboBox)editItem.FindControl("ddlEmpPos");
                                        if (ddlPos != null)
                                        {
                                            ddlPos.Items[0].Value = id;
                                            ddlPos.Items[0].Text = code;
                                            ddlPos.SelectedValue = id;
                                        }
                                    }
                                }
                            }
                        }
                        else if (grid.MasterTableView.Items.Count > 0)
                        {
                            RadComboBox ddlemp = (RadComboBox)editItem.FindControl("ddlEmployee");
                            if (ddlemp != null)
                            {
                                string value = grid.Items[grid.MasterTableView.Items.Count - 1].GetDataKeyValue("empidd").ToString();
                                string text = grid.Items[grid.MasterTableView.Items.Count - 1].GetDataKeyValue("empcod").ToString();
                                ddlemp.Items[0].Value = value;
                                ddlemp.Items[0].Text = text;
                                ddlemp.SelectedValue = value;
                                if (!string.IsNullOrEmpty(text))
                                {
                                    htSearchParams["@employeeCode"] = text;
                                    DataTable dt = clsDAL.GetDataSet_Payroll("sp_User_Get_EmpPosDetail", htSearchParams).Tables[0];
                                    if (dt.Rows.Count > 0)
                                    {
                                        DataRow row = dt.Rows[0];
                                        string id = row[0].ToString();
                                        string code = row[1].ToString();
                                        RadComboBox ddlPos = (RadComboBox)editItem.FindControl("ddlEmpPos");
                                        if (ddlPos != null)
                                        {
                                            ddlPos.Items[0].Value = id;
                                            ddlPos.Items[0].Text = code;
                                            ddlPos.SelectedValue = id;
                                        }
                                    }
                                }
                            }
                        }
                        else
                        {
                            RadComboBox ddlemp = (RadComboBox)editItem.FindControl("ddlEmployee");
                            if (ddlemp != null)
                            {
                                if (!string.IsNullOrEmpty(Session["_UserID"].ToString()))
                                {
                                    string id = Session["_UserID"].ToString();
                                    htSearchParams = new Hashtable();
                                    htSearchParams["@empid"] = id;
                                    DataTable dt = clsDAL.GetDataSet_Payroll("sp_User_Get_EmpCodeByUserId", htSearchParams).Tables[0];
                                    if (dt.Rows.Count > 0)
                                    {
                                        DataRow row = dt.Rows[0];
                                        string idd = row[0].ToString();
                                        string code = row[1].ToString();
                                        
                                        ddlemp.Items[0].Value = idd;
                                        ddlemp.Items[0].Text = code;
                                        ddlemp.SelectedValue = idd;
                                        htSearchParams = new Hashtable();
                                        htSearchParams["@employeeCode"] = code;
                                        DataTable dt1 = clsDAL.GetDataSet_Payroll("sp_User_Get_EmpPosDetail", htSearchParams).Tables[0];
                                        if (dt1.Rows.Count > 0)
                                        {
                                            DataRow row1 = dt1.Rows[0];
                                            string Posid = row1[0].ToString();
                                            string Poscod = row1[1].ToString();
                                            RadComboBox ddlPos = (RadComboBox)editItem.FindControl("ddlEmpPos");
                                            if (ddlPos != null)
                                            {
                                                ddlPos.Items[0].Value = Posid;
                                                ddlPos.Items[0].Text = Poscod;
                                                ddlPos.SelectedValue = Posid;
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        
                        string prjid = "";
                        string prjcod = "";
                        if (ddlProjectOuter.Items[0].Value != null && rcbProject.Checked == true)
                        {
                            prjid = ddlProjectOuter.Items[0].Value.ToString();
                            prjcod = ddlProjectOuter.Items[0].Text.ToString();
                        }
                        else if (grid.MasterTableView.Items.Count > 0)
                        {
                            prjid = grid.Items[grid.MasterTableView.Items.Count - 1].GetDataKeyValue("prjidd").ToString();
                            prjcod = grid.Items[grid.MasterTableView.Items.Count - 1].GetDataKeyValue("prjcod").ToString();
                        }
                        RadComboBox ddlProj = (RadComboBox)e.Item.FindControl("ddlProject");
                        if (ddlProj != null)
                        {
                            RadGrid gridproj = (RadGrid)ddlProj.Items[0].FindControl("rGrdProject4DDL");
                            if (gridproj != null)
                            {
                                gridproj.Rebind();
                                foreach (GridItem item in gridproj.MasterTableView.Items)
                                {
                                    if (item is GridDataItem)
                                    {
                                        if (prjid.Equals(item.OwnerTableView.DataKeyValues[item.ItemIndex]["prjidd"].ToString()))
                                        {
                                            ddlProj.Items[0].Value = prjid;
                                            ddlProj.Items[0].Text = prjcod;
                                            ddlProj.SelectedValue = prjid;
                                            break;
                                        }
                                        else if (item.ItemIndex == 0)
                                        {
                                            ddlProj.Items[0].Value = item.OwnerTableView.DataKeyValues[item.ItemIndex]["prjidd"].ToString();
                                            ddlProj.Items[0].Text = item.OwnerTableView.DataKeyValues[item.ItemIndex]["prjcod"].ToString();
                                            ddlProj.SelectedValue = item.OwnerTableView.DataKeyValues[item.ItemIndex]["prjidd"].ToString();
                                        }
                                    }
                                }
                            }
                        }
                        
                        RadComboBox ddlSubProj = (RadComboBox)e.Item.FindControl("ddlSubProject");
                        if (ddlSubProj != null)
                        {
                            RadGrid SubProjGrid = ddlSubProj.Items[0].FindControl("rGrdSubProject4DDL") as RadGrid;
                            if (SubProjGrid != null)
                            {
                                SubProjGrid.Rebind();
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        ShowClientMessage("Unable to insert master Record. Reason: " + ex.Message, MessageType.Error);
                        e.Canceled = true;
                    }

                    #endregion
                }
                
                if (e.Item.OwnerTableView.DataMember == "PremiumType")
                {
                    #region Premium Type
                    try
                    {
                        ValidatePremtype(e);
                        RadNumericTextBox txtPremium = (RadNumericTextBox)editItem.FindControl("txtPremium");
                        if (txtPremium != null)
                        {
                            txtPremium.Text = "0";
                        }
                        
                        string premid = "";
                        string premcod = "";
                        if (ddlPremTypeOuter.Items[0].Value != null && rcbPremType.Checked == true)
                        {
                            premid = ddlPremTypeOuter.Items[0].Value.ToString();
                            premcod = ddlPremTypeOuter.Items[0].Text.ToString();
                        }
                        else if (e.Item.OwnerTableView.Items.Count > 0)
                        {
                            premid = e.Item.OwnerTableView.Items[e.Item.OwnerTableView.Items.Count - 1].GetDataKeyValue("prtidd").ToString();
                            premcod = e.Item.OwnerTableView.Items[e.Item.OwnerTableView.Items.Count - 1].GetDataKeyValue("prtcod").ToString();
                        }
                        RadComboBox ddlPremTyp = (RadComboBox)editItem.FindControl("ddlPremType");
                        if (ddlPremTyp != null)
                        {
                            RadGrid PremTypeGrid = ddlPremTyp.Items[0].FindControl("rGrdPremType4DDL") as RadGrid;
                            if (PremTypeGrid != null)
                            {
                                foreach (GridItem item in PremTypeGrid.MasterTableView.Items)
                                {
                                    if (item is GridDataItem)
                                    {
                                        if (premid.Equals(item.OwnerTableView.DataKeyValues[item.ItemIndex]["recidd"].ToString()))
                                        {
                                            ddlPremTyp.Items[0].Value = premid;
                                            ddlPremTyp.Items[0].Text = premcod;
                                            ddlPremTyp.SelectedValue = premid;
                                            break;
                                        }
                                        else if (item.ItemIndex == 0)
                                        {
                                            ddlPremTyp.Items[0].Value = item.OwnerTableView.DataKeyValues[item.ItemIndex]["recidd"].ToString();
                                            ddlPremTyp.Items[0].Text = item.OwnerTableView.DataKeyValues[item.ItemIndex]["premtype"].ToString();
                                            ddlPremTyp.SelectedValue = item.OwnerTableView.DataKeyValues[item.ItemIndex]["recidd"].ToString();
                                        }
                                    }
                                }
                            }
                            //ddlPremTyp.Items[0].Value = premid;
                            //ddlPremTyp.Items[0].Text = premcod;
                            //ddlPremTyp.SelectedValue = premid;
                        }
                            
                            GridDataItem ParentItem = editItem.OwnerTableView.ParentItem as GridDataItem;

                            Hashtable ht = new Hashtable();
                            ht["@ID"] = Convert.ToInt32(ddlPremTyp.Items[0].Value);
                            DataTable dt = clsDAL.GetDataSet_Payroll("sp_Payroll_GetPremTypeDtl", ht).Tables[0];
                            
                            if (dt != null)
                            {
                                if (ParentItem.GetDataKeyValue("IsWeekend").ToString() == "1")
                                {
                                    foreach (DataRow row in dt.Rows)
                                    {
                                        if (row["daytcod"].ToString() == "Weekend")
                                        {
                                            if (!string.IsNullOrEmpty(row["defval"].ToString()))
                                            {
                                                txtPremium.Text = row["defval"].ToString();
                                            }
                                            else if (!string.IsNullOrEmpty(row["fromval"].ToString()))
                                            {
                                                txtPremium.Text = row["fromval"].ToString();
                                            }
                                        }
                                    }
                                }
                                else if (ParentItem.GetDataKeyValue("IsPublicHoliday").ToString() == "1")
                                {
                                    foreach (DataRow row in dt.Rows)
                                    {
                                        if (row["daytcod"].ToString() == "Off Day")
                                        {
                                            if (!string.IsNullOrEmpty(row["defval"].ToString()))
                                            {
                                                txtPremium.Text = row["defval"].ToString();
                                            }
                                            else if (!string.IsNullOrEmpty(row["fromval"].ToString()))
                                            {
                                                txtPremium.Text = row["fromval"].ToString();
                                            }
                                        }
                                    }
                                }
                                else
                                {
                                    foreach (DataRow row in dt.Rows)
                                    {
                                        if (row["daytcod"].ToString() == "Working Days")
                                        {
                                            if (!string.IsNullOrEmpty(row["defval"].ToString()))
                                            {
                                                txtPremium.Text = row["defval"].ToString();
                                            }
                                            else if (!string.IsNullOrEmpty(row["fromval"].ToString()))
                                            {
                                                txtPremium.Text = row["fromval"].ToString();
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        catch (Exception ex)
                        {
                            ShowClientMessage("Unable to insert Premium Type Record. Reason: " + ex.Message, MessageType.Error);
                            e.Canceled = true;
                        }
                        #endregion
                    }
                    
                    if (e.Item.OwnerTableView.DataMember == "PremiumType2")
                    {
                        #region Premium Type 2
                        try
                        {
                        ValidatePremtype2(e);
                            RadNumericTextBox txtPremium = (RadNumericTextBox)editItem.FindControl("txtPremium");
                            if (txtPremium != null)
                            {
                                txtPremium.Text = "0";
                            }
                            
                            string premid = "";
                            string premcod = "";
                            if (ddlPremTypeOuter.Items[0].Value != null && rcbPremType.Checked == true)
                            {
                                premid = ddlPremTypeOuter.Items[0].Value.ToString();
                                premcod = ddlPremTypeOuter.Items[0].Text.ToString();
                            }
                            else if (e.Item.OwnerTableView.Items.Count > 0)
                            {
                                premid = e.Item.OwnerTableView.Items[e.Item.OwnerTableView.Items.Count - 1].GetDataKeyValue("prtidd").ToString();
                                premcod = e.Item.OwnerTableView.Items[e.Item.OwnerTableView.Items.Count - 1].GetDataKeyValue("prtcod").ToString();
                            }
                        RadComboBox ddlPremTyp2 = (RadComboBox)editItem.FindControl("ddlPremType2");
                        if (ddlPremTyp2 != null)
                            {
                            RadGrid PremTypeGrid = ddlPremTyp2.Items[0].FindControl("rGrdPremType4DDL") as RadGrid;
                                if (PremTypeGrid != null)
                                {
                                    foreach (GridItem item in PremTypeGrid.MasterTableView.Items)
                                    {
                                        if (item is GridDataItem)
                                        {
                                            if (premid.Equals(item.OwnerTableView.DataKeyValues[item.ItemIndex]["recidd"].ToString()))
                                            {
                                            ddlPremTyp2.Items[0].Value = premid;
                                            ddlPremTyp2.Items[0].Text = premcod;
                                            ddlPremTyp2.SelectedValue = premid;
                                                break;
                                            }
                                            else if (item.ItemIndex == 0)
                                            {
                                            ddlPremTyp2.Items[0].Value = item.OwnerTableView.DataKeyValues[item.ItemIndex]["recidd"].ToString();
                                            ddlPremTyp2.Items[0].Text = item.OwnerTableView.DataKeyValues[item.ItemIndex]["premtype"].ToString();
                                            ddlPremTyp2.SelectedValue = item.OwnerTableView.DataKeyValues[item.ItemIndex]["recidd"].ToString();
                                            }
                                        }
                                    }
                                }
                            //ddlPremTyp2.Items[0].Value = premid;
                            //ddlPremTyp2.Items[0].Text = premcod;
                            //ddlPremTyp2.SelectedValue = premid;
                            }
                            
                            GridDataItem ParentItem = editItem.OwnerTableView.ParentItem as GridDataItem;
                            GridDataItem GrandParentItem = ParentItem.OwnerTableView.ParentItem as GridDataItem;
                            
                            Hashtable ht = new Hashtable();
                        ht["@ID"] = Convert.ToInt32(ddlPremTyp2.Items[0].Value);
                            DataTable dt = clsDAL.GetDataSet_Payroll("sp_Payroll_GetPremTypeDtl", ht).Tables[0];
                            
                            if (dt != null)
                            {
                                if (GrandParentItem.GetDataKeyValue("IsWeekend").ToString() == "1")
                                {
                                    foreach (DataRow row in dt.Rows)
                                    {
                                        if (row["daytcod"].ToString() == "Weekend")
                                        {
                                            if (!string.IsNullOrEmpty(row["defval"].ToString()))
                                            {
                                                txtPremium.Text = row["defval"].ToString();
                                            }
                                            else if (!string.IsNullOrEmpty(row["fromval"].ToString()))
                                            {
                                                txtPremium.Text = row["fromval"].ToString();
                                            }
                                        }
                                    }
                                }
                                else if (GrandParentItem.GetDataKeyValue("IsPublicHoliday").ToString() == "1")
                                {
                                    foreach (DataRow row in dt.Rows)
                                    {
                                        if (row["daytcod"].ToString() == "Off Day")
                                        {
                                            if (!string.IsNullOrEmpty(row["defval"].ToString()))
                                            {
                                                txtPremium.Text = row["defval"].ToString();
                                            }
                                            else if (!string.IsNullOrEmpty(row["fromval"].ToString()))
                                            {
                                                txtPremium.Text = row["fromval"].ToString();
                                            }
                                        }
                                    }
                                }
                                else
                                {
                                    foreach (DataRow row in dt.Rows)
                                    {
                                        if (row["daytcod"].ToString() == "Working Days")
                                        {
                                            if (!string.IsNullOrEmpty(row["defval"].ToString()))
                                            {
                                                txtPremium.Text = row["defval"].ToString();
                                            }
                                            else if (!string.IsNullOrEmpty(row["fromval"].ToString()))
                                            {
                                                txtPremium.Text = row["fromval"].ToString();
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        catch (Exception ex)
                        {
                            ShowClientMessage("Unable to insert Premium Type2 Record . Reason: " + ex.Message, MessageType.Error);
                            e.Canceled = true;
                        }
                        #endregion
                    }

                    if (e.Item.OwnerTableView.DataMember == "HourType")
                    {
                        #region Hour Type
                        try
                        {
                            GridDataItem parentItem = (GridDataItem)(e.Item.OwnerTableView.ParentItem);
                            
                            if (parentItem != null)
                            {
                                string empid = parentItem.OwnerTableView.DataKeyValues[parentItem.ItemIndex]["empidd"].ToString();
                                Session["_Empid"] = empid;
                                RadComboBox ddlHrCls = (RadComboBox)e.Item.FindControl("ddlHourClass");
                                RadGrid gridHrCls = (RadGrid)ddlHrCls.Items[0].FindControl("rGrdHourClass4DDL");
                                gridHrCls.Rebind();
                            }
                            ValidateHourtype(e);
                            
                            RadNumericTextBox txtHours = (RadNumericTextBox)editItem.FindControl("txtHours");
                            if (txtHours != null)
                            {
                                txtHours.Text = "0";
                            }
                            
                            string hcid = "";
                            string hccode = "";
                            if (ddlHourClassOuter.Items[0].Value != null && rcbHourClass.Checked == true)
                            {
                                hcid = ddlHourClassOuter.Items[0].Value.ToString();
                                hccode = ddlHourClassOuter.Items[0].Text.ToString();
                            }
                            else if (e.Item.OwnerTableView.Items.Count > 0)
                            {
                                hcid = e.Item.OwnerTableView.Items[e.Item.OwnerTableView.Items.Count - 1].GetDataKeyValue("hrclsidd").ToString();
                                hccode = e.Item.OwnerTableView.Items[e.Item.OwnerTableView.Items.Count - 1].GetDataKeyValue("hrclscod").ToString();
                            }
                            RadComboBox ddlhourclass = (RadComboBox)editItem.FindControl("ddlHourClass");
                            if (ddlhourclass != null)
                            {
                                RadGrid HourClassGrid = ddlhourclass.Items[0].FindControl("rGrdHourClass4DDL") as RadGrid;
                                if (HourClassGrid != null)
                                {
                                    foreach (GridItem item in HourClassGrid.MasterTableView.Items)
                                    {
                                        if (item is GridDataItem)
                                        {
                                            if (hcid.Equals(item.OwnerTableView.DataKeyValues[item.ItemIndex]["hrtidd"].ToString()))
                                            {
                                                ddlhourclass.Items[0].Value = hcid;
                                                ddlhourclass.Items[0].Text = hccode;
                                                ddlhourclass.SelectedValue = hcid;
                                                break;
                                            }
                                            else if (item.ItemIndex == 0)
                                            {
                                                ddlhourclass.Items[0].Value = item.OwnerTableView.DataKeyValues[item.ItemIndex]["hrtidd"].ToString();
                                                ddlhourclass.Items[0].Text = item.OwnerTableView.DataKeyValues[item.ItemIndex]["hrtcod"].ToString();
                                                ddlhourclass.SelectedValue = item.OwnerTableView.DataKeyValues[item.ItemIndex]["hrtidd"].ToString();
                                            }
                                        }
                                    }
                                }
                            }
                            
                            Hashtable ht = new Hashtable();
                            if (!String.IsNullOrEmpty(ddlhourclass.Items[0].Value.ToString()))
                            {
                                ht["@ID"] = Convert.ToInt32(ddlhourclass.Items[0].Value);
                                DataTable dt = clsDAL.GetDataSet_Payroll("sp_Payroll_GetHourTypeById", ht).Tables[0];
                                
                                if (dt != null)
                                {
                                    foreach (DataRow row in dt.Rows)
                                    {
                                        if (!string.IsNullOrEmpty(row["defval"].ToString()))
                                        {
                                            txtHours.Text = row["defval"].ToString();
                                        }
                                        else if (!string.IsNullOrEmpty(row["fromval"].ToString()))
                                        {
                                            txtHours.Text = row["fromval"].ToString();
                                        }
                                        else
                                        {
                                            txtHours.Text = "0";
                                        }
                                    }
                                }
                            }
                        }
                        catch (Exception ex)
                        {
                            ShowClientMessage("Unable to insert Hour Type Record. Reason: " + ex.Message, MessageType.Error);
                            e.Canceled = true;
                        }
                        #endregion
                    }
                    #endregion
                }
                else
                {
                    #region Update
                    if (e.Item.OwnerTableView.DataMember == "AttMaster")
                    {
                        #region Att Master
                        try
                        {
                            if (dtConfigs.Rows.Count > 0)
                            {
                                if (dtConfigs.Rows[0]["isddlposvis"].ToString() != "True")
                                {
                                    RadComboBox ddlEmpPos = e.Item.FindControl("ddlEmpPos") as RadComboBox;
                                    if (ddlEmpPos != null)
                                    {
                                        (e.Item.FindControl("ddlEmpPos") as RadComboBox).Visible = false;
                                        ddlEmpPos.Parent.Parent.Visible = false;//to hide ddlemppos and its header
                                        (e.Item.FindControl("rfvddlEmpPos") as RequiredFieldValidator).Enabled = false;
                                    }
                                }
                            }
                            (e.Item.FindControl("ddlEmployee") as RadComboBox).Items[0].Value = DataBinder.Eval(e.Item.DataItem, "empidd").ToString();
                            (e.Item.FindControl("ddlEmployee") as RadComboBox).Items[0].Text = DataBinder.Eval(e.Item.DataItem, "empcod").ToString();
                            (e.Item.FindControl("ddlEmployee") as RadComboBox).SelectedValue = DataBinder.Eval(e.Item.DataItem, "empidd").ToString();
                            (e.Item.FindControl("ddlEmployee") as RadComboBox).Enabled = false;
                            
                            (e.Item.FindControl("ddlEmpPos") as RadComboBox).Items[0].Value = DataBinder.Eval(e.Item.DataItem, "posidd").ToString();
                            (e.Item.FindControl("ddlEmpPos") as RadComboBox).Items[0].Text = DataBinder.Eval(e.Item.DataItem, "poscod").ToString();
                            (e.Item.FindControl("ddlEmpPos") as RadComboBox).SelectedValue = DataBinder.Eval(e.Item.DataItem, "posidd").ToString();
                            
                            RadComboBox ddlprj = (RadComboBox)e.Item.FindControl("ddlProject");
                            RadGrid gridprj = (RadGrid)ddlprj.Items[0].FindControl("rGrdProject4DDL");
                            gridprj.Rebind();
                            (e.Item.FindControl("ddlProject") as RadComboBox).Items[0].Value = DataBinder.Eval(e.Item.DataItem, "prjidd").ToString();
                            (e.Item.FindControl("ddlProject") as RadComboBox).Items[0].Text = DataBinder.Eval(e.Item.DataItem, "prjcod").ToString();
                            (e.Item.FindControl("ddlproject") as RadComboBox).SelectedValue = DataBinder.Eval(e.Item.DataItem, "prjidd").ToString();
                            RadComboBox ddlSubProj = (RadComboBox)e.Item.FindControl("ddlSubProject");
                            if (ddlSubProj != null)
                            {
                                RadGrid SubProjGrid = ddlSubProj.Items[0].FindControl("rGrdSubProject4DDL") as RadGrid;
                                if (SubProjGrid != null)
                                {
                                    SubProjGrid.Rebind();
                                }
                            }

                            (e.Item.FindControl("ddlSubProject") as RadComboBox).Items[0].Value = DataBinder.Eval(e.Item.DataItem, "subprjidd").ToString();
                            (e.Item.FindControl("ddlSubProject") as RadComboBox).Items[0].Text = DataBinder.Eval(e.Item.DataItem, "subprjcod").ToString();
                            (e.Item.FindControl("ddlSubproject") as RadComboBox).SelectedValue = DataBinder.Eval(e.Item.DataItem, "subprjidd").ToString();
                        }
                        catch (Exception ex)
                        {
                            ShowClientMessage("Unable to update Master Record. Reason: " + ex.Message, MessageType.Error);
                            e.Canceled = true;
                        }
                        #endregion
                    }
                    
                if (e.Item.OwnerTableView.DataMember == "PremiumType" )
                    {
                    #region Premium Type 
                        try
                        {
                            ValidatePremtype(e);
                            (e.Item.FindControl("ddlPremType") as RadComboBox).Items[0].Value = DataBinder.Eval(e.Item.DataItem, "prtidd").ToString();
                            (e.Item.FindControl("ddlPremType") as RadComboBox).Items[0].Text = DataBinder.Eval(e.Item.DataItem, "prtcod").ToString();
                            (e.Item.FindControl("ddlPremType") as RadComboBox).SelectedValue = DataBinder.Eval(e.Item.DataItem, "prtidd").ToString();
                        }
                        catch (Exception ex)
                        {
                            ShowClientMessage("Unable to update Premium Type Record. Reason: " + ex.Message, MessageType.Error);
                            e.Canceled = true;
                        }
                    #endregion
                }
                        
                if (e.Item.OwnerTableView.DataMember == "PremiumType2")
                {
                    #region Premium Type 2
                    try
                    {
                        ValidatePremtype2(e);
                        (e.Item.FindControl("ddlPremType2") as RadComboBox).Items[0].Value = DataBinder.Eval(e.Item.DataItem, "prtidd").ToString();
                        (e.Item.FindControl("ddlPremType2") as RadComboBox).Items[0].Text = DataBinder.Eval(e.Item.DataItem, "prtcod").ToString();
                        (e.Item.FindControl("ddlPremType2") as RadComboBox).SelectedValue = DataBinder.Eval(e.Item.DataItem, "prtidd").ToString();
                    }
                    catch (Exception ex)
                    {
                        ShowClientMessage("Unable to update Premium Type2 Record. Reason: " + ex.Message, MessageType.Error);
                        e.Canceled = true;
                    }
                        #endregion
                    }
                    if (e.Item.OwnerTableView.DataMember == "HourType")
                    {
                        #region Hour Type
                        try
                        {
                            GridDataItem parentItem = (GridDataItem)(e.Item.OwnerTableView.ParentItem);
                            
                            if (parentItem != null)
                            {
                                string empid = parentItem.OwnerTableView.DataKeyValues[parentItem.ItemIndex]["empidd"].ToString();
                                Session["_Empid"] = empid;
                                RadComboBox ddlHrCls = (RadComboBox)e.Item.FindControl("ddlHourClass");
                                RadGrid gridHrCls = (RadGrid)ddlHrCls.Items[0].FindControl("rGrdHourClass4DDL");
                                gridHrCls.Rebind();
                            }
                            ValidateHourtype(e);
                            (e.Item.FindControl("ddlHourClass") as RadComboBox).Items[0].Value = DataBinder.Eval(e.Item.DataItem, "hrclsidd").ToString();
                            (e.Item.FindControl("ddlHourClass") as RadComboBox).Items[0].Text = DataBinder.Eval(e.Item.DataItem, "hrclscod").ToString();
                            (e.Item.FindControl("ddlHourClass") as RadComboBox).SelectedValue = DataBinder.Eval(e.Item.DataItem, "hrclsidd").ToString();
                        }
                        catch (Exception ex)
                        {
                            ShowClientMessage("Unable to update Hour Type Record. Reason: " + ex.Message, MessageType.Error);
                            e.Canceled = true;
                        }
                    #endregion
                        
                    }
                    #endregion
                }
                
                if (e.Item.OwnerTableView.DataMember == "AttMaster")
                {
                    (e.Item as GridEditableItem)["IsWeekend"].Parent.Visible = false;
                    (e.Item as GridEditableItem)["IsPublicHoliday"].Parent.Visible = false;
                    ValidateAtt(e);
                }
            }
            
            // color days
            if (e.Item is GridDataItem)
            {
                if (e.Item.OwnerTableView.DataMember == "AttMaster")
                {
                    GridDataItem dataItem = (GridDataItem)e.Item;
                    if (dataItem["IsWeekend"].Text == "1")
                    {
                        dataItem.BackColor = System.Drawing.Color.Silver;
                    }
                    if (dataItem["IsPublicHoliday"].Text == "1")
                    {
                        dataItem.BackColor = System.Drawing.Color.GreenYellow;
                    }
                }
            }
            
            if (e.Item is GridCommandItem)
            {
                GridCommandItem commandItem = (GridCommandItem)e.Item;
                RadComboBox ddlPrintOptions = (RadComboBox)commandItem.FindControl("ddlPrintOptions");
                if (ddlPrintOptions != null)
                {
                    Hashtable ht_Reports = new Hashtable();
                    ht_Reports.Add("@userid", Session["_UserID"].ToString());
                    ht_Reports.Add("@formtypeid", 3169); // Att Setup form type = 3103
                
                    DataTable dt_Reports = clsDAL.GetDataSet_admin("sp_Payroll_Get_Reports", ht_Reports).Tables[0];
                    if (ddlPrintOptions != null)
                    {
                        ddlPrintOptions.DataSource = dt_Reports;
                        ddlPrintOptions.DataTextField = "reportname";
                        ddlPrintOptions.DataValueField = "idd";
                        ddlPrintOptions.DataBind();
                        ddlPrintOptions.SelectedIndex = 0;
                    }
                }
            }
        }
    
    // clear grid input form for insert/update
    // exporting functions
    protected void gvAtt_ItemCommand(object sender, GridCommandEventArgs e)
    {
        RadGrid grid = (sender as RadGrid);
        if (e.CommandName == "ExpandCollapse")
        {

        }

        if (e.CommandName == "InitInsert" && e.Item.OwnerTableView.DataMember == "HourType")
        {
            if (Session["_Empid"] != null)
            {
                Session["_Empid"] = null;
            }
        }
        
        if (e.CommandName == "ExpandCollapse" && e.Item.OwnerTableView.DataMember == "AttMaster")
        {
            if (e.Item.Expanded)
            {
            }
            else
            {
                foreach (GridItem item in e.Item.OwnerTableView.Items)
                {
                    if (item.Expanded && item != e.Item)
                    {
                        GridDataItem item1 = (GridDataItem)e.Item;
                        if (item1 is GridDataItem)
                        {
                            GridTableView detailtable = (GridTableView)item1.ChildItem.NestedTableViews[0];
                            detailtable.IsItemInserted = false;
                            detailtable.Rebind(); 
                        }
                        item.Expanded = false;
                    }
                  
                }
            }
        }
        if (e.CommandName == "Print")
        {
            string requestId = clsEncryption.EncryptData(RequestID.ToString());
            string rptName="";

            GridCommandItem commandItem = (GridCommandItem)e.Item;
            RadComboBox ddlPrintOptions = (RadComboBox)commandItem.FindControl("ddlPrintOptions");
            if (ddlPrintOptions != null)
            {
                {
                    rptName = clsEncryption.EncryptData(ddlPrintOptions.SelectedItem.Text);
                }
            }


            // bring report from formtype
            ScriptManager.RegisterStartupScript(this, Page.GetType(), "mykey", "ShowReport('" + requestId + "','" + rptName + "');", true);
        }
        if (e.CommandName == "CopyToToday")
        {
            #region Copy To Today Command
            GridDataItem item = e.Item as GridDataItem;
            try
            {
                Hashtable newValues = new Hashtable();
                newValues["@recidd"] = Convert.ToInt32(item.GetDataKeyValue("recidd").ToString());
                newValues["@empidd"] = Convert.ToInt32(item.GetDataKeyValue("empidd").ToString());
                newValues["@empcod"] = item.GetDataKeyValue("empcod").ToString();
                
                newValues["@posidd"] = Convert.ToInt32(item.GetDataKeyValue("posidd").ToString());
                newValues["@poscod"] = item.GetDataKeyValue("poscod").ToString();
                
                newValues["@prjidd"] = Convert.ToInt32(item.GetDataKeyValue("prjidd").ToString());
                newValues["@prjcod"] = item.GetDataKeyValue("prjcod").ToString();

                if (!string.IsNullOrEmpty(item.GetDataKeyValue("subprjidd").ToString()))
                {
                    newValues["@subprjidd"] = Convert.ToInt32(item.GetDataKeyValue("subprjidd").ToString());
                    newValues["@subprjcod"] = item.GetDataKeyValue("subprjcod").ToString();
                }
                newValues["@attdat"] = item.GetDataKeyValue("Date").ToString();
                
                newValues["@attcmt"] = item.GetDataKeyValue("attcmt").ToString();
                newValues["@atttyp"] = 1;
                newValues["@atttcd"] = "Daily";
                
                newValues["@DBMessage"] = "";
                newValues["@prmtrx"] = Session["_CurrtrxNumber"];
                newValues["@subtrx"] = "subtrans";
                newValues["@userid"] = Session["_UserID"].ToString();
                newValues["@requestdate"] = DateTime.Now;
                
                string DBMessage = "";
                
                DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_payroll_Copy_EmpAtt_Record", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                
                if ((null != DBMessage) && DBMessage.Contains("ERROR:"))
                {
                    ShowClientMessage(DBMessage, MessageType.Error);
                    e.Canceled = true;
                }
                else
                {
                    ShowClientMessage("Record copied/saved successfully.", MessageType.Success);
                    gvAtt.Rebind();
                }
            }
            catch (Exception ex)
            {
                ShowClientMessage("Unable to copy/insert Record . Reason: " + ex.Message, MessageType.Error);
                e.Canceled = true;
            }
            gvAtt.Rebind();
            #endregion
        }
        
        if (e.CommandName == "CopyToTomorrow")
        {
            #region Copy To Tomorrow Command
            GridDataItem item = e.Item as GridDataItem;
            try
            {
                Hashtable newValues = new Hashtable();
                newValues["@recidd"] = Convert.ToInt32(item.GetDataKeyValue("recidd").ToString());
                newValues["@empidd"] = Convert.ToInt32(item.GetDataKeyValue("empidd").ToString());
                newValues["@empcod"] = item.GetDataKeyValue("empcod").ToString();
                newValues["@posidd"] = Convert.ToInt32(item.GetDataKeyValue("posidd").ToString());
                newValues["@poscod"] = item.GetDataKeyValue("poscod").ToString();
                newValues["@prjidd"] = Convert.ToInt32(item.GetDataKeyValue("prjidd").ToString());
                newValues["@prjcod"] = item.GetDataKeyValue("prjcod").ToString();

                if (!string.IsNullOrEmpty(item.GetDataKeyValue("subprjidd").ToString()))
                {
                    newValues["@subprjidd"] = Convert.ToInt32(item.GetDataKeyValue("subprjidd").ToString());
                    newValues["@subprjcod"] = item.GetDataKeyValue("subprjcod").ToString();
                }
                newValues["@attdat"] = Convert.ToDateTime(item.GetDataKeyValue("Date").ToString()).AddDays(1); 
                newValues["@attcmt"] = item.GetDataKeyValue("attcmt").ToString();
                newValues["@atttyp"] = 1;
                newValues["@atttcd"] = "Daily";
                newValues["@DBMessage"] = "";
                newValues["@prmtrx"] = Session["_CurrtrxNumber"];
                newValues["@subtrx"] = "subtrans";
                newValues["@userid"] = Session["_UserID"].ToString();
                newValues["@requestdate"] = DateTime.Now;
                
                string DBMessage = "";
                
                DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_payroll_Copy_EmpAtt_Record", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                
                if ((null != DBMessage) && DBMessage.Contains("ERROR:"))
                {
                    ShowClientMessage(DBMessage, MessageType.Error);
                    e.Canceled = true;
                }
                else
                {
                    ShowClientMessage("Record copied/saved successfully.", MessageType.Success);
                    gvAtt.Rebind();
                }
            }
            catch (Exception ex)
            {
                ShowClientMessage("Unable to copy/insert Record. Reason: " + ex.Message, MessageType.Error);
                e.Canceled = true;
            }
            gvAtt.Rebind();
            #endregion
        }
        if (e.CommandName == "CopyToN")
        {
            #region Copy To N Command
            GridDataItem item = e.Item as GridDataItem;
            try
            {
                // geting the AttEntConfigs Data
                Hashtable ht = new Hashtable();
                DataTable dt = clsDAL.GetDataSet_Payroll("[sp_Payroll_Get_AttEntConfigs]", ht).Tables[0];
                int copyNValue = 0;
                bool isFriOff = false;
                bool isSatOff = false;
                bool isSunOff = false;
                if (dt != null && dt.Rows.Count > 0)
                {
                    copyNValue = dt.Rows[0]["copyNvalue"].ToString() == "" ? 0 : Convert.ToInt32(dt.Rows[0]["copyNvalue"]);
                    isFriOff = dt.Rows[0]["isFriOff"].ToString() == "" ? false : Convert.ToBoolean(dt.Rows[0]["isFriOff"].ToString());
                    isSatOff = dt.Rows[0]["isSatOff"].ToString() == "" ? false : Convert.ToBoolean(dt.Rows[0]["isSatOff"].ToString());
                    isSunOff = dt.Rows[0]["isSunOff"].ToString() == "" ? false : Convert.ToBoolean(dt.Rows[0]["isSunOff"].ToString());
                }

                Hashtable newValues = new Hashtable();
                newValues["@recidd"] = Convert.ToInt32(item.GetDataKeyValue("recidd").ToString());
                newValues["@empidd"] = Convert.ToInt32(item.GetDataKeyValue("empidd").ToString());
                newValues["@empcod"] = item.GetDataKeyValue("empcod").ToString();
                newValues["@posidd"] = Convert.ToInt32(item.GetDataKeyValue("posidd").ToString());
                newValues["@poscod"] = item.GetDataKeyValue("poscod").ToString();
                newValues["@prjidd"] = Convert.ToInt32(item.GetDataKeyValue("prjidd").ToString());
                newValues["@prjcod"] = item.GetDataKeyValue("prjcod").ToString();

                if (!string.IsNullOrEmpty(item.GetDataKeyValue("subprjidd").ToString()))
                {
                    newValues["@subprjidd"] = Convert.ToInt32(item.GetDataKeyValue("subprjidd").ToString());
                    newValues["@subprjcod"] = item.GetDataKeyValue("subprjcod").ToString();
                }
                newValues["@attcmt"] = item.GetDataKeyValue("attcmt").ToString();
                newValues["@atttyp"] = 1;
                newValues["@atttcd"] = "Daily";
                newValues["@DBMessage"] = "";
                newValues["@prmtrx"] = Session["_CurrtrxNumber"];
                newValues["@subtrx"] = "subtrans";
                newValues["@userid"] = Session["_UserID"].ToString();
                newValues["@requestdate"] = DateTime.Now;
                newValues["@attdat"] = item.GetDataKeyValue("Date").ToString();

                string DBMessage = "";

                for (int i = 1; i <= copyNValue; i++)
                {
                    DateTime attdat = Convert.ToDateTime(newValues["@attdat"].ToString()).AddDays(1);

                    if (attdat.ToString("ddd") == "Fri")
                    {
                        if(isFriOff)
                        {
                            attdat = Convert.ToDateTime(attdat).AddDays(1);
                        }
                    }
                    if (attdat.ToString("ddd") == "Sat")
                    {
                        if (isSatOff)
                        {
                            attdat = Convert.ToDateTime(attdat).AddDays(1);
                        }
                    }
                    if (attdat.ToString("ddd") == "Sun")
                    {
                        if (isSunOff)
                        {
                            attdat = Convert.ToDateTime(attdat).AddDays(1);
                        }
                    }

                    newValues["@attdat"] = attdat;
                    DBMessage += clsDAL.ExecuteNonQuery_payroll("sp_payroll_Copy_EmpAtt_Record", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                    DBMessage += "<br/>";
                }

                if ((null != DBMessage) && DBMessage.Contains("ERROR:"))
                {
                    ShowClientMessage(DBMessage, MessageType.Error);
                    e.Canceled = true;
                }
                else
                {
                    ShowClientMessage("Record copied/saved successfully.", MessageType.Success);
                    gvAtt.Rebind();
                }
            }
            catch (Exception ex)
            {
                ShowClientMessage("Unable to copy/insert Record. Reason: " + ex.Message, MessageType.Error);
                e.Canceled = true;
            }
            gvAtt.Rebind();
            #endregion
        }
        
        if (e.CommandName == "UpdateAll")
        {
            #region Update All Command
            try
            {
                string DBMessage = "";
                foreach (GridDataItem item in grid.MasterTableView.Items)
                {
                    Hashtable newValues = new Hashtable();
                    newValues["@recidd"] = Convert.ToInt32(item.GetDataKeyValue("recidd").ToString());
                    newValues["@employeeIDD"] = Convert.ToInt32(item.GetDataKeyValue("empidd").ToString());
                    newValues["@attdat"] = item.GetDataKeyValue("Date").ToString();
                    newValues["@DBMessage"] = "";
                    DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Update_EmpAttNormalHours", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                }
                
                if ((null != DBMessage) && DBMessage.Contains("ERROR:"))
                {
                    ShowClientMessage(DBMessage, MessageType.Error);
                    e.Canceled = true;
                }
                else
                {
                    ShowClientMessage("Record updated successfully.", MessageType.Success);
                    gvAtt.Rebind();
                }
            }
            catch (Exception ex)
            {
                ShowClientMessage("Unable to update Record. Reason: " + ex.Message, MessageType.Error);
                e.Canceled = true;
            }
            #endregion
        }
        
        if (e.CommandName == RadGrid.InitInsertCommandName && e.Item.OwnerTableView.DataMember == "AttMaster")
        {
                grid.MasterTableView.ClearEditItems();


            if (grid.MasterTableView.Items.Count == 0)
            {
            Hashtable ht_nextnumber = new Hashtable();
            ht_nextnumber.Add("@seqcod", "ATTENTRYT2");
            ht_nextnumber.Add("@TRX_ID", null);
                
                string trxNo = clsDAL.ExecuteNonQuery("sp_User_Get_Next_Transaction_Number", ht_nextnumber, "@TRX_ID", System.Data.SqlDbType.NVarChar, 255) as string;
           
            if (trxNo != null)
            {
                Session["_CurrtrxNumber"] = trxNo;
            }
            else 
            {
                ShowClientMessage("Sequence configuration missing", MessageType.Error);
            }
            }
                
            }

        if (e.CommandName == RadGrid.EditCommandName)
        {
            e.Item.OwnerTableView.IsItemInserted = false;
            
            if (e.Item.OwnerTableView.DataMember == "HourType")
            {
                if (Session["_Empid"] != null)
                {
                    Session["_Empid"] = null;
                }
            }
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
            grid.ExportSettings.ExportOnlyData = true;
            grid.ExportSettings.HideStructureColumns = true;
            
            foreach (GridDataItem item in grid.Items)
            {
                item["ExpandColumn"].Visible = false;
            }
            
            if (e.Item.OwnerTableView.DataMember == "AttMaster")
            {
                grid.MasterTableView.GetColumn("EditFiles").Visible = false;
                grid.MasterTableView.ExportToExcel();
            }
            else if (e.Item.OwnerTableView.DataMember == "AttendanceDetail")
            {
                GridTableHierarchySetEditability(grid.MasterTableView, true);
                grid.MasterTableView.ExportToExcel();
            }
        }
        
        if (e.CommandName == RadGrid.ExportToCsvCommandName)
        {
            exporting = true;
            grid.GridLines = GridLines.Both;
            grid.BorderStyle = BorderStyle.Solid;
            grid.BorderWidth = Unit.Pixel(1);
            grid.ExportSettings.ExportOnlyData = false;
            grid.MasterTableView.EnableHierarchyExpandAll = false;
            
            foreach (GridDataItem item in grid.Items)
            {
                item["ExpandColumn"].Visible = false;
            }
            
            if (e.Item.OwnerTableView.DataMember == "AttMaster")
            {
                grid.MasterTableView.GetColumn("EditFiles").Visible = false;
            }
            else if (e.Item.OwnerTableView.DataMember == "AttendanceDetail")
            {
                GridTableHierarchySetEditability(grid.MasterTableView, true);
            }
            grid.MasterTableView.ExportToCSV();
        }
        
        if (e.CommandName == RadGrid.ExportToPdfCommandName)
        {
            exporting = true;
            grid.GridLines = GridLines.Both;
            grid.BorderStyle = BorderStyle.Solid;
            grid.BorderWidth = Unit.Pixel(1);
            
            foreach (GridDataItem item in grid.Items)
            {
                item["ExpandColumn"].Visible = false;
            }
            
            if (e.Item.OwnerTableView.DataMember == "AttMaster")
            {
                grid.MasterTableView.GetColumn("EditFiles").Visible = false;
            }
            else if (e.Item.OwnerTableView.DataMember == "AttendanceDetail")
            {
                GridTableHierarchySetEditability(grid.MasterTableView, true);
            }
            grid.MasterTableView.ExportToPdf();
        }
    }
    
    // export formating function
    protected void GridTableHierarchySetEditability(GridTableView view, bool editAllowed)
    {
        foreach (GridFilteringItem item in view.GetItems(GridItemType.FilteringItem))
            item.Visible = false;
        
        foreach (GridHeaderItem item in view.GetItems(GridItemType.Header))
        {
            if (item.Cells[0].Text == "&nbsp;")
            {
                item.Cells[0].Visible = false;
            }
        }
        
        //If editing is not allowed, remove any edit or command-button columns.  
        if (editAllowed)
        {
            //Remove editing columns in the current view  
            foreach (GridColumn column in view.Columns)
            {
                if (column.UniqueName == "ExpandColumn")
                {
                    column.Display = false;
                    column.Visible = false;
                }
                
                if (column.UniqueName == "EditFiles" || column.UniqueName == "DeleteFiles")
                {
                    column.Display = false;
                    column.Visible = false;
                }
            }
        }
        
        if (view.HasDetailTables)
        {
            foreach (GridDataItem item in view.Items)
            {
                if (item.HasChildItems)
                {
                    foreach (GridTableView innerView in item.ChildItem.NestedTableViews)
                    {
                        GridTableHierarchySetEditability(innerView, true);
                    }
                }
            }
        }
    }
    
    // export formating functions
    void HideCommandColumns(GridTableView gridTableView)
    {
        foreach (GridNestedViewItem nestedViewItem in gridTableView.GetItems(GridItemType.NestedView))
        {
            if (nestedViewItem.NestedTableViews.Length > 0)
            {
                foreach (GridColumn column in gridTableView.Columns)
                {
                    if (column.UniqueName == "EditAttendanceDetail" || column.UniqueName == "DeleteAttendanceDetail")
                    {
                        column.Display = false;
                        column.Visible = false;
                    }
                }
                HideCommandColumns(nestedViewItem.NestedTableViews[0]);
            }
        }
    }
    
    // grid insert command
    protected void gvAtt_InsertCommand(object sender, GridCommandEventArgs e)
    {
        Insert_or_Update_Att(ref e, "Insert");
    }
    
    // insert/update function
    private void Insert_or_Update_Att(ref GridCommandEventArgs e, string operation)
    {
        GridEditableItem editedItem = e.Item as GridEditableItem;
        try
        {
            if (e.Item.OwnerTableView.DataMember == "AttMaster")
            {
                #region Att Master
                
                //Insert new values
                Hashtable newValues = new Hashtable();
                
                if (operation == "Update")
                {
                    newValues["@recidd"] = Convert.ToInt32(editedItem.GetDataKeyValue("recidd").ToString());
                }
                
                newValues["@employeeIDD"] = Convert.ToInt32((editedItem.FindControl("ddlEmployee") as RadComboBox).Items[0].Value);
                newValues["@empcod"] = (editedItem.FindControl("ddlEmployee") as RadComboBox).Items[0].Text.ToString();
                
                newValues["@posidd"] = 0;//Convert.ToInt32((editedItem.FindControl("ddlEmpPos") as RadComboBox).Items[0].Value);
                newValues["@poscod"] = "";//(editedItem.FindControl("ddlEmpPos") as RadComboBox).Items[0].Text.ToString();
                
                if ((editedItem.FindControl("ddlEmpPos") as RadComboBox).Visible)
                {
                    newValues["@posidd"] = Convert.ToInt32((editedItem.FindControl("ddlEmpPos") as RadComboBox).Items[0].Value);
                    newValues["@poscod"] = (editedItem.FindControl("ddlEmpPos") as RadComboBox).Items[0].Text.ToString();
                }
                else
                {
                    newValues["@posidd"] = 0;
                    newValues["@poscod"] = "";
                }
                newValues["@prjidd"] = Convert.ToInt32((editedItem.FindControl("ddlProject") as RadComboBox).Items[0].Value);
                newValues["@prjcod"] = (editedItem.FindControl("ddlProject") as RadComboBox).Items[0].Text.ToString();
                newValues["@attdat"] = (editedItem.FindControl("dtpDate") as RadDatePicker).SelectedDate.Value;

                newValues["@attcmt"] = (editedItem.FindControl("txtattcmt") as TextBox).Text;
                
                if (!string.IsNullOrEmpty((editedItem.FindControl("ddlSubProject") as RadComboBox).Items[0].Value))
                {
                    newValues["@subprjidd"] = Convert.ToInt32((editedItem.FindControl("ddlSubProject") as RadComboBox).Items[0].Value);
                    newValues["@subprjcod"] = (editedItem.FindControl("ddlSubProject") as RadComboBox).Items[0].Text.ToString();
                }
                
                newValues["@atttyp"] = 1;
                newValues["@atttcd"] = "Daily";
                newValues["@DBMessage"] = "";

                newValues["@shtval"] = 0;
                newValues["@requestdate"] = DateTime.Now;

                newValues["@userid"] = Session["_UserID"].ToString();
                if (operation == "Insert")
                {
                    newValues["@prmtrx"] = Session["_CurrtrxNumber"];
                    newValues["@subtrx"] = "subtrans";
                   
                }
                string DBMessage = "";
                if (operation == "Insert")
                {
                    DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Insert_EmpAtt", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;

                    Hashtable htRequestID = new Hashtable();
                    htRequestID["@prmtrx"] = Session["_CurrtrxNumber"];
                    htRequestID["@recidd"] = 0;

                    RequestID = Convert.ToInt32(clsDAL.ExecuteNonQuery("sp_User_getCurrentRequestIDAttT2", htRequestID, "@recidd", System.Data.SqlDbType.NVarChar, 255) as string);
                    Session["_recidd"] = RequestID;
                }
                else if (operation == "Update")
                {
                    DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Update_EmpAtt", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                }

                if ((null != DBMessage) && DBMessage.Contains("ERROR:"))
                {
                
                    ShowClientMessage(DBMessage, MessageType.Error);
                    e.Canceled = true;
                }
                else
                {
                    ShowClientMessage("Record saved successfully.", MessageType.Success);
                    gvAtt.Rebind();
                }

                #endregion
            }
                
            if (e.Item.OwnerTableView.DataMember == "HourType")
            {
                #region Hour Type
                
                //Insert new values
                Hashtable newValues = new Hashtable();
                int error = 0;
                Hashtable ht = new Hashtable();
                ht["@ID"] = Convert.ToInt32((editedItem.FindControl("ddlHourClass") as RadComboBox).Items[0].Value);
                DataTable dt = clsDAL.GetDataSet_Payroll("sp_Payroll_GetHourTypeById", ht).Tables[0];
    
                if (dt != null)
                {
                    foreach (DataRow row in dt.Rows)
                    {
                        if (!string.IsNullOrEmpty(row["fromval"].ToString()) && !string.IsNullOrEmpty(row["toval"].ToString()))
                        {
                            double fromVal = Convert.ToDouble(row["fromval"].ToString());
                            double toVal = Convert.ToDouble(row["toval"].ToString());
                            double hourval = Convert.ToDouble((editedItem.FindControl("txtHours") as RadNumericTextBox).Text);
                            if (hourval < fromVal || hourval > toVal)
                            {
                                ShowClientMessage("Hour value is out of range:" + fromVal + "-" + toVal, MessageType.Error);
                                e.Canceled = true;
                                error = 1;
                            }
                        }
                    }
                }

                if (error == 0)
                {

                    if (operation == "Update")
                    {
                        newValues["@recidd"] = Convert.ToInt32(editedItem.GetDataKeyValue("recidd").ToString());
                    }
                    if (operation == "Insert")
                    {
                        newValues["@mrecidd"] = Convert.ToInt32(editedItem.OwnerTableView.ParentItem.OwnerTableView.DataKeyValues[editedItem.OwnerTableView.ParentItem.ItemIndex]["recidd"].ToString());
                    }
                    newValues["@hrclsidd"] = Convert.ToInt32((editedItem.FindControl("ddlHourClass") as RadComboBox).Items[0].Value);
                    newValues["@hrclscod"] = (editedItem.FindControl("ddlHourClass") as RadComboBox).Items[0].Text.ToString();
                    newValues["@hours"] = (editedItem.FindControl("txtHours") as RadNumericTextBox).Text;
                    newValues["@htdesc"] = (editedItem.FindControl("txthtdesc") as RadTextBox).Text;
                    newValues["@userid"] = Session["_UserID"].ToString();
                    newValues["@DBMessage"] = "";
                    string DBMessage = "";
                    if (operation == "Insert")
                    {
                        DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_payroll_Insert_EmpAtt_HourTypeDetail", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                    }
                    else if (operation == "Update")
                    {
                        DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_payroll_Update_EmpAtt_HourTypeDetail", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                    }
                    if ((null != DBMessage) && DBMessage.Contains("ERROR:"))
                    {
                        ShowClientMessage(DBMessage, MessageType.Error);
                        e.Canceled = true;
                    }
                    else
                    {
                        ShowClientMessage("Record saved successfully.", MessageType.Success);
                    }
                }
                #endregion
            }
                
            if (e.Item.OwnerTableView.DataMember == "PremiumType")
            {
                #region Premium Type
                int error = 0;
                GridDataItem ParentItem = editedItem.OwnerTableView.ParentItem as GridDataItem;
                Hashtable ht = new Hashtable();
                ht["@ID"] = Convert.ToInt32((editedItem.FindControl("ddlPremType") as RadComboBox).Items[0].Value);
                DataTable dt = clsDAL.GetDataSet_Payroll("sp_Payroll_GetPremTypeDtl", ht).Tables[0];
                        
                if (dt != null)
                {
                    if (ParentItem.GetDataKeyValue("IsWeekend").ToString() == "1")
                    {
                        foreach (DataRow row in dt.Rows)
                        {
                            if (row["daytcod"].ToString() == "Weekend")
                            {
                                if (!string.IsNullOrEmpty(row["fromval"].ToString()) && !string.IsNullOrEmpty(row["toval"].ToString()))
                                {
                                    double fromVal = Convert.ToDouble(row["fromval"].ToString());
                                    double toVal = Convert.ToDouble(row["toval"].ToString());
                                    double premval = Convert.ToDouble((editedItem.FindControl("txtPremium") as RadNumericTextBox).Text);
                                    if (premval < fromVal || premval > toVal)
                                    {
                                        ShowClientMessage("Premium value is out of range:" + fromVal + "-" + toVal, MessageType.Error);
                                        e.Canceled = true;
                                        error = 1;
                                    }
                                }
                            }
                        }
                    }
                    else if (ParentItem.GetDataKeyValue("IsPublicHoliday").ToString() == "1")
                    {
                        foreach (DataRow row in dt.Rows)
                        {
                            if (row["daytcod"].ToString() == "Off Day")
                            {
                                if (!string.IsNullOrEmpty(row["fromval"].ToString()) && !string.IsNullOrEmpty(row["toval"].ToString()))
                                {
                                    double fromVal = Convert.ToDouble(row["fromval"].ToString());
                                    double toVal = Convert.ToDouble(row["toval"].ToString());
                                    double premval = Convert.ToDouble((editedItem.FindControl("txtPremium") as RadNumericTextBox).Text);
                                    if (premval < fromVal || premval > toVal)
                                    {
                                        ShowClientMessage("Premium value is out of range:" + fromVal + "-" + toVal, MessageType.Error);
                                        e.Canceled = true;
                                        error = 1;
                                    }
                                }
                            }
                        }
                    }
                    else
                    {
                        foreach (DataRow row in dt.Rows)
                        {
                            if (row["daytcod"].ToString() == "Working Days")
                            {
                                if (!string.IsNullOrEmpty(row["fromval"].ToString()) && !string.IsNullOrEmpty(row["toval"].ToString()))
                                {
                                    double fromVal = Convert.ToDouble(row["fromval"].ToString());
                                    double toVal = Convert.ToDouble(row["toval"].ToString());
                                    double premval = Convert.ToDouble((editedItem.FindControl("txtPremium") as RadNumericTextBox).Text);
                                    if (premval < fromVal || premval > toVal)
                                    {
                                        ShowClientMessage("Premium value is out of range:" + fromVal + "-" + toVal, MessageType.Error);
                                        e.Canceled = true;
                                        error = 1;
                                    }
                                }
                            }
                        }
                    }

                    
                }
                    

                if (error == 0)
                {

                //Insert new values
                Hashtable newValues = new Hashtable();
                
                if (operation == "Update")
                {
                    newValues["@recidd"] = Convert.ToInt32(editedItem.GetDataKeyValue("recidd").ToString());
                }
                if (operation == "Insert")
                {
                    newValues["@mrecidd"] = Convert.ToInt32(editedItem.OwnerTableView.ParentItem.OwnerTableView.DataKeyValues[editedItem.OwnerTableView.ParentItem.ItemIndex]["recidd"].ToString());
                }
                RadComboBox ddlPremType = editedItem.FindControl("ddlPremType") as RadComboBox;
                    if (!string.IsNullOrEmpty(ddlPremType.Items[0].Value))
                {
                    newValues["@prtidd"] = Convert.ToInt32((editedItem.FindControl("ddlPremType") as RadComboBox).Items[0].Value);
                    newValues["@prtcod"] = (editedItem.FindControl("ddlPremType") as RadComboBox).Items[0].Text.ToString();
                }
                if ((editedItem.FindControl("txtPremium") as RadNumericTextBox).Text != "")
                {
                    newValues["@prtval"] = (editedItem.FindControl("txtPremium") as RadNumericTextBox).Text;
                }
                newValues["@ptdesc"] = (editedItem.FindControl("txtptdesc") as RadTextBox).Text;
                newValues["@userid"] = Session["_UserID"].ToString();
                
                newValues["@DBMessage"] = "";
                string DBMessage = "";
                if (operation == "Insert")
                {
                    DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_payroll_Insert_EmpAtt_PremTypeDetail", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                }
                else if (operation == "Update")
                {
                    DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_payroll_Update_EmpAtt_PremTypeDetail", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                }
                if ((null != DBMessage) && DBMessage.Contains("ERROR:"))
                {
                    ShowClientMessage(DBMessage, MessageType.Error);
                    e.Canceled = true;
                }
                else
                {
                    ShowClientMessage("Record saved successfully.", MessageType.Success);
                }
                }
                
                #endregion
            }
                
            if (e.Item.OwnerTableView.DataMember == "PremiumType2")
            {
                #region Premium Type2
                int error = 0;
                GridDataItem hrtItem = editedItem.OwnerTableView.ParentItem as GridDataItem;
                GridDataItem ParentItem = hrtItem.OwnerTableView.ParentItem as GridDataItem;
                Hashtable ht = new Hashtable();
                ht["@ID"] = Convert.ToInt32((editedItem.FindControl("ddlPremType2") as RadComboBox).Items[0].Value);
                DataTable dt = clsDAL.GetDataSet_Payroll("sp_Payroll_GetPremTypeDtl", ht).Tables[0];
                            
                if (dt != null)
                {
                    if (ParentItem.GetDataKeyValue("IsWeekend").ToString() == "1")
                    {
                        foreach (DataRow row in dt.Rows)
                        {
                            if (row["daytcod"].ToString() == "Weekend")
                            {
                                if (!string.IsNullOrEmpty(row["fromval"].ToString()) && !string.IsNullOrEmpty(row["toval"].ToString()))
                                {
                                    double fromVal = Convert.ToDouble(row["fromval"].ToString());
                                    double toVal = Convert.ToDouble(row["toval"].ToString());
                                    double premval = Convert.ToDouble((editedItem.FindControl("txtPremium") as RadNumericTextBox).Text);
                                    if (premval < fromVal || premval > toVal)
                                    {
                                        ShowClientMessage("Premium value is out of range:" + fromVal + "-" + toVal, MessageType.Error);
                                        e.Canceled = true;
                                        error = 1;
                                    }
                                }
                            }
                        }
                    }
                    else if (ParentItem.GetDataKeyValue("IsPublicHoliday").ToString() == "1")
                    {
                        foreach (DataRow row in dt.Rows)
                        {
                            if (row["daytcod"].ToString() == "Off Day")
                            {
                                if (!string.IsNullOrEmpty(row["fromval"].ToString()) && !string.IsNullOrEmpty(row["toval"].ToString()))
                                {
                                    double fromVal = Convert.ToDouble(row["fromval"].ToString());
                                    double toVal = Convert.ToDouble(row["toval"].ToString());
                                    double premval = Convert.ToDouble((editedItem.FindControl("txtPremium") as RadNumericTextBox).Text);
                                    if (premval < fromVal || premval > toVal)
                                    {
                                        ShowClientMessage("Premium value is out of range:" + fromVal + "-" + toVal, MessageType.Error);
                                        e.Canceled = true;
                                        error = 1;
                                    }
                                }
                            }
                        }
                    }
                    else
                    {
                        foreach (DataRow row in dt.Rows)
                        {
                            if (row["daytcod"].ToString() == "Working Days")
                            {
                                if (!string.IsNullOrEmpty(row["fromval"].ToString()) && !string.IsNullOrEmpty(row["toval"].ToString()))
                                {
                                    double fromVal = Convert.ToDouble(row["fromval"].ToString());
                                    double toVal = Convert.ToDouble(row["toval"].ToString());
                                    double premval = Convert.ToDouble((editedItem.FindControl("txtPremium") as RadNumericTextBox).Text);
                                    if (premval < fromVal || premval > toVal)
                                    {
                                        ShowClientMessage("Premium value is out of range:" + fromVal + "-" + toVal, MessageType.Error);
                                        e.Canceled = true;
                                        error = 1;
                                    }
                                }
                            }
                        }
                    }
                }
                        
                if (error == 0)
                {
                    //Insert new values
                    Hashtable newValues = new Hashtable();
                        
                    if (operation == "Update")
                    {
                        newValues["@recidd"] = Convert.ToInt32(editedItem.GetDataKeyValue("recidd").ToString());
                    }
                    if (operation == "Insert")
                    {
                        newValues["@hrtdidd"] = Convert.ToInt32(editedItem.OwnerTableView.ParentItem.OwnerTableView.DataKeyValues[editedItem.OwnerTableView.ParentItem.ItemIndex]["recidd"].ToString());
                        newValues["@mrecidd"] = Convert.ToInt32(editedItem.OwnerTableView.ParentItem.OwnerTableView.DataKeyValues[editedItem.OwnerTableView.ParentItem.ItemIndex]["mrecidd"].ToString());
                    }
                    RadComboBox ddlPremType2 = editedItem.FindControl("ddlPremType2") as RadComboBox;
                    if (!string.IsNullOrEmpty(ddlPremType2.Items[0].Value))
                    {
                        newValues["@prtidd"] = Convert.ToInt32((editedItem.FindControl("ddlPremType2") as RadComboBox).Items[0].Value);
                        newValues["@prtcod"] = (editedItem.FindControl("ddlPremType2") as RadComboBox).Items[0].Text.ToString();
                    }
                    if ((editedItem.FindControl("txtPremium") as RadNumericTextBox).Text != "")
                    {
                        newValues["@prtval"] = (editedItem.FindControl("txtPremium") as RadNumericTextBox).Text;
                    }
                    newValues["@ptdesc"] = (editedItem.FindControl("txtptdesc") as RadTextBox).Text;
                    newValues["@userid"] = Session["_UserID"].ToString();
                    
                    newValues["@DBMessage"] = "";
                    string DBMessage = "";
                    if (operation == "Insert")
                    {
                        DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_payroll_Insert_Hrt_PrtDetail", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                    }
                    else if (operation == "Update")
                    {
                        DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_payroll_Update_Hrt_PrtDetail", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                    }
                    if ((null != DBMessage) && DBMessage.Contains("ERROR:"))
                    {
                        ShowClientMessage(DBMessage, MessageType.Error);
                        e.Canceled = true;
                    }
                    else
                    {
                        ShowClientMessage("Record saved successfully.", MessageType.Success);
                    }
                }
    
                #endregion
            }
        }
        catch (Exception ex)
        {
            ShowClientMessage("Unable to insert/update Record . Reason: " + ex.Message, MessageType.Error);
            e.Canceled = true;
        }
    }
            
    // grid header formating for exporting
    protected void gvAtt_ItemCreated(object sender, GridItemEventArgs e)
    {

        if (e.Item is GridDataItem && e.Item.OwnerTableView.DataMember == "AttMaster")
        {
            GridDataItem dataItem = e.Item as GridDataItem;
            GridTableView table = (GridTableView)e.Item.OwnerTableView;
            if (Session["_Tab1Function"].ToString() != "New")
            {
                //ImageButton DeleteAtt = dataItem.FindControl("DeleteAtt") as ImageButton;
                Hashtable ht = new Hashtable();
                ht["@prmtrx"] = Session["_CurrtrxNumber"].ToString();  
                DataTable dt = clsDAL.GetDataSet_Payroll("[sp_Payroll_Get_EmpAtt_RequestStatusIDs_Byprmtrx]", ht).Tables[0];
                if (dt != null)
                {
                    foreach (DataRow row in dt.Rows)
                        if (row[0].ToString() == "10")
                        {
                            table.GetColumn("DeleteAtt").Display = false;
                            break;
                        }
                }
            }
            else
            {
                table.GetColumn("DeleteAtt").Display = true;
            }


            if (Session["_Tab1Function"].ToString() != "New" && Session["_Tab1Function"].ToString() != "View")
            {
                Hashtable ht = new Hashtable();
                ht["@prmtrx"] = Session["_CurrtrxNumber"].ToString();
                DataTable dt = clsDAL.GetDataSet_Payroll("[sp_Payroll_Get_EmpAtt_RequestStatusIDs_Byprmtrx]", ht).Tables[0];
                if (dt != null)
                {
                    foreach (DataRow row in dt.Rows)
                    {
                        if (Convert.ToInt32(row[0].ToString()) > 2)
                        {
                            Hashtable htt = new Hashtable();
                            DataTable dtConfigs = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_AttEntConfigs", htt).Tables[0];

                            if (dtConfigs.Rows.Count > 0)
                            {
                                if (dtConfigs.Rows[0]["allowedit"].ToString() != "True")
                                {
                                    table.GetColumn("EditFiles").Display = false;
                                }
                                else
                                {
                                    table.GetColumn("EditFiles").Display = true;
                                }
                            }
                        }
                        break;
                    }
                }
            }

        }
            
        if (Session["_Tab1Function"].ToString() == "View")
        {
            if (e.Item is GridDataItem && e.Item.OwnerTableView.DataMember == "AttMaster")
            {
                GridTableView table = (GridTableView)e.Item.OwnerTableView;
            
                table.GetColumn("EditFiles").Display = false;
                table.GetColumn("CopyToToday").Display = false;
                table.GetColumn("CopyToTomorrow").Display = false;
                table.GetColumn("CopyToN").Display = false;
                table.GetColumn("DeleteAtt").Display = false;
            }
            if (e.Item is GridDataItem && e.Item.OwnerTableView.DataMember == "PremiumType" 
                || e.Item.OwnerTableView.DataMember == "PremiumType2" 
                || e.Item.OwnerTableView.DataMember == "HourType")
            {
                GridTableView table = (GridTableView)e.Item.OwnerTableView;

                table.GetColumn("Edit").Display = false;
                table.GetColumn("Delete").Display = false;
            }
            GridCommandItem cmdItem = (GridCommandItem)gvAtt.MasterTableView.GetItems(GridItemType.CommandItem)[0];
            ((Button)cmdItem.FindControl("btnUpdateNH")).Visible = false;

            //GridCommandItem insertcmdItem = (GridCommandItem)gvAtt.MasterTableView.GetItems(GridItemType.CommandItem)[0];
            //((Button)cmdItem.FindControl("btnLdpAdd")).Visible = false;

            if (e.Item is GridCommandItem)
            {
                ((Button)e.Item.FindControl("btnAdd")).Visible = false;
            }
        }
        else
        {
            if (e.Item is GridDataItem && e.Item.OwnerTableView.DataMember == "AttMaster")
            {
                GridTableView table = (GridTableView)e.Item.OwnerTableView;
        
                table.GetColumn("EditFiles").Display = true;
                table.GetColumn("CopyToToday").Display = true;
                table.GetColumn("CopyToTomorrow").Display = true;
                table.GetColumn("CopyToN").Display = true;
                table.GetColumn("DeleteAtt").Display = true;
            }
            if (e.Item is GridCommandItem)
            {
                ((Button)e.Item.FindControl("btnAdd")).Visible = true;
            }
            if (e.Item is GridDataItem && e.Item.OwnerTableView.DataMember == "PremiumType"
                || e.Item.OwnerTableView.DataMember == "PremiumType2"
                || e.Item.OwnerTableView.DataMember == "HourType")
            {
                GridTableView table = (GridTableView)e.Item.OwnerTableView;

                table.GetColumn("Edit").Display = true;
                table.GetColumn("Delete").Display = true;
            }
        }
            
        
    
        if (exporting && e.Item.ItemType == Telerik.Web.UI.GridItemType.FilteringItem)
        {
            e.Item.Visible = false;
        }


        //if (e.Item is GridEditableItem && e.Item.OwnerTableView.DataMember == "AttMaster")
        //{
        //    RadComboBox ddlEmployee = (RadComboBox)e.Item.FindControl("ddlEmployee");
        //    RadGrid rGrdEmployee4DDL = ddlEmployee.Items[0].FindControl("rGrdEmployee4DDL") as RadGrid;
        //    RadAjaxManager1.AjaxSettings.AddAjaxSetting(rGrdEmployee4DDL, rGrdEmployee4DDL);

        //    RadComboBox ddlSubProject = (RadComboBox)e.Item.FindControl("ddlSubProject");
        //    RadGrid rGrdSubProject4DDL = ddlSubProject.Items[0].FindControl("rGrdSubProject4DDL") as RadGrid;
        //    RadAjaxManager1.AjaxSettings.AddAjaxSetting(rGrdSubProject4DDL, rGrdSubProject4DDL);
        //}
    }
    
    // employee ddl data binding event
    protected void rGrdEmployee4DDL_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        Hashtable ht = new Hashtable();
        ht.Add("@UserID", Session["_UserID"].ToString());
        ht.Add("@FormTypeID", Request.QueryString["FormType"]);

        grid.DataSource = clsDAL.GetDataSet_Payroll("sp_User_Get_Employees_By_UserID_4_DDL", ht).Tables[0];
      //  htSearchParams = new Hashtable();
      //  grid.DataSource = clsDAL.GetDataSet_Payroll("sp_payroll_GetAllEmployeeRecords", htSearchParams).Tables[0];
    }
    
    // employee Position ddl data binding event
    protected void rGrdEmpPos4DDL_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {
        htSearchParams = new Hashtable();
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsDAL.GetDataSet_Payroll("sp_payroll_GetAllEmpPos", htSearchParams).Tables[0];
    }
    
    // Premium Type ddl data binding event
    protected void rGrdPremType4DDL_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {
        htSearchParams  = new Hashtable();
        RadGrid grid = sender as RadGrid;
        htSearchParams.Add("@type", 2);
        grid.DataSource = clsDAL.GetDataSet_Payroll("sp_payroll_GetPremiumTypeRecords", htSearchParams).Tables[0];
    }
    protected void rGrdPremHourType4DDL_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {
        htSearchParams = new Hashtable();
        RadGrid grid = sender as RadGrid;
        htSearchParams.Add("@type", 1);
        //grid.DataSource = clsDAL.GetDataSet_Payroll("sp_payroll_GetPremiumTypeRecords_4Hourtype", htSearchParams).Tables[0];

        grid.DataSource = clsDAL.GetDataSet_Payroll("sp_payroll_GetPremiumTypeRecords", htSearchParams).Tables[0];
    }  
    protected void btnNewEntries_Click(object sender, EventArgs e)
    {
        Session["_Tab1Function"] = "New";
        SaveCurrentGroup();

        Hashtable ht_nextnumber = new Hashtable();
        ht_nextnumber.Add("@seqcod", "ATTENTRYT2");
        ht_nextnumber.Add("@TRX_ID", null);
        //Session["_CurrtrxNumber"] = clsDAL.ExecuteNonQuery("sp_User_Get_Next_Transaction_Number", ht_nextnumber, "@TRX_ID", System.Data.SqlDbType.NVarChar, 255) as string;
      
        
//        gvAtt.Rebind();
        //ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowTab", "ShowTab('#tab1');", true);
        ScriptManager.RegisterStartupScript(this, this.GetType(), "RefreshGrid", "refreshGrid2();", true);
      //  rBtnSave.Visible = true;
        rBtnSaveAndSubmit.Visible = true;
        TopPanel.Visible = true;
        ApprovalPanel.Visible = false;
    }
            
    //Save buuton operations
    protected void rBtnSave_Click(object sender, EventArgs e)
    {

           }
       protected void SaveCurrentGroup()
       {
           if (gvAtt.MasterTableView.Items.Count > 0)
           {
    save(1);

               Hashtable ht_nextnumber = new Hashtable();
               ht_nextnumber.Add("@seqcod", "ATTENTRYT2");
               ht_nextnumber.Add("@TRX_ID", null);
         //      Session["_CurrtrxNumber"] = clsDAL.ExecuteNonQuery("sp_User_Get_Next_Transaction_Number", ht_nextnumber, "@TRX_ID", System.Data.SqlDbType.NVarChar, 255) as string;
               RequestID = 0;
               Session["_recidd"] = "0";
            reBindAllTabGrids();
    
}
           else
           {
               ShowClientMessage("No records to save", MessageType.Error);
           }

       }
    //Save & Submit buuton operations
    protected void rBtnSaveAndSubmit_Click(object sender, EventArgs e)
    {
        if (gvAtt.MasterTableView.Items.Count > 0)
        {
            save(2);
           
            if (Session["_Tab1Function"].ToString() == "New")
            {
                //Hashtable newValues = new Hashtable();
                //clsDAL.ExecuteNonQuery_payroll("sp_User_Increment_Seq_Number", newValues);
                Hashtable ht_nextnumber = new Hashtable();
                ht_nextnumber.Add("@seqcod", "ATTENTRYT2");
                ht_nextnumber.Add("@TRX_ID", null);
            //    Session["_CurrtrxNumber"] = clsDAL.ExecuteNonQuery("sp_User_Get_Next_Transaction_Number", ht_nextnumber, "@TRX_ID", System.Data.SqlDbType.NVarChar, 255) as string;
                RequestID = Convert.ToInt32(Session["_recidd"]);
                Session["_recidd"] = 0;
                Session["_ReimbTab1Function"] = "New";
            }
            else 
            {
                Session["_CurrtrxNumber"] = "";
                rBtnSaveAndSubmit.Visible = false;
            }
            reBindAllTabGrids();
            //int rebtrxId = Convert.ToInt32(e.CommandArgument.ToString());
            compileEmail(RequestID,1);
    
        }
        else
        {
            ShowClientMessage("No records to save & submit", MessageType.Error);
        }
    }
            
    private void save(int saveStatus)
    {
        try
        {
            Hashtable ht = new Hashtable();
            Hashtable ht4Submit = new Hashtable();
            ht.Add("@UserID", Session["_UserID"].ToString());
            ht.Add("@FormTypeID", Request.QueryString["FormType"]);

            clsDAL.ExecuteNonQuery_payroll("sp_User_Get_Submitted_AttendanceT2", ht);

            int wfid;
            Hashtable ht_message = new Hashtable();
            ht_message.Add("@FormTypeID", formType);
            ht_message.Add("@SubmittedByUserID", (string)Session["_UserID"]);
            ht_message.Add("@WorkFlowMasterID", "0");
                
            wfid = int.Parse(clsDAL.ExecuteNonQuery_admin(Constraints.get_WorkFlowID, ht_message, "@WorkFlowMasterID", System.Data.SqlDbType.Int, 0).ToString());

            if (saveStatus == 2 && wfid > 0)
            {


                ht4Submit.Add("@RequestID", RequestID);
                ht4Submit.Add("@FormTypeID", Request.QueryString["FormType"]);
                ht4Submit.Add("@SubmittedByUserID", (string)Session["_UserID"]);

                clsDAL.ExecuteNonQuery("sp_User_Submit_AttendanceT2", ht4Submit);

                Session["_recidd"] = 0;
                RequestID = 0;
                Session["_CurrtrxNumber"] = "";
           
                gvAtt.Rebind();

            }
            
            if (wfid == 0)
            {
                ShowClientMessage("Transaction saved but cannot be Sumbitted due to missing workflow.", MessageType.Warning);
            }
            else if (wfid > 0 && saveStatus == 2)
            {
                ShowClientMessage("Transaction saved and submitted successfully.", MessageType.Success);
            }
            else if (wfid > 0 && saveStatus == 1)
            {
                ShowClientMessage("Transaction saved and can be submitted from tab.", MessageType.Info);
            }
        }
        catch (Exception ex)
        {
            ShowClientMessage("Sorry! some error has occurred. Please try again later.<br/>" + ex.Message, MessageType.Error);
            Logger.LogError(ex);
        }
    }

    public void compileEmail(int trxId,int emailType)
    {
        // get email info
        // load email keys columns in email info sp
        Hashtable ht_email = new Hashtable();
        ht_email.Add("@RequestID", trxId);
        DataTable dt = clsDAL.GetDataSet("sp_User_Get_AttendanceT2_Info_4_Email", ht_email).Tables[0];
        if (dt.Rows.Count > 0)
        {
            string sSubject = string.Empty;
            string sBody = String.Empty;

            // load email template , subject , body with templateid

            Hashtable ht_template = new Hashtable();
            ht_template.Add("@emailtypeId", emailType);
            DataTable dtTemplate = clsDAL.GetDataSet("sp_payroll_Get_EmailTemplate", ht_template).Tables[0];
            if (dtTemplate.Rows.Count > 0)
            {
                sSubject = dtTemplate.Rows[0]["subject"].ToString();
                sBody = dtTemplate.Rows[0]["body"].ToString();
                if (!string.IsNullOrEmpty(sBody))
                {
                    sSubject = clsCommon.RefineMessage(sSubject, dt);
                    sBody = clsCommon.RefineMessage(sBody, dt);

                    //call email function SendMail(mailbody,emailto, emailfrom,mailsubject) 
                    clsCommon.SendMail(sBody, dt, string.Empty, sSubject);
                }
            }
        }
        else
        {

            DataTable dtC = clsDAL.GetDataSet("sp_User_Get_AttendanceT2_Info_4_EmailRComp", ht_email).Tables[0];
            if (dtC.Rows.Count > 0)
            {
                string sSubject = string.Empty;
                string sBody = String.Empty;

                // load email template , subject , body with templateid

                Hashtable ht_template = new Hashtable();
                ht_template.Add("@emailtypeId", 5);
                DataTable dtTemplate = clsDAL.GetDataSet("sp_payroll_Get_EmailTemplate", ht_template).Tables[0];
                if (dtTemplate.Rows.Count > 0)
                {
                    sSubject = dtTemplate.Rows[0]["subject"].ToString();
                    sBody = dtTemplate.Rows[0]["body"].ToString();
                    if (!string.IsNullOrEmpty(sBody))
                    {
                        sSubject = clsCommon.RefineMessage(sSubject, dtC);
                        sBody = clsCommon.RefineMessage(sBody, dtC);

                        //call email function SendMail(mailbody,emailto, emailfrom,mailsubject) 
                        clsCommon.SendMail(sBody, dtC, string.Empty, sSubject);
                    }
                }
            }
        }
    }

    private string GetCalendarID(string empID)
    {
        //Hashtable ht = new Hashtable();
        //ht.Add("@EmployeeID", strID);
        //rCmbCalander.ClearSelection();
        //RadGrid grid = rCmbCalander.Items[0].FindControl("rGrdCalanders4DDL") as RadGrid;
        //grid.DataSource = clsDAL.GetDataSet("sp_Payroll_Get_Calander_By_Employee", ht).Tables[0];
        ////grid.Rebind();
        Hashtable ht = new Hashtable();
        ht.Add("@EmployeeID", empID);
        string empcalendarID;
        empcalendarID = clsDAL.GetDataSet("sp_Payroll_Get_Calander_By_Employee", ht).Tables[0].Rows[0][0].ToString();
        return empcalendarID;
    }
        
    private string GetCalendarCode(string empID)
    {
        //Hashtable ht = new Hashtable();
        //ht.Add("@EmployeeID", strID);
        //rCmbCalander.ClearSelection();
        //RadGrid grid = rCmbCalander.Items[0].FindControl("rGrdCalanders4DDL") as RadGrid;
        //grid.DataSource = clsDAL.GetDataSet("sp_Payroll_Get_Calander_By_Employee", ht).Tables[0];
        ////grid.Rebind();
        Hashtable ht = new Hashtable();
        ht.Add("@EmployeeID", empID);
        string empcalendarCode;
        empcalendarCode = clsDAL.GetDataSet("sp_Payroll_Get_Calander_By_Employee", ht).Tables[0].Rows[0][1].ToString();
        return empcalendarCode;
    }

    #endregion
    
    #region Tab2 - Saved Requests
        
    protected void gvSavedRequests_SortCommand(object sender, GridSortCommandEventArgs e)
    {
        ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowTab", "ShowTab('#tab2');", true);
    }
    
    protected void gvSavedRequests_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {
        Hashtable ht = new Hashtable();
        ht.Add("@UserID", Session["_UserID"].ToString());
        ht.Add("@FormTypeID", Request.QueryString["FormType"]);
        DataTable dt = clsDAL.GetDataSet("sp_User_Get_Saved_AttendanceT2", ht).Tables[0];
        dt.TableName = "eb_prlAttEnt";
        gvSavedRequests.DataSource = dt;
        gvSavedRequests.DataMember = "eb_prlAttEnt";
    }
                    
    protected void gvSavedRequests_DetailTableDataBind(object sender, GridDetailTableDataBindEventArgs e)
    {
        GridDataItem dataItem = (GridDataItem)e.DetailTableView.ParentItem;

        switch (e.DetailTableView.Name)
        {
            case "RequestStatuses":
                {
                    string ID = dataItem.GetDataKeyValue("recidd").ToString();
                    
                    Hashtable ht = new Hashtable();
                    ht.Add("@AttEntTrxID", ID);
        
                    DataTable dt = clsDAL.GetDataSet("sp_User_Get_AttEntTrx_Statuses", ht).Tables[0];
                    dt.TableName = "tbl_AttEnttrx_Status";
                    e.DetailTableView.DataSource = dt;
                    e.DetailTableView.DataMember = "tbl_AttEnttrx_Status";
        
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowTab", "ShowTab('#tab2');", true);
                    break;
                }
        }
    }
            
    protected void gvSavedRequests_ItemCommand(object sender, GridCommandEventArgs e)
    {

        if (e.CommandName == "ExpandCollapse")
        {

        }

        if (e.CommandName == "ViewEdit")
        {
            Session["_Tab1Function"] = "Edit";
            string[] arg = new string[2];

            arg = e.CommandArgument.ToString().Split(';');
            Session["IdTemplate"] = arg[0];
            int id = Int32.Parse(arg[0]);
            Session["_recidd"] = id;
            Session["_CurrtrxNumber"] = arg[1].ToString();


         //  Session["_CurrtrxNumber"] = e.CommandArgument.ToString();
            gvAtt.Rebind();
            rBtnSave.Visible = false;
            rBtnSaveAndSubmit.Visible = true;
            TopPanel.Visible = false;
            ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowTab", "ShowTab('#tab1');", true);
            ScriptManager.RegisterStartupScript(this, this.GetType(), "RefreshGrid", "refreshGrid2();", true);
        }
            
        if (e.CommandName == "View")
        {
            Session["_Tab1Function"] = "View";
            string[] arg = new string[2];
            arg = e.CommandArgument.ToString().Split(';');
            Session["IdTemplate"] = arg[0];
            int id = Int32.Parse(arg[0]);
            Session["_recidd"] = id;
            Session["_CurrtrxNumber"] = arg[1].ToString();

            gvAtt.Rebind();
            rBtnSave.Visible = false;
            rBtnSaveAndSubmit.Visible = false;
            TopPanel.Visible = false;
            ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowTab", "ShowTab('#tab1');", true);
            ScriptManager.RegisterStartupScript(this, this.GetType(), "RefreshGrid", "refreshGrid2();", true);



        }
        if (e.CommandName == "Print")
        {
            string printOption = "";
            if (ddlPrintOptions.SelectedItem != null)
            {
                printOption = ddlPrintOptions.SelectedItem.Text;
            }
            string requestId = clsEncryption.EncryptData(e.CommandArgument.ToString());
            // bring report from formtype
            string rptName = clsEncryption.EncryptData("TimeSheetbyProject");
            ScriptManager.RegisterStartupScript(this, Page.GetType(), "mykey", "ShowReport('" + requestId + "','" + rptName + "');", true);
        }
        
        if (e.CommandName == "Delete")
        {
            Hashtable ht_delete = new Hashtable();
          //  ht_delete.Add("@prmtrx", e.CommandArgument.ToString());
            ht_delete["@recidd"] = RequestID;
            ht_delete["@userid"] = Session["_UserID"].ToString();
            clsDAL.ExecuteNonQuery("sp_User_delete_EmpAttEnt", ht_delete);
            RequestID = 0;
            Session["_recidd"] = 0;
            Session["_CurrtrxNumber"] = ""; 
            reBindAllTabGrids();
            ShowClientMessage("Transaction No:" + e.CommandArgument.ToString() + "  is Deleted.", MessageType.Success);
            ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowTab", "ShowTab('#tab2');", true);
            ScriptManager.RegisterStartupScript(this, this.GetType(), "RefreshGrid", "refreshGrid2();", true);
        }
            
        if (e.CommandName == "Submit")
        {
            int wfid;
            Hashtable ht_message = new Hashtable();
            ht_message.Add("@FormTypeID", formType);
            ht_message.Add("@SubmittedbyUserID", (string)Session["_UserID"]);
            ht_message.Add("@WorkFlowMasterID", 0);
                
            wfid = int.Parse(clsDAL.ExecuteNonQuery_admin(Constraints.get_WorkFlowID, ht_message, "@WorkFlowMasterID", System.Data.SqlDbType.Int, 0).ToString());
                
            if (wfid == 0)
            {
                ShowClientMessage("Transaction cannot be submitted due to missing workflow", MessageType.Error);
            }
            else if (wfid > 0)
            {
                Hashtable ht_submit = new Hashtable();
                ht_submit.Add("@RequestID", e.CommandArgument.ToString());
                ht_submit.Add("@FormTypeID", Request.QueryString["FormType"]);
                ht_submit.Add("@SubmittedByUserID", (string)Session["_UserID"]);

                clsDAL.ExecuteNonQuery("sp_User_Submit_AttendanceT2", ht_submit);
                clsCommon.SendMail(3, ht_submit);
                gvSavedRequests.Rebind();
                gvSubmittedRequests.Rebind();
                
                //Hashtable ht_email = new Hashtable();
                //ht_email.Add("LeaveTransactionID", e.CommandArgument.ToString());
                
                //DataTable dt = clsDAL.GetDataSet("sp_User_Get_LeaveTransaction_Info_4_Email", ht_email).Tables[0];
                
                //if ((null != dt) && dt.Rows.Count > 0)
                //{
                //    string sBody = "";
                //    string htmlEmailFormat = Server.MapPath("~/EmailTemplates/NotifyApplicantApproverEmail.htm");
                
                //    //sBody = File.ReadAllText(htmlEmailFormat);
                //    //sBody = sBody.Replace("<%UserFullName%>", dt.Rows[0]["MainApproverFullName"].ToString());
                //    //sBody = sBody.Replace("<%ID%>", Request.QueryString["LeaveTransactionID"]);
                //    ////sBody = sBody.Replace("<%FullName%>", txtFirstName.Text + txtMiddleName.Text + txtLastName.Text);
                //    ////sBody = sBody.Replace("<%Position%>", rCmbPosition.SelectedValue.ToString());
                //    ////sBody = sBody.Replace("<%Remarks%>", rTxtRemarks.Text);
                //    //sBody = sBody.Replace("<%RedirectURL%>", Request.Url.AbsoluteUri);
                //    //clsCommon.SendMail(sBody, dt.Rows[0]["Email"].ToString(), ConfigurationManager.AppSettings["EMAIL_ACC"], "A request is pending for your approval.");
                //}
    
                ShowClientMessage("New Transaction ID: is submitted for approval.", MessageType.Success);
                //clearForm();
                ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowTab", "ShowTab('#tab2');", true);
                ScriptManager.RegisterStartupScript(this, this.GetType(), "RefreshGrid", "refreshGrid2();", true);
            }
        }
    }
            
    protected void gvSavedRequests_ItemCreated(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridDataItem && e.Item.OwnerTableView.DataMember == "eb_prllevtrx")
        {
            //ImageButton imgBtnEdit = (ImageButton)e.Item.FindControl("imgBtnEdit");
            //imgBtnEdit.Attributes["onclick"] = String.Format("return ShowTab('#tab1');");
            //ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowTab", "ShowTab('#tab1');", true);
            //ImageButton imgBtnView = (ImageButton)e.Item.FindControl("imgBtnView");
            //if (imgBtnView != null)
            //   imgBtnView.Attributes["onclick"] = String.Format("return ShowSavedViewForm('{0}','{1}','{2}','{3}');", e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["RequestID"], e.Item.ItemIndex, Request.QueryString["FormType"], true);
            //ImageButton imgBtnOrgChart = (ImageButton)e.Item.FindControl("imgBtnOrgChart");
            //imgBtnOrgChart.Attributes["onclick"] = String.Format("return ShowOrgChart('{0}','{1}');", e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["RequestID"], e.Item.ItemIndex);
        }
    }
            
    protected void gvSavedRequests_ItemDataBound(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridDataItem && e.Item.OwnerTableView.DataMember == "eb_prlAttEnt")
        {
            GridDataItem dataItem = e.Item as GridDataItem;
                    
            ImageButton imgBtnDelete = dataItem.FindControl("imgBtnDelete") as ImageButton;
            Hashtable ht = new Hashtable();
            ht["@prmtrx"] = dataItem["column2"].Text;
            DataTable dt = clsDAL.GetDataSet_Payroll("[sp_Payroll_Get_EmpAtt_RequestStatusIDs_Byprmtrx]", ht).Tables[0];
            if (dt != null)
            {
                foreach (DataRow row in dt.Rows)
                    if (row[0].ToString() == "10")
                    {
                        imgBtnDelete.Visible = false;
                        break;
                    }
            }
        }
            
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
            //                cell.CssClass = "MyMexicoRowClass";
        }
    }
        
    #endregion
                
    #region Tab3 - Submitted Requests

    protected void gvSubmittedRequests_DetailTableDataBind(object sender, GridDetailTableDataBindEventArgs e)
    {
        GridDataItem dataItem = (GridDataItem)e.DetailTableView.ParentItem;
        switch (e.DetailTableView.Name)
        {
            case "RequestStatuses":
                {
                    string ID = dataItem.GetDataKeyValue("recidd").ToString();
                    
                    Hashtable ht = new Hashtable();
                    ht.Add("@AttEntTrxID", ID);
                
                    DataTable dt = clsDAL.GetDataSet("sp_User_Get_AttEntTrx_Statuses", ht).Tables[0];
                    dt.TableName = "tbl_AttEnttrx_Status";
                    e.DetailTableView.DataSource = dt;
                    e.DetailTableView.DataMember = "tbl_AttEnttrx_Status";
    
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowTab", "ShowTab('#tab3');", true);
        
                    break;
                }
        }
    }
            
    protected void gvSubmittedRequests_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == "View")
        {
         
            Session["_Tab1Function"] = "View";
            string[] arg = new string[2];
            arg = e.CommandArgument.ToString().Split(';');
            Session["IdTemplate"] = arg[0];
            int id = Int32.Parse(arg[0]);
            Session["_recidd"] = id;
            Session["_CurrtrxNumber"] = arg[1].ToString();

            gvAtt.Rebind();
            rBtnSave.Visible = false;
            rBtnSaveAndSubmit.Visible = false;
            TopPanel.Visible = false;
            ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowTab", "ShowTab('#tab1');", true);
            ScriptManager.RegisterStartupScript(this, this.GetType(), "RefreshGrid", "refreshGrid2();", true);
        }

        if (e.CommandName == "Recall")
        {
            Hashtable ht = new Hashtable();
            ht["@prmtrx"] = e.CommandArgument.ToString();
            clsDAL.ExecuteNonQuery_payroll("sp_User_Recall_Transaction", ht);
            gvSubmittedRequests.Rebind();
            gvSavedRequests.Rebind();
        }

        if (e.CommandName == "Print")
        {
            string printOption = "";
            if (ddlPrintOptions.SelectedItem != null)
            {
                printOption = ddlPrintOptions.SelectedItem.Text;
            }
            string requestId = clsEncryption.EncryptData(e.CommandArgument.ToString());
            // bring report from formtype
            string rptName = clsEncryption.EncryptData("TimeSheetbyProject");
            ScriptManager.RegisterStartupScript(this, Page.GetType(), "mykey", "ShowReport('" + requestId + "','" + rptName + "');", true);

        }
    }
            
    protected void gvSubmittedRequests_ItemCreated(object sender, GridItemEventArgs e)
    {
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
    
    protected void gvSubmittedRequests_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {
        Hashtable ht = new Hashtable();
        ht.Add("@UserID", Session["_UserID"].ToString());
        ht.Add("@FormTypeID", Request.QueryString["FormType"]);
//        ht.Add("@trxstatus", 3);
        DataTable dt = clsDAL.GetDataSet("sp_User_Get_Submitted_AttendanceT2", ht).Tables[0];
        gvSubmittedRequests.DataSource = dt;
    }
        
    #endregion
            
    #region Tab4 - Pending Approval
                    
    protected void gvPendingAppRequests_DetailTableDataBind(object sender, GridDetailTableDataBindEventArgs e)
    {
        GridDataItem dataItem = (GridDataItem)e.DetailTableView.ParentItem;
                    
        switch (e.DetailTableView.Name)
        {
            case "RequestStatuses":
                {
                    string ID = dataItem.GetDataKeyValue("RequestID").ToString();

                    Hashtable ht = new Hashtable();
                    ht.Add("@AttEntTrxID", ID);
                    DataTable dt = clsDAL.GetDataSet("sp_User_Get_AttEntTrx_Statuses", ht).Tables[0];
                    dt.TableName = "tbl_AttEntTrx_Status";
                    e.DetailTableView.DataSource = dt;
                    e.DetailTableView.DataMember = "tbl_AttEntTrx_Status";
    
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowTab", "ShowTab('#tab4');", true);
        
                    break;
                }
        }
    }
            
    protected void gvPendingAppRequests_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == "Approve")
        {
            string[] arg = new string[2];
            arg = e.CommandArgument.ToString().Split(';');
            Session["IdTemplate"] = arg[0];
            int id = Int32.Parse(arg[0]);
            int requestStatusid = Int32.Parse(arg[1]);
            Session["_recidd"] = id;
            Session["_CurrtrxNumber"] = arg[0].ToString();
            Session["_Tab1Function"] = "Edit";
            Session["_RequestStatusID"] = requestStatusid;
            gvAtt.Rebind();
            rBtnSave.Visible = false;
            rBtnSaveAndSubmit.Visible = false;
            TopPanel.Visible = false;
            ApprovalPanel.Visible = true;
            bindCombos();
            gvHistory.Rebind();
            ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowTab", "ShowTab('#tab1');", true);
            ScriptManager.RegisterStartupScript(this, this.GetType(), "RefreshGrid", "refreshGrid2();", true);
        }
            
        if (e.CommandName == "View")
        {
          //  Session["_CurrtrxNumber"] = e.CommandArgument.ToString();

            Session["_Tab1Function"] = "View";
            string[] arg = new string[2];
            arg = e.CommandArgument.ToString().Split(';');
            Session["IdTemplate"] = arg[0];
            int id = Int32.Parse(arg[0]);
            Session["_recidd"] = id;
            Session["_CurrtrxNumber"] = arg[1].ToString();

            gvAtt.Rebind();
            rBtnSave.Visible = false;
            rBtnSaveAndSubmit.Visible = false;
            TopPanel.Visible = false;
            ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowTab", "ShowTab('#tab1');", true);
            ScriptManager.RegisterStartupScript(this, this.GetType(), "RefreshGrid", "refreshGrid2();", true);
        }
        if (e.CommandName == "Print")
        {
            string printOption = "";
            if (ddlPrintOptions.SelectedItem != null)
            {
                printOption = ddlPrintOptions.SelectedItem.Text;
            }
            string requestId = clsEncryption.EncryptData(e.CommandArgument.ToString());
            // bring report from formtype
            string rptName = clsEncryption.EncryptData("TimeSheetbyProject");
            ScriptManager.RegisterStartupScript(this, Page.GetType(), "mykey", "ShowReport('" + requestId + "','" + rptName + "');", true);

        }
    }
            
    protected void gvPendingAppRequests_ItemCreated(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridDataItem)
        {
            //ImageButton imgBtnApprove = (ImageButton)e.Item.FindControl("imgBtnApprove");
            //if (imgBtnApprove != null)
            //{
            //    imgBtnApprove.Attributes["onclick"] = String.Format("return ShowApproveForm('{0}','{1}','{2}','{3}');",
            //        e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["RequestID"],
            //        e.Item.ItemIndex,
            //        e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["RequestStatusID"],
            //        Request.QueryString["FormType"]);
            //}
            //ImageButton imgBtnView = (ImageButton)e.Item.FindControl("imgBtnView");
            //if (imgBtnView != null)
            //    imgBtnView.Attributes["onclick"] = String.Format("return ShowPendingViewForm('{0}','{1}','{2}','{3}');", e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["RequestID"], e.Item.ItemIndex, Request.QueryString["FormType"], true);
        }
    }
    
    protected void gvPendingAppRequests_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {
        Hashtable ht = new Hashtable();
        ht.Add("@UserID", Session["_UserID"].ToString());
        DataTable dt = clsDAL.GetDataSet("sp_User_Get_AttendanceT2_For_Approval", ht).Tables[0];
        gvPendingAppRequests.DataSource = dt;
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

            if (dataItem["colRequestStatus"].Text == "Request Approved")
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
                    
    protected void gvApprovedRequests_DetailTableDataBind(object sender, GridDetailTableDataBindEventArgs e)
    {
        GridDataItem dataItem = (GridDataItem)e.DetailTableView.ParentItem;

        switch (e.DetailTableView.Name)
        {
            case "RequestStatuses":
                {
                    string ID = dataItem.GetDataKeyValue("RequestID").ToString();
                    
                    Hashtable ht = new Hashtable();
                    ht.Add("@AttEntTrxID", ID);
                
                    DataTable dt = clsDAL.GetDataSet("sp_User_Get_AttEntTrx_Statuses", ht).Tables[0];
                    dt.TableName = "tbl_AttEntTrx_Status";
                    e.DetailTableView.DataSource = dt;
                    e.DetailTableView.DataMember = "tbl_AttEntTrx_Status";
    
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowTab", "ShowTab('#tab5');", true);
        
                    break;
                }
        }
    }
            
    protected void gvApprovedRequests_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == "View")
        {
          //  Session["_CurrtrxNumber"] = e.CommandArgument.ToString();

            Session["_Tab1Function"] = "View";
            string[] arg = new string[2];
            arg = e.CommandArgument.ToString().Split(';');
            Session["IdTemplate"] = arg[0];
            int id = Int32.Parse(arg[0]);
            Session["_recidd"] = id;
            Session["_CurrtrxNumber"] = arg[1].ToString();

            gvAtt.Rebind();
            rBtnSave.Visible = false;
            rBtnSaveAndSubmit.Visible = false;
            TopPanel.Visible = false;
            ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowTab", "ShowTab('#tab1');", true);
            ScriptManager.RegisterStartupScript(this, this.GetType(), "RefreshGrid", "refreshGrid2();", true);


            
            //Session["_CurrtrxNumber"] = e.CommandArgument.ToString();
            //Session["_Tab1Function"] = "View";
            //gvAtt.Rebind();
            //rBtnSave.Visible = false;
            //rBtnSaveAndSubmit.Visible = false;
            //TopPanel.Visible = false;
            //ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowTab", "ShowTab('#tab1');", true);
            //ScriptManager.RegisterStartupScript(this, this.GetType(), "RefreshGrid", "refreshGrid2();", true);
        }
        if (e.CommandName == "Print")
        {
            string printOption = "";
            if (ddlPrintOptions.SelectedItem != null)
            {
                printOption = ddlPrintOptions.SelectedItem.Text;
            }
            string requestId = clsEncryption.EncryptData(e.CommandArgument.ToString());
            // bring report from formtype
            string rptName = clsEncryption.EncryptData("TimeSheetbyProject");
            ScriptManager.RegisterStartupScript(this, Page.GetType(), "mykey", "ShowReport('" + requestId + "','" + rptName + "');", true);

        }
    }
                
    protected void gvApprovedRequests_ItemCreated(object sender, GridItemEventArgs e)
    {
        //ImageButton imgBtnView = (ImageButton)e.Item.FindControl("imgBtnView");
        //if (imgBtnView != null)
        //{
        //    imgBtnView.Attributes["onclick"] = String.Format("return ShowApproveForm('{0}','{1}','{2}','{3}');",
        //        e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["RequestID"],
        //        e.Item.ItemIndex,
        //        e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["RequestStatusID"],
        //        Request.QueryString["FormType"]);
        //}
    }
            
    protected void gvApprovedRequests_ItemDataBound(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridDataItem && e.Item.OwnerTableView.Name == "RequestStatuses")
        {
            Color col_current = System.Drawing.ColorTranslator.FromHtml("#FF0090");
            Color col_pending = System.Drawing.ColorTranslator.FromHtml("#f7e81d");
            Color col_approved = System.Drawing.ColorTranslator.FromHtml("#49F27C");
            Color col_returned = System.Drawing.ColorTranslator.FromHtml("#49de94");
            Color col_rejected = System.Drawing.ColorTranslator.FromHtml("#ed788a ");
            Color col_rejectedcompletion = System.Drawing.ColorTranslator.FromHtml("#ff0026 ");

            Color col_revised = System.Drawing.ColorTranslator.FromHtml("#A7B3DB");
            Color col_initiated = System.Drawing.ColorTranslator.FromHtml("#FAF873");
            Color col_completed = System.Drawing.ColorTranslator.FromHtml("#006426");
            Color col_completed_fore = System.Drawing.ColorTranslator.FromHtml("#fffaf0");
            Color col_completedReject_fore = System.Drawing.ColorTranslator.FromHtml("#ffffff");

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
            if (dataItem["colRequestStatus"].Text == "Request Rejected")
            {
                cell.BackColor = col_rejectedcompletion;
                cell.ForeColor = col_completedReject_fore;
            }

            if (dataItem["colRequestStatus"].Text == "Rejected")
            {
                cell.BackColor = col_rejected;
                cell.ForeColor = col_completedReject_fore;
                
            }

            if (dataItem["colRequestStatus"].Text == "Request Approved")
            {
                cell.BackColor = col_completed;
                cell.ForeColor = col_completed_fore;
            }
        
            if (dataItem["collevelcolor"].Text == "True")
                cell.BackColor = col_current;
        }
    }
    
    protected void gvApprovedRequests_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {
        Hashtable ht = new Hashtable();
        ht.Add("@UserID", Session["_UserID"].ToString());
        DataTable dt = clsDAL.GetDataSet("sp_User_Get_Approved_AttendanceT2", ht).Tables[0];
        gvApprovedRequests.DataSource = dt;
    }
        
    #endregion
            
    protected void ddlEmployee_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        RadComboBox ddlEmp = sender as RadComboBox;
        GridEditFormItem eiditedItem = ddlEmp.NamingContainer as GridEditFormItem;
            
        RadComboBox ddlProject = (((RadComboBox)sender).Parent.FindControl("ddlProject") as RadComboBox);
        if (ddlProject != null)
        {
            ddlProject.Items[0].Value = "";
            ddlProject.Items[0].Text = "";
            ddlProject.SelectedValue = "";
            RadGrid PrjGrid = ddlProject.Items[0].FindControl("rGrdProject4DDL") as RadGrid;
            if (PrjGrid != null)
            {
                PrjGrid.Rebind();
                string id = "";
                string code = "";
                    
                if (ddlProjectOuter.Items[0].Value != null && rcbProject.Checked == true)
                {
                    id = ddlProjectOuter.Items[0].Value.ToString();
                    code = ddlProjectOuter.Items[0].Text.ToString();
                }
                else if (gvAtt.MasterTableView.Items.Count > 0)
                {
                    id = gvAtt.Items[gvAtt.MasterTableView.Items.Count - 1].GetDataKeyValue("prjidd").ToString();
                    code = gvAtt.Items[gvAtt.MasterTableView.Items.Count - 1].GetDataKeyValue("prjcod").ToString();
                }
                            
                foreach (GridItem item in PrjGrid.MasterTableView.Items)
                {
                    if (item is GridDataItem)
                    {
                        if (id.Equals(item.OwnerTableView.DataKeyValues[item.ItemIndex]["prjidd"].ToString()))
                        {
                            ddlProject.Items[0].Value = id;
                            ddlProject.Items[0].Text = code;
                            ddlProject.SelectedValue = id;
                            break;
                        }
                        else if (item.ItemIndex == 0)
                        {
                            ddlProject.Items[0].Value = item.OwnerTableView.DataKeyValues[item.ItemIndex]["prjidd"].ToString();
                            ddlProject.Items[0].Text = item.OwnerTableView.DataKeyValues[item.ItemIndex]["prjcod"].ToString();
                            ddlProject.SelectedValue = item.OwnerTableView.DataKeyValues[item.ItemIndex]["prjidd"].ToString();
                        }
                    }
                }
            }
        }
            
        string empcod = ddlEmp.Items[0].Text;
        htSearchParams = new Hashtable();
        htSearchParams["@employeeCode"] = empcod;
            
        DataTable dt = clsDAL.GetDataSet_Payroll("sp_User_Get_EmpPosDetail", htSearchParams).Tables[0];
        if (dt.Rows.Count > 0)
        {
            DataRow row = dt.Rows[0];
            string id = row[0].ToString();
            string code = row[1].ToString();
            RadComboBox ddlEmpPosition = (((RadComboBox)sender).Parent.FindControl("ddlEmpPos") as RadComboBox);
            if (ddlEmpPosition != null)
            {
                RadGrid EmpPosGrid = ddlEmpPosition.Items[0].FindControl("rGrdEmpPos4DDL") as RadGrid;
                if (EmpPosGrid != null)
                {
                    //EmpPosGrid.Rebind();
                    ddlEmpPosition.Items[0].Value = id;
                    ddlEmpPosition.Items[0].Text = code;
                    ddlEmpPosition.Text = code;
                                
                    foreach (GridItem item in EmpPosGrid.MasterTableView.Items)
                    {
                        if (item is GridDataItem)
                        {
                            if (id.Equals(item.OwnerTableView.DataKeyValues[item.ItemIndex]["posidd"].ToString()))
                            //if (item.GetDataKeyValue("posidd").ToString() == id)
                            {
                                item.Selected = true;
                                break;
                            }
                        }
                    }
                }
            }
        }
        //ScriptManager.RegisterStartupScript(this, this.GetType(), "SettingDefaultEmpPos", "SettingDefaultEmpPos('" + id + "','" + code + "');", true);
    }
        
    private void bindCombos()
    {
        //if (null != Session["_UserID"] && !string.IsNullOrEmpty(Request.QueryString["FormType"]))
        //{
        RadGrid grid;
        rCmbLevels.ClearSelection();
    
        Hashtable ht_transactionentryid = new Hashtable();
        ht_transactionentryid.Add("@AttEntTrxID", int.Parse(Session["_recidd"].ToString()));
        grid = rCmbLevels.Items[0].FindControl("rGrdLevels4DDL") as RadGrid;
        grid.DataSource = clsDAL.GetDataSet("sp_Get_Revise_Users_Of_AttEntry", ht_transactionentryid).Tables[0];
        grid.Rebind();
        //}
    }
        
    protected void rBtnApprove_Click(object sender, EventArgs e)
    {
        try
        {
            RequestID = Convert.ToInt32(Session["_recidd"]);
            Hashtable ht = new Hashtable();

            ht.Add("@RequestID", Session["_recidd"]);
            ht.Add("@RequestStatusID", Session["_RequestStatusID"]);
            ht.Add("@ApproverUserID", Session["_UserID"].ToString());
            ht.Add("@TransRemarks", txtremarks.Text);
            ht.Add("@DBMessage", "");
             
            string DBMessage = clsDAL.ExecuteNonQuery("sp_User_Approve_AttendanceT2", ht, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
            //ReBindAllGrids();
//            if ((null != DBMessage) && DBMessage.Contains("ERROR:"))
            {
                compileEmail(RequestID, 1);
            }
            Hashtable ht_nextnumber = new Hashtable();
            ht_nextnumber.Add("@seqcod", "ATTENTRYT2");
            ht_nextnumber.Add("@TRX_ID", null);
            //sp_User_Increment_Seq_Number
         //   Session["_CurrtrxNumber"] = clsDAL.ExecuteNonQuery("sp_User_Get_Next_Transaction_Number", ht_nextnumber, "@TRX_ID", System.Data.SqlDbType.NVarChar, 255) as string;
            Session["_recidd"] = 0;
            Session["_ReimbTab1Function"] = "New";
            reBindAllTabGrids();
            //ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowTab", "ShowTab('#tab1');", true);
            //ScriptManager.RegisterStartupScript(this, this.GetType(), "RefreshGrid", "refreshGrid2();", true);
           // rBtnSave.Visible = true;
            rBtnSaveAndSubmit.Visible = true;
            TopPanel.Visible = true;
            ApprovalPanel.Visible = false;

            if ((null != DBMessage) && DBMessage.Contains("ERROR:"))
            {
                ShowClientMessage("Sorry! some error has occurred. Please try again later.", MessageType.Error);
            }
            else
            {
                //ScriptManager.RegisterStartupScript(this, Page.GetType(), "mykey", "CloseAndRebind('" + "Processed Successfully" + "');", true);
                ShowClientMessage("Processed successfully.", MessageType.Success);
                ScriptManager.RegisterStartupScript(this, this.GetType(), "GoToNewEntriesState", "GoToNewEntriesState();", true);
            }
        }
        catch (Exception ex)
        {
            ShowClientMessage(ex.Message, MessageType.Error);
        }
    }

        //try
        //{
        //    Hashtable ht = new Hashtable();
        //    ht.Add("@LeaveID", Request.QueryString["RequestID"]);
        //    ht.Add("@LeaveStatusID", Request.QueryString["RequestStatusID"]);
        //    ht.Add("@ApproverUserID", Session["_UserID"].ToString());
        //    ht.Add("@TransRemarks", txtremarks.Text);
        //    ht.Add("@DBMessage", "");
        //    string DBMessage = clsDAL.ExecuteNonQuery("sp_User_Approve_LeaveTransaction", ht, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
        //    //ht = null;
        //    //ht = new Hashtable();
        //    //ht.Add("@LeaveTransactionID", Request.QueryString["RequestID"]);
        //    //DataTable dt = clsDAL.GetDataSet("sp_User_Get_LeaveTransaction_Info_4_Email", ht).Tables[0];
        //    //if ((null != dt) && dt.Rows.Count > 0)
        //    //{
        //    //    ht = null;
        //    //    ht = new Hashtable();
        //    //    ht.Add("@LeaveTransactionID", Request.QueryString["LeaveTransactionID"]);
        //    //    ht.Add("@RedirectURL", Request.Url.AbsoluteUri);
        //    //    //clsCommon.SendMail(3, ht);
        //    //}
        //    if ((null != DBMessage) && DBMessage.Contains("ERROR:"))
        //    {
        //        ShowClientMessage("Sorry! some error has occurred. Please try again later.", MessageType.Error);
        //    }
        //    else
        //    {
        //        //ScriptManager.RegisterStartupScript(this, Page.GetType(), "mykey", "CloseAndRebind('" + "Processed Successfully" + "');", true);
        //        ShowClientMessage("Processed successfully.", MessageType.Success);
        //    }
        //}
        //catch (Exception ex)
        //{
        //    ShowClientMessage(ex.Message, MessageType.Error);
        //}
            
    protected void rBtnReject_Click(object sender, EventArgs e)
    {
        try
        {

            Hashtable ht = new Hashtable();
            ht.Add("@RequestID", Session["_recidd"]);
            ht.Add("@RequestStatusID", Session["_RequestStatusID"]);
            ht.Add("@ApproverUserID", Session["_UserID"].ToString());
            ht.Add("@TransRemarks", txtremarks.Text);
            ht.Add("@DBMessage", "");

            int EmailRequestID = Convert.ToInt32(Session["_recidd"]);
                
            string DBMessage = clsDAL.ExecuteNonQuery("sp_User_Reject_AttendanceT2_Request", ht, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
            
            if ((null != DBMessage) && DBMessage.Contains("ERROR:"))
            {
                ShowClientMessage("Sorry! some error has occurred. Please try again later.", MessageType.Error);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, Page.GetType(), "mykey", "CloseAndRebind('" + "Processed Successfully" + "');", true);
                ShowClientMessage("Processed successfully.", MessageType.Success);
                
                Hashtable ht_nextnumber = new Hashtable();
                ht_nextnumber.Add("@seqcod", "ATTENTRYT2");
                ht_nextnumber.Add("@TRX_ID", null);
       //         Session["_CurrtrxNumber"] = clsDAL.ExecuteNonQuery("sp_User_Get_Next_Transaction_Number", ht_nextnumber, "@TRX_ID", System.Data.SqlDbType.NVarChar, 255) as string;
                Session["_ReimbTab1Function"] = "New";
                Session["_recidd"] = 0;
               
                //ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowTab", "ShowTab('#tab1');", true);
                //ScriptManager.RegisterStartupScript(this, this.GetType(), "RefreshGrid", "refreshGrid2();", true);
               // rBtnSave.Visible = true;
                rBtnSaveAndSubmit.Visible = true;
                TopPanel.Visible = true;
                ApprovalPanel.Visible = false;
                reBindAllTabGrids();
                if ((null != DBMessage) && DBMessage.Contains("ERROR:"))
                {
                    ShowClientMessage("Sorry! some error has occurred. Please try again later.", MessageType.Error);
                }
                else
                {
                    //ScriptManager.RegisterStartupScript(this, Page.GetType(), "mykey", "CloseAndRebind('" + "Processed Successfully" + "');", true);
                    ShowClientMessage("Processed successfully.", MessageType.Success);
                    compileEmail(EmailRequestID,6);

                    ScriptManager.RegisterStartupScript(this, this.GetType(), "GoToNewEntriesState", "GoToNewEntriesState();", true);
                }
            }
        }
        catch (Exception ex)
        {
            ShowClientMessage(ex.Message, MessageType.Error);
        }
    }
    protected void reBindAllTabGrids()
    {
        gvAtt.Rebind();
        gvSavedRequests.Rebind();
        gvSubmittedRequests.Rebind();
        gvPendingAppRequests.Rebind();
        gvApprovedRequests.Rebind();
    }



    protected void rBtnRevise_Click(object sender, EventArgs e)
    {
        //     //MultiView1.ActiveViewIndex = 1;
        //try
        //{
        //    RadGrid grid;
        //    grid = rCmbLevels.Items[0].FindControl("rGrdLevels4DDL") as RadGrid;
        //    if (grid.SelectedValue != null)
        //    {
        //        int transactionstatusid;
        //        transactionstatusid = Int32.Parse(grid.SelectedValue.ToString());
        //        Hashtable ht = new Hashtable();
        //        ht.Add("@TransactionEntryRequestID", Request.QueryString["RequestID"]);
        //        ht.Add("@TransactionEntryStatusID", Request.QueryString["RequestStatusID"]);
        //        ht.Add("@ApproverUserID", Session["_UserID"].ToString());
        //        ht.Add("@transRemarks", txtremarks.Text);
        //        ht.Add("@revisetostatusid", transactionstatusid);
        //        ht.Add("@DBMessage", "");
        //        string DBMessage = clsDAL.ExecuteNonQuery("sp_User_Revise_Leave_Request", ht, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
        //        if ((null != DBMessage) && DBMessage.Contains("ERROR:"))
        //        {
        //            ShowClientMessage("Sorry! some error has occurred. Please try again later.", MessageType.Error);
        //        }
        //        else
        //        {
        //            ScriptManager.RegisterStartupScript(this, Page.GetType(), "mykey", "CloseAndRebind('" + "Processed Successfully" + "');", true);
        //        }
        //    }
        //    else
        //        ShowClientMessage("User Required", MessageType.Error);
        //}
        //catch (Exception ex)
        //{
        //    ShowClientMessage(ex.Message, MessageType.Error);
        //}

        ScriptManager.RegisterStartupScript(this, this.GetType(), "GoToNewEntriesState", "GoToNewEntriesState();", true);
    }
            
    // History grid data loading and binding
    protected void gvHistory_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {
        if (Session["_recidd"] != null)
        {
            htSearchParams = new Hashtable();
            htSearchParams.Add("@recordId", int.Parse(Session["_recidd"].ToString()));
            DataTable dt = clsDAL.GetDataSet_Payroll("sp_User_Get_AttendanceT2Trx_History", htSearchParams).Tables[0];
            dt.TableName = "HistoryMaster";
            Session["Rows"] = dt.Rows.Count;
            gvHistory.DataSource = dt;
            gvHistory.DataMember = "HistoryMaster";
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
                    
    protected void gvAtt_DetailTableDataBind(object sender, GridDetailTableDataBindEventArgs e)
    {
        GridDataItem dataItem = (GridDataItem)e.DetailTableView.ParentItem;

        switch (e.DetailTableView.Name)
        {
            case "HourType":
                {
                    string ID = dataItem.GetDataKeyValue("recidd").ToString();
                
                    Hashtable ht = new Hashtable();
                    ht.Add("@mrecidd", ID);
                    
                    DataTable dt = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_EmpHourTypeDetail_Records", ht).Tables[0];
                    dt.TableName = "HourType";
                    e.DetailTableView.DataSource = dt;
                    e.DetailTableView.DataMember = "HourType";
                    break;
                }
            case "PremiumType":
                {
                    string ID = dataItem.GetDataKeyValue("recidd").ToString();
                
                    Hashtable ht = new Hashtable();
                    ht.Add("@mrecidd", ID);
                    
                    DataTable dt = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_EmpPremTypeDetail_Records", ht).Tables[0];
                    dt.TableName = "PremiumType";
                    e.DetailTableView.DataSource = dt;
                    e.DetailTableView.DataMember = "PremiumType";
                    break;
                }
            case "PremiumType2":
                {
                    //GridDataItem dataItem2 = (GridDataItem)dataItem.OwnerTableView.ParentItem;
                    string ID = dataItem.GetDataKeyValue("mrecidd").ToString();
                    string ID2 = dataItem.GetDataKeyValue("recidd").ToString();
                    
                    Hashtable ht = new Hashtable();
                    ht.Add("@mrecidd", ID);
                    ht.Add("@hrtdidd", ID2);

                    DataTable dt = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_Emp_Hrt_Prt_Records", ht).Tables[0];
                    dt.TableName = "PremiumType2";
                    e.DetailTableView.DataSource = dt;
                    e.DetailTableView.DataMember = "PremiumType2";
                    break;
                }
        }
    }
        
    
    protected void ddlEmployeeOuter_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        ddlHourClassOuter.Items[0].Value = "";
        ddlHourClassOuter.Items[0].Text = "";
        ddlHourClassOuter.SelectedValue = "";
        RadGrid hcgrid = ddlHourClassOuter.Items[0].FindControl("rGrdHourClassOuter4DDL") as RadGrid;
        hcgrid.Rebind();
        ddlProjectOuter.Items[0].Value = "";
        ddlProjectOuter.Items[0].Text = "";
        ddlProjectOuter.SelectedValue = "";
        RadGrid pgrid = ddlProjectOuter.Items[0].FindControl("rGrdProjectOuter4DDL") as RadGrid;
        pgrid.Rebind();
    }
        
    //ddl project outer data loading and binding
    protected void rGrdProjectOuter4DDL_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {
        if (!String.IsNullOrEmpty(ddlEmployeeOuter.Items[0].Value))
        {
            htSearchParams = new Hashtable();
            RadGrid grid = sender as RadGrid;
            htSearchParams["@employeeIDD"] = Convert.ToInt32(ddlEmployeeOuter.Items[0].Value);
            grid.DataSource = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_ProjectEmployeeAssignment", htSearchParams).Tables[0];
        }
    }
    // ddl hour class outer data loading and binding   
    protected void rGrdHourClassOuter4DDL_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {
        if (!String.IsNullOrEmpty(ddlEmployeeOuter.Items[0].Value))
        {
            htSearchParams = new Hashtable();
            RadGrid grid = sender as RadGrid;
            htSearchParams["@employeeIDD"] = Convert.ToInt32(ddlEmployeeOuter.Items[0].Value);
            grid.DataSource = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_HourTypeEmployeeAssignment", htSearchParams).Tables[0];
        }
    }
                
    // ddl hour class data loading and binding    
    protected void rGrdHourClass4DDL_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    { 
        if (Session["_Empid"] != null)
        {
            if (Session["_Empid"].ToString() != "")
            {
                RadGrid grid = sender as RadGrid;
                htSearchParams = new Hashtable();
                htSearchParams["@employeeIDD"] = Convert.ToInt32(Session["_Empid"].ToString());
                grid.DataSource = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_HourTypeEmployeeAssignment", htSearchParams).Tables[0];
            }
        }
    }
            
    // proj ddl data loading and binding
    protected void rGrdProject4DDL_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {
        RadGrid prjgrid = sender as RadGrid;
        RadComboBox ddlProject = prjgrid.Parent.Parent as RadComboBox;
        if (ddlProject != null)
        {
            RadComboBox ddlEmployee = ddlProject.Parent.FindControl("ddlEmployee") as RadComboBox;
            if (ddlEmployee != null)
            {
                if (!String.IsNullOrEmpty(ddlEmployee.Items[0].Value))
                {
                    htSearchParams = new Hashtable();
                    htSearchParams["@employeeIDD"] = Convert.ToInt32(ddlEmployee.Items[0].Value);
                    prjgrid.DataSource = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_ProjectEmployeeAssignment", htSearchParams).Tables[0];
                }
            }
        }
    }

    //ddl sub project data loading and binding
    protected void rGrdSubProject4DDL_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {
        RadGrid subprjgrid = sender as RadGrid;
        RadComboBox ddlSubProject = subprjgrid.Parent.Parent as RadComboBox;
        if (ddlSubProject != null)
        {
            RadComboBox ddlProject = ddlSubProject.Parent.FindControl("ddlProject") as RadComboBox;
            if (ddlProject != null)
            {
                if (!String.IsNullOrEmpty(ddlProject.Items[0].Value))
                {
                    htSearchParams = new Hashtable();
                    htSearchParams["@prjidd"] = Convert.ToInt32(ddlProject.Items[0].Value);
                    subprjgrid.DataSource = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_SubProjectsByPrjId", htSearchParams).Tables[0];
                }
            }
        }

    }

    //ddl project selected index change function
    protected void ddlProject_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        RadComboBox ddlProject = sender as RadComboBox;
        GridEditFormItem eiditedItem = ddlProject.NamingContainer as GridEditFormItem;

        RadComboBox ddlSubProject = (((RadComboBox)sender).Parent.FindControl("ddlSubProject") as RadComboBox);
        if (ddlSubProject != null)
        {
            ddlSubProject.Items[0].Value = "";
            ddlSubProject.Items[0].Text = "";
            ddlSubProject.SelectedValue = "";
            RadGrid SubPrjGrid = ddlSubProject.Items[0].FindControl("rGrdSubProject4DDL") as RadGrid;
            if (SubPrjGrid != null)
            {
                SubPrjGrid.Rebind();
            }
        }
    }

    //ddl premium type selected index change function
    protected void ddlPremType_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        RadComboBox ddlPremType = sender as RadComboBox;
        GridEditFormItem editedItem = ddlPremType.NamingContainer as GridEditFormItem;
        GridDataItem ParentItem = editedItem.OwnerTableView.ParentItem as GridDataItem;
        RadNumericTextBox txtPremium = editedItem.FindControl("txtPremium") as RadNumericTextBox;
        if (!string.IsNullOrEmpty(ddlPremType.Items[0].Value.ToString()))
        {
        Hashtable ht = new Hashtable();
        ht["@ID"] = Convert.ToInt32(ddlPremType.Items[0].Value);
        DataTable dt = clsDAL.GetDataSet_Payroll("sp_Payroll_GetPremTypeDtl", ht).Tables[0];

        if (dt != null)
        {
            if (ParentItem.GetDataKeyValue("IsWeekend").ToString() == "1")
            {
                foreach (DataRow row in dt.Rows)
                {
                    if (row["daytcod"].ToString() == "Weekend")
                    {
                        if(!string.IsNullOrEmpty(row["defval"].ToString()))
                        {
                            txtPremium.Text = row["defval"].ToString();
                        }
                        else if (!string.IsNullOrEmpty(row["fromval"].ToString()))
                        {
                            txtPremium.Text = row["fromval"].ToString();
                        }
                            else
                            {
                                txtPremium.Text = "0";
                            }
                    }
                }
            }
            else if (ParentItem.GetDataKeyValue("IsPublicHoliday").ToString() == "1")
            {
                foreach (DataRow row in dt.Rows)
                {
                    if (row["daytcod"].ToString() == "Off Day")
                    {
                        if (!string.IsNullOrEmpty(row["defval"].ToString()))
                        {
                            txtPremium.Text = row["defval"].ToString();
                        }
                        else if (!string.IsNullOrEmpty(row["fromval"].ToString()))
                        {
                            txtPremium.Text = row["fromval"].ToString();
                        }
                            else
                            {
                                txtPremium.Text = "0";
                            }
                    }
                }
            }
            else
            {
                foreach (DataRow row in dt.Rows)
                {
                    if (row["daytcod"].ToString() == "Working Days")
                    {
                        if (!string.IsNullOrEmpty(row["defval"].ToString()))
                        {
                            txtPremium.Text = row["defval"].ToString();
                        }
                        else if (!string.IsNullOrEmpty(row["fromval"].ToString()))
                        {
                            txtPremium.Text = row["fromval"].ToString();
                        }
                            else
                            {
                                txtPremium.Text = "0";
                            }
                    }
                }
            }


        }
        }           
    }
                    
    //ddl hour class selected index change function
    protected void ddlHourClass_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        RadComboBox ddlHourClass = sender as RadComboBox;
        GridEditFormItem editedItem = ddlHourClass.NamingContainer as GridEditFormItem;
        GridDataItem ParentItem = editedItem.OwnerTableView.ParentItem as GridDataItem;
        RadNumericTextBox txtHours = editedItem.FindControl("txtHours") as RadNumericTextBox;
        if (!string.IsNullOrEmpty(ddlHourClass.Items[0].Value.ToString()))
        {
        Hashtable ht = new Hashtable();
        ht["@ID"] = Convert.ToInt32(ddlHourClass.Items[0].Value);
        DataTable dt = clsDAL.GetDataSet_Payroll("sp_Payroll_GetHourTypeById", ht).Tables[0];

        if (dt != null)
        {
            foreach (DataRow row in dt.Rows)
                {
                    if (!string.IsNullOrEmpty(row["defval"].ToString()))
                        {
                            txtHours.Text = row["defval"].ToString();
                        }
                        else if (!string.IsNullOrEmpty(row["fromval"].ToString()))
                        {
                            txtHours.Text = row["fromval"].ToString();
                        }
                    else
                    {
                        txtHours.Text = "0";
                    }
                }
                }
        }
    }

    //ddl premiumtype2 selected index change function
    protected void ddlPremType2_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        RadComboBox ddlPremType = sender as RadComboBox;
        GridEditFormItem editedItem = ddlPremType.NamingContainer as GridEditFormItem;
        GridDataItem hrtItem = editedItem.OwnerTableView.ParentItem as GridDataItem;
        GridDataItem ParentItem = hrtItem.OwnerTableView.ParentItem as GridDataItem;

        RadNumericTextBox txtPremium = editedItem.FindControl("txtPremium") as RadNumericTextBox;
        if (!string.IsNullOrEmpty(ddlPremType.Items[0].Value.ToString()))
        {
            Hashtable ht = new Hashtable();
            ht["@ID"] = Convert.ToInt32(ddlPremType.Items[0].Value);
            DataTable dt = clsDAL.GetDataSet_Payroll("sp_Payroll_GetPremTypeDtl", ht).Tables[0];

            if (dt != null)
            {
                if (ParentItem.GetDataKeyValue("IsWeekend").ToString() == "1")
                {
                    foreach (DataRow row in dt.Rows)
                    {
                        if (row["daytcod"].ToString() == "Weekend")
                        {
                            if (!string.IsNullOrEmpty(row["defval"].ToString()))
                            {
                                txtPremium.Text = row["defval"].ToString();
                            }
                            else if (!string.IsNullOrEmpty(row["fromval"].ToString()))
                            {
                                txtPremium.Text = row["fromval"].ToString();
                            }
                            else
                            {
                                txtPremium.Text = "0";
                            }
                        }
                    }
                }
                else if (ParentItem.GetDataKeyValue("IsPublicHoliday").ToString() == "1")
                {
                    foreach (DataRow row in dt.Rows)
                    {
                        if (row["daytcod"].ToString() == "Off Day")
                        {
                            if (!string.IsNullOrEmpty(row["defval"].ToString()))
                            {
                                txtPremium.Text = row["defval"].ToString();
                            }
                            else if (!string.IsNullOrEmpty(row["fromval"].ToString()))
                            {
                                txtPremium.Text = row["fromval"].ToString();
                            }
                            else
                            {
                                txtPremium.Text = "0";
                            }
                        }
                    }
                }
                else
                {
                    foreach (DataRow row in dt.Rows)
                    {
                        if (row["daytcod"].ToString() == "Working Days")
                        {
                            if (!string.IsNullOrEmpty(row["defval"].ToString()))
                            {
                                txtPremium.Text = row["defval"].ToString();
                            }
                            else if (!string.IsNullOrEmpty(row["fromval"].ToString()))
                            {
                                txtPremium.Text = row["fromval"].ToString();
                            }
                            else
                            {
                                txtPremium.Text = "0";
                            }
                        }
                    }
                }
            }
        }           
    }


    #region ddls filtering settings 
    protected void rGrdSubProject4DDL_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == RadGrid.FilterCommandName) //FilterCommandName is raised when filtered
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "OpenSubProjectddl", "OpenSubProjectddl();", true);
        }
    }
    protected void rGrdEmployee4DDL_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == RadGrid.FilterCommandName) //FilterCommandName is raised when filtered
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "OpenEmployeeddl", "OpenEmployeeddl();", true);
        }
    }
    protected void rGrdProject4DDL_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == RadGrid.FilterCommandName) //FilterCommandName is raised when filtered
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "OpenProjectddl", "OpenProjectddl();", true);
        }
    }
    protected void rGrdEmpPos4DDL_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == RadGrid.FilterCommandName) //FilterCommandName is raised when filtered
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "OpenEmpPosddl", "OpenEmpPosddl();", true);
        }
    }
    protected void rGrdHourClass4DDL_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == RadGrid.FilterCommandName) //FilterCommandName is raised when filtered
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "OpenHourClassddl", "OpenHourClassddl();", true);
        }
    }
    protected void rGrdPremType4DDL_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == RadGrid.FilterCommandName) //FilterCommandName is raised when filtered
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "OpenPremTypeddl", "OpenPremTypeddl();", true);
        }
    }
    protected void rGrdPremType4DDL_ItemCommand1(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == RadGrid.FilterCommandName) //FilterCommandName is raised when filtered
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "OpenPremType2ddl", "OpenPremType2ddl();", true);
        }
    }
    protected void rGrdEmployeeOuter4DDL_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == RadGrid.FilterCommandName) //FilterCommandName is raised when filtered
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "OpenEmployeeOuterddl", "OpenEmployeeOuterddl();", true);
        }
    }
    protected void rGrdProjectOuter4DDL_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == RadGrid.FilterCommandName) //FilterCommandName is raised when filtered
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "OpenProjectOuterddl", "OpenProjectOuterddl();", true);
        }
    }
    protected void rGrdHourClassOuter4DDL_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == RadGrid.FilterCommandName) //FilterCommandName is raised when filtered
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "OpenHrClassOuterddl", "OpenHrClassOuterddl();", true);
        }
    }
    protected void rGrdPremTypeOuter4DDL_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == RadGrid.FilterCommandName) //FilterCommandName is raised when filtered
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "OpenPremOuterddl", "OpenPremOuterddl();", true);
        }
    }
    #endregion
    protected void ddlHourClass_PreRender(object sender, EventArgs e)
    {
        RadComboBox ddlHourClass = sender as RadComboBox;
        RadGrid rGrdHourClass4DDL = ddlHourClass.Items[0].FindControl("rGrdHourClass4DDL") as RadGrid;
        RadAjaxManager1.AjaxSettings.AddAjaxSetting(rGrdHourClass4DDL, rGrdHourClass4DDL);
    }
    protected void ddlPremType_PreRender(object sender, EventArgs e)
    {
        RadComboBox ddlPremType = sender as RadComboBox;
        RadGrid rGrdPremType4DDL = ddlPremType.Items[0].FindControl("rGrdPremType4DDL") as RadGrid;
        RadAjaxManager1.AjaxSettings.AddAjaxSetting(rGrdPremType4DDL, rGrdPremType4DDL);
    }

    protected void ddlPremType2_PreRender(object sender, EventArgs e)
    {
        RadComboBox ddlPremType2 = sender as RadComboBox;
        RadGrid rGrdPremType4DDL = ddlPremType2.Items[0].FindControl("rGrdPremType4DDL") as RadGrid;
        RadAjaxManager1.AjaxSettings.AddAjaxSetting(rGrdPremType4DDL, rGrdPremType4DDL);
    }
    
    protected void ddlEmpPos_PreRender(object sender, EventArgs e)
    {
        RadComboBox ddlEmpPos = sender as RadComboBox;
        RadGrid rGrdEmpPos4DDL = ddlEmpPos.Items[0].FindControl("rGrdEmpPos4DDL") as RadGrid;
        RadAjaxManager1.AjaxSettings.AddAjaxSetting(rGrdEmpPos4DDL, rGrdEmpPos4DDL);
    }
    protected void ddlSubProject_PreRender(object sender, EventArgs e)
    {
        RadComboBox ddlSubProject = sender as RadComboBox;
        RadGrid rGrdSubProject4DDL = ddlSubProject.Items[0].FindControl("rGrdSubProject4DDL") as RadGrid;
        RadAjaxManager1.AjaxSettings.AddAjaxSetting(rGrdSubProject4DDL, rGrdSubProject4DDL);
    }

    protected void ddlEmployee_PreRender(object sender, EventArgs e)
    {
        RadComboBox ddlEmployee = sender as RadComboBox;
        RadGrid rGrdEmployee4DDL = ddlEmployee.Items[0].FindControl("rGrdEmployee4DDL") as RadGrid;
        RadAjaxManager1.AjaxSettings.AddAjaxSetting(rGrdEmployee4DDL, rGrdEmployee4DDL);
    }
    protected void ddlProject_PreRender(object sender, EventArgs e)
    {
        RadComboBox ddlProject = sender as RadComboBox;
        RadGrid rGrdProject4DDL = ddlProject.Items[0].FindControl("rGrdProject4DDL") as RadGrid;
        RadAjaxManager1.AjaxSettings.AddAjaxSetting(rGrdProject4DDL, rGrdProject4DDL);
    }
}

