using System.Collections.Generic;
using System.Dynamic;
using System.Linq;
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
                .Select(w =>
                {
                    dynamic expando = new ExpandoObject();
                    expando.name = w.Tool.Name;
                    expando.count = w.Count;
                    expando.time = w.WriteOffTime;
                    expando.comment = w.Comment;
                    expando.worker = new ExpandoObject();
                    expando.worker.lastname = w.Worker.LastName;
                    expando.worker.firstname = w.Worker.FirstName;
                    expando.worker.middlename = w.Worker.MiddleName;
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
                    item.time = item.time.ToString("dd.MM.yyyyTHH:mm");
                }
            }
            return response;
        }
    }
}
