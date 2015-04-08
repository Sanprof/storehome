using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace StoreHouse.Controllers.api
{
    [RoutePrefix("api/writeoffs")]
    public class WriteOffApiController : WithDataPagesController
    {
        protected override List<object> GetAllData(dynamic data)
        {
            return store
                .WriteOffTools
                .AsEnumerable()
                .Select(w => new
                {
                    name = w.Tool.Name,
                    count = w.Count,
                    time = w.WriteOffTime.ToString("dd.MM.yyyyTHH:mm"),
                    worker = new
                    {
                        lastname = w.Worker.LastName,
                        firstname = w.Worker.FirstName,
                        middlename = w.Worker.MiddleName,
                    }
                })
                .ToList<object>();
        }
    }
}
