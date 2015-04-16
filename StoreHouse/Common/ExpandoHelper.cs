using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SLICKernel.Common
{
    public static class ExpandoHelper
    {
        public static bool PropertyExists(dynamic expando, string propertyName)
        {
            if (expando is IDictionary<string, object>)
            {
                return (expando as IDictionary<string, object>).ContainsKey(propertyName);
            }
            else
                throw new ArgumentException("First parameter is not implement interface IDictionary<string, object>");
        }
    }
}
