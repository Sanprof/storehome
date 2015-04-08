using StoreHouse.Common;
using StoreHouse.Models.Constants;
using System;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http.Controllers;
using System.Web.Http.Filters;

namespace StoreHouse.Models.Users
{
    public class AuthenticateAttribute : ActionFilterAttribute
    {
        public override void OnActionExecuting(HttpActionContext actionContext)
        {
            var controller = actionContext.ActionDescriptor.ControllerDescriptor.ControllerName.ToLower();
            if (controller != "tokenapi"/* || (controller.CompareTo("tokenapi") == 0 && actionContext.ActionDescriptor.ActionName.ToLower() != "validateuser")*/)
            {
                var status = default(Code);
                try
                {
                    if (actionContext.ActionArguments != null &&
                        actionContext.Request.Method != HttpMethod.Get)
                    {
                        if (actionContext.Request.Content.IsMimeMultipartContent())
                        {
                            var token = System.Web.HttpContext.Current.Request["token"];
                            if (!UserSessionState.TokenIsValid(token))
                            {
                                status = Code.AuthRequired;
                                throw new Exception();
                            }
                        }
                        else if (actionContext.ActionArguments.Any(p => p.Value == null))
                        {
                            status = Code.BadRequest;
                            throw new Exception();
                        }
                        else
                        {
                            var model = actionContext.ActionArguments.Where(p => p.Value.GetType().IsClass).Select(p => p.Value).FirstOrDefault();
                            object token = null;
                            if (model is TokenBase)
                                token = (model as TokenBase).token;
                            else if (model is Newtonsoft.Json.Linq.JObject)
                                token = (model as Newtonsoft.Json.Linq.JObject).Value<object>("token");
                            if (!UserSessionState.TokenIsValid(token))
                            {
                                status = Code.AuthRequired;
                                throw new Exception();
                            }
                        }
                    }
                }
                catch
                {
                    actionContext.Response = actionContext.Request.CreateResponse(
                        HttpStatusCode.OK,
                        ApiResponseManager.CreateResponse(new Status(status)));
                }
            }
            base.OnActionExecuting(actionContext);
        }
    }
}