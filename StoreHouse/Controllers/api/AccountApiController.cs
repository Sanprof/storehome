using Newtonsoft.Json.Converters;
using StoreHouse.Common;
using StoreHouse.Models;
using StoreHouse.Models.Constants;
using System;
using System.Collections.Generic;
using System.Dynamic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Net.Mail;
using System.Threading.Tasks;
using System.Web;
using System.Web.Http;

namespace StoreHouse.Controllers.api
{
    [RoutePrefix("api/accounts")]
    public class AccountApiController : WithDataPagesController
    {
        protected override List<object> GetAllData(dynamic data)
        {
            return store
                .Users
                .Where(u => (!u.IsDeleted.HasValue || (u.IsDeleted.HasValue && !u.IsDeleted.Value)))
                .ToList()
                .Select(u =>
                {
                    dynamic expando = new ExpandoObject();
                    expando.id = u.UserID;
                    expando.username = u.UserName;
                    expando.type = new
                    {
                        id = u.UserTypeID,
                        name = u.UserType.Name
                    };
                    expando.email = u.Email;
                    expando.worker = new
                    {
                        id = u.WorkerID,
                        lastname = u.Worker.LastName,
                        firstname = u.Worker.FirstName,
                        middlename = u.Worker.MiddleName
                    };
                    expando.creationdate = u.CreatedDate.ToString("dd.MM.yyyyTHH:mm");
                    return expando;
                })
                .ToList<object>();
        }

        [HttpPut]
        [Route("")]
        public async Task<IHttpActionResult> AddAccount(dynamic data)
        {
            data = Newtonsoft.Json.JsonConvert.DeserializeObject<ExpandoObject>(Convert.ToString(data), new ExpandoObjectConverter());
            Code status = default(Code);
            dynamic response = null;
            string password = PasswordGenerator.GetPassword(8);
            int salt = new Random().Next(0, int.MaxValue);
            var dbObj = new User()
            {
                UserName = data.username,
                Salt = salt,
                Password = PasswordGenerator.GetPasswordSHA1(password, salt),
                UserTypeID = Convert.ToInt32(data.typeid),
                WorkerID = Convert.ToInt32(data.workerid),
                Email = data.email,
                IsDeleted = false,
                CreatedDate = DateTimeOffset.UtcNow.DateTime
            };
            store.Users.Add(dbObj);
            store.SaveChanges();
            MailAddress to = new MailAddress(dbObj.Email);
            MailMessage message = new MailMessage();
            message.To.Add(to);
            message.Subject = "Регистрация";
            var wr = store
                .Users
                .Where(u => u.UserID == dbObj.UserID)
                .Select(u => u.Worker)
                .FirstOrDefault();
            message.Body = String.Format(@"<p>Ув., {0} {1}, ваш аккаунт был успешно создан</p>
                                        <p>Для вас был создан пароль, который вы можете изменить после первого входа на сайт</p>
                                        <p>Ваши учетный данные:</p>
                                                        Имя пользователя: {2}<br>
                                                        Пароль: {3}<br>
                                        <hr />
                                        <p>Best regards!</p>",
                     wr.FirstName, wr.LastName, dbObj.UserName, password);
            message.IsBodyHtml = true;
            SmtpClient client = new SmtpClient();
            try
            {
                client.Send(message);
            }
            catch (Exception exc)
            {
                //SLICLog.Error(exc);
            }
            response = store
                .Users
                .Where(u => (!u.IsDeleted.HasValue || (u.IsDeleted.HasValue && !u.IsDeleted.Value)) && u.UserID == dbObj.UserID)
                .ToList()
                .Select(u =>
                {
                    dynamic expando = new ExpandoObject();
                    expando.id = u.UserID;
                    expando.username = u.UserName;
                    var userType = store.UserTypes.FirstOrDefault(ut => ut.UserTypeID == u.UserTypeID);
                    expando.type = new
                    {
                        id = u.UserTypeID,
                        name = userType.Name
                    };
                    expando.email = u.Email;
                    var worker = store.Workers.FirstOrDefault(w => w.WorkerID == u.WorkerID);
                    expando.worker = new
                    {
                        id = u.WorkerID,
                        lastname = worker.LastName,
                        firstname = worker.FirstName,
                        middlename = worker.MiddleName
                    };
                    expando.creationdate = u.CreatedDate.ToString("dd.MM.yyyyTHH:mm");
                    return expando;
                })
                .FirstOrDefault();
            return Ok(ApiResponseManager.CreateResponse(new Status(status), response));
        }

        [HttpPost]
        [Route("")]
        public async Task<IHttpActionResult> UpdateAccount([FromBody]dynamic data)
        {
            Code status = default(Code);
            dynamic response = null;

            int? userID = UserSessionState.UserID(data.token);
            if (userID.HasValue)
            {
                int id = (int)data.id;
                var account = store
                   .Users
                   .FirstOrDefault(u => u.UserID == id);
                if (account != null)
                {
                    account.Email = data.email;
                    account.UserTypeID = data.typeid;
                    store.SaveChanges();
                }
                else
                    status = Code.NotFound;
            }
            else
                status = Code.AuthRequired;
            return Ok(ApiResponseManager.CreateResponse(new Status(status), response));
        }

        [HttpDelete]
        [Route("")]
        public async Task<IHttpActionResult> DeleteAccount([FromBody]SimpleDeleteModel data)
        {
            Code status = default(Code);
            int? userId = UserSessionState.UserID(Convert.ToString(data.token));
            int? response = null;
            if (userId != null)
            {
                var account = store
                    .Users
                    .FirstOrDefault(u => u.UserID == data.id);
                if (account != null)
                {
                    account.IsDeleted = true;
                    store.SaveChanges();
                    response = data.id;
                }
                else
                    status = Code.NotFound;
            }
            else
                status = Code.AuthRequired;
            return Ok(ApiResponseManager.CreateResponse(new Status(status), response));
        }

        [HttpPost]
        [Route("types")]
        public async Task<IHttpActionResult> GetUserTypes([FromBody]dynamic data)
        {
            Code status = default(Code);
            dynamic response = null;

            int? userID = UserSessionState.UserID(data.token);
            if (userID.HasValue)
            {
                response = store
                    .UserTypes
                    .Select(ut => new
                    {
                        id = ut.UserTypeID,
                        name = ut.Name
                    });
            }
            else
                status = Code.AuthRequired;
            return Ok(ApiResponseManager.CreateResponse(new Status(status), response));
        }
    }
}
