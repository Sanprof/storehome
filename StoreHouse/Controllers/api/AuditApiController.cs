using StoreHouse.Common;
using StoreHouse.Models;
using StoreHouse.Models.Constants;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Dynamic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Reflection;
using System.Threading.Tasks;
using System.Web.Http;

namespace StoreHouse.Controllers.api
{
    [RoutePrefix("api/audit")]
    public class AuditApiController : WithDataPagesController
    {
        protected override List<object> GetAllData(dynamic data)
        {
            var auditShowFilter = (AuditShowFilter)data.extend.showfilter;
            return store
                .Audits
                .Where(a => auditShowFilter == AuditShowFilter.OnlyNew ? !a.Readed : (auditShowFilter == AuditShowFilter.OnlyReaded ? a.Readed : true))
                .AsEnumerable()
                .Select(a =>
                {
                    dynamic expando = new ExpandoObject();
                    expando.id = a.AuditID;
                    expando.tool = new
                    {
                        id = a.ToolID,
                        name = a.Tool.Name
                    };
                    expando.worker = new
                    {
                        id = a.WorkerID,
                        lastname = a.Worker.LastName,
                        firstname = a.Worker.FirstName,
                        middlename = a.Worker.MiddleName
                    };
                    expando.action = GetTypeDescription((ToolAction)a.Action);
                    expando.count = a.Count;
                    expando.readed = a.Readed;
                    expando.creationdate = a.CreationDate;
                    return expando;
                })
                .ToList<object>();
        }

        protected override object GetAdditionDataAfterSorting(dynamic response, dynamic data)
        {
            if (response != null)
            {
                foreach (var item in response)
                {
                    item.creationdate = item.creationdate.ToString("dd.MM.yyyyTHH:mm");
                }
            }
            return response;
        }

        public string GetTypeDescription(Enum ToolAction)
        {
            FieldInfo fi = ToolAction.GetType().GetField(ToolAction.ToString());
            DescriptionAttribute[] attributes = (DescriptionAttribute[])fi.GetCustomAttributes(typeof(DescriptionAttribute), false);
            if (attributes.Length > 0)
            {
                return attributes[0].Description;
            }
            else
            {
                return ToolAction.ToString();
            }
        }

        [HttpPost]
        [Route("setreaded")]
        public async Task<IHttpActionResult> SetAuditMessageReaded([FromBody]MultiDBAction data)
        {
            Code status = default(Code);
            int? userID = UserSessionState.UserID(data.token);
            if (userID.HasValue)
            {
                foreach (var id in data.ids)
                {
                    var audit = store
                        .Audits
                        .FirstOrDefault(a => a.AuditID == id);
                    if (audit != null)
                    {
                        audit.Readed = true;
                        store.SaveChanges();
                    }
                    else
                        status = Code.NotFound;
                }
            }
            else
                status = Code.AuthRequired;
            return Ok(ApiResponseManager.CreateResponse(new Status(status)));
        }
    }
}
