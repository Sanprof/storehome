using StoreHouse.Models.Constants;

namespace StoreHouse.Models.Validation
{
    public interface ICodeValidation
    {
        Code ErrorCode { get; set; }
    }
}