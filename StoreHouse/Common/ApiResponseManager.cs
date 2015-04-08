using StoreHouse.Models;
using System.Dynamic;

namespace StoreHouse.Common
{
    public static class ApiResponseManager
    {
        public static object CreateResponse(Status status, object data = null, object token = null)
        {
            dynamic expando = new ExpandoObject();
            if (token != null)
                expando.token = token;
            if (data != null)
                expando.response = data;
            expando.status = status;
            return expando;
        }
    }
}