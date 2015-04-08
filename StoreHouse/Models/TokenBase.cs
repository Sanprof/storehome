using System.Dynamic;

namespace StoreHouse.Models
{
    public class TokenBase
    {
        public object token { get; set; }
        public ExpandoObject extend { get; set; }
    }
}