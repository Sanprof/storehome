using StoreHouse.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace StoreHouse.Controllers
{
    public class BaseController : Controller
    {
        protected override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            if (filterContext.ActionDescriptor.ControllerDescriptor.ControllerName.ToLower() != "auth")
                try
                {
                    string token = Request.Cookies["token"] != null && Request.Cookies["token"].Value != null ? Request.Cookies["token"].Value : null;
                    if (String.IsNullOrWhiteSpace(token))
                        throw new Exception("Logon attempt with nonexistent token redirection to the authentication page");
                    using (var store = new Entities())
                    {
                        var user = store.UserSessions.FirstOrDefault(us => us.Token != null && us.Token.CompareTo(token) == 0 &&
                                                                    (us.Worker.IsDeleted == null ||
                                                                        (us.Worker.IsDeleted.HasValue && !us.Worker.IsDeleted.Value)));
                        if (user == null)
                            throw new Exception("User attempted to logon but him token is not valid!");
                    }
                }
                catch (Exception exc)
                {
                    filterContext.Result = new RedirectResult(Url.Action("Index", "Auth"));
                }
            base.OnActionExecuting(filterContext);
        }
    }
}