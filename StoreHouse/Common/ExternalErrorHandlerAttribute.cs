using StoreHouse.Models;
using StoreHouse.Models.Constants;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Http.Filters;

namespace StoreHouse.Common
{
    public class ExternalErrorHandlerAttribute : ExceptionFilterAttribute
    {
        public override void OnException(HttpActionExecutedContext context)
        {
            if (context.ActionContext.ActionArguments.Any(p => p.Value == null))
            {
                context.Response = context.Request.CreateResponse(
                            HttpStatusCode.OK,
                            new { status = new Status(Code.BadRequest) });
            }
            else
                if (!HttpContext.Current.Request.ContentType.ToLower().Contains("application/json"))
                {
                    context.Response = context.Request.CreateResponse(
                        HttpStatusCode.OK,
                        new { status = new Status(Code.UnsupportedMediaType) });
                }
                else
                {
                    context.Response = context.Request.CreateResponse(
                        HttpStatusCode.OK,
                        new { status = new Status(Code.UnexpectedError) });
                }
            base.OnException(context);
        }
    }
}