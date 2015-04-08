using System;

namespace StoreHouse.Models
{
    [AttributeUsage(AttributeTargets.Method, Inherited = true, AllowMultiple = true)]
    public class HttpGetTypeAttribute : Attribute
    {
        private readonly Type requestObjectType;

        public HttpGetTypeAttribute(Type requestObjectType)
        {
            this.requestObjectType = requestObjectType;
        }

        public Type RequestObjectType
        {
            get { return requestObjectType; }
        }
    }
}