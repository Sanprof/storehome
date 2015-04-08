using StoreHouse.Common;
using StoreHouse.Models;
using StoreHouse.Models.Constants;
using System;
using System.Linq;
using System.Configuration;
using System.Dynamic;
using System.Net;
using System.Net.Http;
using System.Net.Mail;
using System.Threading.Tasks;
using System.Web;
using System.Web.Http;

namespace StoreHouse.Controllers
{
    [RoutePrefix("api/token")]
    public class TokenApiController : BaseApiController
    {
        [HttpPost]
        [Route("auth")]
        public async Task<HttpResponseMessage> ValidateUser([FromBody] LoginUserModel user)
        {
            var status = default(Code);
            string token = null;
            var dbuser = store
                .Users
                .FirstOrDefault(u => u.UserName.ToLower().CompareTo(user.username.ToLower()) == 0);
            dynamic response = null;
            if (dbuser != null)
            {
                if (dbuser.IsDeleted == null || (dbuser.IsDeleted != null && !dbuser.IsDeleted.Value))
                {
                    if (dbuser.Password.ToUpper().CompareTo(PasswordGenerator.GetPasswordSHA1(Convert.ToString(user.password), dbuser.Salt)) == 0)
                    {
                        token = UserSessionState.AddNew(dbuser.UserID, user.rememberme);
                        store.UserSessions.Add(new StoreHouse.Models.UserSession()
                        {
                            WorkerID = dbuser.WorkerID,
                            Token = token,
                            RememberMe = true,
                            Expired = DateTimeOffset.UtcNow.DateTime.AddMonths(1),
                            CreatedDate = DateTimeOffset.UtcNow.DateTime
                        });
                        store.SaveChanges();
                        response = new ExpandoObject();
                        response.rememberme = user.rememberme;
                        response.username = dbuser.UserName;
                    }
                    else
                        status = Code.LoginFailed;
                }
                else
                    status = Code.UserHasDeleted;
            }
            else
            {
                status = Code.LoginFailed;
            }
            return Request.CreateResponse(HttpStatusCode.OK, ApiResponseManager.CreateResponse(new Status(status), (object)response, (!string.IsNullOrWhiteSpace(token) ? token : null)));
        }

        [HttpPost]
        [Route("logoff")]
        public async Task<HttpResponseMessage> UserLogoff([FromBody] TokenBase tokenObj)
        {
            var status = default(Code);
            string token = Convert.ToString(tokenObj.token);
            var uSession = store
                        .UserSessions
                        .FirstOrDefault(us => us.Token.CompareTo(token) == 0);
            if (uSession != null)
            {
                store.UserSessions.Remove(uSession);
                store.SaveChanges();
            }
            return Request.CreateResponse(HttpStatusCode.OK, ApiResponseManager.CreateResponse(new Status(status)));
        }

        [HttpPost]
        [Route("~/passrecover")]
        public async Task<HttpResponseMessage> PasswordRecovery([FromBody] RecoveryPasswordModel user)
        {
            
            var status = default(Code);
            var dbuser = store.Users.FirstOrDefault(u => u.Email.ToLower().CompareTo(user.email.ToLower()) == 0);
            dynamic response = null;
            if (dbuser != null)
            {
                if (dbuser.IsDeleted == null || (dbuser.IsDeleted != null && !dbuser.IsDeleted.Value))
                {
                    int passLength = 6;
                    if (!int.TryParse(ConfigurationManager.AppSettings["newPassLength"], out passLength))
                        passLength = 6;
                    string password = PasswordGenerator.GetPassword(passLength);
                    dbuser.Password = PasswordGenerator.GetPasswordSHA1(password, dbuser.Salt);
                    store.SaveChanges();
                    /*MailAddress to = new MailAddress(dbuser.Email);
                    MailMessage message = new MailMessage();
                    message.To.Add(to);
                    message.Subject = message.Subject = System.Configuration.ConfigurationManager.AppSettings["resetPass_EmailSubject"];
                    string str = System.IO.File.ReadAllText(HttpContext.Current.Server.MapPath("~/Email/PasswordRecovery.html"));
                    message.Body = String.Format(str, dbuser.FirstName, dbuser.LastName, "http://" + user.host, dbuser.UserName, password);
                    message.IsBodyHtml = true;
                    SmtpClient client = new SmtpClient();
                    try
                    {
                        client.Send(message);
                    }
                    catch (Exception exc)
                    {
                        status = Code.EmailSendFailed;
                    }*/
                }
                else
                    status = Code.UserHasDeleted;
            }
            else
            {
                status = Code.UserWithEmailNotFound;
            }
            return Request.CreateResponse(HttpStatusCode.OK, ApiResponseManager.CreateResponse(new Status(status), (object)response));
        }
    }
}
