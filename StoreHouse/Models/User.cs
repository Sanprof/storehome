//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace StoreHouse.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class User
    {
        public int UserID { get; set; }
        public int WorkerID { get; set; }
        public string Email { get; set; }
        public string Password { get; set; }
        public int Salt { get; set; }
        public Nullable<bool> IsDeleted { get; set; }
        public System.DateTime CreatedDate { get; set; }
        public string UserName { get; set; }
    
        public virtual Worker Worker { get; set; }
    }
}