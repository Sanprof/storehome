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
    [RoutePrefix("api/categories")]
    public class CategoryApiController : WithDataPagesController
    {
        protected override List<object> GetAllData(dynamic data)
        {
            return store
               .Categories
               .Where(c => !c.IsDeleted)
               .AsEnumerable()
               .Select(c =>
               {
                   dynamic expando = new ExpandoObject();
                   expando.id = c.CategoryID;
                   expando.name = c.Name;
                   expando.description = c.Description;
                   expando.toolpositions = c
                       .Tools
                       .Where(t => t.CategoryID == c.CategoryID && (!t.IsDeleted.HasValue || (t.IsDeleted.HasValue && !t.IsDeleted.Value)))
                       .Count();
                   var tools = c
                       .Tools
                       .Where(t => t.CategoryID == c.CategoryID && (!t.IsDeleted.HasValue || (t.IsDeleted.HasValue && !t.IsDeleted.Value)))
                       .ToList();
                   expando.toolscount = tools.Count > 0 ? tools.Select(t => t.Count).AsEnumerable().Sum() : 0;
                   return expando;
               })
               .ToList<object>();
        }

        [HttpPut]
        [Route("")]
        public async Task<IHttpActionResult> AddCategory([FromBody]dynamic data)
        {
            Code status = default(Code);
            dynamic response = null;
            var dbObj = new Category()
            {
                Name = data.name,
                Description = data.description,
                IsDeleted = false,
                CreationDate = DateTimeOffset.UtcNow.DateTime
            };
            store.Categories.Add(dbObj);
            store.SaveChanges();
            response = store
               .Categories
               .Where(c => c.CategoryID == dbObj.CategoryID)
               .Select(c => new
               {
                   id = c.CategoryID,
                   name = c.Name,
                   description = c.Description,
                   toolpositions = 0,
                   toolscount = 0
               })
               .FirstOrDefault();
            return Ok(ApiResponseManager.CreateResponse(new Status(status), response));
        }

        [HttpPost]
        [Route("")]
        public async Task<IHttpActionResult> UpdateCategory([FromBody]UpdateCategoryModel data)
        {
            Code status = default(Code);
            var category = store
                .Categories
                .Where(c => c.CategoryID == data.id)
                .FirstOrDefault();
            if (category != null)
            {
                category.Name = data.name;
                category.Description = data.description;
            }
            store.SaveChanges();
            return Ok(ApiResponseManager.CreateResponse(new Status(status)));
        }

        [HttpDelete]
        [Route("")]
        public async Task<IHttpActionResult> DeleteCategory([FromBody]SimpleDeleteModel data)
        {
            Code status = default(Code);
            var category = store
                .Categories
                .Where(c => c.CategoryID == data.id).FirstOrDefault();
            if (category != null)
            {
                category.IsDeleted = true;
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
