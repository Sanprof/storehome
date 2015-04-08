using StoreHouse.Common;
using StoreHouse.Models;
using StoreHouse.Models.Constants;
using System;
using System.Collections.Generic;
using System.Dynamic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web.Http;

namespace StoreHouse.Controllers.api
{
    [RoutePrefix("api/tools")]
    public class ToolsApiController : WithDataPagesController
    {
        protected override List<object> GetAllData(dynamic data)
        {
            /*var tools = store
                .Categories
                .Where(c=>c)*/
            return new List<object>();
        }

        [Route("incat/partial")]
        [HttpGet]
        [HttpGetType(typeof(ListPartialModel))]
        [ParameterConverter(Parameter = "data")]
        public async Task<IHttpActionResult> GetToolsInCategory([FromBody]dynamic data)
        {
            Code status = default(Code);
            int id = (int)data.extend.id;
            var response = store
                .Tools
                .Where(t => t.CategoryID == id && (!t.IsDeleted.HasValue || (t.IsDeleted.HasValue && !t.IsDeleted.Value)))
                .AsEnumerable()
                .OrderBy(t => t.Name)
                .Select(t =>
                {
                    dynamic expando = new ExpandoObject();
                    expando.id = t.ToolID;
                    expando.name = t.Name;
                    expando.toolscount = t.Count;
                    expando.toolsinuse = Math.Abs(ToolsHelper.ToolStatByToolID(store, t.ToolID));
                    return expando;
                })
                .ToList<object>();
            string searchStr = !String.IsNullOrWhiteSpace(data.sort.search) ? data.sort.search.ToLower() : null;
            if (!string.IsNullOrWhiteSpace(searchStr) && response.Count > 0)
            {
                Type myListElementType = response[0].GetType();
                if (myListElementType == typeof(ExpandoObject))
                {
                    response = response
                        .Where(t => ((IDictionary<string, object>)t)
                                        .Values
                                        .Where(v => !string.IsNullOrWhiteSpace(Convert.ToString(v)) && Convert.ToString(v).ToLower().Contains(searchStr.ToLower()))
                                        .Count() > 0)
                        .ToList();
                }
                else
                {
                    List<object> searchedList = new List<object>();
                    foreach (var item in response)
                    {
                        var pis = item.GetType().GetProperties();
                        bool isInSearch = false;
                        foreach (var pi in pis)
                        {
                            string value = Convert.ToString(pi.GetValue(item, null));
                            if (!string.IsNullOrWhiteSpace(value) && value.ToLower().Contains(searchStr.ToLower()))
                            {
                                isInSearch = true;
                                break;
                            }
                        }
                        if (isInSearch)
                            searchedList.Add(item);
                    }
                    response = searchedList;
                }
            }
            return Ok(ApiResponseManager.CreateResponse(new Status(status), new { data = response }));
        }

        [HttpPut]
        [Route("incat")]
        public async Task<IHttpActionResult> AddTool([FromBody]dynamic data)
        {
            Code status = default(Code);
            dynamic response = null;
            var dbObj = new Tool()
            {
                Name = data.name,
                CategoryID = Convert.ToInt32(data.category),
                Count = Convert.ToInt32(data.count),
                IsDeleted = false,
                CreationDate = DateTimeOffset.UtcNow.DateTime
            };
            store.Tools.Add(dbObj);
            store.SaveChanges();
            response = new
               {
                   id = dbObj.ToolID,
                   name = dbObj.Name,
                   toolscount = dbObj.Count,
                   toolsinuse = 0,
               };
            return Ok(ApiResponseManager.CreateResponse(new Status(status), response));
        }

        [HttpPost]
        [Route("incat")]
        public async Task<IHttpActionResult> UpdateTool([FromBody]UpdateToolModel data)
        {
            Code status = default(Code);
            dynamic response = null;
            var dbObj = store
                .Tools
                .Where(t => t.ToolID == data.id)
                .FirstOrDefault();
            if (dbObj != null)
            {
                dbObj.Name = data.name;
                dbObj.Count += data.count;
                store.SaveChanges();
                response = new
                {
                    id = dbObj.ToolID,
                    name = dbObj.Name,
                    toolscount = dbObj.Count,
                    toolsinuse = 0,
                };
            }
            else
                status = Code.NotFound;
            return Ok(ApiResponseManager.CreateResponse(new Status(status), response));
        }

