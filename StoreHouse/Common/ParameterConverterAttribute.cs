using Newtonsoft.Json;
using StoreHouse.Common;
using StoreHouse.Models.Constants;
using StoreHouse.Models.Validation;
using System;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Http.Controllers;
using System.Web.Http.Filters;

namespace StoreHouse.Models
{
    [AttributeUsage(AttributeTargets.Method, Inherited = true, AllowMultiple = true)]
    public class ParameterConverterAttribute : ActionFilterAttribute
    {
        public string Parameter { get; set; }

        public ParameterConverterAttribute()
        {
        }

        public override void OnActionExecuting(HttpActionContext actionContext)
        {
            if (actionContext.ActionArguments.ContainsKey(this.Parameter) &&
                actionContext.Request.Method == HttpMethod.Get)
            {
                var filter = actionContext.ActionDescriptor.GetCustomAttributes<HttpGetTypeAttribute>(true).FirstOrDefault();
                if (filter != null)
                {
                    var qs = HttpUtility.ParseQueryString(actionContext.Request.RequestUri.Query);
                    if (qs.HasKeys())
                    {
                        var data = JsonConvert.DeserializeObject(qs[this.Parameter], filter.RequestObjectType);
                        var status = Validator.Validate(data);
                        try
                        {
                            if (status != default(Code))
                                throw new Exception();
                            if (data is TokenBase)
                            {
                                if (!UserSessionState.TokenIsValid((data as TokenBase).token))
                                {
                                    status = Code.AuthRequired;
                                    throw new Exception();
                                }
                            }
                            else
                            {
                                status = Code.BadRequest;
                                throw new Exception();
                            }
                            actionContext.ActionArguments[Parameter] = data;
                        }
                        catch
                        {
                            actionContext.Response = actionContext.Request.CreateResponse(
                                HttpStatusCode.OK,
                                ApiResponseManager.CreateResponse(new Status(status)));
                        }
                    }
                }
            }
            base.OnActionExecuting(actionContext);
        }
    }
}