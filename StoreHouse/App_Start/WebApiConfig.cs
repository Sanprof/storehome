using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Http;
using Newtonsoft.Json.Serialization;
using StoreHouse.Common;
using StoreHouse.Models.Validation;
using StoreHouse.Models.Users;
using System.Web.Http.Cors;

namespace StoreHouse
{
    public static class WebApiConfig
    {
        public static void Register(HttpConfiguration config)
        {
            // Web API configuration and services
            config.Filters.Add(new ExternalErrorHandlerAttribute());
            config.Filters.Add(new ModelValidationAttribute());
            config.Filters.Add(new AuthenticateAttribute());
            // Web API routes
            config.Formatters.JsonFormatter.SerializerSettings.Formatting = Newtonsoft.Json.Formatting.Indented;
            config.Formatters.Remove(config.Formatters.XmlFormatter);

            /*var cors = new EnableCorsAttribute("*", "*", "GET,POST,PUT,DELETE,OPTION");
            config.EnableCors(cors);*/
            config.MapHttpAttributeRoutes(new CustomDirectRouteProvider());

            //config.MapHttpAttributeRoutes();

            config.Routes.MapHttpRoute(
               name: "DefaultApi",
               routeTemplate: "api/{controller}/{id}",
               defaults: new { action = "Index", id = RouteParameter.Optional }
           );

            config.Routes.MapHttpRoute(
                name: "api/{action}",
                routeTemplate: "api/{action}"
            );
        }
    }
}
