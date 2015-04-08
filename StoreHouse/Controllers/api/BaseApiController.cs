using StoreHouse.Models;
using System.Web.Http;

namespace StoreHouse.Controllers
{
    public class BaseApiController : ApiController
    {
        protected Entities store = null;

        public BaseApiController()
        {
            store = new Entities();
        }
    }
}
