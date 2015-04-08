using StoreHouse.Models.Validation;

namespace StoreHouse.Models
{
    public class SimpleDeleteModel : TokenBase
    {
        //[Required(Constants.Code.IDRequired)]
        public int id { get; set; }
    }
}
