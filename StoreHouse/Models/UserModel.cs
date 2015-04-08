using System.Collections.Generic;

namespace StoreHouse.Models
{
    public class UserModel : TokenBase
    {
        public string username { get; set; }
    }

    public class LoginUserModel : UserModel
    {
        public string password { get; set; }
        public bool rememberme { get; set; }
    }

    public class BlockUserModel : TokenBase
    {
        public List<object> data { get; set; }
    }

    public class ChangePasswordModel : TokenBase
    {
        public string oldpass { get; set; }
        public string newpass { get; set; }
    }

    public class DataUserModel : UserModel
    {
        public int id { get; set; }
        public string firstname { get; set; }
        public string lastname { get; set; }
        public string email { get; set; }
        public int roleid { get; set; }
    }

    public class RecoveryPasswordModel : TokenBase
    {
        public string email { get; set; }
        public string host { get; set; }
    }
}