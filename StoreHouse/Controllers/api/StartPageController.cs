using StoreHouse.Common;
using StoreHouse.Models;
using StoreHouse.Models.Constants;
using System.Collections.Generic;
using System.Dynamic;
using System.Linq;
using System.Threading.Tasks;
using System.Web.Http;

namespace StoreHouse.Controllers.api
{
    [RoutePrefix("api/startpage")]
    public class StartPageController : WithDataPagesController
    {
        protected override List<object> GetAllData(dynamic data)
        {
            return store
                .ToolsUses
                .Where(t => !t.Tool.Category.IsDeleted && (!t.Tool.IsDeleted.HasValue || (t.Tool.IsDeleted.HasValue && !t.Tool.IsDeleted.Value)))
                .OrderByDescending(h => h.CreationDate)
                .Take(100)
                .AsEnumerable()
                .Select(tu =>
                        {
                            dynamic expando = new ExpandoObject();
                            expando.isinc = tu.Count > 0;
                            expando.name = tu.Tool.Name;
                            expando.count = System.Math.Abs(tu.Count);
                            expando.time = tu.CreationDate;
                            expando.worker = new ExpandoObject();
                            expando.worker.lastname = tu.Worker.LastName;
                            expando.worker.firstname = tu.Worker.FirstName;
                            expando.worker.middlename = tu.Worker.MiddleName;
                            return expando;
                        })
                .ToList<object>();
        }

        [HttpGet]
        [HttpGetType(typeof(TokenBase))]
        [ParameterConverter(Parameter = "data")]
        [Route("summary")]
        public virtual async Task<IHttpActionResult> GetSummary(dynamic data)
        {
            Code status = default(Code);
            dynamic response = null;
            var allTools = store
                .Tools
                .Where(t => !t.IsDeleted.HasValue || (t.IsDeleted.HasValue && !t.IsDeleted.Value) &&
                    !t.Category.IsDeleted)
                .Select(t => t.Count)
                .ToList();
            response = new
            {
                all = allTools.Count > 0 ? allTools.Sum() : 0,
                inuse = System.Math.Abs(ToolsHelper.ToolStat(store)),
            };
            return Ok(ApiResponseManager.CreateResponse(new Status(status), response));
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
