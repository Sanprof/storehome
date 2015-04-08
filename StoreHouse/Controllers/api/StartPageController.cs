using StoreHouse.Common;
using StoreHouse.Models;
using StoreHouse.Models.Constants;
using System.Collections.Generic;
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
                .Select(tu => new
                        {
                            isinc = tu.Count > 0,
                            name = tu.Tool.Name,
                            count = System.Math.Abs(tu.Count),
                            time = tu.CreationDate,
                            worker = new
                            {
                                lastname = tu.Worker.LastName,
                                firstname = tu.Worker.FirstName,
                                middlename = tu.Worker.MiddleName,
                            }
                        })
                .OrderByDescending(q => q.time)
                .Take(100)
                .AsEnumerable()
                .Select(q => new
                {
                    isinc = q.isinc,
                    name = q.name,
                    count = q.count,
                    time = q.time.ToString("dd.MM.yyyyTHH:mm"),
                    worker = new
                    {
                        lastname = q.worker.lastname,
                        firstname = q.worker.firstname,
                        middlename = q.worker.middlename,
                    }
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
    }
}
