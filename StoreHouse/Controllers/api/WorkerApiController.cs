﻿using StoreHouse.Common;
using StoreHouse.Models;
using StoreHouse.Models.Constants;
using System;
using System.Collections.Generic;
using System.Dynamic;
using System.Linq;
using System.Threading.Tasks;
using System.Web.Http;

namespace StoreHouse.Controllers.api
{
    [RoutePrefix("api/workers")]
    public class WorkerApiController : WithDataPagesController
    {
        protected override List<object> GetAllData(dynamic data)
        {
            return store
                .Workers
                .Where(w => (!w.IsDeleted.HasValue || (w.IsDeleted.HasValue && !w.IsDeleted.Value)) && !w.Position.IsDeleted)
                .AsEnumerable()
                .Select(w =>
                {
                    dynamic expando = new ExpandoObject();
                    expando.id = w.WorkerID;
                    expando.lastname = w.LastName;
                    expando.firstname = w.FirstName;
                    expando.middlename = w.MiddleName;
                    expando.position = new ExpandoObject();
                    expando.position.id = w.PositionID;
                    expando.position.name = w.Position.Name;
                    expando.toolscount = Math.Abs(ToolsHelper.ToolStatByWorkerID(store, w.WorkerID));
                    return expando;
                })
                .ToList<object>();
        }

        [HttpPut]
        [Route("")]
        public async Task<IHttpActionResult> AddWorker([FromBody]dynamic data)
        {
            Code status = default(Code);
            dynamic response = null;
            var dbObj = new Worker()
            {
                FirstName = data.firstname,
                LastName = data.lastname,
                MiddleName = data.middlename,
                PositionID = data.positionid,
                IsDeleted = false,
                CreationDate = DateTimeOffset.UtcNow.DateTime
            };
            store.Workers.Add(dbObj);
            store.SaveChanges();
            var position = store
                .Workers
                .Where(w => w.WorkerID == dbObj.WorkerID)
                .Select(w => w.Position)
                .FirstOrDefault();
            response = new
                  {
                      id = dbObj.WorkerID,
                      lastname = dbObj.LastName,
                      firstname = dbObj.FirstName,
                      middlename = dbObj.MiddleName,
                      position = new
                      {
                          id = position.PositionID,
                          name = position.Name
                      },
                      toolscount = Math.Abs(ToolsHelper.ToolStatByWorkerID(store, dbObj.WorkerID))
                  };
            return Ok(ApiResponseManager.CreateResponse(new Status(status), response));
        }

        [HttpPost]
        [Route("")]
        public async Task<IHttpActionResult> UpdateWorker([FromBody]UpdateWorkerModel data)
        {
            Code status = default(Code);
            var worker = store
                .Workers
                .Where(c => c.WorkerID == data.id)
                .FirstOrDefault();
            if (worker != null)
            {
                worker.FirstName = data.firstname;
                worker.LastName = data.lastname;
                worker.MiddleName = data.middlename;
                worker.PositionID = data.positionid;
            }
            store.SaveChanges();
            return Ok(ApiResponseManager.CreateResponse(new Status(status)));
        }

        [HttpDelete]
        [Route("")]
        public async Task<IHttpActionResult> DeleteWorker([FromBody]SimpleDeleteModel data)
        {
            Code status = default(Code);
            var worker = store
                .Workers
                .Where(c => c.WorkerID == data.id).FirstOrDefault();
            if (worker != null)
            {
                worker.IsDeleted = true;
                store.SaveChanges();
            }
            else
            {
                status = Code.NotFound;
            }
            return Ok(ApiResponseManager.CreateResponse(new Status(status)));
        }

        [HttpPost]
        [Route("usedtools")]
        public async Task<IHttpActionResult> ToolsInUse([FromBody]SimpleDeleteModel data)
        {
            Code status = default(Code);
            dynamic response = null;

            /*store
                .IssuedTools
                .Where(it => it.WorkerID == data.id)
                .GroupBy(it => it.ToolID)
                .Select(it => new
                {
                });*/
            return Ok(ApiResponseManager.CreateResponse(new Status(status), response));
        }
    }
}
