using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public partial class Payroll_EmployeeSetup : BasePage
{
    public static Hashtable htSearchParams = null;
    public bool exporting = false;
    DataTable dtAttDetail = new DataTable();

    // base page initialization
    protected override void Page_Init(object sender, EventArgs e)
    {
        FormName = "Employee Maintenance Form";
        base.Page_Init(sender, e);
    }

    // page load function
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    // employee grid data loading and binding
    protected void gvEmployee_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {
        htSearchParams = new Hashtable();
        DataTable dt = clsDAL.GetDataSet_Payroll("sp_payroll_GetAllEmployeeRecords", htSearchParams).Tables[0];
        dt.TableName = "EmployeeMaster";
        gvEmployee.DataSource = dt;
        gvEmployee.DataMember = "EmployeeMaster";
    }

    // employee ddl data loading and binding
    protected void rGrdEmployee4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsDAL.GetDataSet_Payroll("sp_payroll_GetAllEmployeeRecords", htSearchParams).Tables[0];
    }

    // supervisor ddl data loading and binding
    protected void rGrdSupervisor4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_All_Supervisors", htSearchParams).Tables[0];
    }

    // date format ddl data loading and binding
    protected void rGrdDateFormat4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsCommon.DDLValueSet_GetByDDLID_FromPayroll(Constraints.DropDownLists.AttDateFormat, -1, 1).Tables[0];
    }

    // location ddl data loading and binding
    protected void rGrdLocation4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsCommon.DDLValueSet_GetByDDLID_FromPayroll(Constraints.DropDownLists.Location, -1, 1).Tables[0];
    }

    // status ddl data loading and binding
    protected void rGrdStatus4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsCommon.DDLValueSet_GetByDDLID_FromPayroll(Constraints.DropDownLists.EmployeeStatus, -1, 1).Tables[0];
    }

    // status ddl data loading and binding
    protected void rGrdGender4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsCommon.DDLValueSet_GetByDDLID_FromPayroll(Constraints.DropDownLists.Gender, -1, 1).Tables[0];
    }

    // marital status ddl data loadind and binding
    protected void rGrdMaritalStatus4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsCommon.DDLValueSet_GetByDDLID_FromPayroll(Constraints.DropDownLists.MaritalStatus, -1, 1).Tables[0];
    }

    // employement type ddl data loading and binding
    protected void rGrdEmployeementType4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsCommon.DDLValueSet_GetByDDLID_FromPayroll(Constraints.DropDownLists.ECEmploymentType, -1, 1).Tables[0];
    }

    // visa type ddl data loading and binding
    protected void rGrdVisaType4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsCommon.DDLValueSet_GetByDDLID_FromPayroll(Constraints.DropDownLists.VisaType, -1, 1).Tables[0];
    }

    // address ddl data loading and binding
    protected void rGrdAddress4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsCommon.DDLValueSet_GetByDDLID_FromPayroll(Constraints.DropDownLists.EmployeeAddress, -1, 1).Tables[0];
    }

    // blood group ddl data loading and binding
    protected void rGrdBloodGroup4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsCommon.DDLValueSet_GetByDDLID_FromPayroll(Constraints.DropDownLists.BloodGroup, -1, 1).Tables[0];
    }

    // visa profession ddl data loading and binding
    protected void rGrdVisaProfession4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsCommon.DDLValueSet_GetByDDLID_FromPayroll(Constraints.DropDownLists.VisaProfession, -1, 1).Tables[0];
    }

    // country ddl data loading and binding
    protected void rGrdCountry4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsDAL.GetDataSet_Payroll("sp_payroll_getallcountries", htSearchParams).Tables[0];
    }

    // bank ddl data loading and binding
    protected void rGrdBank4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_All_Branches", htSearchParams).Tables[0];
    }

    // office ddl data loading and binding
    protected void rGrdOffice4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_All_Branches", htSearchParams).Tables[0];
    }

    // position ddl data loading and binding
    protected void rGrdPosition4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsDAL.GetDataSet_Payroll("sp_payroll_GetAllPositions", htSearchParams).Tables[0];
    }

    // division ddl data loading and binding
    protected void rGrdDivision4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_All_Divisions", htSearchParams).Tables[0];
    }

    // grade ddl data loading and binding
    protected void rGrdGrade4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_All_Grades", htSearchParams).Tables[0];
    }

    // nationality ddl data loading and binding
    protected void rGrdNatCode4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_All_Nationalities", htSearchParams).Tables[0];
    }

    // religion ddl data loading and binding
    protected void rGrdReligion4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_All_Religions", htSearchParams).Tables[0];
    }

    // employee class data loading and binding
    protected void rGrdEmployeeClass4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_All_EmployeeClassess", htSearchParams).Tables[0];
    }

    // grid update command
    protected void gvEmployee_UpdateCommand(object sender, GridCommandEventArgs e)
    {
        Insert_or_Update_Employee(ref e, "Update");
    }

    // used for file uploading
    protected void RadAsyncUpImageUpload_FileUploaded(object sender, FileUploadedEventArgs e)
    {
        //string path = Server.MapPath("~/EmployeePhoto/");
        //e.File.SaveAs(path + e.File.GetName());
    }

    // grid delete command 
    protected void gvEmployee_DeleteCommand(object sender, GridCommandEventArgs e)
    {
        Hashtable ht = new Hashtable();

        if (e.Item.OwnerTableView.DataMember == "EmployeeMaster")
        {
            int ID = (int)((GridDataItem)e.Item).GetDataKeyValue("recidd");
            if (ID > 0)
            {
                ht.Add("@ID", ID);
                clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Delete_Employee", ht);
            }
        }
    }

    // client side validation function for employee form input controls
    public void ValidateEmployee(GridItemEventArgs e)
    {
        GridEditableItem editForm = (GridEditableItem)e.Item;

        Button btnSave = (Button)editForm.FindControl("btnUpdate");

        RadTextBox txtempcod = (editForm.FindControl("txtempcod") as RadTextBox);
        RadTextBox txtfirstname = (editForm.FindControl("txtfirstname") as RadTextBox);
        RadTextBox txtlastname = (editForm.FindControl("txtlastname") as RadTextBox);
        RadTextBox txtempprn = (editForm.FindControl("txtempprn") as RadTextBox);

        RadComboBox ddlNationality = (editForm.FindControl("ddlNationality") as RadComboBox);
        RadDatePicker dtpbirthdate = (editForm.FindControl("dtpbirthdate") as RadDatePicker);
        RadComboBox ddlGender = (editForm.FindControl("ddlGender") as RadComboBox);
        RadComboBox ddlMaritalStatus = (editForm.FindControl("ddlMaritalStatus") as RadComboBox);

        RadComboBox ddlGrade = (editForm.FindControl("ddlGrade") as RadComboBox);
        RadComboBox ddlDepartment = (editForm.FindControl("ddlDepartment") as RadComboBox);
        RadComboBox ddlPosition = (editForm.FindControl("ddlPosition") as RadComboBox);
        RadComboBox ddlStatus = (editForm.FindControl("ddlStatus") as RadComboBox);
        RadComboBox ddlEmployeementType = (editForm.FindControl("ddlEmployeementType") as RadComboBox);


        if (btnSave != null)
        {
            btnSave.Attributes.Add("onclick", "ValidateEmployee('" +
                txtempcod.ClientID + "','" +
                txtfirstname.ClientID + "','" +
                txtlastname.ClientID + "','" +
                txtempprn.ClientID + "','" +
                ddlNationality.ClientID + "','" +
                dtpbirthdate.ClientID + "','" +
                ddlGender.ClientID + "','" +
                ddlMaritalStatus.ClientID + "','" +
                ddlGrade.ClientID + "','" +
                ddlDepartment.ClientID + "','" +
                ddlPosition.ClientID + "','" +
                ddlStatus.ClientID + "','" +
                ddlEmployeementType.ClientID

                + "')");
        }
    }

    // set form input controls for insert/update
    protected void gvEmployee_ItemDataBound(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridEditableItem && e.Item.IsInEditMode)
        {
            if (e.Item.OwnerTableView.DataMember == "EmployeeMaster")
            {
                ValidateEmployee(e);

                if (e.Item.OwnerTableView.IsItemInserted)
                {
                    #region  item is about to be inserted

                    GridEditableItem insertedItem = (GridEditableItem)e.Item;

                    #endregion
                }
                else
                {
                    #region item is about to be edited

                    GridEditableItem editedItem = (GridEditableItem)e.Item;

                    HiddenField hfemppsp = (HiddenField)editedItem.FindControl("hfemppsp");
                    TextBox txtemppsp = (TextBox)editedItem.FindControl("txtemppsp");
                    txtemppsp.Attributes.Add("value", hfemppsp.Value);

                    RadComboBox ddlFromBank = (RadComboBox)editedItem.FindControl("ddlFromBank");
                    HiddenField hfddlFromBankID = (HiddenField)editedItem.FindControl("hfddlFromBankID");
                    HiddenField hfddlFromBankText = (HiddenField)editedItem.FindControl("hfddlFromBankText");

                    if (ddlFromBank != null)
                    {
                        RadGrid grid = ddlFromBank.Items[0].FindControl("rGrdFromBank4DDL") as RadGrid;
                        grid.Rebind();

                        if (!string.IsNullOrEmpty(hfddlFromBankID.Value) && !string.IsNullOrEmpty(hfddlFromBankText.Value))
                        {
                            ddlFromBank.Items[0].Value = hfddlFromBankID.Value;
                            ddlFromBank.Items[0].Text = hfddlFromBankText.Value;
                            ddlFromBank.Text = hfddlFromBankText.Value;

                            foreach (GridItem item in grid.MasterTableView.Items)
                            {
                                if (item is GridDataItem)
                                {
                                    GridDataItem dataItem = (GridDataItem)item;
                                    if (hfddlFromBankID.Value.Equals(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["brnidd"].ToString()))
                                    {
                                        dataItem.Selected = true;
                                        break;
                                    }
                                }
                            }
                        }
                    }

                    RadComboBox ddlToBank = (RadComboBox)editedItem.FindControl("ddlToBank");
                    HiddenField hfbnktiddddlid = (HiddenField)editedItem.FindControl("hfbnktiddddlid");
                    HiddenField hfbnktcodddltext = (HiddenField)editedItem.FindControl("hfbnktcodddltext");

                    if (ddlToBank != null)
                    {
                        RadGrid grid = ddlToBank.Items[0].FindControl("rGrdToBank4DDL") as RadGrid;
                        grid.Rebind();

                        if (!string.IsNullOrEmpty(hfbnktiddddlid.Value) && !string.IsNullOrEmpty(hfbnktcodddltext.Value))
                        {
                            ddlToBank.Items[0].Value = hfbnktiddddlid.Value;
                            ddlToBank.Items[0].Text = hfbnktcodddltext.Value;
                            ddlToBank.Text = hfbnktcodddltext.Value;

                            foreach (GridItem item in grid.MasterTableView.Items)
                            {
                                if (item is GridDataItem)
                                {
                                    GridDataItem dataItem = (GridDataItem)item;
                                    if (hfbnktiddddlid.Value.Equals(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["brnidd"].ToString()))
                                    {
                                        dataItem.Selected = true;
                                        break;
                                    }
                                }
                            }
                        }
                    }

                    RadComboBox ddlBloodGroup = (RadComboBox)editedItem.FindControl("ddlBloodGroup");
                    HiddenField hfBloodGroupdllID = (HiddenField)editedItem.FindControl("hfBloodGroupdllID");
                    HiddenField hfBloodGroupdllText = (HiddenField)editedItem.FindControl("hfBloodGroupdllText");

                    if (ddlBloodGroup != null)
                    {
                        RadGrid grid = ddlBloodGroup.Items[0].FindControl("rGrdBloodGroup4DDL") as RadGrid;
                        grid.Rebind();

                        if (!string.IsNullOrEmpty(hfBloodGroupdllID.Value) && !string.IsNullOrEmpty(hfBloodGroupdllText.Value))
                        {
                            ddlBloodGroup.Items[0].Value = hfBloodGroupdllID.Value;
                            ddlBloodGroup.Items[0].Text = hfBloodGroupdllText.Value;
                            ddlBloodGroup.Text = hfBloodGroupdllText.Value;

                            foreach (GridItem item in grid.MasterTableView.Items)
                            {
                                if (item is GridDataItem)
                                {
                                    GridDataItem dataItem = (GridDataItem)item;
                                    if (hfBloodGroupdllID.Value.Equals(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["ValueSetID"].ToString()))
                                    {
                                        dataItem.Selected = true;
                                        break;
                                    }
                                }
                            }
                        }
                    }

                    RadComboBox ddlReligion = (RadComboBox)editedItem.FindControl("ddlReligion");
                    HiddenField hfReligionId = (HiddenField)editedItem.FindControl("hfReligionId");
                    HiddenField hfReligionCode = (HiddenField)editedItem.FindControl("hfReligionCode");

                    if (ddlReligion != null)
                    {
                        RadGrid grid = ddlReligion.Items[0].FindControl("rGrdReligion4DDL") as RadGrid;
                        grid.Rebind();

                        if (!string.IsNullOrEmpty(hfReligionId.Value) && !string.IsNullOrEmpty(hfReligionCode.Value))
                        {
                            ddlReligion.Items[0].Value = hfReligionId.Value;
                            ddlReligion.Items[0].Text = hfReligionCode.Value;
                            ddlReligion.Text = hfReligionCode.Value;

                            foreach (GridItem item in grid.MasterTableView.Items)
                            {
                                if (item is GridDataItem)
                                {
                                    GridDataItem dataItem = (GridDataItem)item;
                                    if (hfReligionId.Value.Equals(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["relidd"].ToString()))
                                    {
                                        dataItem.Selected = true;
                                        break;
                                    }
                                }
                            }
                        }
                    }

                    RadComboBox ddlNationality = (RadComboBox)editedItem.FindControl("ddlNationality");
                    HiddenField hfddlNationalityId = (HiddenField)editedItem.FindControl("hfddlNationalityId");
                    HiddenField hfddlNationalityText = (HiddenField)editedItem.FindControl("hfddlNationalityText");

                    if (ddlNationality != null)
                    {
                        RadGrid grid = ddlNationality.Items[0].FindControl("rGrdNatCode4DDL") as RadGrid;
                        grid.Rebind();

                        if (!string.IsNullOrEmpty(hfddlNationalityId.Value) && !string.IsNullOrEmpty(hfddlNationalityText.Value))
                        {
                            ddlNationality.Items[0].Value = hfddlNationalityId.Value;
                            ddlNationality.Items[0].Text = hfddlNationalityText.Value;
                            ddlNationality.Text = hfddlNationalityText.Value;

                            foreach (GridItem item in grid.MasterTableView.Items)
                            {
                                if (item is GridDataItem)
                                {
                                    GridDataItem dataItem = (GridDataItem)item;
                                    if (hfddlNationalityId.Value.Equals(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["natidd"].ToString()))
                                    {
                                        dataItem.Selected = true;
                                        break;
                                    }
                                }
                            }
                        }
                    }

                    RadComboBox ddlGender = (RadComboBox)editedItem.FindControl("ddlGender");
                    HiddenField hfGenderdllID = (HiddenField)editedItem.FindControl("hfGenderdllID");
                    HiddenField hfGenderdllText = (HiddenField)editedItem.FindControl("hfGenderdllText");

                    if (ddlGender != null)
                    {
                        RadGrid grid = ddlGender.Items[0].FindControl("rGrdGender4DDL") as RadGrid;
                        grid.Rebind();

                        if (!string.IsNullOrEmpty(hfGenderdllID.Value) && !string.IsNullOrEmpty(hfGenderdllText.Value))
                        {
                            ddlGender.Items[0].Value = hfGenderdllID.Value;
                            ddlGender.Items[0].Text = hfGenderdllText.Value;
                            ddlGender.Text = hfGenderdllText.Value;

                            foreach (GridItem item in grid.MasterTableView.Items)
                            {
                                if (item is GridDataItem)
                                {
                                    GridDataItem dataItem = (GridDataItem)item;
                                    if (hfGenderdllID.Value.Equals(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["ValueSetID"].ToString()))
                                    {
                                        dataItem.Selected = true;
                                        break;
                                    }
                                }
                            }
                        }
                    }

                    RadComboBox ddlMaritalStatus = (RadComboBox)editedItem.FindControl("ddlMaritalStatus");
                    HiddenField hfddlempmstId = (HiddenField)editedItem.FindControl("hfddlempmstId");
                    HiddenField hfddlempmsttext = (HiddenField)editedItem.FindControl("hfddlempmsttext");

                    if (ddlMaritalStatus != null)
                    {
                        RadGrid grid = ddlMaritalStatus.Items[0].FindControl("rGrdMaritalStatus4DDL") as RadGrid;
                        grid.Rebind();

                        if (!string.IsNullOrEmpty(hfddlempmstId.Value) && !string.IsNullOrEmpty(hfddlempmsttext.Value))
                        {
                            ddlMaritalStatus.Items[0].Value = hfddlempmstId.Value;
                            ddlMaritalStatus.Items[0].Text = hfddlempmsttext.Value;
                            ddlMaritalStatus.Text = hfddlempmsttext.Value;

                            foreach (GridItem item in grid.MasterTableView.Items)
                            {
                                if (item is GridDataItem)
                                {
                                    GridDataItem dataItem = (GridDataItem)item;
                                    if (hfddlempmstId.Value.Equals(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["ValueSetID"].ToString()))
                                    {
                                        dataItem.Selected = true;
                                        break;
                                    }
                                }
                            }
                        }
                    }

                    RadComboBox ddlStatus = (RadComboBox)editedItem.FindControl("ddlStatus");
                    HiddenField hfempstsdllID = (HiddenField)editedItem.FindControl("hfempstsdllID");
                    HiddenField hfempstsdllText = (HiddenField)editedItem.FindControl("hfempstsdllText");

                    if (ddlStatus != null)
                    {
                        RadGrid grid = ddlStatus.Items[0].FindControl("rGrdStatus4DDL") as RadGrid;
                        grid.Rebind();

                        if (!string.IsNullOrEmpty(hfempstsdllID.Value) && !string.IsNullOrEmpty(hfempstsdllText.Value))
                        {
                            ddlStatus.Items[0].Value = hfempstsdllID.Value;
                            ddlStatus.Items[0].Text = hfempstsdllText.Value;
                            ddlStatus.Text = hfempstsdllText.Value;

                            foreach (GridItem item in grid.MasterTableView.Items)
                            {
                                if (item is GridDataItem)
                                {
                                    GridDataItem dataItem = (GridDataItem)item;
                                    if (hfempstsdllID.Value.Equals(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["ValueSetID"].ToString()))
                                    {
                                        dataItem.Selected = true;
                                        break;
                                    }
                                }
                            }
                        }
                    }

                    RadComboBox ddlGrade = (RadComboBox)editedItem.FindControl("ddlGrade");
                    HiddenField hfGradedllID = (HiddenField)editedItem.FindControl("hfGradedllID");
                    HiddenField hfGradedllText = (HiddenField)editedItem.FindControl("hfGradedllText");

                    if (ddlGrade != null)
                    {
                        RadGrid grid = ddlGrade.Items[0].FindControl("rGrdGrade4DDL") as RadGrid;
                        grid.Rebind();

                        if (!string.IsNullOrEmpty(hfGradedllID.Value) && !string.IsNullOrEmpty(hfGradedllText.Value))
                        {
                            ddlGrade.Items[0].Value = hfGradedllID.Value;
                            ddlGrade.Items[0].Text = hfGradedllText.Value;
                            ddlGrade.Text = hfGradedllText.Value;

                            foreach (GridItem item in grid.MasterTableView.Items)
                            {
                                if (item is GridDataItem)
                                {
                                    GridDataItem dataItem = (GridDataItem)item;
                                    if (hfGradedllID.Value.Equals(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["grdidd"].ToString()))
                                    {
                                        dataItem.Selected = true;
                                        break;
                                    }
                                }
                            }
                        }
                    }

                    RadComboBox ddlPosition = (RadComboBox)editedItem.FindControl("ddlPosition");
                    HiddenField hfPositiondllID = (HiddenField)editedItem.FindControl("hfPositiondllID");
                    HiddenField hfPositiondllText = (HiddenField)editedItem.FindControl("hfPositiondllText");

                    if (ddlPosition != null)
                    {
                        RadGrid grid = ddlPosition.Items[0].FindControl("rGrdPosition4DDL") as RadGrid;
                        grid.Rebind();

                        if (!string.IsNullOrEmpty(hfPositiondllID.Value) && !string.IsNullOrEmpty(hfPositiondllText.Value))
                        {
                            ddlPosition.Items[0].Value = hfPositiondllID.Value;
                            ddlPosition.Items[0].Text = hfPositiondllText.Value;
                            ddlPosition.Text = hfPositiondllText.Value;

                            foreach (GridItem item in grid.MasterTableView.Items)
                            {
                                if (item is GridDataItem)
                                {
                                    GridDataItem dataItem = (GridDataItem)item;
                                    if (hfPositiondllID.Value.Equals(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["recidd"].ToString()))
                                    {
                                        dataItem.Selected = true;
                                        break;
                                    }
                                }
                            }
                        }
                    }

                    RadComboBox ddlEmployeementType = (RadComboBox)editedItem.FindControl("ddlEmployeementType");
                    HiddenField hfddlEmployeementTypeId = (HiddenField)editedItem.FindControl("hfddlEmployeementTypeId");
                    HiddenField hfddlEmployeementTypeText = (HiddenField)editedItem.FindControl("hfddlEmployeementTypeText");

                    if (ddlEmployeementType != null)
                    {
                        RadGrid grid = ddlEmployeementType.Items[0].FindControl("rGrdEmployeementType4DDL") as RadGrid;
                        grid.Rebind();

                        if (!string.IsNullOrEmpty(hfddlEmployeementTypeId.Value) && !string.IsNullOrEmpty(hfddlEmployeementTypeText.Value))
                        {
                            ddlEmployeementType.Items[0].Value = hfddlEmployeementTypeId.Value;
                            ddlEmployeementType.Items[0].Text = hfddlEmployeementTypeText.Value;
                            ddlEmployeementType.Text = hfddlEmployeementTypeText.Value;

                            foreach (GridItem item in grid.MasterTableView.Items)
                            {
                                if (item is GridDataItem)
                                {
                                    GridDataItem dataItem = (GridDataItem)item;
                                    if (hfddlEmployeementTypeId.Value.Equals(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["ValueSetID"].ToString()))
                                    {
                                        dataItem.Selected = true;
                                        break;
                                    }
                                }
                            }
                        }
                    }

                    RadComboBox ddlEmployeeClass = (RadComboBox)editedItem.FindControl("ddlEmployeeClass");
                    HiddenField hfddlEmployeeClassId = (HiddenField)editedItem.FindControl("hfddlEmployeeClassId");
                    HiddenField hfddlEmployeeClassText = (HiddenField)editedItem.FindControl("hfddlEmployeeClassText");

                    if (ddlEmployeeClass != null)
                    {
                        RadGrid grid = ddlEmployeeClass.Items[0].FindControl("rGrdEmployeeClass4DDL") as RadGrid;
                        grid.Rebind();

                        if (!string.IsNullOrEmpty(hfddlEmployeeClassId.Value) && !string.IsNullOrEmpty(hfddlEmployeeClassText.Value))
                        {
                            ddlEmployeeClass.Items[0].Value = hfddlEmployeeClassId.Value;
                            ddlEmployeeClass.Items[0].Text = hfddlEmployeeClassText.Value;
                            ddlEmployeeClass.Text = hfddlEmployeeClassText.Value;

                            foreach (GridItem item in grid.MasterTableView.Items)
                            {
                                if (item is GridDataItem)
                                {
                                    GridDataItem dataItem = (GridDataItem)item;
                                    if (hfddlEmployeeClassId.Value.Equals(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["recidd"].ToString()))
                                    {
                                        dataItem.Selected = true;
                                        break;
                                    }
                                }
                            }
                        }
                    }

                    RadComboBox ddlDivision = (RadComboBox)editedItem.FindControl("ddlDivision");
                    HiddenField hfddlDivisionId = (HiddenField)editedItem.FindControl("hfddlDivisionId");
                    HiddenField hfddlDivisionText = (HiddenField)editedItem.FindControl("hfddlDivisionText");

                    if (ddlDivision != null)
                    {
                        RadGrid grid = ddlDivision.Items[0].FindControl("rGrdDivision4DDL") as RadGrid;
                        grid.Rebind();

                        if (!string.IsNullOrEmpty(hfddlDivisionId.Value) && !string.IsNullOrEmpty(hfddlDivisionText.Value))
                        {
                            ddlDivision.Items[0].Value = hfddlDivisionId.Value;
                            ddlDivision.Items[0].Text = hfddlDivisionText.Value;
                            ddlDivision.Text = hfddlDivisionText.Value;

                            foreach (GridItem item in grid.MasterTableView.Items)
                            {
                                if (item is GridDataItem)
                                {
                                    GridDataItem dataItem = (GridDataItem)item;
                                    if (hfddlDivisionId.Value.Equals(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["dividd"].ToString()))
                                    {
                                        dataItem.Selected = true;
                                        break;
                                    }
                                }
                            }
                        }
                    }

                    RadComboBox ddlDepartment = (RadComboBox)editedItem.FindControl("ddlDepartment");
                    HiddenField hfddlDepartmentId = (HiddenField)editedItem.FindControl("hfddlDepartmentId");
                    HiddenField hfddlDepartmentText = (HiddenField)editedItem.FindControl("hfddlDepartmentText");

                    if (ddlDepartment != null)
                    {
                        RadGrid dptgrid = ddlDepartment.Items[0].FindControl("rGrdDepartment4DDL") as RadGrid;
                        htSearchParams = new Hashtable();
                        htSearchParams.Add("@DivisionID", hfddlDivisionId.Value);
                        dptgrid.DataSource = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_Departments", htSearchParams).Tables[0];
                        dptgrid.DataBind();
                        //grid.Rebind();

                        if (!string.IsNullOrEmpty(hfddlDepartmentId.Value) && !string.IsNullOrEmpty(hfddlDepartmentText.Value))
                        {
                            ddlDepartment.Items[0].Value = hfddlDepartmentId.Value;
                            ddlDepartment.Items[0].Text = hfddlDepartmentText.Value;
                            ddlDepartment.Text = hfddlDepartmentText.Value;

                            foreach (GridItem item in dptgrid.MasterTableView.Items)
                            {
                                if (item is GridDataItem)
                                {
                                    GridDataItem dataItem = (GridDataItem)item;
                                    if (hfddlDepartmentId.Value.Equals(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["dptidd"].ToString()))
                                    {
                                        dataItem.Selected = true;
                                        break;
                                    }
                                }
                            }
                        }
                    }

                    RadComboBox ddlSection = (RadComboBox)editedItem.FindControl("ddlSection");
                    HiddenField hfddlSectionId = (HiddenField)editedItem.FindControl("hfddlSectionId");
                    HiddenField hfddlSectionText = (HiddenField)editedItem.FindControl("hfddlSectionText");

                    if (ddlSection != null)
                    {
                        RadGrid secgrid = ddlSection.Items[0].FindControl("rGrdSection4DDL") as RadGrid;
                        htSearchParams = new Hashtable();
                        htSearchParams.Add("@DepartmentID", hfddlDepartmentId.Value);
                        secgrid.DataSource = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_Sections", htSearchParams).Tables[0];
                        secgrid.DataBind();
                        //grid.Rebind();

                        if (!string.IsNullOrEmpty(hfddlSectionId.Value) && !string.IsNullOrEmpty(hfddlSectionText.Value))
                        {
                            bool selected = false;

                            foreach (GridItem item in secgrid.MasterTableView.Items)
                            {
                                if (item is GridDataItem)
                                {
                                    GridDataItem dataItem = (GridDataItem)item;
                                    if (hfddlSectionId.Value.Equals(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["secidd"].ToString()))
                                    {
                                        dataItem.Selected = true;
                                        selected = true;
                                        break;
                                    }
                                }
                            }
                            if (selected)
                            {
                                ddlSection.Items[0].Value = hfddlSectionId.Value;
                                ddlSection.Items[0].Text = hfddlSectionText.Value;
                                ddlSection.Text = hfddlSectionText.Value;
                            }
                        }
                    }

                    RadComboBox ddlEmployee = (RadComboBox)editedItem.FindControl("ddlEmployee");
                    HiddenField hfddlEmployeeId = (HiddenField)editedItem.FindControl("hfddlEmployeeId");
                    HiddenField hfddlEmployeeText = (HiddenField)editedItem.FindControl("hfddlEmployeeText");

                    if (ddlEmployee != null)
                    {
                        RadGrid grid = ddlEmployee.Items[0].FindControl("rGrdEmployee4DDL") as RadGrid;
                        grid.Rebind();

                        if (!string.IsNullOrEmpty(hfddlEmployeeId.Value) && !string.IsNullOrEmpty(hfddlEmployeeText.Value))
                        {
                            ddlEmployee.Items[0].Value = hfddlEmployeeId.Value;
                            ddlEmployee.Items[0].Text = hfddlEmployeeText.Value;
                            ddlEmployee.Text = hfddlEmployeeText.Value;

                            foreach (GridItem item in grid.MasterTableView.Items)
                            {
                                if (item is GridDataItem)
                                {
                                    GridDataItem dataItem = (GridDataItem)item;
                                    if (hfddlEmployeeId.Value.Equals(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["recidd"].ToString()))
                                    {
                                        dataItem.Selected = true;
                                        break;
                                    }
                                }
                            }
                        }
                    }

                    RadComboBox ddlLocation = (RadComboBox)editedItem.FindControl("ddlLocation");
                    HiddenField hfddlLocationId = (HiddenField)editedItem.FindControl("hfddlLocationId");
                    HiddenField hfddlLocationText = (HiddenField)editedItem.FindControl("hfddlLocationText");

                    if (ddlLocation != null)
                    {
                        RadGrid grid = ddlLocation.Items[0].FindControl("rGrdLocation4DDL") as RadGrid;
                        grid.Rebind();

                        if (!string.IsNullOrEmpty(hfddlLocationId.Value) && !string.IsNullOrEmpty(hfddlLocationText.Value))
                        {
                            ddlLocation.Items[0].Value = hfddlLocationId.Value;
                            ddlLocation.Items[0].Text = hfddlLocationText.Value;
                            ddlLocation.Text = hfddlLocationText.Value;

                            foreach (GridItem item in grid.MasterTableView.Items)
                            {
                                if (item is GridDataItem)
                                {
                                    GridDataItem dataItem = (GridDataItem)item;
                                    if (hfddlLocationId.Value.Equals(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["ValueSetID"].ToString()))
                                    {
                                        dataItem.Selected = true;
                                        break;
                                    }
                                }
                            }
                        }
                    }

                    RadComboBox ddlSupervisor = (RadComboBox)editedItem.FindControl("ddlSupervisor");
                    HiddenField hfddlSupervisorId = (HiddenField)editedItem.FindControl("hfddlSupervisorId");
                    HiddenField hfddlSupervisorText = (HiddenField)editedItem.FindControl("hfddlSupervisorText");

                    if (ddlSupervisor != null)
                    {
                        RadGrid grid = ddlSupervisor.Items[0].FindControl("rGrdSupervisor4DDL") as RadGrid;
                        grid.Rebind();

                        if (!string.IsNullOrEmpty(hfddlSupervisorId.Value) && !string.IsNullOrEmpty(hfddlSupervisorText.Value))
                        {
                            ddlSupervisor.Items[0].Value = hfddlSupervisorId.Value;
                            ddlSupervisor.Items[0].Text = hfddlSupervisorText.Value;
                            ddlSupervisor.Text = hfddlSupervisorText.Value;

                            foreach (GridItem item in grid.MasterTableView.Items)
                            {
                                if (item is GridDataItem)
                                {
                                    GridDataItem dataItem = (GridDataItem)item;
                                    if (hfddlSupervisorId.Value.Equals(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["supidd"].ToString()))
                                    {
                                        dataItem.Selected = true;
                                        break;
                                    }
                                }
                            }
                        }
                    }

                    RadComboBox ddlOffice = (RadComboBox)editedItem.FindControl("ddlOffice");
                    HiddenField hfoffiddddlId = (HiddenField)editedItem.FindControl("hfoffiddddlId");
                    HiddenField hfoffcodddlText = (HiddenField)editedItem.FindControl("hfoffcodddlText");

                    if (ddlOffice != null)
                    {
                        RadGrid grid = ddlOffice.Items[0].FindControl("rGrdOffice4DDL") as RadGrid;
                        grid.Rebind();

                        if (!string.IsNullOrEmpty(hfoffiddddlId.Value) && !string.IsNullOrEmpty(hfoffcodddlText.Value))
                        {
                            ddlOffice.Items[0].Value = hfoffiddddlId.Value;
                            ddlOffice.Items[0].Text = hfoffcodddlText.Value;
                            ddlOffice.Text = hfoffcodddlText.Value;

                            foreach (GridItem item in grid.MasterTableView.Items)
                            {
                                if (item is GridDataItem)
                                {
                                    GridDataItem dataItem = (GridDataItem)item;
                                    if (hfoffiddddlId.Value.Equals(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["brnidd"].ToString()))
                                    {
                                        dataItem.Selected = true;
                                        break;
                                    }
                                }
                            }
                        }
                    }

                    RadComboBox ddlVisaType = (RadComboBox)editedItem.FindControl("ddlVisaType");
                    HiddenField hfddlVisaTypeId = (HiddenField)editedItem.FindControl("hfddlVisaTypeId");
                    HiddenField hfddlVisaTypeText = (HiddenField)editedItem.FindControl("hfddlVisaTypeText");

                    if (ddlVisaType != null)
                    {
                        RadGrid grid = ddlVisaType.Items[0].FindControl("rGrdVisaType4DDL") as RadGrid;
                        grid.Rebind();

                        if (!string.IsNullOrEmpty(hfddlVisaTypeId.Value) && !string.IsNullOrEmpty(hfddlVisaTypeText.Value))
                        {
                            ddlVisaType.Items[0].Value = hfddlVisaTypeId.Value;
                            ddlVisaType.Items[0].Text = hfddlVisaTypeText.Value;
                            ddlVisaType.Text = hfddlVisaTypeText.Value;

                            foreach (GridItem item in grid.MasterTableView.Items)
                            {
                                if (item is GridDataItem)
                                {
                                    GridDataItem dataItem = (GridDataItem)item;
                                    if (hfddlVisaTypeId.Value.Equals(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["ValueSetID"].ToString()))
                                    {
                                        dataItem.Selected = true;
                                        break;
                                    }
                                }
                            }
                        }
                    }

                    RadComboBox ddlVisaProfession = (RadComboBox)editedItem.FindControl("ddlVisaProfession");
                    HiddenField hfddlVisaProfessionID = (HiddenField)editedItem.FindControl("hfddlVisaProfessionID");
                    HiddenField hfddlVisaProfessionText = (HiddenField)editedItem.FindControl("hfddlVisaProfessionText");

                    if (ddlVisaProfession != null)
                    {
                        RadGrid grid = ddlVisaProfession.Items[0].FindControl("rGrdVisaProfession4DDL") as RadGrid;
                        grid.Rebind();

                        if (!string.IsNullOrEmpty(hfddlVisaProfessionID.Value) && !string.IsNullOrEmpty(hfddlVisaProfessionText.Value))
                        {
                            ddlVisaProfession.Items[0].Value = hfddlVisaProfessionID.Value;
                            ddlVisaProfession.Items[0].Text = hfddlVisaProfessionText.Value;
                            ddlVisaProfession.Text = hfddlVisaProfessionText.Value;

                            foreach (GridItem item in grid.MasterTableView.Items)
                            {
                                if (item is GridDataItem)
                                {
                                    GridDataItem dataItem = (GridDataItem)item;
                                    if (hfddlVisaProfessionID.Value.Equals(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["ValueSetID"].ToString()))
                                    {
                                        dataItem.Selected = true;
                                        break;
                                    }
                                }
                            }
                        }
                    }

                    RadComboBox ddlCountry = (RadComboBox)editedItem.FindControl("ddlCountry");
                    HiddenField hfddlCountryID = (HiddenField)editedItem.FindControl("hfddlCountryID");
                    HiddenField hfddlCountryText = (HiddenField)editedItem.FindControl("hfddlCountryText");

                    if (ddlCountry != null)
                    {
                        RadGrid grid = ddlCountry.Items[0].FindControl("rGrdCountry4DDL") as RadGrid;
                        grid.Rebind();

                        if (!string.IsNullOrEmpty(hfddlCountryID.Value) && !string.IsNullOrEmpty(hfddlCountryText.Value))
                        {
                            ddlCountry.Items[0].Value = hfddlCountryID.Value;
                            ddlCountry.Items[0].Text = hfddlCountryText.Value;
                            ddlCountry.Text = hfddlCountryText.Value;

                            foreach (GridItem item in grid.MasterTableView.Items)
                            {
                                if (item is GridDataItem)
                                {
                                    GridDataItem dataItem = (GridDataItem)item;
                                    if (hfddlCountryID.Value.Equals(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["recidd"].ToString()))
                                    {
                                        dataItem.Selected = true;
                                        break;
                                    }
                                }
                            }
                        }
                    }

                    RadComboBox ddlCity = (RadComboBox)editedItem.FindControl("ddlCity");
                    HiddenField hfddlCityID = (HiddenField)editedItem.FindControl("hfddlCityID");
                    HiddenField hfddlCityText = (HiddenField)editedItem.FindControl("hfddlCityText");

                    if (ddlCity != null)
                    {
                        RadGrid grid = ddlCity.Items[0].FindControl("rGrdCity4DDL") as RadGrid;
                        htSearchParams = new Hashtable();
                        htSearchParams.Add("@ID", hfddlCountryID.Value);
                        grid.DataSource = clsDAL.GetDataSet_Payroll("sp_payroll_GetCountryCities", htSearchParams).Tables[0];
                        grid.DataBind();

                        if (!string.IsNullOrEmpty(hfddlCityID.Value) && !string.IsNullOrEmpty(hfddlCityText.Value))
                        {
                            bool isSelected = false;


                            foreach (GridItem item in grid.MasterTableView.Items)
                            {
                                if (item is GridDataItem)
                                {
                                    GridDataItem dataItem = (GridDataItem)item;
                                    if (hfddlCityID.Value.Equals(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["recidd"].ToString()))
                                    {
                                        dataItem.Selected = true;
                                        isSelected = true;
                                        break;
                                    }
                                }
                            }
                            if (isSelected)
                            {
                                ddlCity.Items[0].Value = hfddlCityID.Value;
                                ddlCity.Items[0].Text = hfddlCityText.Value;
                                ddlCity.Text = hfddlCityText.Value;
                            }
                        }
                    }

                    #endregion
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
                ht_Reports.Add("@formtypeid", Request.QueryString["FormType"]);
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

    // set form input controls for insert/update
    // grid exporting functions
    protected void gvEmployee_ItemCommand(object sender, GridCommandEventArgs e)
    {
        RadGrid grid = (sender as RadGrid);
        if (e.CommandName == RadGrid.InitInsertCommandName)
        {
            e.Canceled = true;

            var newValues = new System.Collections.Specialized.ListDictionary();

            newValues["empphto"] = new System.Byte[0];

            e.Item.OwnerTableView.InsertItem(newValues);

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
            grid.ExportSettings.ExportOnlyData = true;
            grid.ExportSettings.HideStructureColumns = true;

            foreach (GridDataItem item in grid.Items)
            {
                item["ExpandColumn"].Visible = false;
            }

            if (e.Item.OwnerTableView.DataMember == "EmployeeMaster")
            {
                grid.MasterTableView.GetColumn("EditEmployee").Visible = false;
                grid.MasterTableView.GetColumn("DeleteEmployee").Visible = false;
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

            if (e.Item.OwnerTableView.DataMember == "EmployeeMaster")
            {
                grid.MasterTableView.GetColumn("EditEmployee").Visible = false;
                grid.MasterTableView.GetColumn("DeleteEmployee").Visible = false;
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
            if (e.Item.OwnerTableView.DataMember == "EmployeeMaster")
            {
                grid.MasterTableView.GetColumn("EditEmployee").Visible = false;
                grid.MasterTableView.GetColumn("DeleteEmployee").Visible = false;
            }

            grid.MasterTableView.ExportToPdf();
        }
        if (e.CommandName == "Print")
        {
            Button btnPrint = (Button)e.Item.FindControl("btnEmployeePrint");
            RadComboBox ddlPrintOptions = (RadComboBox)e.Item.FindControl("ddlPrintOptions");
            if (ddlPrintOptions != null)
            {
                if (!string.IsNullOrEmpty(ddlPrintOptions.SelectedItem.Text))
                {
                    String qstring = clsEncryption.EncryptData(ddlPrintOptions.SelectedItem.Text);
                    //btnPrint.Attributes["onclick"] = String.Format("return ShowReport('{0}');", qstring);
                    ScriptManager.RegisterStartupScript(this, Page.GetType(), "mykey", "ShowReport('" + qstring + "');", true);
                }
            }
        }
    }

    // export setting function
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

                if (column.UniqueName == "EditAttDetail" || column.UniqueName == "DeleteAttDetail")
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

    // grid insert/update command
    protected void gvEmployee_InsertCommand(object sender, GridCommandEventArgs e)
    {
        Insert_or_Update_Employee(ref e, "Insert");
    }

    // insert/update function
    private void Insert_or_Update_Employee(ref GridCommandEventArgs e, string operation)
    {
        GridEditableItem editedItem = e.Item as GridEditableItem;
        try
        {
            //Insert new values
            Hashtable newValues = new Hashtable();

            if (e.Item.OwnerTableView.DataMember == "EmployeeMaster")
            {
                if (operation == "Update")
                {
                    newValues["@recidd"] = (int)editedItem.GetDataKeyValue("recidd");
                }

                // Personal tab
                RadAsyncUpload fileUploader = editedItem.FindControl("RadAsyncUpImageUpload") as RadAsyncUpload;
                if (fileUploader != null)
                {
                    if (fileUploader.UploadedFiles.Count > 0)
                    {
                        UploadedFile file = fileUploader.UploadedFiles[0];
                        byte[] bytes = new byte[file.ContentLength];
                        file.InputStream.Read(bytes, 0, Convert.ToInt32(file.ContentLength));
                        newValues["@empphto"] = bytes;


                        var currentLogo = fileUploader.UploadedFiles[0];

                        var imgStream = currentLogo.InputStream;
                        int imgLen = int.Parse(currentLogo.ContentLength.ToString());

                        byte[] imgBinaryData = new byte[imgLen];
                        int n = imgStream.Read(imgBinaryData, 0, imgLen);

                        // Image to Base64 string and save in database
                        // Convert byte[] to Base64 String
                        string base64String = Convert.ToBase64String(imgBinaryData);

                        newValues = new Hashtable();
                        newValues["@Logo"] = imgBinaryData;
                        newValues["@LogoType"] = currentLogo.ContentType;
                        newValues["@LogoAsBase64"] = base64String;


                    }
                }
                if (operation == "Update")
                {
                    newValues["@recidd"] = (int)editedItem.GetDataKeyValue("recidd");
                }

                newValues["@empcod"] = (editedItem.FindControl("txtempcod") as RadTextBox).Text;
                newValues["@empfsn"] = (editedItem.FindControl("txtfirstname") as RadTextBox).Text;
                newValues["@empmdn"] = (editedItem.FindControl("txtmiddlename") as RadTextBox).Text;
                newValues["@emplsn"] = (editedItem.FindControl("txtlastname") as RadTextBox).Text;
                newValues["@empprn"] = (editedItem.FindControl("txtempprn") as RadTextBox).Text;
                newValues["@empsfx"] = (editedItem.FindControl("txtempsfx") as RadTextBox).Text;
                newValues["@empfss"] = (editedItem.FindControl("txtempfss") as RadTextBox).Text;
                newValues["@empmds"] = (editedItem.FindControl("txtempmds") as RadTextBox).Text;
                newValues["@emplss"] = (editedItem.FindControl("txtemplss") as RadTextBox).Text;
                newValues["@empprs"] = (editedItem.FindControl("txtempprs") as RadTextBox).Text;
                newValues["@empsfs"] = (editedItem.FindControl("txtempsfs") as RadTextBox).Text;
                newValues["@relidd"] = (editedItem.FindControl("ddlReligion") as RadComboBox).Items[0].Value.Trim();
                newValues["@natidd"] = (editedItem.FindControl("ddlNationality") as RadComboBox).Items[0].Value.Trim();
                newValues["@empdob"] = (editedItem.FindControl("dtpbirthdate") as RadDatePicker).SelectedDate;
                newValues["@empgnd"] = (editedItem.FindControl("ddlGender") as RadComboBox).Items[0].Value.Trim();
                newValues["@empmst"] = (editedItem.FindControl("ddlMaritalStatus") as RadComboBox).Items[0].Value.Trim();
                newValues["@empblg"] = (editedItem.FindControl("ddlBloodGroup") as RadComboBox).Items[0].Value.Trim();
                newValues["@empidc"] = (editedItem.FindControl("txtempidc") as RadTextBox).Text;

                newValues["@empftn"] = (editedItem.FindControl("txtempftn") as RadTextBox).Text;
                newValues["@empmtn"] = (editedItem.FindControl("txtempmtn") as RadTextBox).Text;
                newValues["@empfts"] = (editedItem.FindControl("txtempfts") as RadTextBox).Text;
                newValues["@empmts"] = (editedItem.FindControl("txtempmts") as RadTextBox).Text;

                // Contract tab
                newValues["@clsidd"] = (editedItem.FindControl("ddlEmployeeClass") as RadComboBox).Items[0].Value.Trim();
                newValues["@grdidd"] = (editedItem.FindControl("ddlGrade") as RadComboBox).Items[0].Value.Trim();
                newValues["@dividd"] = (editedItem.FindControl("ddlDivision") as RadComboBox).Items[0].Value.Trim();
                newValues["@dptidd"] = (editedItem.FindControl("ddlDepartment") as RadComboBox).Items[0].Value.Trim();
                newValues["@secidd"] = (editedItem.FindControl("ddlSection") as RadComboBox).Items[0].Value.Trim();
                newValues["@posidd"] = (editedItem.FindControl("ddlPosition") as RadComboBox).Items[0].Value.Trim();

                newValues["@empsts"] = (editedItem.FindControl("ddlStatus") as RadComboBox).Items[0].Value.Trim();
                newValues["@empsdt"] = (editedItem.FindControl("dpstatusdatechange") as RadDatePicker).SelectedDate;
                newValues["@empsbi"] = (editedItem.FindControl("ddlEmployee") as RadComboBox).Items[0].Value.Trim();
                newValues["@locidd"] = (editedItem.FindControl("ddlLocation") as RadComboBox).Items[0].Value.Trim();
                newValues["@supidd"] = (editedItem.FindControl("ddlSupervisor") as RadComboBox).Items[0].Value.Trim();
                newValues["@offidd"] = (editedItem.FindControl("ddlOffice") as RadComboBox).Items[0].Value.Trim();
                newValues["@emptyp"] = (editedItem.FindControl("ddlEmployeementType") as RadComboBox).Items[0].Value.Trim();
                newValues["@visidd"] = (editedItem.FindControl("ddlVisaType") as RadComboBox).Items[0].Value.Trim();
                newValues["@vispidd"] = (editedItem.FindControl("ddlVisaProfession") as RadComboBox).Items[0].Value.Trim();
                newValues["@empadu"] = (editedItem.FindControl("txtactivedirectory") as RadTextBox).Text;
                newValues["@empdoj"] = (editedItem.FindControl("dpJoiningDate") as RadDatePicker).SelectedDate;
                newValues["@empisact"] = (editedItem.FindControl("chkbxisactive") as CheckBox).Checked;

                // Address tab
                newValues["@addln1"] = (editedItem.FindControl("txtaddln1") as RadTextBox).Text;
                newValues["@addln2"] = (editedItem.FindControl("txtaddln2") as RadTextBox).Text;
                newValues["@addln3"] = (editedItem.FindControl("txtaddln3") as RadTextBox).Text;
                newValues["@addln4"] = (editedItem.FindControl("txtaddln4") as RadTextBox).Text;
                newValues["@addln5"] = (editedItem.FindControl("txtaddln5") as RadTextBox).Text;

                newValues["@addprv"] = (editedItem.FindControl("txtaddprv") as RadTextBox).Text;
                newValues["@addpsc"] = (editedItem.FindControl("txtaddpsc") as RadTextBox).Text;
                newValues["@ctridd"] = (editedItem.FindControl("ddlCountry") as RadComboBox).Items[0].Value.Trim();
                newValues["@ctyidd"] = (editedItem.FindControl("ddlCity") as RadComboBox).Items[0].Value.Trim();
                newValues["@addlcn"] = (editedItem.FindControl("txtaddlcn") as RadTextBox).Text;
                newValues["@addmbn"] = (editedItem.FindControl("txtaddmbn") as RadTextBox).Text;
                newValues["@addhmn"] = (editedItem.FindControl("txtaddhmn") as RadTextBox).Text;
                newValues["@addbld"] = (editedItem.FindControl("txtaddbld") as RadTextBox).Text;
                newValues["@addunt"] = (editedItem.FindControl("txtaddunt") as RadTextBox).Text;
                newValues["@addflr"] = (editedItem.FindControl("txtaddflr") as RadTextBox).Text;
                newValues["@addpre"] = (editedItem.FindControl("txtaddpre") as RadTextBox).Text;

                // Payment
                newValues["@emppse"] = (editedItem.FindControl("txtemppse") as RadTextBox).Text;
                newValues["@emppsp"] = (editedItem.FindControl("txtemppsp") as TextBox).Text;
                newValues["@bnkfidd"] = (editedItem.FindControl("ddlFromBank") as RadComboBox).Items[0].Value.Trim();
                newValues["@bnktidd"] = (editedItem.FindControl("ddlToBank") as RadComboBox).Items[0].Value.Trim();
                newValues["@empibn"] = (editedItem.FindControl("txtempibn") as RadTextBox).Text;
                newValues["@empact"] = (editedItem.FindControl("txtempact") as RadTextBox).Text;
                newValues["@empswf"] = (editedItem.FindControl("txtempswf") as RadTextBox).Text;
                newValues["@emprou"] = (editedItem.FindControl("txtemprou") as RadTextBox).Text;
                newValues["@empbrn"] = (editedItem.FindControl("txtempbrn") as RadTextBox).Text;
                newValues["@empbct"] = (editedItem.FindControl("txtempbct") as RadTextBox).Text;
                newValues["@empcur"] = (editedItem.FindControl("txtempcur") as RadTextBox).Text;

                newValues["@DBMessage"] = "";

                string DBMessage = "";

                if (operation == "Insert")
                {
                    DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Insert_EmployeeRecord", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                }
                else if (operation == "Update")
                {
                    DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Update_EmployeeRecord", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                }

                if ((null != DBMessage) && DBMessage.Contains("ERROR:"))
                {
                    ShowClientMessage(DBMessage, MessageType.Error);
                    e.Canceled = true;
                }
                else
                {
                ShowClientMessage("Employee record saved successfully.", MessageType.Success);
                //gvEmployee.Rebind();
                }
            }
        }
        catch (Exception ex)
        {
            ShowClientMessage("Unable to update/insert Employee record. Reason: " + ex.Message, MessageType.Error);
            e.Canceled = true;
        }
    }

    // display client side messages
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

    // detail table data binding
    protected void gvEmployee_DetailTableDataBind(object sender, GridDetailTableDataBindEventArgs e)
    {

    }

    // get value for boolean grid column
    protected bool CheckBoxValue(object value)
    {
        if (Convert.ToString(value) == "1") return true;
        else if (Convert.ToString(value) == "True") return true;
        else if (Convert.ToString(value) == "true") return true;

        return false;
    }

    // get image for boolean grid column
    protected string getImagePathForTrue(bool flag)
    {
        if (flag)
            return "~/Images/16x16_tick.png";
        else
            return "";
    }

    // grid header formating for exporting
    protected void gvEmployee_ItemCreated(object sender, GridItemEventArgs e)
    {
        if (exporting && e.Item.ItemType == Telerik.Web.UI.GridItemType.FilteringItem)
        {
            e.Item.Visible = false;
        }
    }

    // ddl division selection change event to load and bind department ddl data
    protected void ddlDivision_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        RadComboBox ddlDivision = sender as RadComboBox;
        if (ddlDivision != null)
        {
            RadGrid divgrid = ddlDivision.Items[0].FindControl("rGrdDivision4DDL") as RadGrid;
            if (divgrid != null)
            {
                if (divgrid.SelectedItems.Count > 0)
                {
                    GridDataItem dataItem = divgrid.SelectedItems[0] as GridDataItem;
                    int divIdd = Convert.ToInt32(dataItem.GetDataKeyValue("dividd"));

                    // next dropdown
                    RadComboBox ddlDepartment = (((RadComboBox)sender).Parent.FindControl("ddlDepartment") as RadComboBox);
                    if (ddlDepartment != null)
                    {
                        RadGrid dptgrid = ddlDepartment.Items[0].FindControl("rGrdDepartment4DDL") as RadGrid;
                        if (dptgrid != null)
                        {
                            htSearchParams = new Hashtable();
                            htSearchParams.Add("@DivisionID", divIdd);
                            dptgrid.DataSource = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_Departments", htSearchParams).Tables[0];
                            dptgrid.DataBind();
                            ddlDepartment.Text = string.Empty;
                        }
                    }
                    // next dropdown
                    RadComboBox ddlSection = (((RadComboBox)sender).Parent.FindControl("ddlSection") as RadComboBox);
                    if (ddlSection != null)
                    {
                        RadGrid secgrid = ddlSection.Items[0].FindControl("rGrdSection4DDL") as RadGrid;
                        if (secgrid != null)
                        {
                            secgrid.DataSource = null;
                            secgrid.DataBind();
                            ddlSection.Text = string.Empty;
                        }
                    }
                }
            }
        }
    }

    // btn used for manual post back of reference ddls
    protected void btn_Click(object sender, EventArgs e)
    {

    }

    // ddl department selection change event to load and bind section ddl data
    protected void ddlDepartment_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        RadComboBox ddlDepartment = sender as RadComboBox;
        if (ddlDepartment != null)
        {
            RadGrid dptgrid = ddlDepartment.Items[0].FindControl("rGrdDepartment4DDL") as RadGrid;
            if (dptgrid != null)
            {
                if (dptgrid.SelectedItems.Count > 0)
                {
                    GridDataItem dataItem = dptgrid.SelectedItems[0] as GridDataItem;
                    int dptIdd = Convert.ToInt32(dataItem.GetDataKeyValue("dptidd"));

                    // next dropdown
                    RadComboBox ddlSection = (((RadComboBox)sender).Parent.FindControl("ddlSection") as RadComboBox);
                    if (ddlSection != null)
                    {
                        RadGrid secgrid = ddlSection.Items[0].FindControl("rGrdSection4DDL") as RadGrid;
                        if (secgrid != null)
                        {
                            htSearchParams = new Hashtable();
                            htSearchParams.Add("@DepartmentID", dptIdd);
                            secgrid.DataSource = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_Sections", htSearchParams).Tables[0];
                            secgrid.DataBind();
                            ddlSection.Text = string.Empty;
                        }
                    }
                }
            }
        }
    }

    // ddl country selection change event to load and bind city ddl data 
    protected void ddlCountry_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        RadComboBox ddlCountry = sender as RadComboBox;
        if (ddlCountry != null)
        {
            RadGrid ctrgrid = ddlCountry.Items[0].FindControl("rGrdCountry4DDL") as RadGrid;
            if (ctrgrid != null)
            {
                if (ctrgrid.SelectedItems.Count > 0)
                {
                    GridDataItem dataItem = ctrgrid.SelectedItems[0] as GridDataItem;
                    int ctrIdd = Convert.ToInt32(dataItem.GetDataKeyValue("recidd"));

                    // next dropdown
                    RadComboBox ddlCity = (((RadComboBox)sender).Parent.FindControl("ddlCity") as RadComboBox);
                    if (ddlCity != null)
                    {
                        RadGrid ctygrid = ddlCity.Items[0].FindControl("rGrdCity4DDL") as RadGrid;
                        if (ctygrid != null)
                        {
                            htSearchParams = new Hashtable();
                            htSearchParams.Add("@ID", ctrIdd);
                            ctygrid.DataSource = clsDAL.GetDataSet_Payroll("sp_payroll_GetCountryCities", htSearchParams).Tables[0];
                            ctygrid.DataBind();
                            ddlCity.Text = string.Empty;
                        }
                    }
                }
            }
        }
    }
}