        [HttpDelete]
        [Route("incat")]
        public async Task<IHttpActionResult> DeleteTool([FromBody]SimpleDeleteModel data)
        {
            Code status = default(Code);
            int? userId = UserSessionState.UserID(Convert.ToString(data.token));
            int? response = null;
            if (userId != null)
            {
                var c = ToolsHelper.ToolStatByToolID(store, data.id);
                if (c <= 0)
                {
                    var tool = store
                        .Tools
                        .FirstOrDefault(t => t.ToolID == data.id);
                    tool.IsDeleted = true;
                    store
                    .DeletedTools
                    .Add(new DeletedTool()
                    {
                        ToolID = data.id,
                        WorkerID = store.Users.FirstOrDefault(u => u.UserID == userId.Value).WorkerID,
                        DeletedDate = DateTimeOffset.UtcNow.DateTime
                    });
                    store.SaveChanges();
                    response = data.id;
                }
                else
                    status = Code.ToolIsInUse;
            }
            else
                status = Code.AuthRequired;
            return Ok(ApiResponseManager.CreateResponse(new Status(status), response));
        }

        [HttpPost]
        [Route("incat/writeoff")]
        public async Task<IHttpActionResult> WriteOffTool([FromBody]WriteOffModel data)
        {
            Code status = default(Code);
            dynamic response = null;
            if (data.count > 0)
            {
                int? userID = UserSessionState.UserID(data.token);
                if (userID.HasValue)
                {
                    var allTools = store
                        .Tools
                        .Where(t => (!t.IsDeleted.HasValue || (t.IsDeleted.HasValue && !t.IsDeleted.Value)) &&
                            !t.Category.IsDeleted &&
                            t.ToolID == data.id)
                        .Select(t => t.Count)
                        .ToList();
                    var all = allTools.Count > 0 ? allTools.Sum() : 0;
                    int inuseCount = Math.Abs(ToolsHelper.ToolStatByToolID(store, data.id));
                    if (data.count < all - inuseCount)
                    {
                        store
                            .WriteOffTools
                            .Add(new WriteOffTool()
                            {
                                ToolID = data.id,
                                WorkerID = store.Users.FirstOrDefault(u => u.UserID == userID.Value).WorkerID,
                                Count = data.count,
                                WriteOffTime = DateTimeOffset.UtcNow.DateTime
                            });
                        var tool = store
                            .Tools
                            .FirstOrDefault(t => t.ToolID == data.id);
                        if (tool != null)
                        {
                            response = tool.Count -= data.count;
                            store.SaveChanges();
                        }
                        else
                            status = Code.NotFound;
                    }
                    else
                        status = Code.OperationFailed;
                }
                else
                    status = Code.AuthRequired;
            }
            return Ok(ApiResponseManager.CreateResponse(new Status(status), response));
        }

        [HttpPost]
        [Route("incat/incissue")]
        public async Task<IHttpActionResult> IncIssueTool([FromBody]IncIssueModel data)
        {
            Code status = default(Code);
            dynamic response = null;
            int? userID = UserSessionState.UserID(data.token);
            if (userID.HasValue)
            {
                store.ToolsUses.Add(new ToolsUs()
                {
                    ToolID = data.id,
                    WorkerID = data.workerid,
                    ManageWorkerID = store.Users.FirstOrDefault(u => u.UserID == userID.Value).WorkerID,
                    Count = data.count * (data.isinc ? 1 : -1),
                    CreationDate = DateTimeOffset.UtcNow.DateTime
                });
                store.SaveChanges();
                response = Math.Abs(ToolsHelper.ToolStatByToolID(store, data.id));
            }
            else
                status = Code.AuthRequired;
            return Ok(ApiResponseManager.CreateResponse(new Status(status), response));
        }

        [HttpPost]
        [Route("incat/used")]
        public async Task<IHttpActionResult> ToolsInUse([FromBody]ToolsInCategoryModel data)
        {
            Code status = default(Code);
            dynamic response = null;

            var objs = store
                .Get_UsersUsedTool(data.id)
                .Select(g => new
                {
                    tool = new
                    {
                        id = g.ToolID,
                        name = g.Name
                    },
                    worker = new
                    {
                        id = g.WorkerID,
                        lastname = g.LastName,
                        firstname = g.FirstName,
                        middlename = g.MiddleName
                    },
                    count = g.Count
                })
                .ToList<object>();
            response = objs;
            return Ok(ApiResponseManager.CreateResponse(new Status(status), response));
        }
    }
}
