using StoreHouse.Common;
using StoreHouse.Models.Constants;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http.Controllers;
using System.Web.Http.Filters;

namespace StoreHouse.Models.Validation
{
    /// <summary>
    /// The model validation attribute.
    /// </summary>
    public class ModelValidationAttribute : ActionFilterAttribute
    {
        #region Public Methods and Operators

        /// <summary>
        /// The on exception.
        /// </summary>
        /// <param name="context">
        /// The <c>context</c>.
        /// </param>
        public override void OnActionExecuting(HttpActionContext context)
        {
            if (context.ActionArguments != null &&
                context.Request.Method != HttpMethod.Get &&
                !context.Request.Content.IsMimeMultipartContent())
            {
                if (context.ActionArguments.Any(p => p.Value == null))
                {
                    context.Response = context.Request.CreateResponse(
                                HttpStatusCode.OK,
                                ApiResponseManager.CreateResponse(new Status(Code.BadRequest)));
                }
                else
                {
                    var models = context.ActionArguments.Where(p => p.Value.GetType().IsClass).Select(p => p.Value).ToList();

                    foreach (var item in models)
                    {
                        var status = Validator.Validate(item);

                        if (status != default(Code))
                        {
                            context.Response = context.Request.CreateResponse(
                                HttpStatusCode.OK,
                                ApiResponseManager.CreateResponse(new Status(status)));

                            break;
                        }
                    }
                }
            }

            base.OnActionExecuting(context);
        }

        #endregion
    }
}