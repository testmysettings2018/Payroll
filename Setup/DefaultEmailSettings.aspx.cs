using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net.Mail;
using System;
using System.Web.UI;
using System.Linq;
using System.Web;
using System.Collections;
using System.Net.Mail;
using System.Net;
using System.Configuration;
using System.ComponentModel;
using System.Data;
public partial class Payroll_Setup_DefaultEmailSettings : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void RadButton1_Click(object sender, EventArgs e)
    {
        SendEmail2();
    }

    protected void SendEmail2()
    {
        try
        {
            MailMessage msg = new MailMessage();
            string add;
            msg.To.Add("salmanfazal@gmail.com");

            msg.From = new MailAddress("rene@neelands.com");
            msg.Subject = "Subject";
            SmtpClient smtp = new System.Net.Mail.SmtpClient("pro.turbo-smtp.com", 587);
            ICredentials credentials;

                smtp.UseDefaultCredentials = true;
                smtp.Credentials = new NetworkCredential("rene@neelands.com", "z5scz6A9");

            smtp.EnableSsl = false;


            smtp.Send(msg);

            msg.To.Clear();
        }
        catch (Exception ex)
        {
        }
       
    }

    protected void SendEmail()
    {
        
                MailMessage msg = new MailMessage();

                msg.To.Add("salmanfazal@gmail.com"); 
                msg.From = new MailAddress("rene@neelands.com");

                msg.Subject = "Test Subject";
                msg.Body = "Test Body";
                msg.IsBodyHtml = true;
               
                // Smtp settings
                SmtpClient smtp = new SmtpClient("pro.turbo-smtp.com", 25);

                    smtp.UseDefaultCredentials = false;
                    smtp.Credentials = new NetworkCredential("rene@neelands.com", "z5scz6A9");
                    smtp.EnableSsl = false;

                smtp.Send(msg);
                
                msg.Dispose();
    }
}