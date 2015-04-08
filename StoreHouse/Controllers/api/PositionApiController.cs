using StoreHouse.Common;
using StoreHouse.Models;
using StoreHouse.Models.Constants;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web.Http;

namespace StoreHouse.Controllers.api
{
    [RoutePrefix("api/positions")]
    public class PositionApiController : WithDataPagesController
    {
        protected override List<object> GetAllData(dynamic data)
        {
            return store
                .Positions
                .Where(p => !p.IsDeleted)
                .Select(p => new { id = p.PositionID, name = p.Name, description = p.Description })
                .ToList<object>();
        }

        [HttpPut]
        [Route("")]
        public async Task<IHttpActionResult> AddPosition([FromBody]dynamic data)
        {
            Code status = default(Code);
            dynamic response = null;
            var dbObj = new Position()
            {
                Name = data.name,
                Description = data.description,
                IsDeleted = false,
                CreationDate = DateTimeOffset.UtcNow.DateTime
            };
            store.Positions.Add(dbObj);
            store.SaveChanges();
            response = store
               .Positions
               .Where(c => c.PositionID == dbObj.PositionID)
               .Select(c => new
               {
                   id = c.PositionID,
                   name = c.Name,
                   description = c.Description,
               })
               .FirstOrDefault();
            return Ok(ApiResponseManager.CreateResponse(new Status(status), response));
        }

        [HttpPost]
        [Route("")]
        public async Task<IHttpActionResult> UpdatePosition([FromBody]UpdateCategoryModel data)
        {
            Code status = default(Code);
            var position = store
                .Positions
                .Where(c => c.PositionID == data.id)
                .FirstOrDefault();
            if (position != null)
            {
                position.Name = data.name;
                position.Description = data.description;
            }
            store.SaveChanges();
            return Ok(ApiResponseManager.CreateResponse(new Status(status)));
        }

        [HttpDelete]
        [Route("")]
        public async Task<IHttpActionResult> DeletePosition([FromBody]SimpleDeleteModel data)
        {
            Code status = default(Code);
            var position = store
                .Positions
                .Where(c => c.PositionID == data.id).FirstOrDefault();
            if (position != null)
            {
                position.IsDeleted = true;
                store.SaveChanges();
            }
            else
            {
                status = Code.NotFound;
            }
            return Ok(ApiResponseManager.CreateResponse(new Status(status)));
        }
    }
}
